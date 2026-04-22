---
weight: 220
title: "Quote management"
description: "How providers publish FX quotes to the T-0 network for pay-in and pay-out routing."
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2026-04-22T00:00:00+00:00"
draft: false
toc: true
---

A quote is a provider's offer to convert between USD and a local currency at a given rate, up to a given volume, for a given payment method. The network uses quotes to route payments: when a client requests a payout in EUR via SEPA, the network compares every active quote matching those criteria and picks one.

Providers publish quotes by streaming `UpdateQuote` requests. Each request is a **full snapshot** of the provider's current offer. The network routes new payments against the latest snapshot. This model shapes every other rule on this page.

## Two quote streams: pay-in and pay-out

A provider publishes quotes on two independent streams that map to the two directions of payment on the network.

| Stream  | RPC                                                         | What it covers |
|---------|-------------------------------------------------------------|----------------|
| Pay-out | `tzero.v1.payment.NetworkService/UpdateQuote`               | Rates at which the provider accepts USDT settlement and disburses local currency to a beneficiary. Used in the [payment flow](../payment-flow). |
| Pay-in  | `tzero.v1.payment_intent.PaymentIntentService/UpdateQuote`  | Rates at which the provider collects local currency from an end-user and settles in USD. Used in the [payment intent flow](../payment-intent-flow). |

The network stores the two streams in separate tables. A publish to one has no effect on the other. A provider operating in both directions calls both RPCs. A provider operating in one direction leaves the other empty.

## The snapshot model

Every `UpdateQuote` request atomically replaces the provider's current snapshot for that stream. The new snapshot drives matching: every subsequent `GetQuote`, `CreatePayment`, and `CreatePaymentIntent` against that provider resolves against the new bands.

**Pay-out: the lock happens at `CreatePayment`.** Once `CreatePayment` returns `Accepted`, the settlement amount, pay-out amount, and quote reference are committed to that payment. The network and the pay-out provider finish the payout on those locked terms, even after the provider replaces the underlying snapshot.

**Pay-in: the lock happens later, at `ConfirmFundsReceived`.** Between `CreatePaymentIntent` and confirmation, the intent carries an indicative rate only; nothing is bound yet. When `ConfirmFundsReceived` fires, the network reads the provider's current snapshot: a new rate for the same `(currency, payment method)` applies on that call, and a snapshot that no longer covers that pair causes the call to fail with `REJECT_REASON_NO_ACTIVE_QUOTE`. See [Pay-in: indicative vs actual rate](#pay-in-indicative-vs-actual-rate).

Consequences for publishing:

**1. Every request carries the full set of currencies, payment methods, and bands the provider currently offers.** A provider that publishes EUR/SEPA at 09:00:00, then sends a snapshot at 09:00:05 containing only GBP/FPS, has no EUR/SEPA quotes for matching new requests at 09:00:05. `Accepted` pay-outs against EUR/SEPA continue on their locked terms; unconfirmed pay-in intents on EUR/SEPA fail at confirmation with `REJECT_REASON_NO_ACTIVE_QUOTE`.

**2. An empty request removes the provider from routing.** The network treats it as "I offer nothing" for new matches. Every unconfirmed pay-in intent fails at confirmation; `Accepted` pay-outs continue on their locked terms.

**3. There is no partial patch.** To drop a currency, band, or payment method, publish a new snapshot without it. To add one, publish a new snapshot that includes it alongside everything else.

## Anatomy of a quote

A request carries a list of **quote groups**, and each group carries a list of **bands**. The pay-out stream wraps its list in a field named `pay_out`; the pay-in stream wraps its list in a field named `payment_intent_quotes`. Below that wrapper, the shape is the same.

**Quote group.** Identifies a single offer for one currency on one payment rail.

- **Currency**: ISO 4217 code in uppercase (EUR, GBP, BRL).
- **Payment method**: the rail the offer applies to (SEPA, SWIFT, PIX, and so on).
- **Expiration**: a timestamp that applies to every band in the group. All bands in a group expire at the same instant.
- **Timestamp**: when the provider generated the group.
- **Bands**: one or more bands, described below.

**Band.** A single volume tier within a group, with its own rate.

