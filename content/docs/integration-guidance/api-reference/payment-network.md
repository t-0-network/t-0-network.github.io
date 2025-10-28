---
weight: 331
title: "Payment Network"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---



<a name="tzero-v1-payment-NetworkService"></a>

## NetworkService
This service is used by provider to interact with the Network, e.g. push quotes and initiate payments.

All methods of this service are idempotent, meaning they are safe to retry and multiple calls with the same parameters will have no additional effect.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| UpdateQuote | [UpdateQuoteRequest](#tzero-v1-payment-UpdateQuoteRequest) | [UpdateQuoteResponse](#tzero-v1-payment-UpdateQuoteResponse) | Used by the provider to publish pay-in and pay-out quotes (FX rates) into the network. These quotes include tiered pricing bands and an expiration timestamp. |
| GetQuote | [GetQuoteRequest](#tzero-v1-payment-GetQuoteRequest) | [GetQuoteResponse](#tzero-v1-payment-GetQuoteResponse) | Request the best available quote for a payout in a specific currency, for a given amount. If the payout quote exists, but the credit limit is exceeded, this quote will not be considered. Before calling this endpoint UpdateQuote should be periodically triggered in order to put pay-in quotes into the network. |
| CreatePayment | [CreatePaymentRequest](#tzero-v1-payment-CreatePaymentRequest) | [CreatePaymentResponse](#tzero-v1-payment-CreatePaymentResponse) | Submit a request to create a new payment. PayIn currency and QuoteId are the optional parameters. If the payIn currency is not specified, the network will use USD as the default payIn currency, and considering the amount in USD. If specified, it must be a valid currency code - in this case the network will try to find the payIn quote for the specified currency and considering the band from the provider initiated this request. So this is only possible, if this provider already submitted the payIn quote for the specified currency using UpdateQuote rpc. If the quoteID is specified, it must be a valid quoteId that was previously returned by the GetPayoutQuote method. If the quoteId is not specified, the network will try to find a suitable quote for the payout currency and amount, same way as GetPayoutQuote rpc. |
| ConfirmPayout | [ConfirmPayoutRequest](#tzero-v1-payment-ConfirmPayoutRequest) | [ConfirmPayoutResponse](#tzero-v1-payment-ConfirmPayoutResponse) | Inform the network that a payout has been completed. This endpoint is called by the payout provider, specifying the payment ID and payout ID, which was provided when the payout request was made to this provider. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment-ConfirmPayoutRequest"></a>

### ConfirmPayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  | payment id assigned by the network, this is the same payment id that was provided in the PayoutRequest |
| payout_id | [uint64](#uint64) |  | payout id assigned by the payout provider, this is the same payout id that was provided in the PayoutRequest |
| receipt | [tzero.v1.common.PaymentReceipt](#tzero-v1-common-PaymentReceipt) |  | Payment receipt might contain metadata about payment recognizable by pay-in provider. |







<a name="tzero-v1-payment-ConfirmPayoutResponse"></a>

### ConfirmPayoutResponse



This message has no fields defined.






<a name="tzero-v1-payment-CreatePaymentRequest"></a>

### CreatePaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](#string) |  | unique client generated id for this payment |
| amount | [PaymentAmount](#tzero-v1-payment-PaymentAmount) |  | payment amount |
| pay_in | [CreatePaymentRequest.PayIn](#tzero-v1-payment-CreatePaymentRequest-PayIn) |  | pay-in details |
| pay_out | [CreatePaymentRequest.PayOut](#tzero-v1-payment-CreatePaymentRequest-PayOut) |  | payout details |
| travel_rule_data | [CreatePaymentRequest.TravelRuleData](#tzero-v1-payment-CreatePaymentRequest-TravelRuleData) | optional | travel rule data |







<a name="tzero-v1-payment-CreatePaymentRequest-PayIn"></a>

### CreatePaymentRequest.PayIn
Provider must submit quotes to the network for the specified pay-in currency and payment method


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](#string) |  | pay-in currency |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | pay-in payment method |







<a name="tzero-v1-payment-CreatePaymentRequest-PayOut"></a>

### CreatePaymentRequest.PayOut



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](#string) |  | pay-out currency |
| payment_method | [tzero.v1.common.PaymentMethod](#tzero-v1-common-PaymentMethod) |  | pay-in payment details |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) | optional | if specified, must be a valid quoteId that was previously returned by the GetPayoutQuote method otherwise last available quote will be used |







<a name="tzero-v1-payment-CreatePaymentRequest-TravelRuleData"></a>

### CreatePaymentRequest.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| originator | [ivms101.Person](#ivms101-Person) | repeated | the natural or legal person that requests payment with originating provider |
| beneficiary | [ivms101.Person](#ivms101-Person) | repeated | the natural or legal person or legal arrangement who is identified by the originator as the receiver of the requested payment. |







<a name="tzero-v1-payment-CreatePaymentResponse"></a>

### CreatePaymentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](#string) |  | client generated id supplied in the request |
| success | [CreatePaymentResponse.Success](#tzero-v1-payment-CreatePaymentResponse-Success) |  | Success response - means the payment was accepted, but the payout is not yet completed. This means, the network found a suitable quote for the payout currency and amount, and instructed the payout provider to process the payout. |
| failure | [CreatePaymentResponse.Failure](#tzero-v1-payment-CreatePaymentResponse-Failure) |  | Failure response - means the payment was not accepted, e.g. the network could not find a suitable quote for the payout currency and amount, or the credit limit is exceeded for the available quotes. |







<a name="tzero-v1-payment-CreatePaymentResponse-Failure"></a>

### CreatePaymentResponse.Failure



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [CreatePaymentResponse.Failure.Reason](#tzero-v1-payment-CreatePaymentResponse-Failure-Reason) |  |  |







<a name="tzero-v1-payment-CreatePaymentResponse-Success"></a>

### CreatePaymentResponse.Success



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](#uint64) |  | payment ID assigned by the network |
| pay_in_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  |  |
| settlement_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  |  |







<a name="tzero-v1-payment-GetQuoteRequest"></a>

### GetQuoteRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_in_currency | [string](#string) |  | ISO 4217 currency code, e.g. EUR, GBP, etc. in which the payout should be made |
| amount | [PaymentAmount](#tzero-v1-payment-PaymentAmount) |  | amount |
| pay_in_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | payment method to use for the payout, e.g. bank transfer, card, etc. |
| pay_out_currency | [string](#string) |  | ISO 4217 currency code, e.g. EUR, GBP, etc. in which the payout should be made |
| pay_out_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | payment method to use for the payout, e.g. bank transfer, card, etc. |
| quote_type | [QuoteType](#tzero-v1-payment-QuoteType) |  | type of the quote, e.g. real-time or guaranteed |







<a name="tzero-v1-payment-GetQuoteResponse"></a>

### GetQuoteResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | exchange rate as pay_out_currency_rate/pay_in_currency_rate, e.g. BRL/EUR |
| expiration | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | expiration time of the payout quote |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) |  | id of the payout quote |







<a name="tzero-v1-payment-PaymentAmount"></a>

### PaymentAmount
Payment amount could be specified eiter as pay-in amount and then converted to corresponding amount of pay-out amount
or as pay-out amount, so that pay-in and settlement amounts are calculated accordingly


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_in_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Amount in the pay-in currency |
| pay_out_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Amount in the pay-out currency |







<a name="tzero-v1-payment-QuoteId"></a>

### QuoteId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quote_id | [int64](#int64) |  | unique identifier of the quote within the specified provider |
| provider_id | [int32](#int32) |  | provider id of the quote |







<a name="tzero-v1-payment-UpdateQuoteRequest"></a>

### UpdateQuoteRequest
Base currency is always USD, so the quotes are always in USD/currency format.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_out | [UpdateQuoteRequest.Quote](#tzero-v1-payment-UpdateQuoteRequest-Quote) | repeated | Zero or more quotes for pay-out operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band. |
| pay_in | [UpdateQuoteRequest.Quote](#tzero-v1-payment-UpdateQuoteRequest-Quote) | repeated | Zero or more quotes for pay-in operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band. |







<a name="tzero-v1-payment-UpdateQuoteRequest-Quote"></a>

### UpdateQuoteRequest.Quote



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](#string) |  | BRL, EUR, GBP, etc. (ISO 4217 currency code) |
| quote_type | [QuoteType](#tzero-v1-payment-QuoteType) |  |  |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | Payment method must be specified |
| bands | [UpdateQuoteRequest.Quote.Band](#tzero-v1-payment-UpdateQuoteRequest-Quote-Band) | repeated | list of bands for this quote |
| expiration | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | expiration time of the quote |
| timestamp | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | timestamp quote was created |







<a name="tzero-v1-payment-UpdateQuoteRequest-Quote-Band"></a>

### UpdateQuoteRequest.Quote.Band



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_quote_id | [string](#string) |  | unique client generated id for this band |
| max_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | max amount of USD this quote is applicable for. Please look into documentation for valid amounts. |
| rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | USD/currency rate |







<a name="tzero-v1-payment-UpdateQuoteResponse"></a>

### UpdateQuoteResponse



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-payment-CreatePaymentResponse-Failure-Reason"></a>

### CreatePaymentResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |
| REASON_QUOTE_NOT_FOUND | 10 | No matching quote par for the specified pay-in and payout currencies found or provider limits would exceed by processing this payment |



<a name="tzero-v1-payment-QuoteType"></a>

### QuoteType


| Name | Number | Description |
| ---- | ------ | ----------- |
| QUOTE_TYPE_UNSPECIFIED | 0 |  |
| QUOTE_TYPE_REALTIME | 1 | real-time quote must be valid at least for 30 seconds (TBD) |


 <!-- end enums -->

