---
weight: 338
title: "Common"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---


 <!-- end services -->


 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-common-Decimal"></a>

### Decimal
Decimal 123.45 equals to unscaled=12345 and exponent=-2 (e.g. unscaled * 10^exponent, 123.45 = 12345 * 10^-2)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| unscaled | [int64](#int64) |  |  |
| exponent | [int32](#int32) |  | Exponent should be reasonable for financial calculations (typically -8 to 8) |






 <!-- end messages -->


<a name="tzero-v1-common-Blockchain"></a>

### Blockchain


| Name | Number | Description |
| ---- | ------ | ----------- |
| BLOCKCHAIN_UNSPECIFIED | 0 |  |
| BLOCKCHAIN_BSC | 10 |  |
| BLOCKCHAIN_TRON | 100 |  |



<a name="tzero-v1-common-Stablecoin"></a>

### Stablecoin


| Name | Number | Description |
| ---- | ------ | ----------- |
| STABLECOIN_UNSPECIFIED | 0 |  |
| STABLECOIN_USDT | 10 |  |


 <!-- end enums -->



<a name="tzero-v1-common-AchPaymentDetails"></a>

### AchPaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| routing_number | [string](#string) |  | US bank routing number (9 digits) |
| account_number | [string](#string) |  | US bank account number (up to 17 digits) |
| account_holder_name | [string](#string) |  | Account holder name (1-70 characters) |
| account_type | [AchPaymentDetails.AchAccountType](#tzero-v1-common-AchPaymentDetails-AchAccountType) |  | Account type (checking or savings) |







<a name="tzero-v1-common-PaymentMethod"></a>

### PaymentMethod



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sepa | [SepaPaymentDetails](#tzero-v1-common-SepaPaymentDetails) |  |  |
| swift | [SwiftPaymentDetails](#tzero-v1-common-SwiftPaymentDetails) |  |  |
| stablecoin | [StablecoinPaymentDetails](#tzero-v1-common-StablecoinPaymentDetails) |  |  |
| ach | [AchPaymentDetails](#tzero-v1-common-AchPaymentDetails) |  |  |
| wire | [WirePaymentDetails](#tzero-v1-common-WirePaymentDetails) |  |  |







<a name="tzero-v1-common-SepaPaymentDetails"></a>

### SepaPaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| iban | [string](#string) |  | IBAN should be 15-34 characters, alphanumeric |
| beneficiary_name | [string](#string) |  | Beneficiary name should be 1-70 characters (SEPA standard) |
| payment_reference | [string](#string) |  | Payment reference up to 140 characters (SEPA standard) |







<a name="tzero-v1-common-StablecoinPaymentDetails"></a>

### StablecoinPaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| blockchain | [Blockchain](#tzero-v1-common-Blockchain) |  | Blockchain must be specified and not UNSPECIFIED |
| stablecoin | [Stablecoin](#tzero-v1-common-Stablecoin) |  | Stablecoin must be specified and not UNSPECIFIED |
| address | [string](#string) |  | Blockchain address should be a valid hex address (20-64 chars for most blockchains) |







<a name="tzero-v1-common-SwiftPaymentDetails"></a>

### SwiftPaymentDetails



This message has no fields defined.






<a name="tzero-v1-common-WirePaymentDetails"></a>

### WirePaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bank_name | [string](#string) |  | Bank name (1-70 characters) |
| bank_address | [string](#string) |  | Bank address (1-140 characters) |
| swift_code | [string](#string) |  | SWIFT/BIC code (8 or 11 characters) |
| account_number | [string](#string) |  | Account number (up to 34 characters for international compatibility) |
| beneficiary_name | [string](#string) |  | Beneficiary name (1-70 characters) |
| beneficiary_address | [string](#string) |  | Beneficiary address (1-140 characters) |
| wire_reference | [string](#string) |  | Wire reference/purpose (up to 140 characters) |






 <!-- end messages -->


<a name="tzero-v1-common-AchPaymentDetails-AchAccountType"></a>

### AchPaymentDetails.AchAccountType


| Name | Number | Description |
| ---- | ------ | ----------- |
| ACH_ACCOUNT_TYPE_UNSPECIFIED | 0 |  |
| ACH_ACCOUNT_TYPE_CHECKING | 10 |  |
| ACH_ACCOUNT_TYPE_SAVINGS | 20 |  |



<a name="tzero-v1-common-PaymentMethodType"></a>

### PaymentMethodType


| Name | Number | Description |
| ---- | ------ | ----------- |
| PAYMENT_METHOD_TYPE_UNSPECIFIED | 0 |  |
| PAYMENT_METHOD_TYPE_SEPA | 10 |  |
| PAYMENT_METHOD_TYPE_SWIFT | 20 |  |
| PAYMENT_METHOD_TYPE_CARD | 30 | only pay in |
| PAYMENT_METHOD_TYPE_STABLECOIN | 40 | only pay out |
| PAYMENT_METHOD_TYPE_ACH | 50 |  |
| PAYMENT_METHOD_TYPE_WIRE | 60 |  |


 <!-- end enums -->

