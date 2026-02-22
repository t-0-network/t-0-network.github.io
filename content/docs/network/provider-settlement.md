---
weight: 240
title: "Settlement with Counterparties"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---


## The Balance Model

When two network members establish a relationship, they create a balance system between them. Similar to the concept of a bank account, a member who requests payouts can fund their USDT balance at a specific payout provider, and use that balance to request a payout.

Each network member has a single wallet address associated with them. This allows the Network to identify settlement transactions (or “balance top-ups”) by monitoring activity between these wallets.

While all USDT settlement is peer-to-peer between registered wallets, the Network dictates the possible chains that settlement can be made in, to ensure it is one of [the chains that the Network currently monitors](supported-chains).

When members establish a relationship, they also decide which chain, from those supported, they will use to make transfers to each other.

## Settlement Models

Network members can decide to operate on one of two models. The decision is made independently by network members when they are connected to any new member; and the rules they decide on may differ for when each of them is in the requester or the provider role.

#### Pre-funding model:
    
USDT must be sent by the *payout requester* to the *payout provider* before they can request a payout. 

#### Post-settlement model:
    
USDT can be sent by the *requester* to the *provider*, **after** the *provider* has completed the required fiat transaction. The provider extends a credit line, so the requester is allowed to go into debt with them temporarily, up to a specific limit which is defined in USD.

When a *payout requester*'s credit limit is less than they require for a payout, the *requester* can fund their balance at the provider, for the difference between their credit limit and the amount they require.

For example, the *payout requester* has an agreed post-settlement credit of 10K USD with a specific *payout provider*. They want to request a payout worth 20K USD. They may send 10K USDT to the *payout provider’s wallet.* Once this transfer is confirmed, the *payout requester* now has a balance of 10K and a credit line of 10K at the *payout provider.* Allowing them to request a payout worth $20K.

Post-settlement can result in better utilisation of stablecoin liquidity due to netting. If two members are both acting as providers to each other (in different markets), their settlement due to each other will reduce, or theoretically could even cancel out completely.


## ℹ️ Settlement Related Decisions

#### While onboarding:

New network member provides t-0 with: a single wallet address they will use to interact with all network members, and the chains which they can support sending and receiving transfers from other members on.

#### Before two network members are matched:

t-0 ensures that they are able to settle with each other, sharing at least one supported chain.

#### After a match has been made:

t-0 provides both members with the wallet address of the other party.

Both members independently discuss how they expect to receive settlement transfers, specifically:

