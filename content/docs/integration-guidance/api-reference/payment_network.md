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
Publishes quotes and creates pay-out payments. Every method is safe to retry.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| UpdateQuote | [UpdateQuoteRequest](#tzero-v1-payment-UpdateQuoteRequest) | [UpdateQuoteResponse](#tzero-v1-payment-UpdateQuoteResponse) | Publishes pay-out quotes. Each request is a full snapshot: a quote left out is deleted. |
| GetQuote | [GetQuoteRequest](#tzero-v1-payment-GetQuoteRequest) | [GetQuoteResponse](#tzero-v1-payment-GetQuoteResponse) | Returns the best pay-out quote for an amount. A quote whose credit line cannot cover the amount is not picked. |
| CreatePayment | [CreatePaymentRequest](#tzero-v1-payment-CreatePaymentRequest) | [CreatePaymentResponse](#tzero-v1-payment-CreatePaymentResponse) | Creates a pay-out payment. With quote_id, the payment uses that quote from GetQuote. Without it, the best quote is picked, as GetQuote does. |
| ConfirmPayout | [ConfirmPayoutRequest](#tzero-v1-payment-ConfirmPayoutRequest) | [ConfirmPayoutResponse](#tzero-v1-payment-ConfirmPayoutResponse) | Reports that a payout is complete. Deprecated: use FinalizePayout. |
| FinalizePayout | [FinalizePayoutRequest](#tzero-v1-payment-FinalizePayoutRequest) | [FinalizePayoutResponse](#tzero-v1-payment-FinalizePayoutResponse) | Reports the final result of a payout: success with an optional receipt, or failure with a reason. |
| CompleteManualAmlCheck | [CompleteManualAmlCheckRequest](#tzero-v1-payment-CompleteManualAmlCheckRequest) | [CompleteManualAmlCheckResponse](#tzero-v1-payment-CompleteManualAmlCheckResponse) | Reports the result of a manual AML check on a payment. On approval, the response carries the updated settlement/payout amount and quotes. |

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
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | updated amount based on updated quote approved by the Payout Requester |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | updated settlement amount based on updated quote approved by the Payout Requester |
| pay_out_quote_id | [int64](../scalar/#int64) |  | unique identifier of the updated pay-out quote |
| pay_out_client_quote_id | [string](../scalar/#string) |  | client_quote_id of the updated pay-out quote assigned by the Payout Provider |







<a name="tzero-v1-payment-CompleteManualAmlCheckResponse-Rejected"></a>

### CompleteManualAmlCheckResponse.Rejected
Rejected means that the updated quotes were rejected by the Payout Requester, and the Payout Provider should not proceed
with the payout.


This message has no fields defined.






<a name="tzero-v1-payment-ConfirmPayoutRequest"></a>

### ConfirmPayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_id | [uint64](../scalar/#uint64) |  | payment id assigned by the network, this is the same payment id that was provided in the PayoutRequest |
| payout_id | [uint64](../scalar/#uint64) |  | **Deprecated.** deprecated, this is 1->1 mapping between payment and payout ids |
| receipt | [tzero.v1.common.PaymentReceipt](../common_payment_receipt/#tzero-v1-common-PaymentReceipt) | optional | Payment receipt might contain metadata about payment recognizable by the Payout Requester. |







<a name="tzero-v1-payment-ConfirmPayoutResponse"></a>

### ConfirmPayoutResponse



This message has no fields defined.






<a name="tzero-v1-payment-CreatePaymentRequest"></a>

### CreatePaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](../scalar/#string) |  | Client id of the payment. To retry, resend the same id, also with a new amount or quote. Once accepted, the id returns that payment, or AlreadyExists if the amount or currency differs. A retry of a `failure` under a new id can pay the payment out twice. |
| amount | [PaymentAmount](#tzero-v1-payment-PaymentAmount) |  | payment amount - should be either pay-out amount or settlement amount |
| currency | [string](../scalar/#string) |  | pay-out currency |
| payment_details | [tzero.v1.common.PaymentDetails](../common_payment_method/#tzero-v1-common-PaymentDetails) |  | pay-out payment details |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) | optional | a quote from GetQuote; without it, the best quote is picked |
| travel_rule_data | [CreatePaymentRequest.TravelRuleData](#tzero-v1-payment-CreatePaymentRequest-TravelRuleData) |  | travel rule data |







<a name="tzero-v1-payment-CreatePaymentRequest-TravelRuleData"></a>

### CreatePaymentRequest.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| originator | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | the natural or legal person that requests payment with the Payout Requester |
| beneficiary | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | the natural or legal person or legal arrangement who is identified by the originator as the receiver of the requested payment. |
| originator_provider_legal_entity_id | [uint32](../scalar/#uint32) | optional | Legal entity of the Payout Requester. Required only when the provider has more than one. |







<a name="tzero-v1-payment-CreatePaymentResponse"></a>

### CreatePaymentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_client_id | [string](../scalar/#string) |  | client generated id supplied in the request |
| accepted | [CreatePaymentResponse.Accepted](#tzero-v1-payment-CreatePaymentResponse-Accepted) |  | The payment was accepted and will be passed to the payout provider. A suitable quote was found for the pay-out currency and amount. |
| settlement_required | [CreatePaymentResponse.SettlementRequired](#tzero-v1-payment-CreatePaymentResponse-SettlementRequired) |  | **Deprecated.** Deprecated: no longer returned. |
| failure | [CreatePaymentResponse.Failure](#tzero-v1-payment-CreatePaymentResponse-Failure) |  | The payment was not accepted. The reason says why. |







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
Deprecated: no longer used.


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
| receipt | [tzero.v1.common.PaymentReceipt](../common_payment_receipt/#tzero-v1-common-PaymentReceipt) | optional | Payment receipt might contain metadata about payment recognizable by the Payout Requester. |







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
| success | [GetQuoteResponse.Success](#tzero-v1-payment-GetQuoteResponse-Success) |  | A suitable quote was found for the provided parameters, with available credit or pre-settlement option. Use the returned quoteId to call CreatePayment. |
| failure | [GetQuoteResponse.Failure](#tzero-v1-payment-GetQuoteResponse-Failure) |  | No quote can serve the request. The reason says why. |
| all_quotes | [GetQuoteResponse.ProviderQuote](#tzero-v1-payment-GetQuoteResponse-ProviderQuote) | repeated | The best quote of each provider with a credit line, for the requested amount. Returned with both success and failure. |







<a name="tzero-v1-payment-GetQuoteResponse-Failure"></a>

### GetQuoteResponse.Failure



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [GetQuoteResponse.Failure.Reason](#tzero-v1-payment-GetQuoteResponse-Failure-Reason) |  |  |







<a name="tzero-v1-payment-GetQuoteResponse-ProviderQuote"></a>

### GetQuoteResponse.ProviderQuote
Best quote for each provider with a credit line configured.
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
Settlement details between the Payout Requester and the Payout Provider.
All amounts are in USD (settlement currency).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Settlement amount required for this payment |
| credit_limit | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Total credit limit from payout provider |
| total_used | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Total amount used from credit line (completed + reserved) |
| prefunding_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Additional funding needed before this quote can be executed |







<a name="tzero-v1-payment-GetQuoteResponse-Success"></a>

### GetQuoteResponse.Success



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | pay-out quote rate in settlement_currency/pay_out_currency, i.e. USD/pay_out_currency |
| expiration | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | expiration time of the payout quote |
| quote_id | [QuoteId](#tzero-v1-payment-QuoteId) |  | id of the payout quote |
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | pay-out amount in pay-out currency if the quote from response is used |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | settlement amount in settlement currency if the quote from response is used |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Fixed charge in USD, included in settlement_amount. The settlement amount is rounded up to the cent, and the pay-out amount is rounded down. |







<a name="tzero-v1-payment-PaymentAmount"></a>

### PaymentAmount
The amount as a pay-out amount or as a settlement amount. The other amount is computed from it.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_out_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Amount in the pay-out currency. At most 2 decimal places; trailing zeros are allowed; otherwise InvalidArgument. |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Settlement amount in the settlement currency. At most 2 decimal places; trailing zeros are allowed; otherwise InvalidArgument. |







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
| pay_out | [UpdateQuoteRequest.Quote](#tzero-v1-payment-UpdateQuoteRequest-Quote) | repeated | Pay-out quotes. Each band has a unique client_quote_id. |







<a name="tzero-v1-payment-UpdateQuoteRequest-Quote"></a>

### UpdateQuoteRequest.Quote



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](../scalar/#string) |  | BRL, EUR, GBP, etc. (ISO 4217 currency code) |
| quote_type | [QuoteType](#tzero-v1-payment-QuoteType) |  | **Deprecated.** Deprecated: rate type is no longer used; the server ignores the value. |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | Payment method must be specified |
| bands | [UpdateQuoteRequest.Quote.Band](#tzero-v1-payment-UpdateQuoteRequest-Quote-Band) | repeated | list of bands for this quote |
| expiration | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | Expiration time of the quote. Must be at least the network's minimum quote validity after the network receives the request; otherwise InvalidArgument. |
| timestamp | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | timestamp quote was created |







<a name="tzero-v1-payment-UpdateQuoteRequest-Quote-Band"></a>

### UpdateQuoteRequest.Quote.Band



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_quote_id | [string](../scalar/#string) |  | unique client generated id for this band |
| max_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Maximum amount of USD this band applies to. |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | USD/currency rate |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) | optional | Fixed charge in USD per transfer, added to the settlement amount. Absent means no charge. |







<a name="tzero-v1-payment-UpdateQuoteResponse"></a>

### UpdateQuoteResponse



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-payment-CreatePaymentResponse-Failure-Reason"></a>

### CreatePaymentResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |
| REASON_QUOTE_NOT_FOUND | 10 | No quote fits the currency, payment method and amount, or no credit line exists. |
| REASON_CREDIT_OR_PREDEPOSIT_REQUIRED | 20 | Quotes exist, but no credit line covers the amount. GetQuote shows the prefunding each provider needs. |
| REASON_AMOUNT_EXCEEDS_QUOTE_BAND | 30 | The amount is above the pinned quote's maximum. Retry with a smaller amount, or with a new quote from GetQuote. |
| REASON_QUOTE_EXPIRED | 40 | The pinned quote has expired. Retry with a new quote from GetQuote. |
| REASON_QUOTE_ID_UNKNOWN | 50 | The pinned quote id is unknown. A retry with the same quote id fails again. |
| REASON_AMOUNT_TOO_SMALL | 60 | The settlement_amount is too small to pay out anything after the quote's fix. Retry with a larger settlement_amount. |



<a name="tzero-v1-payment-GetQuoteResponse-Failure-Reason"></a>

### GetQuoteResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REASON_UNSPECIFIED | 0 |  |
| REASON_QUOTE_NOT_FOUND | 10 | No quote fits the currency, payment method and amount, or no credit line exists. |
| REASON_CREDIT_OR_PREDEPOSIT_REQUIRED | 20 | Quotes exist, but no credit line covers the amount. all_quotes shows the prefunding each provider needs. |
| REASON_AMOUNT_TOO_SMALL | 30 | The settlement_amount is too small to pay out anything after the quote's fix. Retry with a larger settlement_amount. |



<a name="tzero-v1-payment-QuoteType"></a>

### QuoteType


| Name | Number | Description |
| ---- | ------ | ----------- |
| QUOTE_TYPE_UNSPECIFIED | 0 |  |
| QUOTE_TYPE_REALTIME | 1 |  |


 <!-- end enums -->


