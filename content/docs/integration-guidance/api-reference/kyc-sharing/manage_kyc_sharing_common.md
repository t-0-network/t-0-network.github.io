---
weight: 348
title: "Common"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-manage-kyc_sharing-CustomFieldValue"></a>

### CustomFieldValue
Submission value for a Payout-Provider-declared custom field — the filled-in
counterpart of FormField. Reused by KYB (main + UBO) and KYC
submissions. Typed by the field's declared FormField type; the server checks
the value arm matches the definition.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| identifier | [string](../../scalar/#string) |  | References the custom field by its FormField.identifier. |
| string | [string](../../scalar/#string) |  | At most FormField.String.max_length characters, and never more than 10000. |
| date | [google.protobuf.Timestamp](../../scalar/#google-protobuf-Timestamp) |  | Calendar date as midnight UTC; a value with a time of day is rejected; a fraction of a second is dropped. |
| number | [tzero.v1.common.Decimal](../../common_common/#tzero-v1-common-Decimal) |  | A custom number has no range or sign check and may be negative. |
| single_select | [CustomFieldValue.SingleSelect](#tzero-v1-manage-kyc_sharing-CustomFieldValue-SingleSelect) |  | no validation: the chosen key is validated by SingleSelect's own rules and checked against the form's declared options server-side. |
| multi_select | [CustomFieldValue.MultiSelect](#tzero-v1-manage-kyc_sharing-CustomFieldValue-MultiSelect) |  | no validation: the chosen keys are validated by MultiSelect's own rules and checked against the form's declared options server-side. |
| file | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) |  | no validation: the file reference is validated server-side against the requester's uploaded-file set; FileValue.file_id carries its own gt:0 constraint. |







<a name="tzero-v1-manage-kyc_sharing-CustomFieldValue-MultiSelect"></a>

### CustomFieldValue.MultiSelect
Chosen option keys from the FormField's Select.options (multi-select).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| keys | [string](../../scalar/#string) | repeated |  |







<a name="tzero-v1-manage-kyc_sharing-CustomFieldValue-SingleSelect"></a>

### CustomFieldValue.SingleSelect
The one chosen option key from the FormField's Select.options (single-select).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-FileValue"></a>

### FileValue
A reference to an already-uploaded file (KycFileService.UploadFile), by its stable id. File field values
carry only this reference; the bytes are uploaded out of band. Shared by standard and custom file fields.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| file_id | [int64](../../scalar/#int64) |  |  |







<a name="tzero-v1-manage-kyc_sharing-KybApplicant"></a>

### KybApplicant
The applicant's filled-in KYB main-form values — the complete main-form state for each save (a snapshot:
stored values are replaced, and anything omitted is cleared). A draft may leave any field unset, including the
ones marked required here: which fields a given applicant owes is set by the Payout Provider's form, and
completeness is enforced when the applicant is submitted for review and on every save while it is rejected.
An empty value on a field without `optional` counts as unset.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| business_name | [string](../../scalar/#string) |  |  |
| business_industry | [KybIndustry](#tzero-v1-manage-kyc_sharing-KybIndustry) | optional |  |
| registered_address_line_1 | [string](../../scalar/#string) |  |  |
| registered_city | [string](../../scalar/#string) |  |  |
| registered_state_province_region | [string](../../scalar/#string) |  |  |
| registered_postal_code | [string](../../scalar/#string) |  |  |
| registered_country | [string](../../scalar/#string) |  | ISO 3166-1 alpha-2; format-checked (2 uppercase letters), not membership-validated. |
| incorporation_date | [google.protobuf.Timestamp](../../scalar/#google-protobuf-Timestamp) | optional | Calendar date as midnight UTC; a value with a time of day is rejected; a fraction of a second is dropped. |
| registration_number | [string](../../scalar/#string) |  |  |
| tax_identification_number | [string](../../scalar/#string) | optional |  |
| email | [string](../../scalar/#string) | optional |  |
| website | [string](../../scalar/#string) | optional |  |
| legal_presence_document | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) |  |  |
| ownership_structure_document | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) |  |  |
| control_structure_document | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) |  |  |
| proof_of_address | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) | optional | no validation: the reference is validated by FileValue's own rules. |
| business_type | [KybBusinessType](#tzero-v1-manage-kyc_sharing-KybBusinessType) | optional |  |
| business_description | [string](../../scalar/#string) | optional |  |
| registration_authority | [string](../../scalar/#string) | optional |  |
| tax_authority | [string](../../scalar/#string) | optional |  |
| operational_address_line_1 | [string](../../scalar/#string) | optional |  |
| operational_city | [string](../../scalar/#string) | optional |  |
| operational_state_province_region | [string](../../scalar/#string) | optional |  |
| operational_postal_code | [string](../../scalar/#string) | optional |  |
| operational_country | [string](../../scalar/#string) | optional | ISO 3166-1 alpha-2; format-checked (2 uppercase letters), not membership-validated. |
| phone | [string](../../scalar/#string) | optional |  |
| primary_purpose_of_account | [string](../../scalar/#string) | optional |  |
| source_of_funds_description | [string](../../scalar/#string) | optional |  |
| high_risk_activities | [KybHighRiskActivity](#tzero-v1-manage-kyc_sharing-KybHighRiskActivity) | repeated | Multi-select: an empty list means the field was not answered (a single choice is a 1-element list). |
| estimated_annual_revenue_usd | [tzero.v1.common.Decimal](../../common_common/#tzero-v1-common-Decimal) | optional | Non-negative when provided. |
| expected_monthly_payments_usd | [tzero.v1.common.Decimal](../../common_common/#tzero-v1-common-Decimal) | optional | Non-negative when provided. |
| company_details_document | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) | optional | no validation: the reference is validated by FileValue's own rules. |
| custom_fields | [CustomFieldValue](#tzero-v1-manage-kyc_sharing-CustomFieldValue) | repeated | Zero or more provider-declared custom main-form fields, each identifier at most once. |







<a name="tzero-v1-manage-kyc_sharing-KybUbo"></a>

### KybUbo
One beneficial owner's filled-in values (mirrors KybApplicant). Owners are identified positionally: the
request's `ubos` list is the full ordered set, and the response echoes them in the same order.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| first_name | [string](../../scalar/#string) |  |  |
| last_name | [string](../../scalar/#string) |  |  |
| email | [string](../../scalar/#string) | optional |  |
| date_of_birth | [google.protobuf.Timestamp](../../scalar/#google-protobuf-Timestamp) | optional | Calendar date as midnight UTC; a value with a time of day is rejected; a fraction of a second is dropped. |
| identity_document_front | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) |  |  |
| identity_document_back | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) | optional | no validation: the reference is validated by FileValue's own rules. |
| roles | [KybUboRole](#tzero-v1-manage-kyc_sharing-KybUboRole) | repeated | Multi-select: an empty list means the field was not answered (a single choice is a 1-element list). |
| business_title | [string](../../scalar/#string) | optional |  |
| nationality | [string](../../scalar/#string) | optional | ISO 3166-1 alpha-2; format-checked (2 uppercase letters), not membership-validated. |
| phone | [string](../../scalar/#string) | optional |  |
| registered_address_line_1 | [string](../../scalar/#string) | optional |  |
| registered_city | [string](../../scalar/#string) | optional |  |
| registered_state_province_region | [string](../../scalar/#string) | optional |  |
| registered_postal_code | [string](../../scalar/#string) | optional |  |
| registered_country | [string](../../scalar/#string) | optional | ISO 3166-1 alpha-2; format-checked (2 uppercase letters), not membership-validated. |
| tax_identification_number | [string](../../scalar/#string) | optional |  |
| share_proportion | [tzero.v1.common.Decimal](../../common_common/#tzero-v1-common-Decimal) | optional | Percentage of ownership; non-negative when provided. |
| relationship_established_at | [google.protobuf.Timestamp](../../scalar/#google-protobuf-Timestamp) | optional | Calendar date as midnight UTC; a value with a time of day is rejected; a fraction of a second is dropped. |
| proof_of_address | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) | optional | no validation: the reference is validated by FileValue's own rules. |
| custom_fields | [CustomFieldValue](#tzero-v1-manage-kyc_sharing-CustomFieldValue) | repeated | Zero or more provider-declared custom UBO sub-form fields, each identifier at most once. |







<a name="tzero-v1-manage-kyc_sharing-KycApplicant"></a>

### KycApplicant
The applicant's filled-in KYC values (private-person End Client; no UBO sub-form) — the complete state for
each save (a snapshot: stored values are replaced, and anything omitted is cleared). A draft may leave any
field unset; completeness is enforced when the applicant is submitted for review and on every save while it is
rejected. An empty value on a field without `optional` counts as unset.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| first_name | [string](../../scalar/#string) |  |  |
| last_name | [string](../../scalar/#string) |  |  |
| registered_address_line_1 | [string](../../scalar/#string) |  |  |
| registered_city | [string](../../scalar/#string) |  |  |
| registered_state_province_region | [string](../../scalar/#string) |  |  |
| registered_postal_code | [string](../../scalar/#string) |  |  |
| registered_country | [string](../../scalar/#string) |  | ISO 3166-1 alpha-2; format-checked (2 uppercase letters), not membership-validated. |
| identity_document_front | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) |  |  |
| identity_document_back | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) | optional | no validation: the reference is validated by FileValue's own rules. |
| email | [string](../../scalar/#string) | optional |  |
| phone | [string](../../scalar/#string) | optional |  |
| nationality | [string](../../scalar/#string) | optional | ISO 3166-1 alpha-2; format-checked (2 uppercase letters), not membership-validated. |
| date_of_birth | [google.protobuf.Timestamp](../../scalar/#google-protobuf-Timestamp) | optional | Calendar date as midnight UTC; a value with a time of day is rejected; a fraction of a second is dropped. |
| tax_identification_number | [string](../../scalar/#string) | optional |  |
| proof_of_address | [FileValue](#tzero-v1-manage-kyc_sharing-FileValue) | optional | no validation: the reference is validated by FileValue's own rules. |
| custom_fields | [CustomFieldValue](#tzero-v1-manage-kyc_sharing-CustomFieldValue) | repeated | Zero or more provider-declared custom KYC fields, each identifier at most once. |







<a name="tzero-v1-manage-kyc_sharing-Page"></a>

### Page
Offset/limit pagination request.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| page | [uint32](../../scalar/#uint32) | optional |  |
| size | [uint32](../../scalar/#uint32) | optional |  |







<a name="tzero-v1-manage-kyc_sharing-PageInfo"></a>

### PageInfo
Offset/limit pagination response metadata.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| current_page | [uint32](../../scalar/#uint32) |  |  |
| page_size | [uint32](../../scalar/#uint32) |  |  |
| has_next | [bool](../../scalar/#bool) |  |  |






 <!-- end messages -->


<a name="tzero-v1-manage-kyc_sharing-ApplicantState"></a>

### ApplicantState
Lifecycle state of an Applicant through the review state machine.

| Name | Number | Description |
| ---- | ------ | ----------- |
| APPLICANT_STATE_UNSPECIFIED | 0 |  |
| APPLICANT_STATE_DRAFT | 10 |  |
| APPLICANT_STATE_REQUESTED | 20 |  |
| APPLICANT_STATE_APPROVED | 30 |  |
| APPLICANT_STATE_REJECTED | 40 |  |



<a name="tzero-v1-manage-kyc_sharing-FormType"></a>

### FormType
Which applicant form a list call selects: KYB (company) or KYC (private person).

| Name | Number | Description |
| ---- | ------ | ----------- |
| FORM_TYPE_UNSPECIFIED | 0 |  |
| FORM_TYPE_KYB | 10 |  |
| FORM_TYPE_KYC | 20 |  |



<a name="tzero-v1-manage-kyc_sharing-KybBusinessType"></a>

### KybBusinessType
Closed value set for STANDARD_KYB_FIELD_TYPE_BUSINESS_TYPE.

| Name | Number | Description |
| ---- | ------ | ----------- |
| KYB_BUSINESS_TYPE_UNSPECIFIED | 0 |  |
| KYB_BUSINESS_TYPE_SOLE_PROPRIETORSHIP | 10 |  |
| KYB_BUSINESS_TYPE_PARTNERSHIP | 20 |  |
| KYB_BUSINESS_TYPE_PRIVATE_LIMITED_COMPANY | 30 |  |
| KYB_BUSINESS_TYPE_PUBLIC_LIMITED_COMPANY | 40 |  |
| KYB_BUSINESS_TYPE_COOPERATIVE | 50 |  |
| KYB_BUSINESS_TYPE_NON_PROFIT_ORGANIZATION | 60 |  |
| KYB_BUSINESS_TYPE_TRUST | 70 |  |
| KYB_BUSINESS_TYPE_FOUNDATION | 80 |  |
| KYB_BUSINESS_TYPE_GOVERNMENT_ENTITY | 90 |  |
| KYB_BUSINESS_TYPE_BRANCH_OR_REPRESENTATIVE_OFFICE | 100 |  |



<a name="tzero-v1-manage-kyc_sharing-KybHighRiskActivity"></a>

### KybHighRiskActivity
Closed value set for STANDARD_KYB_FIELD_TYPE_HIGH_RISK_ACTIVITIES (multi-select).

| Name | Number | Description |
| ---- | ------ | ----------- |
| KYB_HIGH_RISK_ACTIVITY_UNSPECIFIED | 0 |  |
| KYB_HIGH_RISK_ACTIVITY_TRANSMITS_OR_HOLDS_CUSTOMER_FUNDS | 10 |  |
| KYB_HIGH_RISK_ACTIVITY_CURRENCY_EXCHANGE | 20 |  |
| KYB_HIGH_RISK_ACTIVITY_REMITTANCE_SERVICES | 30 |  |
| KYB_HIGH_RISK_ACTIVITY_PAYMENT_PROCESSING | 40 |  |
| KYB_HIGH_RISK_ACTIVITY_GAMBLING_AND_GAMING | 50 |  |
| KYB_HIGH_RISK_ACTIVITY_CANNABIS_AND_REGULATED_SUBSTANCES | 60 |  |
| KYB_HIGH_RISK_ACTIVITY_ADULT_ENTERTAINMENT | 70 |  |
| KYB_HIGH_RISK_ACTIVITY_PRECIOUS_METALS_AND_STONES_DEALERS | 80 |  |
| KYB_HIGH_RISK_ACTIVITY_ART_AND_ANTIQUITIES_DEALERS | 90 |  |
| KYB_HIGH_RISK_ACTIVITY_ARMS_AND_DEFENSE | 100 |  |
| KYB_HIGH_RISK_ACTIVITY_PAWNSHOPS | 110 |  |
| KYB_HIGH_RISK_ACTIVITY_HIGH_VALUE_REAL_ESTATE | 120 |  |
| KYB_HIGH_RISK_ACTIVITY_PRIVATE_BANKING_AND_WEALTH_MANAGEMENT | 130 |  |
| KYB_HIGH_RISK_ACTIVITY_TRUST_AND_COMPANY_SERVICE_PROVIDERS | 140 |  |
| KYB_HIGH_RISK_ACTIVITY_CASH_INTENSIVE_BUSINESSES | 150 |  |
| KYB_HIGH_RISK_ACTIVITY_CHARITIES_AND_NGOS | 160 |  |
| KYB_HIGH_RISK_ACTIVITY_PHARMACEUTICALS_AND_CONTROLLED_SUBSTANCES | 170 |  |
| KYB_HIGH_RISK_ACTIVITY_TOBACCO_AND_ALCOHOL | 180 |  |
| KYB_HIGH_RISK_ACTIVITY_SHIPPING_AND_IMPORT_EXPORT | 190 |  |
| KYB_HIGH_RISK_ACTIVITY_NONE_OF_THE_ABOVE | 200 |  |



<a name="tzero-v1-manage-kyc_sharing-KybIndustry"></a>

### KybIndustry
Closed value set for STANDARD_KYB_FIELD_TYPE_BUSINESS_INDUSTRY.

| Name | Number | Description |
| ---- | ------ | ----------- |
| KYB_INDUSTRY_UNSPECIFIED | 0 |  |
| KYB_INDUSTRY_AGRICULTURE | 10 |  |
| KYB_INDUSTRY_MINING_AND_ENERGY | 20 |  |
| KYB_INDUSTRY_CONSTRUCTION | 30 |  |
| KYB_INDUSTRY_MANUFACTURING | 40 |  |
| KYB_INDUSTRY_UTILITIES | 50 |  |
| KYB_INDUSTRY_WHOLESALE_AND_RETAIL_TRADE | 60 |  |
| KYB_INDUSTRY_TRANSPORTATION_AND_LOGISTICS | 70 |  |
| KYB_INDUSTRY_INFORMATION_AND_TECHNOLOGY | 80 |  |
| KYB_INDUSTRY_TELECOMMUNICATIONS_AND_MEDIA | 90 |  |
| KYB_INDUSTRY_FINANCIAL_SERVICES | 100 |  |
| KYB_INDUSTRY_REAL_ESTATE | 110 |  |
| KYB_INDUSTRY_PROFESSIONAL_SERVICES | 120 |  |
| KYB_INDUSTRY_HEALTHCARE | 130 |  |
| KYB_INDUSTRY_EDUCATION | 140 |  |
| KYB_INDUSTRY_HOSPITALITY_AND_FOOD_SERVICES | 150 |  |
| KYB_INDUSTRY_ARTS_AND_ENTERTAINMENT | 160 |  |
| KYB_INDUSTRY_GOVERNMENT_AND_PUBLIC_SECTOR | 170 |  |
| KYB_INDUSTRY_NON_PROFIT | 180 |  |



<a name="tzero-v1-manage-kyc_sharing-KybUboRole"></a>

### KybUboRole
Closed value set for STANDARD_UBO_FIELD_TYPE_ROLES (multi-select).

| Name | Number | Description |
| ---- | ------ | ----------- |
| KYB_UBO_ROLE_UNSPECIFIED | 0 |  |
| KYB_UBO_ROLE_UBO | 10 |  |
| KYB_UBO_ROLE_DIRECTOR | 20 |  |
| KYB_UBO_ROLE_REPRESENTATIVE | 30 |  |



<a name="tzero-v1-manage-kyc_sharing-StandardKybFieldType"></a>

### StandardKybFieldType


| Name | Number | Description |
| ---- | ------ | ----------- |
| STANDARD_KYB_FIELD_TYPE_UNSPECIFIED | 0 |  |
| STANDARD_KYB_FIELD_TYPE_BUSINESS_NAME | 10 |  |
| STANDARD_KYB_FIELD_TYPE_BUSINESS_INDUSTRY | 20 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTERED_ADDRESS_LINE_1 | 30 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTERED_CITY | 40 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTERED_STATE_PROVINCE_REGION | 50 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTERED_POSTAL_CODE | 60 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTERED_COUNTRY | 70 |  |
| STANDARD_KYB_FIELD_TYPE_INCORPORATION_DATE | 80 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTRATION_NUMBER | 90 |  |
| STANDARD_KYB_FIELD_TYPE_TAX_IDENTIFICATION_NUMBER | 100 |  |
| STANDARD_KYB_FIELD_TYPE_EMAIL | 110 |  |
| STANDARD_KYB_FIELD_TYPE_WEBSITE | 120 |  |
| STANDARD_KYB_FIELD_TYPE_LEGAL_PRESENCE_DOCUMENT | 130 |  |
| STANDARD_KYB_FIELD_TYPE_OWNERSHIP_STRUCTURE_DOCUMENT | 140 |  |
| STANDARD_KYB_FIELD_TYPE_CONTROL_STRUCTURE_DOCUMENT | 150 |  |
| STANDARD_KYB_FIELD_TYPE_PROOF_OF_ADDRESS | 160 |  |
| STANDARD_KYB_FIELD_TYPE_BUSINESS_TYPE | 170 |  |
| STANDARD_KYB_FIELD_TYPE_BUSINESS_DESCRIPTION | 180 |  |
| STANDARD_KYB_FIELD_TYPE_REGISTRATION_AUTHORITY | 190 |  |
| STANDARD_KYB_FIELD_TYPE_TAX_AUTHORITY | 200 |  |
| STANDARD_KYB_FIELD_TYPE_OPERATIONAL_ADDRESS_LINE_1 | 210 |  |
| STANDARD_KYB_FIELD_TYPE_OPERATIONAL_CITY | 220 |  |
| STANDARD_KYB_FIELD_TYPE_OPERATIONAL_STATE_PROVINCE_REGION | 230 |  |
| STANDARD_KYB_FIELD_TYPE_OPERATIONAL_POSTAL_CODE | 240 |  |
| STANDARD_KYB_FIELD_TYPE_OPERATIONAL_COUNTRY | 250 |  |
| STANDARD_KYB_FIELD_TYPE_PHONE | 260 |  |
| STANDARD_KYB_FIELD_TYPE_PRIMARY_PURPOSE_OF_ACCOUNT | 270 |  |
| STANDARD_KYB_FIELD_TYPE_SOURCE_OF_FUNDS_DESCRIPTION | 280 |  |
| STANDARD_KYB_FIELD_TYPE_HIGH_RISK_ACTIVITIES | 290 |  |
| STANDARD_KYB_FIELD_TYPE_ESTIMATED_ANNUAL_REVENUE_USD | 300 |  |
| STANDARD_KYB_FIELD_TYPE_EXPECTED_MONTHLY_PAYMENTS_USD | 310 |  |
| STANDARD_KYB_FIELD_TYPE_COMPANY_DETAILS_DOCUMENT | 320 |  |



<a name="tzero-v1-manage-kyc_sharing-StandardKycFieldType"></a>

### StandardKycFieldType


| Name | Number | Description |
| ---- | ------ | ----------- |
| STANDARD_KYC_FIELD_TYPE_UNSPECIFIED | 0 |  |
| STANDARD_KYC_FIELD_TYPE_FIRST_NAME | 10 |  |
| STANDARD_KYC_FIELD_TYPE_LAST_NAME | 20 |  |
| STANDARD_KYC_FIELD_TYPE_REGISTERED_ADDRESS_LINE_1 | 30 |  |
| STANDARD_KYC_FIELD_TYPE_REGISTERED_CITY | 40 |  |
| STANDARD_KYC_FIELD_TYPE_REGISTERED_STATE_PROVINCE_REGION | 50 |  |
| STANDARD_KYC_FIELD_TYPE_REGISTERED_POSTAL_CODE | 60 |  |
| STANDARD_KYC_FIELD_TYPE_REGISTERED_COUNTRY | 70 |  |
| STANDARD_KYC_FIELD_TYPE_IDENTITY_DOCUMENT_FRONT | 80 |  |
| STANDARD_KYC_FIELD_TYPE_IDENTITY_DOCUMENT_BACK | 85 |  |
| STANDARD_KYC_FIELD_TYPE_EMAIL | 90 |  |
| STANDARD_KYC_FIELD_TYPE_PHONE | 100 |  |
| STANDARD_KYC_FIELD_TYPE_NATIONALITY | 110 |  |
| STANDARD_KYC_FIELD_TYPE_DATE_OF_BIRTH | 120 |  |
| STANDARD_KYC_FIELD_TYPE_TAX_IDENTIFICATION_NUMBER | 130 |  |
| STANDARD_KYC_FIELD_TYPE_PROOF_OF_ADDRESS | 140 |  |



<a name="tzero-v1-manage-kyc_sharing-StandardUboFieldType"></a>

### StandardUboFieldType


| Name | Number | Description |
| ---- | ------ | ----------- |
| STANDARD_UBO_FIELD_TYPE_UNSPECIFIED | 0 |  |
| STANDARD_UBO_FIELD_TYPE_FIRST_NAME | 10 |  |
| STANDARD_UBO_FIELD_TYPE_LAST_NAME | 20 |  |
| STANDARD_UBO_FIELD_TYPE_EMAIL | 30 |  |
| STANDARD_UBO_FIELD_TYPE_DATE_OF_BIRTH | 40 |  |
| STANDARD_UBO_FIELD_TYPE_IDENTITY_DOCUMENT_FRONT | 50 |  |
| STANDARD_UBO_FIELD_TYPE_IDENTITY_DOCUMENT_BACK | 55 |  |
| STANDARD_UBO_FIELD_TYPE_ROLES | 60 |  |
| STANDARD_UBO_FIELD_TYPE_BUSINESS_TITLE | 70 |  |
| STANDARD_UBO_FIELD_TYPE_NATIONALITY | 80 |  |
| STANDARD_UBO_FIELD_TYPE_PHONE | 90 |  |
| STANDARD_UBO_FIELD_TYPE_REGISTERED_ADDRESS_LINE_1 | 100 |  |
| STANDARD_UBO_FIELD_TYPE_REGISTERED_CITY | 110 |  |
| STANDARD_UBO_FIELD_TYPE_REGISTERED_STATE_PROVINCE_REGION | 120 |  |
| STANDARD_UBO_FIELD_TYPE_REGISTERED_POSTAL_CODE | 130 |  |
| STANDARD_UBO_FIELD_TYPE_REGISTERED_COUNTRY | 140 |  |
| STANDARD_UBO_FIELD_TYPE_TAX_IDENTIFICATION_NUMBER | 150 |  |
| STANDARD_UBO_FIELD_TYPE_SHARE_PROPORTION | 160 |  |
| STANDARD_UBO_FIELD_TYPE_RELATIONSHIP_ESTABLISHED_AT | 170 |  |
| STANDARD_UBO_FIELD_TYPE_PROOF_OF_ADDRESS | 180 |  |


 <!-- end enums -->