- Which chain(s) should be used
- For each of the following points, there may be a different rule for (1) when *member A* is in the provider role for *member B*, and for (2) when *member B* is in the provider role for *member A*.
    - Which settlement model to operate on ([see “Settlement Models” above](#settlement-models))
    - If on post-settlement:
        - What is the post-settlement credit limit
        - How often should settlement happen. *Network best practice is at least every 8 hours.*

#### At any moment in the future:

Both members may discuss and decide on a change to their chosen settlement model.

Members tell t-0 about these changes. 

t-0 then updates settlement model parameters in the Network to ensure new limits can’t be exceeded. And the Network issues an update ([via the UpdateLimitRequest RPC](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-UpdateLimitRequest)) to the endpoints of both of the network members, confirming the update.
 
## Monitoring Balances and Availability

The Network tracks balances between network members, and sends messages to member's endpoints whenever there is a change. There are 5 events which can affect your balances, their availability and your credit limits:

1. **Payout request created:** When a [payment is created](/content/docs/integration-guidance/api-reference/payment-network#createpaymentrequest), the *requester's* available balance at the chosen provider is temporarily reduced. This amount is reserved.
2. **Confirmed payout request:** When a *payout provider* confirms a payout, the *requester's* balance at that provider is reduced. This amount is now used.
3. **Confirmed collection request:** When a *collection provider* confirms that fiat funds were received, the *collection requester's* liability to that provider increases.
4. **Blockchain transfer:** The Network detects a USDT transfer between your wallet and another network member’s wallet.
5. **Credit limit update:** When you and one of your counterparties inform t-0 via a formal channel that you have decided on a change to your credit limits.

To deliver your latest balances, availability and credit limits, when any of the above events occur, the Network calls your [UpdateLimit RPC endpoint](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-UpdateLimitRequest).

To deliver detailed updates about important accounting events (specifically events 2, 3 & 4 in the list above), the Network also calls your [AppendLedgerEntries RPC endpoint](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-AppendLedgerEntriesRequest), in addition to UpdateLimit.

### Example Payout Walkthrough

Two providers:
- Network Member A (ID=1, licensed in Mexico)
- Network Member B (ID=2, licensed in Philippines)

Credit lines (asymmetric):
- B extends $10,000 credit to A (A can send payouts through B up to $10,000)
- A extends $5,000 credit to B (B can send payouts through A up to $5,000)

#### Step 1: Payment created

A customer of Member A in Mexico wants to send money to the Philippines. Member B will be providing the payout. Settlement amount will be $1,000.

**The Network sends an UpdateLimit request to Member A:**

counterpart_id: 2<br>
credit_limit: 10,000<br>
reserve: 1,000 *(the 1,000 that is reserved for this transaction)*<br>
payout_limit: 9,000 *(10,000 - 1,000 reserved)*<br>
credit_usage: 0 *(1,000 is reserved but not yet confirmed)*<br>

Member A is seeing: "My available payout capacity through B dropped from $10,000 to $9,000. $1,000 is reserved for a pending payment."

Member B sees nothing yet.

#### Step 2: Payment confirmed

Member B has confirmed the payout. 
Both Member A and Member B's ledgers are touched by this event, so they both receive notifications from the Network.

**UpdateLimit sent to Member A:**

counterpart_id: 2<br>
credit_limit: 10,000<br>
reserve: 0 *(the 1,000 that is reserved for this transaction)*<br>
payout_limit: 9,000 *(10,000 - 1,000 reserved)*<br>
credit_usage: 1,000 *(1,000 is reserved but not yet confirmed)*<br>

Member A is seeing: "The reserve has been converted to credit usage. I've used $1,000 of my $10,000 credit line with B. $9,000 remaining."

Member A also receives an [AppendLedgerEntries RPC](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-AppendLedgerEntriesRequest), with 2 entries, showing changes to their *balance* and *pay-in* accounts with B.

**UpdateLimit sent to Provider B:**

counterpart_id: 1<br>
credit_limit: 5,000<br>
reserve: 0<br>
payout_limit: 6,000 *(5,000 + 1,000 I'm owed)*<br>
credit_usage: -1,000 <br>

Member B is seeing: "My payout capacity through A has increased from $5,000 to $6,000. My credit usage is -1,000 (negative, meaning I'm owed money, not using credit)."

Member B also receives an [AppendLedgerEntries RPC](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-AppendLedgerEntriesRequest), with 2 entries, showing changes to their *balance* and *pay-out* accounts with A.

This step demonstrates a key feature of the bidirectional system: when Member A pays out through Member B, it simultaneously increases B's capacity to pay out through A. A owes B $1,000, which offsets against B's credit line with A, effectively giving B an extra $1,000 of headroom.

#### Step 3: Settlement

A owes B money, so A sends a USDT settlement to B's wallet.

**UpdateLimit sent to Member A:**

counterpart_id: 2<br>
credit_limit: 10,000<br>
reserve: 0<br>
payout_limit: 10,000 *(9,000 + 1,000 sent)*<br>
credit_usage: 0 *(1,000 - 1,000 sent)*<br>

Member A also receives an [AppendLedgerEntries RPC](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-AppendLedgerEntriesRequest), with 2 entries, showing changes to their *balance* and *settlement-out* accounts with B.

**UpdateLimit sent to Member B:**

counterpart_id: 1<br>
credit_limit: 5,000<br>
reserve: 0<br>
payout_limit: 5,000 *(6,000 - 1,000 received)*<br>
credit_usage: 0 *(-1,000 + 1,000 received)*<br>

Member B also receives an [AppendLedgerEntries RPC](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-AppendLedgerEntriesRequest), with 2 entries, showing changes to their *balance* and *settlement-in* accounts with A.