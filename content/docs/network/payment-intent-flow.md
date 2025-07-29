---
weight: 235
title: "Payment Intent Flow"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

The Payment Intent flow enables merchants to accept payments from customers in other countries while avoiding high currency conversion and money transfer costs. This streamlined process facilitates cross-border transactions through the T-0 Network's distributed payment infrastructure.
Overview

The T-0 Network orchestrates cross-border payments by connecting pay-in providers (who collect local currency from payers) with payout providers (who disburse funds to recipients in their local currency). The network eliminates the need for traditional correspondent banking relationships and reduces settlement times from days to seconds.

### Key Benefits
* Reduced counterparty risk through frequent settlement between providers
* Faster payments - seconds instead of several days compared to SWIFT transfers
* No currency exchange complexity - providers work only with their local currencies and trade USDT
* Simplified compliance - no need for providers to maintain legal entities in multiple countries

```mermaid
sequenceDiagram
    autonumber
    
    actor R as Recipient
    participant TP as Payout<br/>Provider
    participant N as T-0<br/>Network
    participant PIP as Pay-in<br/>Provider
    participant P as Payer

    R->>+N: Create Payment Intent<br/>(payment_reference, currency, amount)
    N->>N: Find Best Pay-in Quotes
    N->>+PIP: Create Payment Intent<br/>(payment_intent_id, currency, amount)
    PIP-->>-N: Payment URLs<br/>([payment_method, payment_url])
    N-->>-R: Payment URLs<br/>([payment_method, provider_id, payment_url])

    R->>P: Redirect/pop-up Payment URL
    P->>PIP: Payment

    PIP->>+N: Confirm Payment<br/>(payment_intent_id)
    N-->>-PIP: Settlement Data<br/>(provider_id, chain, address, amount)

    PIP->>TP: USDT Transfer
    PIP->>N: Settlement Confirmation<br/>(tx_hash, [payment_intent_id])
    
    Note over N: Awaiting USDT transfer confirmation

    N->>+TP: Pay Out
    TP->>R: Pay Out (fiat, stablecoin, etc.)
    TP-->>-N: 
    N->>R: Confirm Payment<br/>(payment_intent_id, payout amount)
    N->>PIP: Confirm Payout<br/>(payment_intent_id)
```

<br />

## Payment Initiation

The payment process begins when a recipient creates a payment intent in the T-0 Network, providing:
- **Payment reference** - unique identifier for tracking the incoming payment
- **Currency and amount** - the desired pay-in currency and transaction value
- **Payout details** - recipient's preferred payout method (e.g., bank account, digital wallet)

### Network Processing
- The network evaluates available pay-in providers based on multiple factors:
    - Pay-in quotes and exchange rates
    - Available credit limits
    - Pre-settlement capacity
- Selected pay-in providers are contacted to generate payment details and URLs by payment method
- The network returns available payment options to the recipient, including:
    - Payment methods available for each provider
    - Estimated processing quotes (noting that costs may vary by payment method, card processing typically costs more than bank transfers)

### Payment Selection
Once the recipient (or payer) selects their preferred payment method and provider, they are redirected to the corresponding payment URL to complete the transaction.


## Payment Confirmation
When a pay-in provider successfully receives payment from the payer, they must send a payment confirmation to the T-0 Network. The network response includes essential settlement details which can be used for the pre-settlement scenario:
* Target blockchain network
* On-chain wallet address
* Settlement amount in USDT

### Settlement Process
The pay-in provider initiates USDT settlement by transferring funds to the payout provider's blockchain address, then submits settlement confirmation to the network, including:
* Transaction hash from the blockchain
* List of associated payment intents (may contain single or multiple payment intents)

## Payout Execution
There are to approaches for payouts to Recipient: pre- and post-settlement

#### Pre-settlement 
Payouts are initiated only after the USDT transaction arrives at the payout provider's address and is confirmed on-chain. The network waits for blockchain confirmation before triggering the payout.

#### Post-settlement
Payouts are initiated immediately using available credit limits between providers, without waiting for USDT settlement. The payout provider extends credit to process the payment, and settlement occurs later to reconcile the credit usage.

#### Completion Notifications
Upon successful payout confirmation from the payout provider to the recipient, the network sends final confirmation notifications to both the pay-in provider and the original recipient, completing the payment cycle.