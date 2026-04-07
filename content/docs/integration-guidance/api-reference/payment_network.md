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
| GetQuote | [GetQuoteRequest](#tzero-v1-payment-GetQuoteRequest) | [GetQuoteResponse](#tzero-v1-payment-GetQuoteResponse) | Request the best available quote for a payout in a specific currency, for a given amount. If the payout quote exists, but the credit limit is exceeded, this quote will not be considered. |
| CreatePayment | [CreatePaymentRequest](#tzero-v1-payment-CreatePaymentRequest) | [CreatePaymentResponse](#tzero-v1-payment-CreatePaymentResponse) | Submit a request to create a new payment for the specified pay-out currency. QuoteId is the optional parameter. If the quoteID is specified, it must be a valid quoteId that was previously returned by the GetPayoutQuote method. If the quoteId is not specified, the network will try to find a suitable quote for the payout currency and amount, same way as GetPayoutQuote rpc. |
| ConfirmPayout | [ConfirmPayoutRequest](#tzero-v1-payment-ConfirmPayoutRequest) | [ConfirmPayoutResponse](#tzero-v1-payment-ConfirmPayoutResponse) | Inform the network that a payout has been completed. This endpoint is called by the payout provider, specifying the payment ID and payout ID, which was provided when the payout request was made to this provider. deprecated, use the FinalizePayout rpc instead. |
| FinalizePayout | [FinalizePayoutRequest](#tzero-v1-payment-FinalizePayoutRequest) | [FinalizePayoutResponse](#tzero-v1-payment-FinalizePayoutResponse) |  |
| CompleteManualAmlCheck | [CompleteManualAmlCheckRequest](#tzero-v1-payment-CompleteManualAmlCheckRequest) | [CompleteManualAmlCheckResponse](#tzero-v1-payment-CompleteManualAmlCheckResponse) | Pay-out provider reports the result of manual AML check. This endpoint is called after the manual AML check is completed. The network will find the new best quotes for the payment and will return the updated settlement/payout amount along with the updated quotes in the response. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment-CompleteManualAmlCheckRequest"></a>

### CompleteManualAmlCheckRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](../scalar/#uint64) |  |  |
| approved | [CompleteManualAmlCheckRequest.Approved](#tzero-v1-payment-CompleteManualAmlCheckRequest-Approved) |  |  |
| rejected | [CompleteManualAmlCheckRequest.Rejected](#tzero-v1-payment-CompleteManualAmlCheckRequest-Rejected) |  |  |







<a name="tzero-v1-payment-CompleteManualAmlCheckRequest-Approved"></a>

### CompleteManualAmlCheckRequest.Approved



This message has no fields defined.






<a name="tzero-v1-payment-CompleteManualAmlCheckRequest-Rejected"></a>

### CompleteManualAmlCheckRequest.Rejected



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [string](../scalar/#string) |  |  |







<a name="tzero-v1-payment-CompleteManualAmlCheckResponse"></a>

### CompleteManualAmlCheckResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| approved | [CompleteManualAmlCheckResponse.Approved](#tzero-v1-payment-CompleteManualAmlCheckResponse-Approved) |  |  |
| rejected | [CompleteManualAmlCheckResponse.Rejected](#tzero-v1-payment-CompleteManualAmlCheckResponse-Rejected) |  |  |







<a name="tzero-v1-payment-CompleteManualAmlCheckResponse-Approved"></a>

### CompleteManualAmlCheckResponse.Approved



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | updated amount based on updated quote approved by the  pay-in provider |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | updated settlement amount based on updated quote approved by the  pay-in provider |
| pay_out_quote_id | [int64](../scalar/#int64) |  | unique identifier of the updated pay-out quote |
| pay_out_client_quote_id | [string](../scalar/#string) |  | client_quote_id of the updated pay-out quote assigned by pay-out provider |







<a name="tzero-v1-payment-CompleteManualAmlCheckResponse-Rejected"></a>

### CompleteManualAmlCheckResponse.Rejected
Rejected means that the updated quotes were rejected by pay-in provider, and the payout provider should not proceed
with the payout.


This message has no fields defined.






<a name="tzero-v1-payment-ConfirmPayoutRequest"></a>

### ConfirmPayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](../scalar/#uint64) |  | payment id assigned by the network, this is the same payment id that was provided in the PayoutRequest |
| payout_id | [uint64](../scalar/#uint64) |  | **Deprecated.** deprecated, this is 1->1 mapping between payment and payout ids |
| receipt | [tzero.v1.common.PaymentReceipt](../common_payment_receipt/#tzero-v1-common-PaymentReceipt) | optional | Payment receipt might contain metadata about payment recognizable by pay-in provider. |







<a name="tzero-v1-payment-ConfirmPayoutResponse"></a>

### ConfirmPayoutResponse



This message has no fields defined.






<a name="tzero-v1-payment-CreatePaymentRequest"></a>

### CreatePaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](../scalar/#string) |  | unique client generated id for this payment |
| amount | [PaymentAmount](#tzero-v1-payment-PaymentAmount) |  | payment amount - should be either pay-out amount or settlement amount |
| currency | [string](../scalar/#string) |  | pay-out currency |
| payment_details | [tzero.v1.common.PaymentDetails](../common_payment_method/#tzero-v1-common-PaymentDetails) |  | pay-out payment details |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) | optional | if specified, must be a valid quoteId that was previously returned by the GetPayoutQuote method otherwise last available quote will be used |
| travel_rule_data | [CreatePaymentRequest.TravelRuleData](#tzero-v1-payment-CreatePaymentRequest-TravelRuleData) | optional | travel rule data |







<a name="tzero-v1-payment-CreatePaymentRequest-TravelRuleData"></a>

### CreatePaymentRequest.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| originator | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | the natural or legal person that requests payment with originating provider |
| beneficiary | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | the natural or legal person or legal arrangement who is identified by the originator as the receiver of the requested payment. |
| originator_provider_legal_entity_id | [uint32](../scalar/#uint32) | optional | Legal entity ID of the originating provider. Required when the provider has multiple registered legal entities. If the provider has a single entity, this field may be omitted. |







<a name="tzero-v1-payment-CreatePaymentResponse"></a>

### CreatePaymentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](../scalar/#string) |  | client generated id supplied in the request |
| accepted | [CreatePaymentResponse.Accepted](#tzero-v1-payment-CreatePaymentResponse-Accepted) |  | Accepted response - the payment was accepted by the network and it's going to be passed to payout provider. Means the network found a suitable quote for the payout currency and amount. |
| settlement_required | [CreatePaymentResponse.SettlementRequired](#tzero-v1-payment-CreatePaymentResponse-SettlementRequired) |  | **Deprecated.** Deprecated: Settlement required response - presettlement flow is being removed. This response type will no longer be returned. |
| failure | [CreatePaymentResponse.Failure](#tzero-v1-payment-CreatePaymentResponse-Failure) |  | Failure response - means the payment was not accepted, e.g. the network could not find a suitable quote for the payout currency and amount, or the credit limit is exceeded for the available quotes. |







<a name="tzero-v1-payment-CreatePaymentResponse-Accepted"></a>

### CreatePaymentResponse.Accepted



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](../scalar/#uint64) |  | payment ID assigned by the network |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  |  |
| payout_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  |  |
| payout_provider_id | [uint32](../scalar/#uint32) |  | payout provider id with the best quote selected for this payment |







<a name="tzero-v1-payment-CreatePaymentResponse-Failure"></a>

### CreatePaymentResponse.Failure



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [CreatePaymentResponse.Failure.Reason](#tzero-v1-payment-CreatePaymentResponse-Failure-Reason) |  |  |







<a name="tzero-v1-payment-CreatePaymentResponse-SettlementRequired"></a>

### CreatePaymentResponse.SettlementRequired
Deprecated: presettlement flow is being removed. This message will no longer be used.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](../scalar/#uint64) |  | payment ID assigned by the network |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  |  |
| payout_provider_id | [uint32](../scalar/#uint32) |  | payout provider id with the best quote selected for this payment |







<a name="tzero-v1-payment-FinalizePayoutRequest"></a>

### FinalizePayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](../scalar/#uint64) |  | payment id assigned by the network, this is the same payment id that was provided in the PayoutRequest |
| success | [FinalizePayoutRequest.Success](#tzero-v1-payment-FinalizePayoutRequest-Success) |  |  |
| failure | [FinalizePayoutRequest.Failure](#tzero-v1-payment-FinalizePayoutRequest-Failure) |  |  |







<a name="tzero-v1-payment-FinalizePayoutRequest-Failure"></a>

### FinalizePayoutRequest.Failure



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [string](../scalar/#string) |  |  |







<a name="tzero-v1-payment-FinalizePayoutRequest-Success"></a>

### FinalizePayoutRequest.Success



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| receipt | [tzero.v1.common.PaymentReceipt](../common_payment_receipt/#tzero-v1-common-PaymentReceipt) | optional | Payment receipt might contain metadata about payment recognizable by pay-in provider. |







<a name="tzero-v1-payment-FinalizePayoutResponse"></a>

### FinalizePayoutResponse



This message has no fields defined.






<a name="tzero-v1-payment-GetQuoteRequest"></a>

### GetQuoteRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| amount | [PaymentAmount](#tzero-v1-payment-PaymentAmount) |  | payment amount - must be either pay-out amount or settlement amount |
| pay_out_currency | [string](../scalar/#string) |  | ISO 4217 currency code, e.g. EUR, GBP, etc. in which the payout should be made |
| pay_out_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | payment method to use for the payout, e.g. bank transfer, card, etc. |
| quote_type | [QuoteType](#tzero-v1-payment-QuoteType) |  | type of the quote, e.g. real-time |







<a name="tzero-v1-payment-GetQuoteResponse"></a>

### GetQuoteResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| success | [GetQuoteResponse.Success](#tzero-v1-payment-GetQuoteResponse-Success) |  | Success response - the network found a suitable quote for the provided parameters and with available credit or pre-settlement option. The returned quoteId can be used later to call the create payment endpoint. |
| failure | [GetQuoteResponse.Failure](#tzero-v1-payment-GetQuoteResponse-Failure) |  | Failure response - means the quote was not found for the specified parameters, or provider limits would exceed by processing the payment amount with the specified amount. |
| all_quotes | [GetQuoteResponse.ProviderQuote](#tzero-v1-payment-GetQuoteResponse-ProviderQuote) | repeated | All best quotes from providers with credit lines. Each quote is the best rate for that provider for the requested amount. Includes has_sufficient_credit flag to indicate if quote can be executed immediately. Always returned alongside success/failure - providers can compare alternatives or see options when no executable quote exists. |







<a name="tzero-v1-payment-GetQuoteResponse-Failure"></a>

### GetQuoteResponse.Failure



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [GetQuoteResponse.Failure.Reason](#tzero-v1-payment-GetQuoteResponse-Failure-Reason) |  |  |







<a name="tzero-v1-payment-GetQuoteResponse-ProviderQuote"></a>

### GetQuoteResponse.ProviderQuote
Best quote from a provider with credit line configured.
Contains settlement status and calculated amounts for the payment request.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) |  | Quote identification - can be used to initiate payment |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Exchange rate: USD/pay_out_currency |
| expiration | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | Quote validity period |
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Payout amount in payout currency |
| settlement | [GetQuoteResponse.ProviderQuote.Settlement](#tzero-v1-payment-GetQuoteResponse-ProviderQuote-Settlement) |  | Settlement details for this quote |
| executable | [bool](../scalar/#bool) |  | Indicates payment can be initiated with this quote immediately and no pre-funding is required |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Fixed charge in USD per transfer for this provider's quote. |







<a name="tzero-v1-payment-GetQuoteResponse-ProviderQuote-Settlement"></a>

### GetQuoteResponse.ProviderQuote.Settlement
Settlement details between pay-in and pay-out providers.
All amounts are in USD (settlement currency).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Settlement amount required for this payment |
| credit_limit | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Total credit limit from payout provider |
| total_used | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Total amount used from credit line (completed + reserved) |
| prefunding_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Additional funding needed before payment can proceed (amount - max_executable) |







<a name="tzero-v1-payment-GetQuoteResponse-Success"></a>

### GetQuoteResponse.Success



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | pay-out quote rate in settlement_currency/pay_out_currency, i.e. USD/pay_out_currency |
| expiration | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | expiration time of the payout quote |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) |  | id of the payout quote |
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | pay-out amount in pay-out currency if the quote from response is used |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | settlement amount in settlement currency if the quote from response is used |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Fixed charge in USD included in settlement_amount. settlement_amount = (pay_out_amount / rate) + fix. |







<a name="tzero-v1-payment-PaymentAmount"></a>

### PaymentAmount
Payment amount could be specified either as settlement amount and then converted to corresponding amount of pay-out amount
or as pay-out amount, so that the settlement amount is calculated accordingly


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Amount in the pay-out currency |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Settlement amount in the settlement currency |







<a name="tzero-v1-payment-QuoteId"></a>

### QuoteId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quote_id | [int64](../scalar/#int64) |  | unique identifier of the quote within the specified provider |
| provider_id | [int32](../scalar/#int32) |  | provider id of the quote |







<a name="tzero-v1-payment-UpdateQuoteRequest"></a>

### UpdateQuoteRequest
Base currency is always USD, so the quotes are always in USD/currency format.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_out | [UpdateQuoteRequest.Quote](#tzero-v1-payment-UpdateQuoteRequest-Quote) | repeated | Zero or more quotes for pay-out operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band. |
| pay_in | [UpdateQuoteRequest.Quote](#tzero-v1-payment-UpdateQuoteRequest-Quote) | repeated | **Deprecated.** Zero or more quotes for pay-in operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band.  Deprecated: pay-in quotes are no longer used. |







<a name="tzero-v1-payment-UpdateQuoteRequest-Quote"></a>

### UpdateQuoteRequest.Quote



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](../scalar/#string) |  | BRL, EUR, GBP, etc. (ISO 4217 currency code) |
| quote_type | [QuoteType](#tzero-v1-payment-QuoteType) |  |  |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | Payment method must be specified |
| bands | [UpdateQuoteRequest.Quote.Band](#tzero-v1-payment-UpdateQuoteRequest-Quote-Band) | repeated | list of bands for this quote |
| expiration | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | expiration time of the quote |
| timestamp | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | timestamp quote was created |







<a name="tzero-v1-payment-UpdateQuoteRequest-Quote-Band"></a>

### UpdateQuoteRequest.Quote.Band



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_quote_id | [string](../scalar/#string) |  | unique client generated id for this band |
| max_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | max amount of USD this quote is applicable for. Please look into documentation for valid amounts. |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | USD/currency rate |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) | optional | Fixed charge in USD applied per transfer on top of the exchange rate. This covers payment method costs (e.g. wire transfer fees). Added to the settlement amount: settlement = (amount / rate) + fix. Defaults to 0 when absent — no fixed charge applied. |







<a name="tzero-v1-payment-UpdateQuoteResponse"></a>

### UpdateQuoteResponse



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-payment-CreatePaymentResponse-Failure-Reason"></a>

### CreatePaymentResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |
| REASON_QUOTE_NOT_FOUND | 10 | No matching quote for the specified payout currency found or provider limits would exceed by processing this payment |
| REASON_CREDIT_OR_PREDEPOSIT_REQUIRED | 20 | Payments with amount in pay out currency require available credit or pre-deposit |



<a name="tzero-v1-payment-GetQuoteResponse-Failure-Reason"></a>

### GetQuoteResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |
| REASON_QUOTE_NOT_FOUND | 10 | No matching quote par for the specified payout currency found or provider limits would exceed by processing this payment |



<a name="tzero-v1-payment-QuoteType"></a>

### QuoteType


| Name | Number | Description |
| ---- | ------ | ----------- |
| QUOTE_TYPE_UNSPECIFIED | 0 |  |
| QUOTE_TYPE_REALTIME | 1 | real-time quote must be valid at least for 30 seconds (TBD) |


 <!-- end enums -->


