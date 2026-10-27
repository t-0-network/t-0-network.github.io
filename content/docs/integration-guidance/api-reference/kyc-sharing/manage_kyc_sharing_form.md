---
weight: 347
title: "Form"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-manage-kyc_sharing-FormField"></a>

### FormField
Payout-Provider-declared custom field. Shared by KYB (main form + UBO
sub-form) and KYC. The set of allowed types is fixed — one branch per type in `type`;
each branch carries only the config that type needs.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| identifier | [string](../../scalar/#string) |  |  |
| title | [string](../../scalar/#string) |  |  |
| required | [bool](../../scalar/#bool) |  |  |
| number | [FormField.Number](#tzero-v1-manage-kyc_sharing-FormField-Number) |  |  |
| string | [FormField.String](#tzero-v1-manage-kyc_sharing-FormField-String) |  |  |
| date | [FormField.Date](#tzero-v1-manage-kyc_sharing-FormField-Date) |  |  |
| file | [FormField.File](#tzero-v1-manage-kyc_sharing-FormField-File) |  |  |
| single_select | [FormField.Select](#tzero-v1-manage-kyc_sharing-FormField-Select) |  |  |
| multi_select | [FormField.Select](#tzero-v1-manage-kyc_sharing-FormField-Select) |  |  |







<a name="tzero-v1-manage-kyc_sharing-FormField-Date"></a>

### FormField.Date
Date field; carries no extra configuration.


This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-FormField-File"></a>

### FormField.File
File-upload field; carries no extra configuration. Upload size is bounded by the global server limit.


This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-FormField-Number"></a>

### FormField.Number
Numeric free-entry field; carries no extra configuration.


This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-FormField-Select"></a>

### FormField.Select
Single- or multi-select field. At least two options — a select with one or zero choices is
meaningless.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| options | [FormField.Select.Item](#tzero-v1-manage-kyc_sharing-FormField-Select-Item) | repeated |  |







<a name="tzero-v1-manage-kyc_sharing-FormField-Select-Item"></a>

### FormField.Select.Item
One selectable option: a stable `key` plus a display `title`.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| key | [string](../../scalar/#string) |  |  |
| title | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-FormField-String"></a>

### FormField.String
Free-text field with an optional maximum length.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| max_length | [uint32](../../scalar/#uint32) | optional | Maximum character length (absent ⇒ 10000, the cap of CustomFieldValue.string). |







<a name="tzero-v1-manage-kyc_sharing-KybForm"></a>

### KybForm
KYB form definition: the provider's selected standard fields, custom fields, and UBO sub-form. Every
network-mandatory standard field of the main form and of the UBO sub-form is part of the form and required.
`standard_fields` never lists one, in a form-setup request or in any response. To render the form, add them
from the `(network_mandatory)` enum value option.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| standard_fields | [KybForm.StandardField](#tzero-v1-manage-kyc_sharing-KybForm-StandardField) | repeated | The no-duplicate rules — standard_fields by `field`, custom_fields by `identifier` — are enforced by the CEL above. standard_fields holds only the selectable fields the provider chose, each with its `required` choice; an empty list is valid. |
| custom_fields | [FormField](#tzero-v1-manage-kyc_sharing-FormField) | repeated |  |
| ubo_form | [KybForm.UboForm](#tzero-v1-manage-kyc_sharing-KybForm-UboForm) |  |  |







<a name="tzero-v1-manage-kyc_sharing-KybForm-StandardField"></a>

### KybForm.StandardField
One selection of a KYB main-form standard field. The catalogue (StandardKybFieldType) is the source of truth
for what exists.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| field | [StandardKybFieldType](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-StandardKybFieldType) |  |  |
| required | [bool](../../scalar/#bool) |  |  |







<a name="tzero-v1-manage-kyc_sharing-KybForm-UboForm"></a>

### KybForm.UboForm
UBO sub-form nested in the KYB form: the standard and custom fields collected per beneficial owner.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| standard_fields | [KybForm.UboForm.StandardField](#tzero-v1-manage-kyc_sharing-KybForm-UboForm-StandardField) | repeated | Same no-duplicate rules as the main form, enforced by the CEL above. standard_fields holds only the selectable fields the provider chose, each with its `required` choice; an empty list is valid. |
| custom_fields | [FormField](#tzero-v1-manage-kyc_sharing-FormField) | repeated |  |







<a name="tzero-v1-manage-kyc_sharing-KybForm-UboForm-StandardField"></a>

### KybForm.UboForm.StandardField
One selection of a UBO sub-form standard field. Same shape and rule as
KybForm.StandardField but typed over StandardUboFieldType.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| field | [StandardUboFieldType](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-StandardUboFieldType) |  |  |
| required | [bool](../../scalar/#bool) |  |  |







<a name="tzero-v1-manage-kyc_sharing-KycForm"></a>

### KycForm
KYC Form composition. No embedded sub-form — KYC is for private-person End
Clients. Every network-mandatory standard field is part of the form and required.
`standard_fields` never lists one, in a form-setup request or in any response. To render
the form, add them from the `(network_mandatory)` enum value option.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| standard_fields | [KycForm.StandardField](#tzero-v1-manage-kyc_sharing-KycForm-StandardField) | repeated | The no-duplicate rules — standard_fields by `field`, custom_fields by `identifier` — are enforced by the CEL above. standard_fields holds only the selectable fields the provider chose, each with its `required` choice; an empty list is valid. |
| custom_fields | [FormField](#tzero-v1-manage-kyc_sharing-FormField) | repeated |  |







<a name="tzero-v1-manage-kyc_sharing-KycForm-StandardField"></a>

### KycForm.StandardField
One selection of a KYC main-form standard field. Same shape and rule as
KybForm.StandardField but typed over StandardKycFieldType.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| field | [StandardKycFieldType](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-StandardKycFieldType) |  |  |
| required | [bool](../../scalar/#bool) |  |  |






 <!-- end messages -->

 <!-- end enums -->