- **Client quote id**: a string the provider assigns, unique per provider across publishes.
- **Max amount**: the cap for this tier, in USD. Must equal one of the six standard bands listed in [Standard bands](#standard-bands).
- **Rate**: `USD/XXX` exchange rate. USD is the base currency; `XXX` is the local currency. `rate = 0.92` for EUR means one USD yields 0.92 EUR.
- **Fix**: optional flat USD surcharge. See [Rate, fix, and settlement math](#rate-fix-and-settlement-math).

A provider that offers EUR on SEPA and SWIFT and GBP on FPS publishes three groups. A concrete snapshot might look like this:

| Currency | Payment method | Band (USD) |  Rate | Fix (USD) | Client quote id |
|----------|----------------|-----------:|------:|----------:|-----------------|
| EUR      | SEPA           |      1,000 | 0.920 |      0.50 | eur-sepa-1k     |
| EUR      | SEPA           |      5,000 | 0.915 |      0.50 | eur-sepa-5k     |
| EUR      | SEPA           |     25,000 | 0.910 |      0.50 | eur-sepa-25k    |
| EUR      | SWIFT          |     10,000 | 0.908 |      8.00 | eur-swift-10k   |
| EUR      | SWIFT          |    250,000 | 0.905 |      8.00 | eur-swift-250k  |
| GBP      | FPS            |      1,000 | 0.790 |      0.20 | gbp-fps-1k      |
| GBP      | FPS            |     10,000 | 0.785 |      0.20 | gbp-fps-10k     |

Expiration and timestamp sit on the group, not on the band, so the table does not repeat them. Every group has its own pair; a provider may set them to the same instant across groups or stagger them.

Rules:

- One group per `(currency, payment method)` pair.
- At least one band per group.
- `max_amount` values within a single group must not repeat.

### Standard bands

Bands are denominated in USD. The network accepts a fixed set of `max_amount` values:

- $1,000
- $5,000
- $10,000
- $25,000
- $250,000
- $1,000,000

The network rejects any `max_amount` outside this set with `unsupported band`. A provider publishes only the bands it offers on a given currency and payment method; omitted bands mean "I do not quote at that volume on this rail."

The fixed set keeps provider offers comparable. Every provider competes at the same volume tiers, so the network (and the client) can rank rates side by side without reconciling overlapping ad-hoc ranges.

### Rate, fix, and settlement math

`rate` is a `USD/XXX` exchange rate. **USD is always the base currency**, on every quote, pay-in or pay-out. At `rate = 0.92` for EUR, one USD yields 0.92 EUR.

`fix` is a flat USD fee on a band, covering the cost of the payment rail (wire, mobile money, card). Whichever side runs the rail keeps `fix`, so the sign differs between pay-out and pay-in settlement. `fix` is optional on a band and defaults to zero when absent.

Settlement between the pay-in provider and the pay-out provider clears in USD (transferred on-chain as USDT).

**Pay-out.** The pay-out provider runs the outbound rail and earns `fix`. The pay-in provider settles the converted amount plus `fix`:

```
settlement_amount = (pay_out_amount / rate) + fix
```

Paying out €1,000 at `rate = 0.92` with `fix = 0.50`:

```
settlement_amount = (1000 / 0.92) + 0.50 = 1087.46 USD
```

When the client fixes the settlement amount instead of the pay-out amount, the network inverts the formula to derive the pay-out:

```
pay_out_amount = (settlement_amount − fix) × rate
```

**Pay-in.** The pay-in provider runs the inbound rail and earns `fix`. They keep `fix` from what the end-user paid; the beneficiary provider receives the converted amount minus `fix`:

```
settlement_amount = (pay_in_amount / rate) − fix
```

A €1,000 pay-in at `rate = 0.92` with `fix = 0.50`:

```
settlement_amount = (1000 / 0.92) − 0.50 = 1086.46 USD
```

The rate applied on pay-in is binding at `ConfirmFundsReceived`, not at quote publish or at payment intent creation. See [Pay-in: indicative vs actual rate](#pay-in-indicative-vs-actual-rate) for the timing rules.

### Expiration and timestamp

`expiration` is the only validity control. A quote is live while `now() < expiration`. Once `expiration` passes, the network stops offering that band in routing. There is no grace period after expiration and no server-side cap on how far ahead `expiration` can be set.

`timestamp` records when the provider generated the quote. The network stores it but does not use it for filtering. Set it to the time the rate was computed so audit logs can correlate with the provider's internal systems.

### Client quote IDs

`client_quote_id` is a per-band identifier the provider assigns. The network stores it with the band and echoes it back in the `PayoutRequest` sent to the provider, so the provider can look up which internal rate the network used.

- Unique per provider. The network rejects a reused ID in a later snapshot with a conflict error.
- 1 to 64 characters.
- Any format the provider chooses. A UUID, a ULID, or a monotonic counter all fit.

The network-assigned `quote_id` returned by `GetQuote` is separate: it is the network's internal handle, used by `CreatePayment` to lock a specific quote. `client_quote_id` is what lets the provider map the network's `quote_id` back to its own records.

## Publishing cadence

The network does not enforce a minimum or maximum publishing interval. The provider chooses the cadence. `expiration` is the only thing the network checks.

A cadence picks a tradeoff between spread tightness and system load:

- Short cadence (1 to 5 seconds) reflects current market conditions, so the provider can offer tighter spreads with lower FX risk.
- Longer cadence (10 to 20 seconds) reduces publish volume and load on both sides, at the cost of wider spreads to absorb more rate uncertainty.

Set `expiration` to `now() + cadence + grace_window`. The `grace_window` is the minimum validity the provider wants clients to see when fetching a quote at the worst moment, a moment before the next publish overwrites it. A 5-second cadence with a 30-second grace gives `expiration = now() + 35s`. A client fetching that quote in the last moment of the interval still has 30 seconds to use it.

When the provider stops publishing, the network drops the provider from routing the moment the last snapshot expires. Resuming means sending a fresh `UpdateQuote`. There is no heartbeat or keep-alive separate from the quote stream itself.

## How the network picks a pay-out quote

A client calls `NetworkService/GetQuote` (or `CreatePayment` directly) with a pay-out currency, payment method, and amount. The amount can be specified as the pay-out amount or the settlement amount. The network:

1. Filters live pay-out quotes to the requested currency and payment method.
2. Keeps only bands whose cap fits the request: `(pay_out_amount / rate) ≤ max_amount`, or `settlement_amount ≤ max_amount` when the request is given in settlement terms.
3. For each provider, picks one band from the remaining set: highest `rate` wins, ties break on lowest `fix`, then latest `expiration`.
4. Returns the best quote overall as `success`, and every provider's winning band as `all_quotes` for client-side comparison.

A quote is **executable** only if the pay-in provider has enough credit (or pre-deposit) against the pay-out provider to cover the settlement amount. Non-executable quotes still appear in `all_quotes` with the exact `prefunding_amount` needed to make them executable. The client can choose to pre-fund and retry.

## Pay-in: indicative vs actual rate

Pay-in routing works differently. When a beneficiary provider creates a payment intent, the network asks each available pay-in provider for payment details and returns them with indicative rates so the end-user can pick a method. The settlement rate is not bound yet.

The network locks the rate when the pay-in provider calls `ConfirmFundsReceived`. At that moment it reads the provider's current pay-in snapshot for the relevant currency and payment method, takes the live qualifying band with the lowest rate, and computes the settlement as `(pay_in_amount / rate) − fix` in USD.

Two implications:

- A pay-in provider that stops publishing between intent creation and funds confirmation has no active quote at confirmation. The network rejects the call with `REJECT_REASON_NO_ACTIVE_QUOTE`.
- A pay-in provider's rate can move between intent creation (indicative) and confirmation (binding), so the indicative rate the end-user sees carries no guarantee.

## Field-level reference

Field types, enums, and validation rules live in the auto-generated API reference:

- Pay-out: [`UpdateQuoteRequest`](../../integration-guidance/api-reference/payment_network/#tzero-v1-payment-UpdateQuoteRequest), [`Quote`](../../integration-guidance/api-reference/payment_network/#tzero-v1-payment-UpdateQuoteRequest-Quote), [`Band`](../../integration-guidance/api-reference/payment_network/#tzero-v1-payment-UpdateQuoteRequest-Quote-Band).
- Pay-in: [`UpdateQuoteRequest`](../../integration-guidance/api-reference/payment_intent_network/#tzero-v1-payment_intent-UpdateQuoteRequest), [`Quote`](../../integration-guidance/api-reference/payment_intent_network/#tzero-v1-payment_intent-UpdateQuoteRequest-Quote), [`Band`](../../integration-guidance/api-reference/payment_intent_network/#tzero-v1-payment_intent-UpdateQuoteRequest-Quote-Band).

## Integration checklist

- [ ] Every `UpdateQuote` carries the complete current snapshot. No deltas, no patches.
- [ ] All `max_amount` values sit in the set {1000, 5000, 10000, 25000, 250000, 1000000}.
- [ ] `client_quote_id` is unique per provider across publishes, not within this request alone.
- [ ] `expiration` is set to `now() + cadence + grace_window` so clients fetching at the worst moment still have useful validity.
- [ ] Pay-in and pay-out run on their own RPCs. A provider in both directions publishes to both.
- [ ] Pay-in `rate` matches the rate the provider can honor at `ConfirmFundsReceived`, since that is when the rate binds.
- [ ] To stop a currency or method, publish a new snapshot without it. A blank request removes the provider from routing.
