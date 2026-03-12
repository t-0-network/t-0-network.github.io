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
PayInProviderService must be implemented by pay-in providers to participate
in the Payment Intent flow.

Pay-in providers are those who:
- Receive fiat payments from end-users
- Publish pay-in quotes to the network
- Confirm when payments are received via ConfirmFundsReceived

The network calls this service to obtain payment details that will be
presented to end-users for making payments.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetPaymentDetails | [GetPaymentDetailsRequest](#tzero-v1-payment_intent-GetPaymentDetailsRequest) | [GetPaymentDetailsResponse](#tzero-v1-payment_intent-GetPaymentDetailsResponse) | GetPaymentDetails returns payment details for the end-user.  Called by the network during CreatePaymentIntent processing. The provider should return payment details (bank accounts, mobile money info, etc.) that the end-user can use to send funds.  The provider may return details for multiple payment methods if requested. Each returned PaymentDetails will be presented to the end-user as a payment option.  Important considerations: - Payment details should be valid for the expected payment timeframe - Include any reference numbers needed to identify incoming payments - The provider is responsible for monitoring incoming payments and calling ConfirmFundsReceived |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-GetPaymentDetailsRequest"></a>

### GetPaymentDetailsRequest
Request for payment details.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](../scalar/#uint64) |  | The payment intent ID this request relates to. Can be used for logging, reference tracking, or payment reconciliation. |
| payment_methods | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) | repeated | Payment methods being requested. The provider should return PaymentDetails for each method they support. Methods the provider doesn't support can be omitted from the response. |
| currency | [string](../scalar/#string) |  | The currency for the pay-in. ISO 4217 currency code (e.g., "EUR", "GBP", "KES"). |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | The amount to be paid in the specified currency. Payment details should be suitable for receiving this amount. |
| travel_rule | [GetPaymentDetailsRequest.TravelRuleData](#tzero-v1-payment_intent-GetPaymentDetailsRequest-TravelRuleData) |  | Travel rule data for this payment |







<a name="tzero-v1-payment_intent-GetPaymentDetailsRequest-TravelRuleData"></a>

### GetPaymentDetailsRequest.TravelRuleData



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | The natural or legal person or legal arrangement who is identified by the beneficiary provider as the receiver of the requested payment. |
| beneficiary_provider | [ivms101.LegalPerson](../ivms_ivms101/#ivms101-LegalPerson) |  | Beneficiary provider travel rule data. |
| payer | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | optional | Optional travel rule data of the payer |







<a name="tzero-v1-payment_intent-GetPaymentDetailsResponse"></a>

### GetPaymentDetailsResponse
Response containing payment details for the requested methods.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_details | [tzero.v1.common.PaymentDetails](../common_payment_method/#tzero-v1-common-PaymentDetails) | repeated | Payment details for each supported payment method. May contain fewer items than requested if the provider doesn't support some of the requested payment methods.  Each PaymentDetails contains the information needed for an end-user to send a payment (e.g., bank account details, mobile money number). |






 <!-- end messages -->

 <!-- end enums -->


