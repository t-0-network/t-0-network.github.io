---
weight: 333
title: "Payment Intent Provider"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---



<a name="tzero-v1-payment_intent-provider-NetworkService"></a>

## NetworkService
NetworkService is used by provider in order to notify network on payment intent updates

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| ConfirmPayment | [ConfirmPaymentRequest](#tzero-v1-payment_intent-provider-ConfirmPaymentRequest) | [ConfirmPaymentResponse](#tzero-v1-payment_intent-provider-ConfirmPaymentResponse) | Notify network about a successful payment for the corresponding payment intent |
| RejectPaymentIntent | [RejectPaymentIntentRequest](#tzero-v1-payment_intent-provider-RejectPaymentIntentRequest) | [RejectPaymentIntentResponse](#tzero-v1-payment_intent-provider-RejectPaymentIntentResponse) | Notify network about a payment failure for the corresponding payment intent |
| ConfirmSettlement | [ConfirmSettlementRequest](#tzero-v1-payment_intent-provider-ConfirmSettlementRequest) | [ConfirmSettlementResponse](#tzero-v1-payment_intent-provider-ConfirmSettlementResponse) | Notify network about relation between payment intent and settlement transaction. This method is not essential but helps to keep track of payment flow |


<a name="tzero-v1-payment_intent-provider-ProviderService"></a>

## ProviderService
ProviderService is implemented by provider to provide pay-in details fpr payment intents

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| CreatePaymentIntent | [CreatePaymentIntentRequest](#tzero-v1-payment_intent-provider-CreatePaymentIntentRequest) | [CreatePaymentIntentResponse](#tzero-v1-payment_intent-provider-CreatePaymentIntentResponse) | Network instructs provider to create payment details for the payment intent. Provide should return a list of supported payment method along with URL where payer should be redirected. |
| ConfirmPayout | [ConfirmPayoutRequest](#tzero-v1-payment_intent-provider-ConfirmPayoutRequest) | [ConfirmPayoutResponse](#tzero-v1-payment_intent-provider-ConfirmPayoutResponse) | Network notifies provider about successful payout for the corresponding payment intent |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-provider-ConfirmPaymentRequest"></a>

### ConfirmPaymentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | Payment intent ID must be positive

payment_intent_id from CreatePaymentIntentRequest |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | Payment method must be specified |







<a name="tzero-v1-payment_intent-provider-ConfirmPaymentResponse"></a>

### ConfirmPaymentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| settlement_amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | settlement amount denominated in settlement currency |
| payout_provider_id | [uint32](#uint32) |  |  |
| settlement_addresses | [ConfirmPaymentResponse.SettlementAddress](#tzero-v1-payment_intent-provider-ConfirmPaymentResponse-SettlementAddress) | repeated | payout provider could support multiple chains for settlement. Any of these could be used for settlement. |







<a name="tzero-v1-payment_intent-provider-ConfirmPaymentResponse-SettlementAddress"></a>

### ConfirmPaymentResponse.SettlementAddress



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| chain | [tzero.v1.common.Blockchain](#tzero-v1-common-Blockchain) |  |  |
| stablecoin | [tzero.v1.common.Stablecoin](#tzero-v1-common-Stablecoin) |  |  |
| address | [string](#string) |  |  |







<a name="tzero-v1-payment_intent-provider-ConfirmPayoutRequest"></a>

### ConfirmPayoutRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from CreatePaymentIntentRequest |
| payment_id | [uint64](#uint64) |  | corresponding payment_id for this payment intent |







<a name="tzero-v1-payment_intent-provider-ConfirmPayoutResponse"></a>

### ConfirmPayoutResponse



This message has no fields defined.






<a name="tzero-v1-payment_intent-provider-ConfirmSettlementRequest"></a>

### ConfirmSettlementRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| blockchain | [tzero.v1.common.Blockchain](#tzero-v1-common-Blockchain) |  |  |
| tx_hash | [string](#string) |  |  |
| payment_intent_id | [uint64](#uint64) | repeated | list of payment_intent_id's for this settlement (on-chain) transaction |







<a name="tzero-v1-payment_intent-provider-ConfirmSettlementResponse"></a>

### ConfirmSettlementResponse



This message has no fields defined.






<a name="tzero-v1-payment_intent-provider-CreatePaymentIntentRequest"></a>

### CreatePaymentIntentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | Payment intent ID must be positive

idempotency key |
| currency | [string](#string) |  | ISO 4217 currency code (3 uppercase letters)

pay-in currency |
| amount | [tzero.v1.common.Decimal](#tzero-v1-common-Decimal) |  | Amount is required

pay-in amount |







<a name="tzero-v1-payment_intent-provider-CreatePaymentIntentResponse"></a>

### CreatePaymentIntentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_methods | [CreatePaymentIntentResponse.PaymentMethod](#tzero-v1-payment_intent-provider-CreatePaymentIntentResponse-PaymentMethod) | repeated | At least one payment method should be provided |







<a name="tzero-v1-payment_intent-provider-CreatePaymentIntentResponse-PaymentMethod"></a>

### CreatePaymentIntentResponse.PaymentMethod



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_url | [string](#string) |  | Payment URL must be a valid URL |
| payment_method | [tzero.v1.common.PaymentMethodType](#tzero-v1-common-PaymentMethodType) |  | Payment method must be specified |







<a name="tzero-v1-payment_intent-provider-RejectPaymentIntentRequest"></a>

### RejectPaymentIntentRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](#uint64) |  | payment_intent_id from CreatePaymentIntentRequest |
| reason | [string](#string) |  |  |







<a name="tzero-v1-payment_intent-provider-RejectPaymentIntentResponse"></a>

### RejectPaymentIntentResponse



This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->

