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
| exponent | [int32](#int32) |  |  |






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
| routing_number | [string](#string) |  |  |
| account_number | [string](#string) |  |  |
| account_holder_name | [string](#string) |  |  |
| account_type | [AchPaymentDetails.AchAccountType](#tzero-v1-common-AchPaymentDetails-AchAccountType) |  |  |







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
| iban | [string](#string) |  |  |
| beneficiary_name | [string](#string) |  |  |
| payment_reference | [string](#string) |  |  |







<a name="tzero-v1-common-StablecoinPaymentDetails"></a>

### StablecoinPaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| blockchain | [Blockchain](#tzero-v1-common-Blockchain) |  |  |
| stablecoin | [Stablecoin](#tzero-v1-common-Stablecoin) |  |  |
| address | [string](#string) |  |  |







<a name="tzero-v1-common-SwiftPaymentDetails"></a>

### SwiftPaymentDetails



This message has no fields defined.






<a name="tzero-v1-common-WirePaymentDetails"></a>

### WirePaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bank_name | [string](#string) |  |  |
| bank_address | [string](#string) |  |  |
| swift_code | [string](#string) |  |  |
| account_number | [string](#string) |  |  |
| beneficiary_name | [string](#string) |  |  |
| beneficiary_address | [string](#string) |  |  |
| wire_reference | [string](#string) |  |  |






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

