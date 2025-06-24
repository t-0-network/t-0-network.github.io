---
weight: 332
title: "Network"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---




<a name="tzero-v1-network-NetworkService"></a>

## NetworkService
This service is used by provider to interact with the Network, e.g. push quotes and initiate payments.

All methods of this service are idempotent, meaning they are safe to retry and multiple calls with the same parameters will have no additional effect.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| UpdateQuote | [UpdateQuoteRequest](#tzero-v1-network-UpdateQuoteRequest) | [UpdateQuoteResponse](#tzero-v1-network-UpdateQuoteResponse) | Used by the provider to publish pay-in and pay-out quotes (FX rates) into the network. These quotes include tiered pricing bands and an expiration timestamp. This method is idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| GetPayoutQuote | [GetPayoutQuoteRequest](#tzero-v1-network-GetPayoutQuoteRequest) | [GetPayoutQuoteResponse](#tzero-v1-network-GetPayoutQuoteResponse) | Request the best available quote for a payout in a specific currency, for a given amount. If the payout quote exists, but the credit limit is exceeded, this quote will not be considered. |
| CreatePayment | [CreatePaymentRequest](#tzero-v1-network-CreatePaymentRequest) | [CreatePaymentResponse](#tzero-v1-network-CreatePaymentResponse) | Submit a request to create a new payment. PayIn currency and QuoteId are the optional parameters. If the payIn currency is not specified, the network will use USD as the default payIn currency, and considering the amount in USD. If specified, it must be a valid currency code - in this case the network will try to find the payIn quote for the specified currency and considering the band from the provider initiated this request. So this is only possible, if this provider already submitted the payIn quote for the specified currency using UpdateQuote rpc. If the quoteID is specified, it must be a valid quoteId that was previously returned by the GetPayoutQuote method. If the quoteId is not specified, the network will try to find a suitable quote for the payout currency and amount, same way as GetPayoutQuote rpc. This method is idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| UpdatePayout | [UpdatePayoutRequest](#tzero-v1-network-UpdatePayoutRequest) | [UpdatePayoutResponse](#tzero-v1-network-UpdatePayoutResponse) | Inform the network that a payout has been completed or failed. This endpoint is called by the payout provider, specifying the payment ID and payout ID, which was provided when the payout request was made to this provider. This method is idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| CreatePayIn | [CreatePayInRequest](#tzero-v1-network-CreatePayInRequest) | [CreatePayInResponse](#tzero-v1-network-CreatePayInResponse) | Inform the network that the provider has received a pay-in from the user. This method is idempotent, meaning that multiple calls with the same parameters will have no additional effect. |
| GetKycData | [GetKycDataRequest](#tzero-v1-network-GetKycDataRequest) | [GetKycDataResponse](#tzero-v1-network-GetKycDataResponse) | Retrieve KYC verification data (e.g., SumSub token) for a person involved in the payment. |

 <!-- end services -->

##  Requests And Response Types


<a name="tzero-v1-network-CreatePayInRequest"></a>

### CreatePayInRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [string](#string) |  |  |
| amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  |  |







<a name="tzero-v1-network-CreatePayInResponse"></a>

### CreatePayInResponse



This message has no fields defined.






<a name="tzero-v1-network-CreatePaymentRequest"></a>

### CreatePaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](#string) |  | unique client generated id for this payment |
| payout_currency | [string](#string) |  | ISO 4217 currency code, e.g. EUR, GBP, etc. in which the payout should be made |
| amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount in the payin currency, by default USD (if the payIn currency is not specified) |
| payin_currency | [string](#string) | optional | if not specified, USD is used for calculations |
| sender | [CreatePaymentRequest.Sender](#tzero-v1-network-CreatePaymentRequest-Sender) |  |  |
| recipient | [CreatePaymentRequest.Recipient](#tzero-v1-network-CreatePaymentRequest-Recipient) |  |  |
| quote_id | [QuoteId](#tzero-v1-network-QuoteId) | optional | if specified, must be a valid quoteId that was previously returned by the GetPayoutQuote method |







<a name="tzero-v1-network-CreatePaymentRequest-PrivatePerson"></a>

### CreatePaymentRequest.PrivatePerson
Work in progress


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| private_person_client_id | [string](#string) |  |  |
| first_name | [string](#string) |  |  |
| last_name | [string](#string) |  |  |







<a name="tzero-v1-network-CreatePaymentRequest-Recipient"></a>

### CreatePaymentRequest.Recipient
Work in progress


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| private_person | [CreatePaymentRequest.PrivatePerson](#tzero-v1-network-CreatePaymentRequest-PrivatePerson) |  |  |







<a name="tzero-v1-network-CreatePaymentRequest-Sender"></a>

### CreatePaymentRequest.Sender
Work in progress


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| private_person | [CreatePaymentRequest.PrivatePerson](#tzero-v1-network-CreatePaymentRequest-PrivatePerson) |  |  |







<a name="tzero-v1-network-CreatePaymentResponse"></a>

### CreatePaymentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](#string) |  | client generated id supplied in the request |
| success | [CreatePaymentResponse.Success](#tzero-v1-network-CreatePaymentResponse-Success) |  | Success response - means the payment was accepted, but the payout is not yet completed. This means, the network found a suitable quote for the payout currency and amount, and instructed the payout provider to process the payout. |
| failure | [CreatePaymentResponse.Failure](#tzero-v1-network-CreatePaymentResponse-Failure) |  | Failure response - means the payment was not accepted, e.g. the network could not find a suitable quote for the payout currency and amount, or the credit limit is exceeded for the available quotes. |







<a name="tzero-v1-network-CreatePaymentResponse-Failure"></a>

### CreatePaymentResponse.Failure



This message has no fields defined.






<a name="tzero-v1-network-CreatePaymentResponse-Success"></a>

### CreatePaymentResponse.Success



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [int64](#int64) |  | payment id assigned by the network |







<a name="tzero-v1-network-GetKycDataRequest"></a>

### GetKycDataRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| person_id | [string](#string) |  |  |







<a name="tzero-v1-network-GetKycDataResponse"></a>

### GetKycDataResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sumsub_kyc_token | [string](#string) |  |  |







<a name="tzero-v1-network-GetPayoutQuoteRequest"></a>

### GetPayoutQuoteRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_currency | [string](#string) |  | ISO 4217 currency code, e.g. EUR, GBP, etc. in which the payout should be made |
| amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount in quote currency, only USD is supported |
| quote_type | [QuoteType](#tzero-v1-network-QuoteType) |  | type of the quote, e.g. real-time or guaranteed |







<a name="tzero-v1-network-GetPayoutQuoteResponse"></a>

### GetPayoutQuoteResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | rate in USD/currency, e.g. 1.2345 for 1 USD = 1.2345 EUR |
| expiration | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | expiration time of the quote |
| quote_id | [QuoteId](#tzero-v1-network-QuoteId) |  |  |







<a name="tzero-v1-network-QuoteId"></a>

### QuoteId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quote_id | [int64](#int64) |  | unique identifier of the quote within the specified provider |
| provider_id | [int32](#int32) |  | provider id of the quote |







<a name="tzero-v1-network-UpdatePayoutRequest"></a>

### UpdatePayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [int64](#int64) |  | payment id assigned by the network, this is the same payment id that was provided in the PayoutRequest |
| payout_id | [int64](#int64) |  | payout id assigned by the payout provider, this is the same payout id that was provided in the PayoutRequest |
| success | [UpdatePayoutRequest.Success](#tzero-v1-network-UpdatePayoutRequest-Success) |  | success response with the details of the payout |
| failure | [UpdatePayoutRequest.Failure](#tzero-v1-network-UpdatePayoutRequest-Failure) |  | failure response with the reason of the failure |







<a name="tzero-v1-network-UpdatePayoutRequest-Failure"></a>

### UpdatePayoutRequest.Failure



This message has no fields defined.






<a name="tzero-v1-network-UpdatePayoutRequest-Success"></a>

### UpdatePayoutRequest.Success



This message has no fields defined.






<a name="tzero-v1-network-UpdatePayoutResponse"></a>

### UpdatePayoutResponse



This message has no fields defined.






<a name="tzero-v1-network-UpdateQuoteRequest"></a>

### UpdateQuoteRequest
Base currency is always USD, so the quotes are always in USD/currency format.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_out | [UpdateQuoteRequest.Quote](#tzero-v1-network-UpdateQuoteRequest-Quote) | repeated | Zero or more quotes for pay-out operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band. |
| pay_in | [UpdateQuoteRequest.Quote](#tzero-v1-network-UpdateQuoteRequest-Quote) | repeated | Zero or more quotes for pay-in operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band. |







<a name="tzero-v1-network-UpdateQuoteRequest-Quote"></a>

### UpdateQuoteRequest.Quote



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](#string) |  | BRL, EUR, GBP, etc. (ISO 4217 currency code) |
| quote_type | [QuoteType](#tzero-v1-network-QuoteType) |  | type of the quote, e.g. real-time or guaranteed |
| bands | [UpdateQuoteRequest.Quote.Band](#tzero-v1-network-UpdateQuoteRequest-Quote-Band) | repeated | list of bands for this quote |
| expiration | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | expiration time of the quote |
| timestamp | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | timestamp quote was created |







<a name="tzero-v1-network-UpdateQuoteRequest-Quote-Band"></a>

### UpdateQuoteRequest.Quote.Band



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_quote_id | [string](#string) |  | unique client generated id for this band |
| max_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | max amount of USD this quote is applicable for. Please look into documentation for valid amounts. |
| rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | USD/currency rate |







<a name="tzero-v1-network-UpdateQuoteResponse"></a>

### UpdateQuoteResponse



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-network-CreatePaymentResponse-Failure-Reason"></a>

### CreatePaymentResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ |-------------|
| REASON_UNSPECIFIED | 0 |             |



<a name="tzero-v1-network-QuoteType"></a>

### QuoteType


| Name | Number | Description |
| ---- | ------ | ----------- |
| QUOTE_TYPE_UNSPECIFIED | 0 |  |
| QUOTE_TYPE_REALTIME | 1 | real-time quote must be valid at least for 30 seconds (TBD) |


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
