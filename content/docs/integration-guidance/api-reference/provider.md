---
weight: 200
title: "Provider Service"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
<a name="network-v1-provider-ProviderService"></a>

## ProviderService
This service must be implemented by the provider.

All methods of this service must be idempotent, meaning they are safe to retry and multiple calls with the same parameters must not have additional effect.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| PayOut | [PayoutRequest](#network-v1-provider-PayoutRequest) | [PayoutResponse](#network-v1-provider-PayoutResponse) | Network instructs the provider to execute a payout to the recipient. This method should be idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| UpdatePayment | [UpdatePaymentRequest](#network-v1-provider-UpdatePaymentRequest) | [UpdatePaymentResponse](#network-v1-provider-UpdatePaymentResponse) | Network provides an update on the status of a payment. This can be either a success or a failure. This method should be idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| CreatePayInDetails | [CreatePayInDetailsRequest](#network-v1-provider-CreatePayInDetailsRequest) | [CreatePayInDetailsResponse](#network-v1-provider-CreatePayInDetailsResponse) | Network asks the provider for possible pay-in options for a sender, in preparation for a pay-in process. This is optional, but if implemented, it should return a list of available pay-in methods. |
| UpdateLimit | [UpdateLimitRequest](#network-v1-provider-UpdateLimitRequest) | [UpdateLimitResponse](#network-v1-provider-UpdateLimitResponse) | This rpc is used to notify the provider about the changes in credit limit and/or credit usage. |
| AppendLedgerEntries | [AppendLedgerEntriesRequest](#network-v1-provider-AppendLedgerEntriesRequest) | [AppendLedgerEntriesResponse](#network-v1-provider-AppendLedgerEntriesResponse) | Network can send all the updates about ledger entries of the provider's accounts. It can be used to keep track of the provider's exposure to other participants and other important financial events. (see the list in the message below) |

 <!-- end services -->

##  Requests And Response Types


<a name="network-v1-provider-AppendLedgerEntriesRequest"></a>

### AppendLedgerEntriesRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transactions | [AppendLedgerEntriesRequest.Transaction](#network-v1-provider-AppendLedgerEntriesRequest-Transaction) | repeated | This is a list of transactions that were appended to the ledger of the provider. The transaction_id should be used to identify the transaction and ensure that it is processed only once. |







<a name="network-v1-provider-AppendLedgerEntriesRequest-LedgerEntry"></a>

### AppendLedgerEntriesRequest.LedgerEntry



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_owner_id | [uint32](#uint32) |  | 1 is network account, others are ids of participants |
| account_type | [AppendLedgerEntriesRequest.AccountType](#network-v1-provider-AppendLedgerEntriesRequest-AccountType) |  | account_type is the type of the account that the entry belongs to. It is used to categorize the entries and understand the nature of the financial event. |
| currency | [string](#string) |  | It is the currency of the entry. If the transaction contains entries with multiple currencies, the exchange_rate field should be provided to be used to convert the amounts to USD. |
| debit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | debit is the amount that was debited from the account. If the entry is a credit, this field should be 0. |
| credit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | credit is the amount that was credited to the account. If the entry is a debit, this field should be 0. |
| exchange_rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | exchange_rate is the exchange rate of the currency to USD if the currency is not USD and the transaction contains entries with multiple currencies. Exchange rate for the base currency USD and the quote currency provided in the entry. |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction"></a>

### AppendLedgerEntriesRequest.Transaction



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transaction_id | [uint64](#uint64) |  | transaction_id is an incrementally growing identifier for the transaction. It could have gaps and could be out of order, but it is unique for each transaction. |
| entries | [AppendLedgerEntriesRequest.LedgerEntry](#network-v1-provider-AppendLedgerEntriesRequest-LedgerEntry) | repeated | entries is a list of ledger entries that were appended to the ledger of the provider. Each entry represents a financial event that occurred in the provider's accounts. |
| pay_in | [AppendLedgerEntriesRequest.Transaction.PayIn](#network-v1-provider-AppendLedgerEntriesRequest-Transaction-PayIn) |  |  |
| payout_reservation | [AppendLedgerEntriesRequest.Transaction.PayoutReservation](#network-v1-provider-AppendLedgerEntriesRequest-Transaction-PayoutReservation) |  |  |
| payout | [AppendLedgerEntriesRequest.Transaction.Payout](#network-v1-provider-AppendLedgerEntriesRequest-Transaction-Payout) |  |  |
| provider_settlement | [AppendLedgerEntriesRequest.Transaction.ProviderSettlement](#network-v1-provider-AppendLedgerEntriesRequest-Transaction-ProviderSettlement) |  |  |
| fee_settlement | [AppendLedgerEntriesRequest.Transaction.FeeSettlement](#network-v1-provider-AppendLedgerEntriesRequest-Transaction-FeeSettlement) |  |  |
| payout_reservation_release | [AppendLedgerEntriesRequest.Transaction.PayoutReservationRelease](#network-v1-provider-AppendLedgerEntriesRequest-Transaction-PayoutReservationRelease) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction-FeeSettlement"></a>

### AppendLedgerEntriesRequest.Transaction.FeeSettlement



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| fee_settlement_id | [uint64](#uint64) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction-PayIn"></a>

### AppendLedgerEntriesRequest.Transaction.PayIn



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [string](#string) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction-Payout"></a>

### AppendLedgerEntriesRequest.Transaction.Payout



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [string](#string) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction-PayoutReservation"></a>

### AppendLedgerEntriesRequest.Transaction.PayoutReservation



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [string](#string) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction-PayoutReservationRelease"></a>

### AppendLedgerEntriesRequest.Transaction.PayoutReservationRelease



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [string](#string) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesRequest-Transaction-ProviderSettlement"></a>

### AppendLedgerEntriesRequest.Transaction.ProviderSettlement

| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| settlement_id | [uint64](#uint64) |  |  |







<a name="network-v1-provider-AppendLedgerEntriesResponse"></a>

### AppendLedgerEntriesResponse



This message has no fields defined.






<a name="network-v1-provider-CreatePayInDetailsRequest"></a>

### CreatePayInDetailsRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [string](#string) |  | payment_intent_id is a unique identifier for the payment intent, which is used to create a payment later. |
| sender | [CreatePayInDetailsRequest.Sender](#network-v1-provider-CreatePayInDetailsRequest-Sender) |  | Sender details for the pay-in process. |







<a name="network-v1-provider-CreatePayInDetailsRequest-Sender"></a>

### CreatePayInDetailsRequest.Sender



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| private_person | [CreatePayInDetailsRequest.Sender.PrivatePerson](#network-v1-provider-CreatePayInDetailsRequest-Sender-PrivatePerson) |  |  |







<a name="network-v1-provider-CreatePayInDetailsRequest-Sender-PrivatePerson"></a>

### CreatePayInDetailsRequest.Sender.PrivatePerson



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| private_person_id | [string](#string) |  | can be used to get KYC data |







<a name="network-v1-provider-CreatePayInDetailsResponse"></a>

### CreatePayInDetailsResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_in_method | [tzero.v1.common.PaymentMethod](#tzero-v1-common-PaymentMethod) | repeated | List of available pay-in methods for the sender. This is used to present the user with options for how they can pay in. |







<a name="network-v1-provider-PayoutRequest"></a>

### PayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [int64](#int64) |  | payment id assigned by the network (provider should store this id to provide details in UpdatePayout later) |
| payout_id | [int64](#int64) |  | payout id assigned by the network (provider should store this id to provide details in UpdatePayout later) |
| currency | [string](#string) |  | currency of the payout (participant could support multiple currencies) This is the currency in which the payout should be made. |
| client_quote_id | [string](#string) |  | client quote id of the quote used for this payout (the provider provides the quote IDs in the UpdateQuote rpc) This is the identifier of the quote that was used to calculate the payout amount. |
| amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount in currency of the payout This is the amount that should be paid out to the recipient. |
| payout_method | [tzero.v1.common.PaymentMethod](#tzero-v1-common-PaymentMethod) |  | payout_method is the payment method for the payout, e.g. bank transfer, crypto transfer, etc. This is used to specify how the payout should be made. |







<a name="network-v1-provider-PayoutResponse"></a>

### PayoutResponse



This message has no fields defined.






<a name="network-v1-provider-UpdateLimitRequest"></a>

### UpdateLimitRequest
All the amounts are in USD


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| version | [int64](#int64) |  | Incrementally growing for the provider - same as in Ledger. Different providers have different versions. |
| provider_id | [int32](#int32) |  | the Id of the counterparty (creditor) provider, e.g. the provider that is providing the credit limit. It's usually the payOut provider, which provides the credit line to the payIn provider. |
| payout_limit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | payout_limit = credit_limit - credit_usage, negative value means credit limit is exceeded, e.g. if counterparty decreased credit limit |
| credit_limit | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | This is the credit limit that the counterparty is willing to extend to the provider. |
| credit_usage | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | This is the credit usage that the provider has used so far. It is the sum of all payouts made by the provider minus the settlement net (settlement balance). It could be negative if the provider has received more settlements than payouts. |







<a name="network-v1-provider-UpdateLimitResponse"></a>

### UpdateLimitResponse
Empty message - means no response is needed.


This message has no fields defined.






<a name="network-v1-provider-UpdatePaymentRequest"></a>

### UpdatePaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](#string) |  | payment_client_id is a payment id assigned by the client, this is the same id that was provided in the CreatePaymentRequest. |
| success | [UpdatePaymentRequest.Success](#network-v1-provider-UpdatePaymentRequest-Success) |  | Success response - means the payout was executed successfully and the payment is now complete. This happens when the payout is successfully processed by the payout provider, and the payment was made to the recipient. |
| failure | [UpdatePaymentRequest.Failure](#network-v1-provider-UpdatePaymentRequest-Failure) |  | Failure response - means the payout was not executed successfully, e.g. the payout provider could not process the payout. |







<a name="network-v1-provider-UpdatePaymentRequest-Failure"></a>

### UpdatePaymentRequest.Failure



This message has no fields defined.






<a name="network-v1-provider-UpdatePaymentRequest-Success"></a>

### UpdatePaymentRequest.Success



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount in currency of the payout |
| paid_out_at | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | time of the payout |







<a name="network-v1-provider-UpdatePaymentResponse"></a>

### UpdatePaymentResponse



This message has no fields defined.





 <!-- end messages -->


<a name="network-v1-provider-AppendLedgerEntriesRequest-AccountType"></a>

### AppendLedgerEntriesRequest.AccountType


| Name | Number | Description |
| ---- | ------ |-------------|
| ACCOUNT_TYPE_UNSPECIFIED | 0 |             |
| ACCOUNT_TYPE_USER_PAYABLE | 1 | Reflects the user's payable balance, the amount that the provider owes to the user. |
| ACCOUNT_TYPE_CASH | 2 | Reflects the cash balance of the provider. |
| ACCOUNT_TYPE_RESERVE | 3 | This is the reserve account of the provider, which reflects the reserve of balance to reduce the limit available from one provider to another. |
| ACCOUNT_TYPE_RESERVE_USAGE | 4 | This is the mirror account for the reserve. To keep the double entry accounting principle. |
| ACCOUNT_TYPE_PROVIDER_PAYABLE | 5 | Reflects how much the provider owes to the network or other participants. |
| ACCOUNT_TYPE_PROVIDER_RECEIVABLE | 6 | Reflects how much the provider is owed by the network or other participants. |
| ACCOUNT_TYPE_FEE_PAYABLE | 7 | Reflects the fees that the provider owes to the network. |
| ACCOUNT_TYPE_FEE_RECEIVABLE | 8 | Reflects the fees that the network is owed by the provider. |
| ACCOUNT_TYPE_FEE_EXPENSE | 9 | Reflects the fees that the provider has to pay for the services provided by the network. |
| ACCOUNT_TYPE_PROVIDER_SETTLEMENT | 10 | Reflects the settlement balance of the provider with the network or other participants. |



<a name="network-v1-provider-UpdatePaymentRequest-Failure-Reason"></a>

### UpdatePaymentRequest.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |


 <!-- end enums -->



## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |
