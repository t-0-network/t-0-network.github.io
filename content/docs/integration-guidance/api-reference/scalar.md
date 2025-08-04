---
weight: 339
title: "Scalar Types"
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



<a name="tzero-v1-common-PaymentMethod"></a>

### PaymentMethod



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sepa | [SepaPaymentMethod](#tzero-v1-common-SepaPaymentMethod) |  |  |
| swift | [SwiftPaymentMethod](#tzero-v1-common-SwiftPaymentMethod) |  |  |
| stablecoin | [StablecoinPaymentMethod](#tzero-v1-common-StablecoinPaymentMethod) |  |  |







<a name="tzero-v1-common-SepaPaymentMethod"></a>

### SepaPaymentMethod



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| iban | [string](#string) |  |  |
| beneficiary_name | [string](#string) |  |  |
| payment_reference | [string](#string) |  |  |







<a name="tzero-v1-common-StablecoinPaymentMethod"></a>

### StablecoinPaymentMethod



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| blockchain | [Blockchain](#tzero-v1-common-Blockchain) |  |  |
| stablecoin | [Stablecoin](#tzero-v1-common-Stablecoin) |  |  |
| address | [string](#string) |  |  |







<a name="tzero-v1-common-SwiftPaymentMethod"></a>

### SwiftPaymentMethod



This message has no fields defined.





 <!-- end messages -->


<a name="tzero-v1-common-PaymentMethodType"></a>

### PaymentMethodType


| Name | Number | Description |
| ---- | ------ | ----------- |
| PAYMENT_METHOD_TYPE_UNSPECIFIED | 0 |  |
| PAYMENT_METHOD_TYPE_SEPA | 10 |  |
| PAYMENT_METHOD_TYPE_SWIFT | 20 |  |
| PAYMENT_METHOD_TYPE_CARD | 30 | only pay in |
| PAYMENT_METHOD_TYPE_STABLECOIN | 40 | only pay out |


 <!-- end enums -->




## Scalar Value Types

| .proto Type | Notes | C++ | Java | Python | Go | C# | PHP | Ruby |
| ----------- | ----- | --- | ---- | ------ | -- | -- | --- | ---- |
| <a name="double" /> double |  | double | double | float | float64 | double | float | Float |
| <a name="float" /> float |  | float | float | float | float32 | float | float | Float |
| <a name="int32" /> int32 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint32 instead. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="int64" /> int64 | Uses variable-length encoding. Inefficient for encoding negative numbers – if your field is likely to have negative values, use sint64 instead. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="uint32" /> uint32 | Uses variable-length encoding. | uint32 | int | int/long | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="uint64" /> uint64 | Uses variable-length encoding. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum or Fixnum (as required) |
| <a name="sint32" /> sint32 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int32s. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sint64" /> sint64 | Uses variable-length encoding. Signed int value. These more efficiently encode negative numbers than regular int64s. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="fixed32" /> fixed32 | Always four bytes. More efficient than uint32 if values are often greater than 2^28. | uint32 | int | int | uint32 | uint | integer | Bignum or Fixnum (as required) |
| <a name="fixed64" /> fixed64 | Always eight bytes. More efficient than uint64 if values are often greater than 2^56. | uint64 | long | int/long | uint64 | ulong | integer/string | Bignum |
| <a name="sfixed32" /> sfixed32 | Always four bytes. | int32 | int | int | int32 | int | integer | Bignum or Fixnum (as required) |
| <a name="sfixed64" /> sfixed64 | Always eight bytes. | int64 | long | int/long | int64 | long | integer/string | Bignum |
| <a name="bool" /> bool |  | bool | boolean | boolean | bool | bool | boolean | TrueClass/FalseClass |
| <a name="string" /> string | A string must always contain UTF-8 encoded or 7-bit ASCII text. | string | String | str/unicode | string | string | string | String (UTF-8) |
| <a name="bytes" /> bytes | May contain any arbitrary sequence of bytes. | string | ByteString | str | []byte | ByteString | string | String (ASCII-8BIT) |
