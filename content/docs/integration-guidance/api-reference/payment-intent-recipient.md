---
weight: 334
title: "Payment Intent Recipient"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---



<a name="tzero-v1-payment_intent-recipient-NetworkService"></a>

## NetworkService
NetworkService is used by recipient to create a payment intents

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| CreatePaymentIntent | [CreatePaymentIntentRequest](#tzero-v1-payment_intent-recipient-CreatePaymentIntentRequest) | [CreatePaymentIntentResponse](#tzero-v1-payment_intent-recipient-CreatePaymentIntentResponse) |  |
| GetQuote | [GetQuoteRequest](#tzero-v1-payment_intent-recipient-GetQuoteRequest) | [GetQuoteResponse](#tzero-v1-payment_intent-recipient-GetQuoteResponse) |  |


<a name="tzero-v1-payment_intent-recipient-RecipientService"></a>

## RecipientService
RecipientService is implemented by recipient in order to get updates on payment intents

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ConfirmPayIn | [ConfirmPayInRequest](#tzero-v1-payment_intent-recipient-ConfirmPayInRequest) | [ConfirmPayInResponse](#tzero-v1-payment_intent-recipient-ConfirmPayInResponse) | notifies recipient that pay-in providers received payment from payer |
| ConfirmPayment | [ConfirmPaymentRequest](#tzero-v1-payment_intent-recipient-ConfirmPaymentRequest) | [ConfirmPaymentResponse](#tzero-v1-payment_intent-recipient-ConfirmPaymentResponse) | notifies recipient about successful payment |
| RejectPaymentIntent | [RejectPaymentIntentRequest](#tzero-v1-payment_intent-recipient-RejectPaymentIntentRequest) | [RejectPaymentIntentResponse](#tzero-v1-payment_intent-recipient-RejectPaymentIntentResponse) | notifies recipient about failed payment |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-recipient-ConfirmPayInRequest"></a>

### ConfirmPayInRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from the CreatePaymentIntentResponse |
| payment_reference | [string](#string) |  | payment_reference from the CreatePaymentIntentRequest |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | pay-in payment method |







<a name="tzero-v1-payment_intent-recipient-ConfirmPayInResponse"></a>

### ConfirmPayInResponse



This message has no fields defined.






<a name="tzero-v1-payment_intent-recipient-ConfirmPaymentRequest"></a>

### ConfirmPaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from the CreatePaymentIntentResponse |
| payment_reference | [string](#string) |  | payment_reference from the CreatePaymentIntentRequest |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | pay-in payment method |
| pay_out_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | amount which will be paid out denominated in pay_out_currency of the payment intent |
| receipt | [tzero.v1.common.PaymentReceipt](#tzero-v1-common-PaymentReceipt) |  | Payment receipt might contain metadata about payment recognizable by pay-in provider. |







<a name="tzero-v1-payment_intent-recipient-ConfirmPaymentResponse"></a>

### ConfirmPaymentResponse



This message has no fields defined.






<a name="tzero-v1-payment_intent-recipient-CreatePaymentIntentRequest"></a>

### CreatePaymentIntentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_reference | [string](#string) |  | Idempotency Key payment reference to identify payment by client. |
| pay_in_currency | [string](#string) |  | Pay-in currency |
| pay_in_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Amount denominated in the pay-in currency |
| pay_out_currency | [string](#string) |  | Payout currency |
| pay_out_details | [tzero.v1.common.PaymentDetails](#tzero-v1-common-PaymentDetails) |  | Payout payment details |







<a name="tzero-v1-payment_intent-recipient-CreatePaymentIntentResponse"></a>

### CreatePaymentIntentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  |  |
| pay_in_payment_methods | [CreatePaymentIntentResponse.PaymentMethod](#tzero-v1-payment_intent-recipient-CreatePaymentIntentResponse-PaymentMethod) | repeated |  |







<a name="tzero-v1-payment_intent-recipient-CreatePaymentIntentResponse-PaymentMethod"></a>

### CreatePaymentIntentResponse.PaymentMethod



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_url | [string](#string) |  |  |
| provider_id | [uint32](#uint32) |  |  |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  |  |







<a name="tzero-v1-payment_intent-recipient-GetQuoteRequest"></a>

### GetQuoteRequest
TODO: enrich with more fields


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| pay_in_currency | [string](#string) |  | Pay-in currency |
| pay_in_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Amount denominated in the pay-in currency |
| pay_out_currency | [string](#string) |  | Payout currency |
| pay_in_payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | payment method to use for the pay-in, e.g. bank transfer, card, etc. |
| pay_out_payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | payment method to use for the pay-out, e.g. bank transfer, card, etc. |







<a name="tzero-v1-payment_intent-recipient-GetQuoteResponse"></a>

### GetQuoteResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quote | [GetQuoteResponse.Quote](#tzero-v1-payment_intent-recipient-GetQuoteResponse-Quote) |  |  |
| not_found | [GetQuoteResponse.NotFound](#tzero-v1-payment_intent-recipient-GetQuoteResponse-NotFound) |  |  |







<a name="tzero-v1-payment_intent-recipient-GetQuoteResponse-NotFound"></a>

### GetQuoteResponse.NotFound



This message has no fields defined.






<a name="tzero-v1-payment_intent-recipient-GetQuoteResponse-Quote"></a>

### GetQuoteResponse.Quote



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| rate | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Rate of pay-in currency to pay-out |
| expiration | [google.protobuf.Timestamp](#google-protobuf-Timestamp) |  | Time until when quote is valid. Used only for reference. Actual quote is determined at the moment of payment. |







<a name="tzero-v1-payment_intent-recipient-RejectPaymentIntentRequest"></a>

### RejectPaymentIntentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from the CreatePaymentIntentResponse |
| payment_reference | [string](#string) |  | payment_reference from the CreatePaymentIntentRequest |
| reason | [string](#string) |  |  |







<a name="tzero-v1-payment_intent-recipient-RejectPaymentIntentResponse"></a>

### RejectPaymentIntentResponse



This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->

