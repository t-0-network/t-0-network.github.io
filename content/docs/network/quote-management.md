---
weight: 220
title: "Quote management"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

Providers participate in the network's payment routing by publishing quotes for both pay-in and payout operations using the UpdateQuote RPC method. These quotes define the exchange rates and volume bands that the network uses to route payments and calculate optimal pricing for end users.

## Quote Structure and Bands

Each quote consists of multiple pricing bands that define rate tiers based on transaction volume. This banded approach allows providers to offer different pricing for different transaction sizes while managing their risk exposure appropriately.

The standard quote bands are structured as follows (denominated in USD):
* $1,000
* $5,000
* $10,000
* $25,000
* $250,000
* $1,000,000

The predefined band structure unifies the system and simplifies quote matching. Without standardized bands, the system would have to manage thousands of quotes with arbitrary amounts, creating matching complexity. Providers can set different exchange rates for different transaction volumes since rates typically vary based on payment size.

All quotes pushed to the network are denominated in USD for the supported currencies. For example, if a provider supports Euro, they push quotes as USD/EUR (base currency USD, quote currency EUR). The rate field defines the USD to local currency exchange rate, while the max_amount field specifies the maximum USD amount for which the band's rate applies.

Providers can publish separate quotes for pay-in and payout operations, allowing for different pricing strategies based on operational requirements and liquidity needs. Pay-in quotes represent rates at which a provider is willing to accept local currency and convert it to USDT. Payout quotes represent rates at which a provider is willing to accept USDT and disburse local currency through domestic banking rails.

The `client_quote_id` field allows providers to track their own quotes for internal reconciliation and reporting purposes. This identifier is included in payout requests, enabling providers to correlate network requests with their published pricing and verify that the correct rate was applied.

## Quote Streaming and Validity

Providers must stream quotes to the network every 5 seconds to maintain their active status in the network. This regular streaming serves two purposes: it provides the network with current pricing information and acts as a liveness check to ensure provider systems are operational and ready to receive payment requests.

Quote validity is limited to 30 seconds to maintain tight spreads and minimize foreign exchange risk uncertainty for participants. This short validity period ensures that participants are not exposed to extended periods of exchange rate volatility. Because quotes have such short lifespans, participants can offer tighter spreads with lower uncertainty compared to systems requiring quotes valid for several minutes.

If a provider stops submitting quotes for 30 seconds, they are automatically removed from the network until quote streaming resumes. The network will not route payment requests to providers that have stopped streaming quotes, ensuring that only active providers with functioning systems receive transaction requests.

Providers can submit both pay-in and payout quotes in a single request every 5 seconds, containing all supported currencies, all bands, and both directional quotes. The network maintains a complete audit trail of all submitted quotes, storing the quote history along with the unique quote identifiers for reconciliation purposes.
