---
weight: 333
title: "Payment Intent Beneficiary"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

<a name="tzero-v1-payment_intent-BeneficiaryService"></a>

## BeneficiaryService
Beneficiary provider surface for payment intent status notifications.

Beneficiary providers are those who:
- Create payment intents via CreatePaymentIntent
- Receive settlement (in settlement currency via configured blockchain network)
- Need to be notified of payment status changes

Notifications are delivered when:
- Funds have been received from the payer by pay-in provider

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| PaymentIntentUpdate | [PaymentIntentUpdateRequest](#tzero-v1-payment_intent-PaymentIntentUpdateRequest) | [PaymentIntentUpdateResponse](#tzero-v1-payment_intent-PaymentIntentUpdateResponse) | PaymentIntentUpdate notifies the beneficiary provider of status changes.  Delivery is retried on failure or timeout; handling must be idempotent. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-PaymentIntentUpdateRequest"></a>

### PaymentIntentUpdateRequest
Notification of a payment intent status change.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](../scalar/#uint64) |  | The payment intent ID this update relates to. Matches the ID returned in CreatePaymentIntentResponse. |
| funds_received | [PaymentIntentUpdateRequest.FundsReceived](#tzero-v1-payment_intent-PaymentIntentUpdateRequest-FundsReceived) |  | Funds were received from the payer by pay-in provider. |







<a name="tzero-v1-payment_intent-PaymentIntentUpdateRequest-FundsReceived"></a>

### PaymentIntentUpdateRequest.FundsReceived
Notification that funds were received from the payer by pay-in provider.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| settlement_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | The settlement amount credited to the beneficiary balance. This is calculated as: (source_amount / rate) - fix  Note: Fees are NOT deducted from this amount. Fees are tracked separately and settled in periodic fee settlements. |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | The exchange rate used for settlement. |
| payment_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | The fiat amount received from the end-user. Matches the amount originally requested in CreatePaymentIntent. |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method used for the pay-in |
| transaction_reference | [string](../scalar/#string) |  | Pay-in's rail-native reference (SEPA EndToEndId, SWIFT UETR, PIX e2e_id), forwarded from ConfirmFundsReceived. Reconcile against the beneficiary's records; serves as the anchor for dispute resolution. |
| travel_rule_data | [PaymentIntentUpdateRequest.FundsReceived.TravelRuleData](#tzero-v1-payment_intent-PaymentIntentUpdateRequest-FundsReceived-TravelRuleData) |  | Travel rule data of the pay-in provider's legal entity that received the funds. Present when the pay-in provider has registered travel rule data. |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Flat USD surcharge retained by the pay-in provider per transfer. Already subtracted from settlement_amount. Settlement is computed as (payment_amount / rate) - fix. |







<a name="tzero-v1-payment_intent-PaymentIntentUpdateRequest-FundsReceived-TravelRuleData"></a>

### PaymentIntentUpdateRequest.FundsReceived.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| originator_provider | [ivms101.LegalPerson](../ivms_ivms101/#ivms101-LegalPerson) |  | IVMS101 legal person data of the originating provider's legal entity. |







<a name="tzero-v1-payment_intent-PaymentIntentUpdateResponse"></a>

### PaymentIntentUpdateResponse
Acknowledgment of receiving the payment intent update.
Empty response indicates successful processing.
Return an error status code if processing failed and retry is needed.


This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->


