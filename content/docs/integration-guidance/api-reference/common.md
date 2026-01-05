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
| pesonet | [PaymentDetails.Pesonet](#tzero-v1-common-PaymentDetails-Pesonet) |  | PESONet - Real-time domestic payments system Philippines |
| instapay | [PaymentDetails.Instapay](#tzero-v1-common-PaymentDetails-Instapay) |  | Instapay - Real-time domestic payments system Philippines |
| pakistan_bank_transfer | [PaymentDetails.PakistanBankTransfer](#tzero-v1-common-PaymentDetails-PakistanBankTransfer) |  | Pakistan Bank Transfer - Domestic bank transfers using Pakistani IBAN Pakistan |
| pakistan_mobile_wallet | [PaymentDetails.PakistanMobileWallet](#tzero-v1-common-PaymentDetails-PakistanMobileWallet) |  | Pakistan Mobile Wallet - JazzCash, Easypaisa, SadaPay, NayaPay and other wallets Pakistan |
| pix | [PaymentDetails.Pix](#tzero-v1-common-PaymentDetails-Pix) |  | PIX - Brazilian instant payment system Brazil |







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







<a name="tzero-v1-common-PaymentDetails-Instapay"></a>

### PaymentDetails.Instapay



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| recipient_institution | [string](#string) |  | Recipient institution: receiving bank or e‑money issuer selected from an InstaPay list. |
| recipient_identifier | [string](#string) |  | Recipient identifier (one of): Account number, or Mobile number, or Email address, or QR code (scanned/uploaded “InstaPay QR”). |
| recipient_account_name | [string](#string) |  | Recipient account name: the name as registered on the account or wallet (may be auto-displayed but is logically required for correct routing/confirmation). |
| purpose_of_transfer | [string](#string) | optional | Purpose of Transfer (Optional/Mandatory depending on bank) |







<a name="tzero-v1-common-PaymentDetails-MPesa"></a>

### PaymentDetails.MPesa



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_phone | [string](#string) |  | Phone number in international format without + sign Examples: 254708374149 (Kenya), 255712345678 (Tanzania), 256712345678 (Uganda) Required: Yes |
| account_reference | [string](#string) |  | Account reference (max 12 chars, alphanumeric) Required: Yes |







<a name="tzero-v1-common-PaymentDetails-PakistanBankTransfer"></a>

### PaymentDetails.PakistanBankTransfer
Pakistan Bank Transfer - Domestic transfers using Pakistani IBAN
Pakistan uses 24-character IBAN: PK + 2 check digits + 4-char bank code + 16-char account number


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| iban | [string](#string) |  | Pakistani IBAN (24 characters: PK + 2 check digits + 4-char bank identifier + 16-char account) Example: PK36SCBL0000001123456702 |
| beneficiary_name | [string](#string) |  | Beneficiary's full name |
| beneficiary_cnic | [string](#string) | optional | (Optional) Beneficiary CNIC (13 digits, no dashes) — sometimes required by receiving banks |
| payment_reference | [string](#string) |  | Payment reference/description |







<a name="tzero-v1-common-PaymentDetails-PakistanMobileWallet"></a>

### PaymentDetails.PakistanMobileWallet
Pakistan Mobile Wallet - JazzCash, Easypaisa, SadaPay, NayaPay and other wallets
Transfers are made using the mobile number linked to the wallet account; CNIC is required for verification


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| wallet_provider | [PaymentDetails.PakistanMobileWallet.PakistanWalletProvider](#tzero-v1-common-PaymentDetails-PakistanMobileWallet-PakistanWalletProvider) |  | Wallet provider |
| mobile_number | [string](#string) |  | Mobile number linked to the wallet (Pak local 03XXXXXXXXX or international 923XXXXXXXXX) |
| cnic | [string](#string) |  | CNIC (Computerized National Identity Card) - 13 digits without dashes |
| beneficiary_name | [string](#string) |  | Beneficiary's full name as registered with the wallet |
| payment_reference | [string](#string) | optional | Payment reference/description (optional) |







<a name="tzero-v1-common-PaymentDetails-Pesonet"></a>

### PaymentDetails.Pesonet



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| recipient_financial_institution | [string](#string) |  | Recipient institution: receiving bank or participating non‑bank chosen from a PESONet list. |
| recipient_identifier | [string](#string) |  | Recipient identifier: Account number (some banks also allow email/mobile). |
| recipient_account_name | [string](#string) |  |  |
| purpose_of_transfer | [string](#string) | optional | Purpose of Transfer (Optional/Mandatory depending on bank) |
| recipient_address_email | [string](#string) | optional | Recipient's Address/Email (Optional/Mandatory depending on bank) |







<a name="tzero-v1-common-PaymentDetails-Pix"></a>

### PaymentDetails.Pix
PIX - Brazilian instant payment system
PIX allows transfers using a Pix key (CPF, CNPJ, email, phone, or random EVP)
or traditional bank account details (bank code, branch, account number)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key_type | [PaymentDetails.Pix.KeyType](#tzero-v1-common-PaymentDetails-Pix-KeyType) |  | Pix key type - determines the format of pix_key_value |
| key_value | [string](#string) |  | Pix key value - format depends on pix_key_type: - CPF: 11 digits (e.g., "12345678901") - CNPJ: 14 digits (e.g., "12345678000195") - EMAIL: valid email address - PHONE: international format with country code (e.g., "+5511999999999") - EVP: 32-character UUID (e.g., "123e4567-e89b-12d3-a456-426614174000") |
| beneficiary_name | [string](#string) |  | Beneficiary's full name |
| beneficiary_tax_id | [string](#string) | optional | (Optional) Beneficiary's CPF (11 digits) or CNPJ (14 digits) for verification |
| payment_reference | [string](#string) | optional | (Optional) Payment description/reference |







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



<a name="tzero-v1-common-PaymentDetails-PakistanMobileWallet-PakistanWalletProvider"></a>

### PaymentDetails.PakistanMobileWallet.PakistanWalletProvider


| Name | Number | Description |
| ---- | ------ | ----------- |
| PAKISTAN_WALLET_PROVIDER_UNSPECIFIED | 0 |  |
| PAKISTAN_WALLET_PROVIDER_JAZZCASH | 10 |  |
| PAKISTAN_WALLET_PROVIDER_EASYPAISA | 20 |  |
| PAKISTAN_WALLET_PROVIDER_SADAPAY | 30 |  |
| PAKISTAN_WALLET_PROVIDER_NAYAPAY | 40 |  |
| PAKISTAN_WALLET_PROVIDER_OTHER | 100 |  |



<a name="tzero-v1-common-PaymentDetails-Pix-KeyType"></a>

### PaymentDetails.Pix.KeyType


| Name | Number | Description |
| ---- | ------ | ----------- |
| KEY_TYPE_UNSPECIFIED | 0 |  |
| KEY_TYPE_CPF | 10 | CPF - Cadastro de Pessoas Físicas (Individual Taxpayer Registry) - 11 digits |
| KEY_TYPE_CNPJ | 20 | CNPJ - Cadastro Nacional da Pessoa Jurídica (Business Tax ID) - 14 digits |
| KEY_TYPE_EMAIL | 30 | Email address |
| KEY_TYPE_PHONE | 40 | Phone number in international format |
| KEY_TYPE_EVP | 50 | EVP - Random key (UUID format) |



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
| PAYMENT_METHOD_TYPE_PESONET | 110 |  |
| PAYMENT_METHOD_TYPE_INSTAPAY | 120 |  |
| PAYMENT_METHOD_TYPE_PAKISTAN_BANK_TRANSFER | 130 | Pakistan domestic bank transfer via IBAN |
| PAYMENT_METHOD_TYPE_PAKISTAN_MOBILE_WALLET | 140 | Pakistan mobile wallet (JazzCash, Easypaisa, etc.) - sometimes also called ID Wallet |
| PAYMENT_METHOD_TYPE_PIX | 150 | PIX - Brazilian instant payment system |


 <!-- end enums -->

