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

Providers participate in the network's payment routing by publishing quotes for both pay-in and payout operations using the UpdateQuote RPC method. These quotes define the exchange rates and capacity bands that the network uses to route payments and calculate optimal pricing for end users.

## Quote Structure and Bands
Each quote consists of multiple pricing bands that define rate tiers based on transaction volume. This banded approach allows providers to offer competitive pricing for different transaction sizes while managing their risk exposure appropriately.

Current supported bands denominated in USD are (the other bands would be considered upon request):
* $1 000
* $5 000
* $10 000
* $25 000

Quotes specify a base currency of USD and a quote currency representing the provider's local currency (be careful, quotes such as EUR/USD must be represented like USD/EUR). The rate field defines the USD to local currency exchange rate, while the max_amount field specifies the maximum USD amount for which the band's rate applies.

Providers can publish separate quotes for pay-in and payout operations, allowing for different pricing strategies based on operational requirements and risk considerations. Each quote includes an expiration timestamp that defines how long the quote remains valid, enabling providers to manage their exposure to exchange rate fluctuations.

The `client_quote_id` field allows providers to track their own quotes for internal reconciliation and reporting purposes. This identifier is returned in payout requests, enabling providers to correlate network requests with their published pricing.

## Quote Types and Validity
The network currently supports real-time quotes that must remain valid for at least 30 seconds from publication. This requirement ensures sufficient time for payment processing while allowing providers to update their pricing frequently in response to market conditions.

Real-time quotes provide maximum flexibility for providers to adjust pricing based on current market conditions, liquidity availability, and operational capacity. The short validity period minimizes exposure to adverse market movements while ensuring competitive pricing for end users.

Future network versions may support guaranteed quotes with longer validity periods, providing additional options for providers with different risk management requirements or pricing strategies.
