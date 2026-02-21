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

 **While onboarding:** 
 
 New network member provides t-0 with: a single wallet address they will use to interact with all network members, and the chains which they can support sending and receiving transfers from other members on.
 
 **Before two network members are matched:**
 
 t-0 ensures that they are able to settle with each other, sharing at least one supported chain.
 
 **After a match has been made:**
 
 t-0 provides both members with the wallet address of the other party.
 
 Both members independently discuss how they expect to receive settlement transfers, specifically:
 
 - Which chain(s) should be used
 - For each of the following points, there may be a different rule for (1) when *member A* is in the provider role for *member B*, and for (2) when *member B* is in the provider role for *member A*.
     - Which settlement model to operate on ([see “Settlement Models” above](#settlement-models))
     - If on post-settlement:
         - What is the post-settlement credit limit
         - How often should settlement happen. *Network best practice is at least every 8 hours.*
 
 **At any moment in the future:**
 
 Both members may discuss and decide on a change to their chosen settlement model.
 
 Members tell t-0 about these changes. 
 
 t-0 then updates settlement model parameters in the Network to ensure new limits can’t be exceeded. And the Network issues an update ([via the UpdateLimitRequest RPC](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-UpdateLimitRequest)) to the endpoints of both of the network members, confirming the update.
 
## Monitoring Balances and Availability

The Network tracks balances between network members, and sends messages to member's endpoints whenever there is a change. There are 5 events which can affect your balances, their availability and your credit limits:

1. **Payout request created:** When a [payment is created](/content/docs/integration-guidance/api-reference/payment-network#createpaymentrequest), the *requester's* available balance at the chosen provider is temporarily reduced. This amount is reserved.
2. **Confirmed payout request:** When a *payout provider* confirms a payout, the *requester's* balance at that provider is reduced. This amount is now used.
3. **Confirmed collection request:** When a *collection provider* confirms that fiat funds were received, the *collection requester's* liability to that provider increases.
4. **Blockchain transfer:** The Network detects a USDT transfer to or from your wallet to another member’s wallet. The message includes the blockchain transaction hash.
5. **Credit limit update:** When you and one of your counterparties inform t-0 via a communication channel that you have decided on a change to your credit limits.

To deliver your latest balances, availability and credit limits, when any of the above events occur, the Network calls your [UpdateLimit RPC endpoint](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-UpdateLimitRequest).

To deliver detailed updates about important accounting events (specifically events 2, 3 & 4 in the list above), the Network also calls your [AppendLedgerEntries RPC endpoint](/docs/integration-guidance/api-reference/payment-provider#tzero-v1-payment-AppendLedgerEntriesRequest), in addition to UpdateLimit.

