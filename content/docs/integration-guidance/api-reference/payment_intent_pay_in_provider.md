---
weight: 335
title: "Payment Intent Pay-In Provider"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

<a name="tzero-v1-payment_intent-PayInProviderService"></a>

## PayInProviderService
Pay-in provider surface for the Payment Intent flow.

Pay-in providers are those who:
- Receive fiat payments from end-users
- Publish payment intent (pay-in) quotes to the network
- Confirm when payments are received via ConfirmFundsReceived
- Settles periodically with the beneficiary provider

Provides the payment details presented to end-users for making payments.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetPaymentDetails | [GetPaymentDetailsRequest](#tzero-v1-payment_intent-GetPaymentDetailsRequest) | [GetPaymentDetailsResponse](#tzero-v1-payment_intent-GetPaymentDetailsResponse) | Returns the payment details (bank account, mobile money, etc.) an end-user uses to send funds. The details must carry a payment reference that ties an incoming payment back to its payment intent. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-GetPaymentDetailsRequest"></a>

### GetPaymentDetailsRequest
Request for payment details.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](../scalar/#uint64) |  | The payment intent ID this request relates to. |
| confirmation_code | [string](../scalar/#string) |  | This is the confirmation code to be used later with ConfirmFundsReceived endpoint to prevent accidental confirmation of the wrong payment intent |
| payment_methods | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) | repeated | Payment methods to return PaymentDetails for. Each is drawn from a previously submitted quote. |
| currency | [string](../scalar/#string) |  | The currency for the pay-in. ISO 4217 currency code (e.g., "EUR", "GBP", "KES"). |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | The amount to be paid in the specified currency. |
| travel_rule | [GetPaymentDetailsRequest.TravelRuleData](#tzero-v1-payment_intent-GetPaymentDetailsRequest-TravelRuleData) |  | Travel rule data for this payment |
| beneficiary_provider_id | [uint32](../scalar/#uint32) |  | The T-0 provider ID of the beneficiary provider (the FI the funds are destined for). Stable, opaque identifier for the beneficiary. |







<a name="tzero-v1-payment_intent-GetPaymentDetailsRequest-TravelRuleData"></a>

### GetPaymentDetailsRequest.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | The natural or legal person or legal arrangement who is identified by the beneficiary provider as the receiver of the requested payment. |
| beneficiary_provider | [ivms101.LegalPerson](../ivms_ivms101/#ivms101-LegalPerson) |  | Beneficiary provider travel rule data. |
| payer | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | optional | no validation: ivms101.Person opaque to protovalidate; structural checks delegated to travel-rule layer |







<a name="tzero-v1-payment_intent-GetPaymentDetailsResponse"></a>

### GetPaymentDetailsResponse
Response containing payment details for the requested methods.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| details | [GetPaymentDetailsResponse.Details](#tzero-v1-payment_intent-GetPaymentDetailsResponse-Details) |  |  |
| rejection | [GetPaymentDetailsResponse.Rejection](#tzero-v1-payment_intent-GetPaymentDetailsResponse-Rejection) |  |  |







<a name="tzero-v1-payment_intent-GetPaymentDetailsResponse-Details"></a>

### GetPaymentDetailsResponse.Details



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_details | [tzero.v1.common.PaymentDetails](../common_payment_method/#tzero-v1-common-PaymentDetails) | repeated | Payment details for each supported payment method. Each entry carries the information an end-user needs to send a payment (bank account, mobile money, etc.) plus a payment reference that identifies the incoming payment. |







<a name="tzero-v1-payment_intent-GetPaymentDetailsResponse-Rejection"></a>

### GetPaymentDetailsResponse.Rejection



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [string](../scalar/#string) |  |  |






 <!-- end messages -->

 <!-- end enums -->


