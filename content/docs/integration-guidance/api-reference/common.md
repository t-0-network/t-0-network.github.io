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



<a name="tzero-v1-common-PaymentDetails"></a>

### PaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sepa | [PaymentDetails.Sepa](#tzero-v1-common-PaymentDetails-Sepa) |  | SEPA (Single Euro Payments Area) - Euro bank transfers across European countries |
| swift | [PaymentDetails.Swift](#tzero-v1-common-PaymentDetails-Swift) |  | SWIFT (Society for Worldwide Interbank Financial Telecommunication) - International wire transfers Global (200+ countries) |
| stablecoin | [PaymentDetails.Stablecoin](#tzero-v1-common-PaymentDetails-Stablecoin) |  | Stablecoin - Cryptocurrency transfers pegged to fiat currencies Global |
| ach | [PaymentDetails.Ach](#tzero-v1-common-PaymentDetails-Ach) |  | ACH (Automated Clearing House) - Electronic bank-to-bank transfers United States |
| wire | [PaymentDetails.Wire](#tzero-v1-common-PaymentDetails-Wire) |  | Wire - Domestic electronic funds transfer United States |
| fps | [PaymentDetails.Fps](#tzero-v1-common-PaymentDetails-Fps) |  | FPS (Faster Payments Service) United Kingdom |
| mpesa | [PaymentDetails.MPesa](#tzero-v1-common-PaymentDetails-MPesa) |  | M-Pesa - Mobile money transfer and payment service Kenya, Tanzania, Mozambique, DRC, Lesotho, Ghana, Egypt, South Africa |
| gcash | [PaymentDetails.GCash](#tzero-v1-common-PaymentDetails-GCash) |  | GCash - Mobile wallet and payment platform Philippines |
| indian_bank_transfer | [PaymentDetails.IndianBankTransfer](#tzero-v1-common-PaymentDetails-IndianBankTransfer) |  | Indian Bank Transfer - Domestic electronic funds transfer (IMPS/NEFT/RTGS) India |







<a name="tzero-v1-common-PaymentDetails-Ach"></a>

### PaymentDetails.Ach



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| routing_number | [string](#string) |  |  |
| account_number | [string](#string) |  |  |
| account_holder_name | [string](#string) |  |  |
| account_type | [PaymentDetails.Ach.AchAccountType](#tzero-v1-common-PaymentDetails-Ach-AchAccountType) |  |  |







<a name="tzero-v1-common-PaymentDetails-Fps"></a>

### PaymentDetails.Fps



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sort_code | [string](#string) |  |  |
| account_number | [string](#string) |  |  |
| beneficiary_name | [string](#string) |  |  |
| reference | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-GCash"></a>

### PaymentDetails.GCash



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_name | [string](#string) |  |  |
| beneficiary_phone | [string](#string) |  | Recipient phone |
| payment_reference | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-IndianBankTransfer"></a>

### PaymentDetails.IndianBankTransfer



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_ifsc | [PaymentDetails.IndianBankTransfer.AccountIFSC](#tzero-v1-common-PaymentDetails-IndianBankTransfer-AccountIFSC) |  | 1) ACCOUNT + IFSC (NEFT/RTGS/IMPS P2A) |
| imps | [PaymentDetails.IndianBankTransfer.IMPS](#tzero-v1-common-PaymentDetails-IndianBankTransfer-IMPS) |  | 2) IMPS P2P (MOBILE + MMID) |
| beneficiary_name | [string](#string) |  | Beneficiary name |
| beneficiary_type | [string](#string) |  | Beneficiary type |
| payment_reference | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-IndianBankTransfer-AccountIFSC"></a>

### PaymentDetails.IndianBankTransfer.AccountIFSC



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_number | [string](#string) |  | Beneficiary bank account number |
| ifsc | [string](#string) |  | IFSC code (11 characters: 4 letters + '0' + 6 alphanumeric). |







<a name="tzero-v1-common-PaymentDetails-IndianBankTransfer-IMPS"></a>

### PaymentDetails.IndianBankTransfer.IMPS
Method 2: IMPS P2P (Mobile + MMID)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_phone | [string](#string) |  | Indian mobile number (10 digits, starting from 6–9). |
| mmid | [string](#string) |  | MMID: 7-digit Mobile Money Identifier. |







<a name="tzero-v1-common-PaymentDetails-MPesa"></a>

### PaymentDetails.MPesa



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_phone | [string](#string) |  | Phone number in international format without + sign Examples: 254708374149 (Kenya), 255712345678 (Tanzania), 256712345678 (Uganda) Required: Yes |
| account_reference | [string](#string) |  | Account reference (max 12 chars, alphanumeric) Required: Yes |







<a name="tzero-v1-common-PaymentDetails-Sepa"></a>

### PaymentDetails.Sepa



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| iban | [string](#string) |  |  |
| beneficiary_name | [string](#string) |  |  |
| payment_reference | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-Stablecoin"></a>

### PaymentDetails.Stablecoin



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| blockchain | [Blockchain](#tzero-v1-common-Blockchain) |  |  |
| stablecoin | [Stablecoin](#tzero-v1-common-Stablecoin) |  |  |
| address | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-Swift"></a>

### PaymentDetails.Swift



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| swift_code | [string](#string) |  | Beneficiary's bank SWIFT/BIC code (8 or 11 characters) |
| account_number | [string](#string) |  | Beneficiary's account number (format varies by country) Could be IBAN, account number, or other format |
| beneficiary_name | [string](#string) |  | Beneficiary's full name |
| beneficiary_address | [string](#string) |  | Beneficiary's address |
| payment_reference | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-Wire"></a>

### PaymentDetails.Wire



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


<a name="tzero-v1-common-PaymentDetails-Ach-AchAccountType"></a>

### PaymentDetails.Ach.AchAccountType


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
| PAYMENT_METHOD_TYPE_FPS | 70 |  |
| PAYMENT_METHOD_TYPE_M_PESA | 80 |  |
| PAYMENT_METHOD_TYPE_G_CASH | 90 |  |
| PAYMENT_METHOD_TYPE_INDIAN_BANK_TRANSFER | 100 |  |


 <!-- end enums -->

