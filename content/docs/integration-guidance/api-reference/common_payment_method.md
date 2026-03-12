---
weight: 337
title: "Payment Method"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-common-PaymentDetails"></a>

### PaymentDetails



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sepa | [PaymentDetails.Sepa](#tzero-v1-common-PaymentDetails-Sepa) |  | SEPA (Single Euro Payments Area) - Euro bank transfers across European countries |
| swift | [PaymentDetails.Swift](#tzero-v1-common-PaymentDetails-Swift) |  | SWIFT (Society for Worldwide Interbank Financial Telecommunication) - International wire transfers Global (200+ countries) |
| ach | [PaymentDetails.Ach](#tzero-v1-common-PaymentDetails-Ach) |  | ACH (Automated Clearing House) - Electronic bank-to-bank transfers United States |
| domestic_wire | [PaymentDetails.DomesticWire](#tzero-v1-common-PaymentDetails-DomesticWire) |  | DomesticWire - US domestic wire transfer United States |
| fps | [PaymentDetails.Fps](#tzero-v1-common-PaymentDetails-Fps) |  | FPS (Faster Payments Service) United Kingdom |
| mpesa | [PaymentDetails.MPesa](#tzero-v1-common-PaymentDetails-MPesa) |  | **Deprecated.** M-Pesa - Mobile money transfer and payment service Kenya, Tanzania, Mozambique, DRC, Lesotho, Ghana, Egypt, South Africa  deprecated in favor of AfricanMobileMoney |
| gcash | [PaymentDetails.GCash](#tzero-v1-common-PaymentDetails-GCash) |  | GCash - Mobile wallet and payment platform Philippines |
| indian_bank_transfer | [PaymentDetails.IndianBankTransfer](#tzero-v1-common-PaymentDetails-IndianBankTransfer) |  | Indian Bank Transfer - Domestic electronic funds transfer (IMPS/NEFT/RTGS) India |
| pesonet | [PaymentDetails.Pesonet](#tzero-v1-common-PaymentDetails-Pesonet) |  | PESONet - Real-time domestic payments system Philippines |
| instapay | [PaymentDetails.Instapay](#tzero-v1-common-PaymentDetails-Instapay) |  | Instapay - Real-time domestic payments system Philippines |
| pakistan_bank_transfer | [PaymentDetails.PakistanBankTransfer](#tzero-v1-common-PaymentDetails-PakistanBankTransfer) |  | Pakistan Bank Transfer - Domestic bank transfers using Pakistani IBAN Pakistan |
| pakistan_mobile_wallet | [PaymentDetails.PakistanMobileWallet](#tzero-v1-common-PaymentDetails-PakistanMobileWallet) |  | Pakistan Mobile Wallet - JazzCash, Easypaisa, SadaPay, NayaPay and other wallets Pakistan |
| pix | [PaymentDetails.Pix](#tzero-v1-common-PaymentDetails-Pix) |  | PIX - Brazilian instant payment system Brazil |
| african_mobile_money | [PaymentDetails.AfricanMobileMoney](#tzero-v1-common-PaymentDetails-AfricanMobileMoney) |  | African Money - Kenya payment method |
| naps | [PaymentDetails.Cnaps](#tzero-v1-common-PaymentDetails-Cnaps) |  | The China National Advanced Payment System |
| nip | [PaymentDetails.Nip](#tzero-v1-common-PaymentDetails-Nip) |  | NIP - Nigeria Instant Payment system Nigeria |







<a name="tzero-v1-common-PaymentDetails-Ach"></a>

### PaymentDetails.Ach



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| routing_number | [string](../scalar/#string) |  |  |
| account_number | [string](../scalar/#string) |  |  |
| account_holder_name | [string](../scalar/#string) |  |  |
| account_type | [PaymentDetails.Ach.AchAccountType](#tzero-v1-common-PaymentDetails-Ach-AchAccountType) |  |  |







<a name="tzero-v1-common-PaymentDetails-AfricanMobileMoney"></a>

### PaymentDetails.AfricanMobileMoney



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| network | [PaymentDetails.AfricanMobileMoney.Network](#tzero-v1-common-PaymentDetails-AfricanMobileMoney-Network) |  | The phone network |
| beneficiary_phone | [string](../scalar/#string) |  | Phone number in international format without + sign Required: Yes |
| account_reference | [string](../scalar/#string) |  | Account reference (max 12 chars, alphanumeric) Required: Yes |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary name |







<a name="tzero-v1-common-PaymentDetails-Cnaps"></a>

### PaymentDetails.Cnaps
The China National Advanced Payment System


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_number | [string](../scalar/#string) |  | 6-25 digits |
| cnaps_code | [string](../scalar/#string) |  | 12 digits (encodes the bank + branch) |
| beneficiary_name_local | [string](../scalar/#string) |  | Beneficiary name in Chinese characters |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary name in Latin characters |
| business | [PaymentDetails.Cnaps.Business](#tzero-v1-common-PaymentDetails-Cnaps-Business) |  |  |
| person | [PaymentDetails.Cnaps.Person](#tzero-v1-common-PaymentDetails-Cnaps-Person) |  |  |







<a name="tzero-v1-common-PaymentDetails-Cnaps-Business"></a>

### PaymentDetails.Cnaps.Business



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| license_number | [string](../scalar/#string) |  | Business license number - 18 digits |







<a name="tzero-v1-common-PaymentDetails-Cnaps-Person"></a>

### PaymentDetails.Cnaps.Person



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| id_number | [string](../scalar/#string) |  | ID number - 18 digits |







<a name="tzero-v1-common-PaymentDetails-DomesticWire"></a>

### PaymentDetails.DomesticWire



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bank_name | [string](#string) |  |  |
| bank_address | [string](#string) |  |  |
| routing_number | [string](#string) |  | ABA routing number (9 digits) |
| account_number | [string](#string) |  |  |
| beneficiary_name | [string](#string) |  |  |
| beneficiary_address | [string](#string) |  |  |
| wire_reference | [string](#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-Fps"></a>

### PaymentDetails.Fps



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sort_code | [string](../scalar/#string) |  |  |
| account_number | [string](../scalar/#string) |  |  |
| beneficiary_name | [string](../scalar/#string) |  |  |
| reference | [string](../scalar/#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-GCash"></a>

### PaymentDetails.GCash



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_name | [string](../scalar/#string) |  |  |
| beneficiary_phone | [string](../scalar/#string) |  | Recipient phone |
| payment_reference | [string](../scalar/#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-IndianBankTransfer"></a>

### PaymentDetails.IndianBankTransfer



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_ifsc | [PaymentDetails.IndianBankTransfer.AccountIFSC](#tzero-v1-common-PaymentDetails-IndianBankTransfer-AccountIFSC) |  | 1) ACCOUNT + IFSC (NEFT/RTGS/IMPS P2A) |
| imps | [PaymentDetails.IndianBankTransfer.IMPS](#tzero-v1-common-PaymentDetails-IndianBankTransfer-IMPS) |  | 2) IMPS P2P (MOBILE + MMID) |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary name |
| beneficiary_type | [string](../scalar/#string) |  | Beneficiary type |
| payment_reference | [string](../scalar/#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-IndianBankTransfer-AccountIFSC"></a>

### PaymentDetails.IndianBankTransfer.AccountIFSC



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| account_number | [string](../scalar/#string) |  | Beneficiary bank account number |
| ifsc | [string](../scalar/#string) |  | IFSC code (11 characters: 4 letters + '0' + 6 alphanumeric). |







<a name="tzero-v1-common-PaymentDetails-IndianBankTransfer-IMPS"></a>

### PaymentDetails.IndianBankTransfer.IMPS
Method 2: IMPS P2P (Mobile + MMID)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_phone | [string](../scalar/#string) |  | Indian mobile number (10 digits, starting from 6–9). |
| mmid | [string](../scalar/#string) |  | MMID: 7-digit Mobile Money Identifier. |







<a name="tzero-v1-common-PaymentDetails-Instapay"></a>

### PaymentDetails.Instapay



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| recipient_institution | [string](../scalar/#string) |  | Recipient institution: receiving bank or e‑money issuer selected from an InstaPay list. |
| recipient_identifier | [string](../scalar/#string) |  | Recipient identifier (one of): Account number, or Mobile number, or Email address, or QR code (scanned/uploaded “InstaPay QR”). |
| recipient_account_name | [string](../scalar/#string) |  | Recipient account name: the name as registered on the account or wallet (may be auto-displayed but is logically required for correct routing/confirmation). |
| purpose_of_transfer | [string](../scalar/#string) | optional | Purpose of Transfer (Optional/Mandatory depending on bank) |







<a name="tzero-v1-common-PaymentDetails-MPesa"></a>

### PaymentDetails.MPesa



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| beneficiary_phone | [string](../scalar/#string) |  | Phone number in international format without + sign Examples: 254708374149 (Kenya), 255712345678 (Tanzania), 256712345678 (Uganda) Required: Yes |
| account_reference | [string](../scalar/#string) |  | Account reference (max 12 chars, alphanumeric) Required: Yes |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary name |







<a name="tzero-v1-common-PaymentDetails-Nip"></a>

### PaymentDetails.Nip
NIP - Nigeria Instant Payment system
Transfers are made using bank code and account number (NUBAN)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bank_code | [string](../scalar/#string) |  | Bank code (e.g., "00001") |
| account_number | [string](../scalar/#string) |  | Account number (NUBAN format) |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary's full name |
| payment_reference | [string](../scalar/#string) |  | Payment reference/description (optional) |







<a name="tzero-v1-common-PaymentDetails-PakistanBankTransfer"></a>

### PaymentDetails.PakistanBankTransfer
Pakistan Bank Transfer - Domestic transfers using Pakistani IBAN
Pakistan uses 24-character IBAN: PK + 2 check digits + 4-char bank code + 16-char account number


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| iban | [string](../scalar/#string) |  | Pakistani IBAN (24 characters: PK + 2 check digits + 4-char bank identifier + 16-char account) Example: PK36SCBL0000001123456702 |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary's full name |
| beneficiary_cnic | [string](../scalar/#string) | optional | (Optional) Beneficiary CNIC (13 digits, no dashes) — sometimes required by receiving banks |
| payment_reference | [string](../scalar/#string) |  | Payment reference/description |







<a name="tzero-v1-common-PaymentDetails-PakistanMobileWallet"></a>

### PaymentDetails.PakistanMobileWallet
Pakistan Mobile Wallet - JazzCash, Easypaisa, SadaPay, NayaPay and other wallets
Transfers are made using the mobile number linked to the wallet account; CNIC is required for verification


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| wallet_provider | [PaymentDetails.PakistanMobileWallet.PakistanWalletProvider](#tzero-v1-common-PaymentDetails-PakistanMobileWallet-PakistanWalletProvider) |  | Wallet provider |
| mobile_number | [string](../scalar/#string) |  | Mobile number linked to the wallet (Pak local 03XXXXXXXXX or international 923XXXXXXXXX) |
| cnic | [string](../scalar/#string) |  | CNIC (Computerized National Identity Card) - 13 digits without dashes |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary's full name as registered with the wallet |
| payment_reference | [string](../scalar/#string) | optional | Payment reference/description (optional) |







<a name="tzero-v1-common-PaymentDetails-Pesonet"></a>

### PaymentDetails.Pesonet



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| recipient_financial_institution | [string](../scalar/#string) |  | Recipient institution: receiving bank or participating non‑bank chosen from a PESONet list. |
| recipient_identifier | [string](../scalar/#string) |  | Recipient identifier: Account number (some banks also allow email/mobile). |
| recipient_account_name | [string](../scalar/#string) |  |  |
| purpose_of_transfer | [string](../scalar/#string) | optional | Purpose of Transfer (Optional/Mandatory depending on bank) |
| recipient_address_email | [string](../scalar/#string) | optional | Recipient's Address/Email (Optional/Mandatory depending on bank) |







<a name="tzero-v1-common-PaymentDetails-Pix"></a>

### PaymentDetails.Pix
PIX - Brazilian instant payment system
PIX allows transfers using a Pix key (CPF, CNPJ, email, phone, or random EVP)
or traditional bank account details (bank code, branch, account number)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key_type | [PaymentDetails.Pix.KeyType](#tzero-v1-common-PaymentDetails-Pix-KeyType) |  | Pix key type - determines the format of pix_key_value |
| key_value | [string](../scalar/#string) |  | Pix key value - format depends on pix_key_type: - CPF: 11 digits (e.g., "12345678901") - CNPJ: 14 digits (e.g., "12345678000195") - EMAIL: valid email address - PHONE: international format with country code (e.g., "+5511999999999") - EVP: 32-character UUID (e.g., "123e4567-e89b-12d3-a456-426614174000") |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary's full name |
| beneficiary_tax_id | [string](../scalar/#string) | optional | (Optional) Beneficiary's CPF (11 digits) or CNPJ (14 digits) for verification |
| payment_reference | [string](../scalar/#string) | optional | (Optional) Payment description/reference |







<a name="tzero-v1-common-PaymentDetails-Sepa"></a>

### PaymentDetails.Sepa



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| iban | [string](../scalar/#string) |  |  |
| beneficiary_name | [string](../scalar/#string) |  |  |
| payment_reference | [string](../scalar/#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-Swift"></a>

### PaymentDetails.Swift



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| swift_code | [string](../scalar/#string) |  | Beneficiary's bank SWIFT/BIC code (8 or 11 characters) |
| account_number | [string](../scalar/#string) |  | Beneficiary's account number (format varies by country) Could be IBAN, account number, or other format |
| beneficiary_name | [string](../scalar/#string) |  | Beneficiary's full name |
| beneficiary_address | [string](../scalar/#string) |  | Beneficiary's address |
| payment_reference | [string](../scalar/#string) |  |  |
| bank_name | [string](../scalar/#string) |  | Beneficiary's bank name |
| bank_country | [string](../scalar/#string) |  | Beneficiary's bank country (ISO 3166-1 alpha-2) |
| account_currency | [string](../scalar/#string) | optional | Account currency (ISO 4217) |
| intermediary_bank | [PaymentDetails.Swift.IntermediaryBank](#tzero-v1-common-PaymentDetails-Swift-IntermediaryBank) |  |  |







<a name="tzero-v1-common-PaymentDetails-Swift-IntermediaryBank"></a>

### PaymentDetails.Swift.IntermediaryBank
Intermediary bank details (optional)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| swift_code | [string](../scalar/#string) |  |  |
| bank_name | [string](../scalar/#string) |  |  |
| account_number | [string](../scalar/#string) |  |  |







<a name="tzero-v1-common-PaymentDetails-Wire"></a>

### PaymentDetails.Wire



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| bank_name | [string](../scalar/#string) |  |  |
| bank_address | [string](../scalar/#string) |  |  |
| swift_code | [string](../scalar/#string) |  |  |
| account_number | [string](../scalar/#string) |  |  |
| beneficiary_name | [string](../scalar/#string) |  |  |
| beneficiary_address | [string](../scalar/#string) |  |  |
| wire_reference | [string](../scalar/#string) |  |  |






 <!-- end messages -->


<a name="tzero-v1-common-PaymentDetails-Ach-AchAccountType"></a>

### PaymentDetails.Ach.AchAccountType


| Name | Number | Description |
| ---- | ------ | ----------- |
| ACH_ACCOUNT_TYPE_UNSPECIFIED | 0 |  |
| ACH_ACCOUNT_TYPE_CHECKING | 10 |  |
| ACH_ACCOUNT_TYPE_SAVINGS | 20 |  |



<a name="tzero-v1-common-PaymentDetails-AfricanMobileMoney-Network"></a>

### PaymentDetails.AfricanMobileMoney.Network


| Name | Number | Description |
| ---- | ------ | ----------- |
| NETWORK_UNDEFINED | 0 |  |
| NETWORK_M_PESA | 10 |  |
| NETWORK_AIRTEL | 20 |  |
| NETWORK_MTN | 30 |  |
| NETWORK_VODACOM | 40 |  |
| NETWORK_ORANGE | 50 |  |
| NETWORK_VODAFONE | 60 |  |
| NETWORK_FREE | 70 |  |
| NETWORK_ZAMTEL | 80 |  |



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
| PAYMENT_METHOD_TYPE_ACH | 50 |  |
| PAYMENT_METHOD_TYPE_DOMESTIC_WIRE | 60 |  |
| PAYMENT_METHOD_TYPE_FPS | 70 |  |
| PAYMENT_METHOD_TYPE_M_PESA | 80 | deprecated in favor of PAYMENT_METHOD_TYPE_AFRICAN_MOBILE_MONEY |
| PAYMENT_METHOD_TYPE_G_CASH | 90 |  |
| PAYMENT_METHOD_TYPE_INDIAN_BANK_TRANSFER | 100 |  |
| PAYMENT_METHOD_TYPE_PESONET | 110 |  |
| PAYMENT_METHOD_TYPE_INSTAPAY | 120 |  |
| PAYMENT_METHOD_TYPE_PAKISTAN_BANK_TRANSFER | 130 | Pakistan domestic bank transfer via IBAN |
| PAYMENT_METHOD_TYPE_PAKISTAN_MOBILE_WALLET | 140 | Pakistan mobile wallet (JazzCash, Easypaisa, etc.) - sometimes also called ID Wallet |
| PAYMENT_METHOD_TYPE_PIX | 150 | PIX - Brazilian instant payment system |
| PAYMENT_METHOD_TYPE_AFRICAN_MOBILE_MONEY | 160 | African Mobile Money  - Mobile money system across multiple countries: Kenya (Mpesa, Airtel), Tanzania, Mozambique, DRC, Lesotho, Ghana, Egypt, South Africa etc. |
| PAYMENT_METHOD_TYPE_CNAPS | 170 | The China National Advanced Payment System |
| PAYMENT_METHOD_TYPE_NIP | 180 | NIP - Nigeria Instant Payment system |


 <!-- end enums -->


