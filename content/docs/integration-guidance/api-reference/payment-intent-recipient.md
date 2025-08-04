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


<a name="tzero-v1-payment_intent-recipient-RecipientService"></a>

## RecipientService
RecipientService is implemented by recipient in order to get updates on payment intents

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ConfirmPayment | [ConfirmPaymentRequest](#tzero-v1-payment_intent-recipient-ConfirmPaymentRequest) | [ConfirmPaymentIntentResponse](#tzero-v1-payment_intent-recipient-ConfirmPaymentIntentResponse) | notifies recipient about successful payment |
| RejectPaymentIntent | [RejectPaymentIntentRequest](#tzero-v1-payment_intent-recipient-RejectPaymentIntentRequest) | [RejectPaymentIntentResponse](#tzero-v1-payment_intent-recipient-RejectPaymentIntentResponse) | notifies recipient about failed payment |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-recipient-ConfirmPaymentIntentResponse"></a>

### ConfirmPaymentIntentResponse



This message has no fields defined.






<a name="tzero-v1-payment_intent-recipient-ConfirmPaymentRequest"></a>

### ConfirmPaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from the CreatePaymentIntentRequest |
| payment_reference | [string](#string) |  |  |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  |  |







<a name="tzero-v1-payment_intent-recipient-CreatePaymentIntentRequest"></a>

### CreatePaymentIntentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_reference | [string](#string) |  | Idempotency Key payment reference to identify payment by client.

idempotency key |
| pay_in_currency | [string](#string) |  | Pay-in currency

pay-in currency |
| pay_in_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Amount denominated in the pay-in currency |
| pay_out_currency | [string](#string) |  | Payout currency

pay-out currency |
| pay_out_method | [tzero.v1.common.PaymentMethod](#tzero-v1-common-PaymentMethod) |  | Payout payment method |







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







<a name="tzero-v1-payment_intent-recipient-RejectPaymentIntentRequest"></a>

### RejectPaymentIntentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from the CreatePaymentIntentRequest |
| payment_reference | [string](#string) |  | payment_reference from the CreatePaymentIntentRequest |
| reason | [string](#string) |  |  |







<a name="tzero-v1-payment_intent-recipient-RejectPaymentIntentResponse"></a>

### RejectPaymentIntentResponse



This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->

