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

Payment Intent is a flow where:
1. Beneficiary provider creates a payment intent specifying amount/currency
2. End-user pays via one of the returned payment options
3. Pay-in provider confirms funds received
4. Settlement will happen periodically between providers

This service is hosted by the T-0 Network and called by providers.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| UpdateQuote | [UpdateQuoteRequest](#tzero-v1-payment_intent-UpdateQuoteRequest) | [UpdateQuoteResponse](#tzero-v1-payment_intent-UpdateQuoteResponse) | Used by the provider to publish payment intent (pay-in) quotes into the network. These quotes include tiered pricing bands and an expiration timestamp. |
| GetQuote | [GetQuoteRequest](#tzero-v1-payment_intent-GetQuoteRequest) | [GetQuoteResponse](#tzero-v1-payment_intent-GetQuoteResponse) | GetQuote returns available quotes for a given currency and amount.  Use this to check indicative rates before creating a payment intent. The returned quotes show which providers can accept pay-ins and their current rates.  Note: Quotes are indicative only. The actual rate used for settlement is determined at the time of ConfirmFundsReceived. |
| CreatePaymentIntent | [CreatePaymentIntentRequest](#tzero-v1-payment_intent-CreatePaymentIntentRequest) | [CreatePaymentIntentResponse](#tzero-v1-payment_intent-CreatePaymentIntentResponse) | CreatePaymentIntent initiates a new payment intent.  Called by the beneficiary provider (the one who will receive the settlement). The network finds suitable pay-in providers, retrieves their payment details, and returns available payment options to present to the end-user.  The returned payment_intent_id must be stored by the beneficiary provider to correlate with the PaymentIntentUpdate notification received later.  Idempotency: Multiple calls with the same external_reference return the same payment_intent_id. |
| ConfirmFundsReceived | [ConfirmFundsReceivedRequest](#tzero-v1-payment_intent-ConfirmFundsReceivedRequest) | [ConfirmFundsReceivedResponse](#tzero-v1-payment_intent-ConfirmFundsReceivedResponse) | ConfirmFundsReceived confirms that the pay-in provider has received funds from the end-user. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-payment_intent-ConfirmFundsReceivedRequest"></a>

### ConfirmFundsReceivedRequest
Request to confirm that funds have been received from the end-user.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_id | [uint64](../scalar/#uint64) |  | The payment intent ID being confirmed. Must be a valid, pending payment intent. |
| confirmation_code | [string](../scalar/#string) |  | Confirmation code received in the get payment details along with the payment_intent_id. This is to prevent the accidental confirmation of the wrong payment intent. |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method used by the end-user. Must match one of the payment methods returned in CreatePaymentIntentResponse. |
| transaction_reference | [string](../scalar/#string) |  | Transaction reference |
| originator_provider_legal_entity_id | [uint32](../scalar/#uint32) | optional | Legal entity ID of the pay-in provider that received the funds. Required when the provider has multiple registered legal entities. If the provider has a single entity, this field may be omitted. |







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


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| reason | [ConfirmFundsReceivedResponse.Reject.Reason](#tzero-v1-payment_intent-ConfirmFundsReceivedResponse-Reject-Reason) |  |  |







<a name="tzero-v1-payment_intent-CreatePaymentIntentRequest"></a>

### CreatePaymentIntentRequest
Request to create a new payment intent.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| external_reference | [string](../scalar/#string) |  | Provider-supplied unique identifier for this payment intent. Used for idempotency - subsequent requests with the same external_reference return the existing payment_intent_id instead of creating a new one. Should be unique per beneficiary provider. |
| currency | [string](../scalar/#string) |  | Pay-in currency code in ISO 4217 format. The currency that the end-user will pay in. |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Pay-in amount in the specified currency. The exact fiat amount the end-user should pay. |
| travel_rule_data | [CreatePaymentIntentRequest.TravelRuleData](#tzero-v1-payment_intent-CreatePaymentIntentRequest-TravelRuleData) |  | Travel rule compliance data. Required for regulatory compliance under FATF guidelines. |
| pay_in_provider_ids | [uint32](../scalar/#uint32) | repeated | Optional list of pay-in provider IDs to consider. When specified, only quotes from these providers will be used. When empty, all available providers are considered. |







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
| payment_intent_id | [uint64](../scalar/#uint64) |  | Unique identifier for this payment intent. Store this ID to correlate with: - PaymentIntentUpdate notifications you'll receive |
| pay_in_details | [PaymentIntentPayInDetails](#tzero-v1-payment_intent-PaymentIntentPayInDetails) | repeated | Available payment options for the end-user. Present these options to your user so they can choose how to pay. Each entry contains the payment details needed to complete the payment.  Indicative rate/fix are resolved live on every call, including idempotent retries. The set of options (provider, payment_method, payment_details) is fixed at first call; individual options whose underlying quote has lapsed are omitted on retry. |







<a name="tzero-v1-payment_intent-GetQuoteRequest"></a>

### GetQuoteRequest
Request to get indicative quotes for a currency/amount pair.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](../scalar/#string) |  | Pay-in currency code in ISO 4217 format. Examples: "EUR", "GBP", "USD", "KES" |
| amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Pay-in amount in the specified currency. This is the fiat amount the end-user will pay. |
| pay_in_provider_ids | [uint32](../scalar/#uint32) | repeated | Optional list of pay-in provider IDs to filter by. When specified, only quotes from these providers are returned. When empty, quotes from all providers are returned. |







<a name="tzero-v1-payment_intent-GetQuoteResponse"></a>

### GetQuoteResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| success | [GetQuoteResponse.Success](#tzero-v1-payment_intent-GetQuoteResponse-Success) |  |  |
| quote_not_found | [GetQuoteResponse.QuoteNotFound](#tzero-v1-payment_intent-GetQuoteResponse-QuoteNotFound) |  |  |







<a name="tzero-v1-payment_intent-GetQuoteResponse-QuoteNotFound"></a>

### GetQuoteResponse.QuoteNotFound
No providers have active quotes for the requested currency/amount.


This message has no fields defined.






<a name="tzero-v1-payment_intent-GetQuoteResponse-Success"></a>

### GetQuoteResponse.Success
Quotes were found for the requested currency/amount.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| best_quotes | [GetQuoteResponse.Success.IndicativeQuote](#tzero-v1-payment_intent-GetQuoteResponse-Success-IndicativeQuote) | repeated | Best quotes per payment method available for the specified currency and amount. |
| all_quotes | [GetQuoteResponse.Success.IndicativeQuote](#tzero-v1-payment_intent-GetQuoteResponse-Success-IndicativeQuote) | repeated | Available indicative quotes. Each entry represents a different pay-in provider and payment method combination. Use CreatePaymentIntent to get the actual payment details for making a payment. |







<a name="tzero-v1-payment_intent-GetQuoteResponse-Success-IndicativeQuote"></a>

### GetQuoteResponse.Success.IndicativeQuote
Represents an indicative quote from a pay-in provider.
Contains the payment method, provider info, and indicative exchange rate.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method type (e.g., SEPA, SWIFT, mobile money). |
| provider_id | [uint32](../scalar/#uint32) |  | The T-0 provider ID of the pay-in provider offering this quote. Providers can use this to identify counterparties. |
| indicative_rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Indicative exchange rate USD/XXX (base currency is always USD).  Note: This is indicative only. The actual rate is determined when pay-in provider calls ConfirmFundsReceived |
| indicative_fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Indicative fixed charge in USD retained by the pay-in provider per transfer. Settlement is calculated as (amount / indicative_rate) - indicative_fix. Indicative only: the actual fix is locked in at ConfirmFundsReceived time. |







<a name="tzero-v1-payment_intent-PaymentIntentPayInDetails"></a>

### PaymentIntentPayInDetails
Represents pay-in details for a payment intent option.
Contains the payment method, provider info, payment details, and indicative exchange rate.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | The payment method type (e.g., SEPA, SWIFT, mobile money). Determines which payment details format is provided. |
| provider_id | [uint32](../scalar/#uint32) |  | The T-0 provider ID of the pay-in provider offering this quote. Providers can use this to identify counterparties. |
| payment_details | [tzero.v1.common.PaymentDetails](../common_payment_method/#tzero-v1-common-PaymentDetails) |  | Payment details for the end-user to make the payment. Contains bank account info, mobile money details, etc. based on payment_method. This should be displayed to the end-user to complete their payment. |
| indicative_rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Indicative exchange rate USD/XXX (base currency is always USD).  Resolved live from the network's current quote snapshot on every call, including idempotent retries. The binding rate is locked in at ConfirmFundsReceived and may differ. |
| indicative_fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | Indicative fixed charge in USD retained by the pay-in provider per transfer. Settlement is calculated as (amount / indicative_rate) - indicative_fix.  Resolved live from the network's current quote snapshot on every call, including idempotent retries. The binding fix is locked in at ConfirmFundsReceived and may differ. |







<a name="tzero-v1-payment_intent-UpdateQuoteRequest"></a>

### UpdateQuoteRequest
Base currency is always USD, so the quotes are always in USD/currency format.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payment_intent_quotes | [UpdateQuoteRequest.Quote](#tzero-v1-payment_intent-UpdateQuoteRequest-Quote) | repeated | Zero or more quotes for pay-in operations, each quote must have a unique currency, and one or more bands, with the unique client_quote_id for each band. |







<a name="tzero-v1-payment_intent-UpdateQuoteRequest-Quote"></a>

### UpdateQuoteRequest.Quote



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| currency | [string](../scalar/#string) |  | BRL, EUR, GBP, etc. (ISO 4217 currency code) |
| payment_method | [tzero.v1.common.PaymentMethodType](../common_payment_method/#tzero-v1-common-PaymentMethodType) |  | Payment method must be specified |
| bands | [UpdateQuoteRequest.Quote.Band](#tzero-v1-payment_intent-UpdateQuoteRequest-Quote-Band) | repeated | list of bands for this quote |
| expiration | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | expiration time of the quote |
| timestamp | [google.protobuf.Timestamp](../scalar/#google-protobuf-Timestamp) |  | timestamp quote was created |







<a name="tzero-v1-payment_intent-UpdateQuoteRequest-Quote-Band"></a>

### UpdateQuoteRequest.Quote.Band



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| client_quote_id | [string](../scalar/#string) |  | unique client generated id for this band |
| max_amount | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | max amount of USD this quote is applicable for. Please look into documentation for valid amounts. |
| rate | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) |  | USD/currency rate |
| fix | [tzero.v1.common.Decimal](../common_common/#tzero-v1-common-Decimal) | optional | Fixed charge in USD retained by the pay-in provider per transfer. Covers flat operational costs that do not scale with amount (wire fees, rail fees, compliance checks). Subtracted from the settlement amount: settlement = (amount / rate) - fix. Defaults to 0 when absent — no fixed charge applied. |







<a name="tzero-v1-payment_intent-UpdateQuoteResponse"></a>

### UpdateQuoteResponse



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-payment_intent-ConfirmFundsReceivedResponse-Reject-Reason"></a>

### ConfirmFundsReceivedResponse.Reject.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| REJECT_REASON_UNSPECIFIED | 0 |  |
| REJECT_REASON_CONFIRMATION_CODE_MISMATCH | 10 |  |
| REJECT_REASON_NO_ACTIVE_QUOTE | 20 |  |
| REJECT_REASON_PROVIDER_NOT_ALLOWED | 30 |  |
| REJECT_REASON_AMOUNT_TOO_SMALL | 40 | The pay-in amount would yield a zero or negative beneficiary settlement (pay_in / rate − fix) at every active quote. |



<a name="tzero-v1-payment_intent-CreatePaymentIntentResponse-Failure-Reason"></a>

### CreatePaymentIntentResponse.Failure.Reason


| Name | Number | Description |
| ---- | ------ | ----------- |
| FAILURE_REASON_UNSPECIFIED | 0 |  |
| FAILURE_REASON_QUOTE_NOT_FOUND | 10 | No live quote covers the requested currency/amount. On first call this means the intent was never created. On an idempotent retry this means every stored offer has since lost its live quote; a subsequent retry may succeed once providers republish. |
| FAILURE_REASON_REJECTED | 20 | Payment intent rejected. |


 <!-- end enums -->


