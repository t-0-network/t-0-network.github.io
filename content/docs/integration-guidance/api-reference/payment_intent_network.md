---
weight: 334
title: "Payment Intent Network"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

<a name="tzero-v1-payment_intent-PaymentIntentService"></a>

## PaymentIntentService
PaymentIntentService provides Payment Intent APIs for providers.

Payment Intent is a pay-in initiated flow where:
1. Beneficiary provider creates a payment intent specifying amount/currency
2. End-user pays via one of the returned payment options
3. Pay-in provider confirms receipt, triggering settlement

This service is hosted by the T-0 Network and called by providers.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetQuote | [GetQuoteRequest](#tzero-v1-payment_intent-GetQuoteRequest) | [GetQuoteResponse](#tzero-v1-payment_intent-GetQuoteResponse) | GetQuote returns available quotes for a given currency and amount.  Use this to check indicative rates before creating a payment intent. The returned quotes show which providers can accept pay-ins and their current rates.  Note: Quotes are indicative only. The actual rate used for settlement is determined at the time of ConfirmFundsReceived. |
| CreatePaymentIntent | [CreatePaymentIntentRequest](#tzero-v1-payment_intent-CreatePaymentIntentRequest) | [CreatePaymentIntentResponse](#tzero-v1-payment_intent-CreatePaymentIntentResponse) | CreatePaymentIntent initiates a new payment intent.  Called by the beneficiary provider (the one who will receive the settlement). The network finds suitable pay-in providers, retrieves their payment details, and returns available payment options to present to the end-user.  Flow: 1. Network finds providers with quotes for the requested currency/amount 2. Network calls GetPaymentInstructions on each pay-in provider 3. Network stores the payment intent and returns available options  The returned payment_intent_id must be stored by the beneficiary provider to correlate with the PaymentIntentUpdate notification received later.  Idempotency: Multiple calls with the same external_reference return the same payment_intent_id. |
| ConfirmFundsReceived | [ConfirmFundsReceivedRequest](#tzero-v1-payment_intent-ConfirmFundsReceivedRequest) | [ConfirmFundsReceivedResponse](#tzero-v1-payment_intent-ConfirmFundsReceivedResponse) | ConfirmFundsReceived confirms that the pay-in provider has received funds from the end-user.  Called by the pay-in provider after verifying payment receipt. The provider is responsible for validating the received amount matches expectations.  On success: 1. Network finds the best quote from the last 30 minutes 2. Settlement amount is calculated using that quote's rate 3. Ledger entries are created (settlement + fees) 4. Beneficiary provider receives PaymentIntentUpdate notification  Important: This endpoint assumes full payment. Partial payments are not supported in V1. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-ConfirmFundsReceivedRequest"></a>

### ConfirmFundsReceivedRequest
Request to confirm that funds have been received from the end-user.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](../scalar/#uint64) |  | The payment intent ID being confirmed. Must be a valid, pending payment intent. |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method used by the end-user. Must match one of the payment methods returned in CreatePaymentIntentResponse. |







<a name="tzero-v1-payment_intent-ConfirmFundsReceivedResponse"></a>

### ConfirmFundsReceivedResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| accept | [ConfirmFundsReceivedResponse.Accept](#tzero-v1-payment_intent-ConfirmFundsReceivedResponse-Accept) |  | Funds confirmed successfully. Settlement will proceed. |
| reject | [ConfirmFundsReceivedResponse.Reject](#tzero-v1-payment_intent-ConfirmFundsReceivedResponse-Reject) |  | Funds receipt rejected. No settlement will occur. |







<a name="tzero-v1-payment_intent-ConfirmFundsReceivedResponse-Accept"></a>

### ConfirmFundsReceivedResponse.Accept
Funds accepted - settlement will proceed.
The beneficiary provider will receive a PaymentIntentUpdate notification
with settlement details.


This message has no fields defined.






<a name="tzero-v1-payment_intent-ConfirmFundsReceivedResponse-Reject"></a>

### ConfirmFundsReceivedResponse.Reject
Funds rejected.
Reserved for future use when credit limit checks or other validations
may cause rejection.


This message has no fields defined.






<a name="tzero-v1-payment_intent-CreatePaymentIntentRequest"></a>

### CreatePaymentIntentRequest
Request to create a new payment intent.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| external_reference | [string](../scalar/#string) |  | Provider-supplied unique identifier for this payment intent. Used for idempotency - subsequent requests with the same external_reference return the existing payment_intent_id instead of creating a new one.  Should be unique per beneficiary provider. Recommended format: UUID or combination of your internal transaction ID with a timestamp. |
| currency | [string](../scalar/#string) |  | Pay-in currency code in ISO 4217 format. The currency that the end-user will pay in. Examples: "EUR", "GBP", "USD", "KES" |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Pay-in amount in the specified currency. The exact fiat amount the end-user should pay. |
| travel_rule_data | [CreatePaymentIntentRequest.TravelRuleData](#tzero-v1-payment_intent-CreatePaymentIntentRequest-TravelRuleData) |  | Travel rule compliance data. Required for regulatory compliance under FATF guidelines. |







<a name="tzero-v1-payment_intent-CreatePaymentIntentRequest-TravelRuleData"></a>

### CreatePaymentIntentRequest.TravelRuleData
Travel rule data containing originator information.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | repeated | The natural or legal person or legal arrangement who is identified as the receiver of the requested payment. |
| payer | [ivms101.Person](../ivms_ivms101/#ivms101-Person) | optional | Optional travel rule data of the payer |







<a name="tzero-v1-payment_intent-CreatePaymentIntentResponse"></a>

### CreatePaymentIntentResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| success | [CreatePaymentIntentResponse.Success](#tzero-v1-payment_intent-CreatePaymentIntentResponse-Success) |  | Payment intent created successfully with available payment options. |
| failure | [CreatePaymentIntentResponse.Failure](#tzero-v1-payment_intent-CreatePaymentIntentResponse-Failure) |  | Failed to create payment intent. |







<a name="tzero-v1-payment_intent-CreatePaymentIntentResponse-Failure"></a>

### CreatePaymentIntentResponse.Failure
Payment intent creation failed.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [CreatePaymentIntentResponse.Failure.Reason](#tzero-v1-payment_intent-CreatePaymentIntentResponse-Failure-Reason) |  | The reason for failure. |







<a name="tzero-v1-payment_intent-CreatePaymentIntentResponse-Success"></a>

### CreatePaymentIntentResponse.Success
Payment intent created successfully.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](../scalar/#uint64) |  | Unique identifier for this payment intent. Store this ID to correlate with: - PaymentIntentUpdate notifications you'll receive - Any support inquiries or reconciliation needs |
| pay_in_details | [PaymentIntentPayInDetails](#tzero-v1-payment_intent-PaymentIntentPayInDetails) | repeated | Available payment options for the end-user. Present these options to your user so they can choose how to pay. Each entry contains the payment details needed to complete the payment. |







<a name="tzero-v1-payment_intent-GetQuoteRequest"></a>

### GetQuoteRequest
Request to get indicative quotes for a currency/amount pair.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](../scalar/#string) |  | Pay-in currency code in ISO 4217 format. Examples: "EUR", "GBP", "USD", "KES" |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Pay-in amount in the specified currency. This is the fiat amount the end-user will pay. |







<a name="tzero-v1-payment_intent-GetQuoteResponse"></a>

### GetQuoteResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| success | [GetQuoteResponse.Success](#tzero-v1-payment_intent-GetQuoteResponse-Success) |  |  |
| quote_not_found | [GetQuoteResponse.QuoteNotFound](#tzero-v1-payment_intent-GetQuoteResponse-QuoteNotFound) |  |  |







<a name="tzero-v1-payment_intent-GetQuoteResponse-QuoteNotFound"></a>

### GetQuoteResponse.QuoteNotFound
No providers have active quotes for the requested currency/amount.
This may occur if:
- No providers support the currency
- The amount is outside all providers' supported ranges
- All relevant quotes have expired


This message has no fields defined.






<a name="tzero-v1-payment_intent-GetQuoteResponse-Success"></a>

### GetQuoteResponse.Success
Quotes were found for the requested currency/amount.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| quotes | [GetQuoteResponse.Success.IndicativeQuote](#tzero-v1-payment_intent-GetQuoteResponse-Success-IndicativeQuote) | repeated | Available indicative quotes. Each entry represents a different pay-in provider and payment method combination. Use CreatePaymentIntent to get the actual payment details for making a payment. |







<a name="tzero-v1-payment_intent-GetQuoteResponse-Success-IndicativeQuote"></a>

### GetQuoteResponse.Success.IndicativeQuote
Represents an indicative quote from a pay-in provider.
Contains the payment method, provider info, and indicative exchange rate.
Does not include payment details - use CreatePaymentIntent to get those.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method type (e.g., SEPA, SWIFT, mobile money). |
| provider_id | [uint32](../scalar/#uint32) |  | The T-0 provider ID of the pay-in provider offering this quote. Used internally for routing; providers can use this to identify counterparties. |
| indicative_rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Indicative exchange rate USD/XXX (quote currency is always USD).  Note: This is indicative only. The actual rate is determined at ConfirmFundsReceived using the best quote available at that time from the pay-in provider. |







<a name="tzero-v1-payment_intent-PaymentIntentPayInDetails"></a>

### PaymentIntentPayInDetails
Represents pay-in details for a payment intent option.
Contains the payment method, provider info, payment details, and indicative exchange rate.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method type (e.g., SEPA, SWIFT, mobile money). Determines which payment details format is provided. |
| provider_id | [uint32](../scalar/#uint32) |  | The T-0 provider ID of the pay-in provider offering this quote. Used internally for routing; providers can use this to identify counterparties. |
| payment_details | [tzero.v1.common.PaymentDetails](../common_payment_method/#tzero-v1-common-PaymentDetails) |  | Payment details for the end-user to make the payment. Contains bank account info, mobile money details, etc. based on payment_method. This should be displayed to the end-user to complete their payment. |
| indicative_rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Indicative exchange rate USD/XXX (quote currency is always USD).  Note: This is indicative only. The actual rate is determined at ConfirmFundsReceived using the best quote available at that time from the pay-in provider. |






 <!-- end messages -->


<a name="tzero-v1-payment_intent-CreatePaymentIntentResponse-Failure-Reason"></a>

### CreatePaymentIntentResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| FAILURE_REASON_UNSPECIFIED | 0 |  |
| FAILURE_REASON_QUOTE_NOT_FOUND | 10 | No quotes found for the requested currency/amount. This may occur if: - No providers support the requested currency - The amount is outside all providers' supported ranges - All relevant quotes have expired |


 <!-- end enums -->


