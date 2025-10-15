---
weight: 332
title: "Payment Provider"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---



<a name="tzero-v1-payment-ProviderService"></a>

## ProviderService
This service must be implemented by the provider.

All methods of this service must be idempotent, meaning they are safe to retry and multiple calls with the same parameters must not have additional effect.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| PayOut | [PayoutRequest](#tzero-v1-payment-PayoutRequest) | [PayoutResponse](#tzero-v1-payment-PayoutResponse) | Network instructs the provider to execute a payout to the recipient. This method should be idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| UpdatePayment | [UpdatePaymentRequest](#tzero-v1-payment-UpdatePaymentRequest) | [UpdatePaymentResponse](#tzero-v1-payment-UpdatePaymentResponse) | Network provides an update on the status of a payment. This can be either a success or a failure. This method should be idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| UpdateLimit | [UpdateLimitRequest](#tzero-v1-payment-UpdateLimitRequest) | [UpdateLimitResponse](#tzero-v1-payment-UpdateLimitResponse) | This rpc is used to notify the provider about the changes in credit limit and/or credit usage. |
| AppendLedgerEntries | [AppendLedgerEntriesRequest](#tzero-v1-payment-AppendLedgerEntriesRequest) | [AppendLedgerEntriesResponse](#tzero-v1-payment-AppendLedgerEntriesResponse) | Network can send all the updates about ledger entries of the provider's accounts. It can be used to keep track of the provider's exposure to other participants and other important financial events. (see the list in the message below) |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment-AppendLedgerEntriesRequest"></a>

### AppendLedgerEntriesRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transactions | [AppendLedgerEntriesRequest.Transaction](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction) | repeated | This is a list of transactions that were appended to the ledger of the provider. The transaction_id should be used to identify the transaction and ensure that it is processed only once. |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-LedgerEntry"></a>

### AppendLedgerEntriesRequest.LedgerEntry



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_owner_id | [uint32](#uint32) |  | 1 is network account, others are ids of participants |
| account_type | [AppendLedgerEntriesRequest.AccountType](#tzero-v1-payment-AppendLedgerEntriesRequest-AccountType) |  | account_type is the type of the account that the entry belongs to. It is used to categorize the entries and understand the nature of the financial event. |
| currency | [string](#string) |  | It is the currency of the entry. If the transaction contains entries with multiple currencies, the exchange_rate field should be provided to be used to convert the amounts to USD. |
| debit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | debit is the amount that was debited from the account. If the entry is a credit, this field should be 0. |
| credit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | credit is the amount that was credited to the account. If the entry is a debit, this field should be 0. |
| exchange_rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | exchange_rate is the exchange rate of the currency to USD if the currency is not USD and the transaction contains entries with multiple currencies. Exchange rate for the base currency USD and the quote currency provided in the entry. |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction"></a>

### AppendLedgerEntriesRequest.Transaction



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transaction_id | [uint64](#uint64) |  | transaction_id is an incrementally growing identifier for the transaction. It could have gaps and could be out of order, but it is unique for each transaction. |
| entries | [AppendLedgerEntriesRequest.LedgerEntry](#tzero-v1-payment-AppendLedgerEntriesRequest-LedgerEntry) | repeated | entries is a list of ledger entries that were appended to the ledger of the provider. Each entry represents a financial event that occurred in the provider's accounts. |
| pay_in | [AppendLedgerEntriesRequest.Transaction.PayIn](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-PayIn) |  |  |
| payout_reservation | [AppendLedgerEntriesRequest.Transaction.PayoutReservation](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-PayoutReservation) |  |  |
| payout | [AppendLedgerEntriesRequest.Transaction.Payout](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-Payout) |  |  |
| provider_settlement | [AppendLedgerEntriesRequest.Transaction.ProviderSettlement](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-ProviderSettlement) |  |  |
| fee_settlement | [AppendLedgerEntriesRequest.Transaction.FeeSettlement](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-FeeSettlement) |  |  |
| payout_reservation_release | [AppendLedgerEntriesRequest.Transaction.PayoutReservationRelease](#tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-PayoutReservationRelease) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-FeeSettlement"></a>

### AppendLedgerEntriesRequest.Transaction.FeeSettlement



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| fee_settlement_id | [uint64](#uint64) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-PayIn"></a>

### AppendLedgerEntriesRequest.Transaction.PayIn



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-Payout"></a>

### AppendLedgerEntriesRequest.Transaction.Payout



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-PayoutReservation"></a>

### AppendLedgerEntriesRequest.Transaction.PayoutReservation



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-PayoutReservationRelease"></a>

### AppendLedgerEntriesRequest.Transaction.PayoutReservationRelease



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesRequest-Transaction-ProviderSettlement"></a>

### AppendLedgerEntriesRequest.Transaction.ProviderSettlement



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| settlement_id | [uint64](#uint64) |  |  |







<a name="tzero-v1-payment-AppendLedgerEntriesResponse"></a>

### AppendLedgerEntriesResponse



This message has no fields defined.






<a name="tzero-v1-payment-PayoutRequest"></a>

### PayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  | payment id assigned by the network (provider should store this id to provide details in UpdatePayout later) |
| payout_id | [uint64](#uint64) |  | payout id assigned by the network (provider should store this id to provide details in UpdatePayout later) |
| currency | [string](#string) |  | currency of the payout (participant could support multiple currencies) This is the currency in which the payout should be made. |
| client_quote_id | [string](#string) |  | client quote id of the quote used for this payout (the provider provides the quote IDs in the UpdateQuote rpc) This is the identifier of the quote that was used to calculate the payout amount. |
| amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount in currency of the payout This is the amount that should be paid out to the recipient.

* payout_method is the payment method for the payout, e.g. bank transfer, crypto transfer, etc. This is used to specify how the payout should be made. |
| payout_method | [tzero.v1.common.PaymentMethod](#tzero-v1-common-PaymentMethod) | optional |  |
| pay_in_provider_id | [uint32](#uint32) |  | Pay-in provider id which initiated the pay out. |
| travel_rule_data | [PayoutRequest.TravelRuleData](#tzero-v1-payment-PayoutRequest-TravelRuleData) | optional |  |







<a name="tzero-v1-payment-PayoutRequest-TravelRuleData"></a>

### PayoutRequest.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| originator | [ivms101.Person](#ivms101-Person) | repeated | the natural or legal person that requests payment with originating provider |
| beneficiary | [ivms101.Person](#ivms101-Person) | repeated | the natural or legal person or legal arrangement who is identified by the originator as the receiver of the requested payment. |







<a name="tzero-v1-payment-PayoutResponse"></a>

### PayoutResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| accepted | [PayoutResponse.Accepted](#tzero-v1-payment-PayoutResponse-Accepted) |  | Success response - means the payout was executed successfully and the payment is now complete. This happens when the payout is successfully processed by the payout provider, and the payment was made to the recipient. |
| failed | [PayoutResponse.Failed](#tzero-v1-payment-PayoutResponse-Failed) |  | Failure response - means the payout was not executed successfully, e.g. the payout provider could not process the payout. |







<a name="tzero-v1-payment-PayoutResponse-Accepted"></a>

### PayoutResponse.Accepted



This message has no fields defined.






<a name="tzero-v1-payment-PayoutResponse-Failed"></a>

### PayoutResponse.Failed



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [PayoutResponse.Failed.Reason](#tzero-v1-payment-PayoutResponse-Failed-Reason) |  |  |







<a name="tzero-v1-payment-UpdateLimitRequest"></a>

### UpdateLimitRequest
All the amounts are in USD


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| limits | [UpdateLimitRequest.Limit](#tzero-v1-payment-UpdateLimitRequest-Limit) | repeated | can contain one or more Limit messages, each representing a credit limit for a specific counterparty provider. |







<a name="tzero-v1-payment-UpdateLimitRequest-Limit"></a>

### UpdateLimitRequest.Limit



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [int64](#int64) |  | Incrementally growing for the provider - same as in Ledger. |
| creditor_id | [int32](#int32) |  | the Id of the counterparty (creditor) provider, e.g. the provider that is providing the credit limit. It's usually the payOut provider, which provides the credit line to the payIn provider. |
| payout_limit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | payout_limit = credit_limit - credit_usage, negative value means credit limit is exceeded, e.g. if counterparty decreased credit limit |
| credit_limit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | This is the credit limit that the counterparty is willing to extend to the provider. |
| credit_usage | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | This is the credit usage that the provider has used so far. It is the sum of all payouts made by the provider minus the settlement net (settlement balance). It could be negative if the provider has received more in settlements than made payouts (pre-settlement). |







<a name="tzero-v1-payment-UpdateLimitResponse"></a>

### UpdateLimitResponse
Empty message - means no response is needed.


This message has no fields defined.






<a name="tzero-v1-payment-UpdatePaymentRequest"></a>

### UpdatePaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  | payment_id is a payment id in the T-0 network. |
| payment_client_id | [string](#string) |  | payment_client_id is a payment id assigned by the client, this is the same id that was provided in the CreatePaymentRequest. |
| accepted | [UpdatePaymentRequest.Accepted](#tzero-v1-payment-UpdatePaymentRequest-Accepted) |  | Accepted response - means the payout was accepted by the pay-out provider and pay-out provider is obligated to make a pay-out. |
| failed | [UpdatePaymentRequest.Failed](#tzero-v1-payment-UpdatePaymentRequest-Failed) |  | Payment failed and would not be retried. |
| confirmed | [UpdatePaymentRequest.Confirmed](#tzero-v1-payment-UpdatePaymentRequest-Confirmed) |  | Confirmed response - final state meaning the payout was executed successfully and the payment is now complete. This happens when the payout is successfully processed by the payout provider, and the payment was made to the recipient. |







<a name="tzero-v1-payment-UpdatePaymentRequest-Accepted"></a>

### UpdatePaymentRequest.Accepted



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount in currency of the payout |







<a name="tzero-v1-payment-UpdatePaymentRequest-Confirmed"></a>

### UpdatePaymentRequest.Confirmed



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| paid_out_at | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | time of the payout |
| receipt | [tzero.v1.common.PaymentReceipt](#tzero-v1-common-PaymentReceipt) |  | Payment receipt might contain metadata about payment recognizable by pay-in provider. |







<a name="tzero-v1-payment-UpdatePaymentRequest-Failed"></a>

### UpdatePaymentRequest.Failed



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [UpdatePaymentRequest.Failed.Reason](#tzero-v1-payment-UpdatePaymentRequest-Failed-Reason) |  |  |







<a name="tzero-v1-payment-UpdatePaymentResponse"></a>

### UpdatePaymentResponse



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-payment-AppendLedgerEntriesRequest-AccountType"></a>

### AppendLedgerEntriesRequest.AccountType


| Name | Number | Description |
| ---- | ------ | ----------- |
| ACCOUNT_TYPE_UNSPECIFIED | 0 |  |
| ACCOUNT_TYPE_USER_PAYABLE | 10 | Reflects the user's payable balance, the amount that the provider owes to the user. |
| ACCOUNT_TYPE_CASH | 20 | Reflects the cash balance of the provider. |
| ACCOUNT_TYPE_RESERVE | 30 | This is the reserve account of the provider, which reflects the reserve of balance to reduce the limit available from one provider to another. |
| ACCOUNT_TYPE_RESERVE_USAGE | 40 | This is the mirror account for the reserve. To keep the double entry accounting principle. |
| ACCOUNT_TYPE_PROVIDER_PAYABLE | 50 | Reflects how much the provider owes to the network or other participants. |
| ACCOUNT_TYPE_PROVIDER_RECEIVABLE | 60 | Reflects how much the provider is owed by the network or other participants. |
| ACCOUNT_TYPE_PROVIDER_SETTLEMENT | 70 | Reflects the settlement balance of the provider with the network or other participants. |
| ACCOUNT_TYPE_FEE_PAYABLE | 80 | Reflects the fees that the provider owes to the network. |
| ACCOUNT_TYPE_FEE_RECEIVABLE | 90 | Reflects the fees that the network is owed by the provider. |
| ACCOUNT_TYPE_FEE_EXPENSE | 100 | Reflects the fees that the provider has to pay for the services provided by the network. |
| ACCOUNT_TYPE_FEE_SETTLEMENT | 110 |  |



<a name="tzero-v1-payment-PayoutResponse-Failed-Reason"></a>

### PayoutResponse.Failed.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |



<a name="tzero-v1-payment-UpdatePaymentRequest-Failed-Reason"></a>

### UpdatePaymentRequest.Failed.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |


 <!-- end enums -->

