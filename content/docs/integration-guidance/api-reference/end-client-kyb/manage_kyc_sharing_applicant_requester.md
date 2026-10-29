---
weight: 344
title: "Requester"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

<a name="tzero-v1-manage-kyc_sharing-KycApplicantRequesterService"></a>

## KycApplicantRequesterService
Payout-Requester-facing applicant RPCs: create an applicant, read its form pre-filled for editing, save values, submit for review, withdraw, and delete a draft.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| CreateRequesterKybApplicant | [CreateRequesterKybApplicantRequest](#tzero-v1-manage-kyc_sharing-CreateRequesterKybApplicantRequest) | [CreateRequesterKybApplicantResponse](#tzero-v1-manage-kyc_sharing-CreateRequesterKybApplicantResponse) | Initiates a KYB applicant by binding a fresh draft to the payout provider's current form version. A repeat call for an already-created applicant returns AlreadyExists, and FailedPrecondition when the provider has no published KYB form. |
| GetRequesterKybApplicant | [GetRequesterKybApplicantRequest](#tzero-v1-manage-kyc_sharing-GetRequesterKybApplicantRequest) | [GetRequesterKybApplicantResponse](#tzero-v1-manage-kyc_sharing-GetRequesterKybApplicantResponse) | Returns the KYB form at the version the applicant is bound to plus their stored values, for editing. Read-only: FailedPrecondition when the applicant does not exist — create it first — and InvalidArgument when the `client_id` has a KYC applicant. |
| CreateRequesterKycApplicant | [CreateRequesterKycApplicantRequest](#tzero-v1-manage-kyc_sharing-CreateRequesterKycApplicantRequest) | [CreateRequesterKycApplicantResponse](#tzero-v1-manage-kyc_sharing-CreateRequesterKycApplicantResponse) | Initiates a KYC applicant by binding a fresh draft to the payout provider's current form version. A repeat call for an already-created applicant returns AlreadyExists, and FailedPrecondition when the provider has no published KYC form. |
| GetRequesterKycApplicant | [GetRequesterKycApplicantRequest](#tzero-v1-manage-kyc_sharing-GetRequesterKycApplicantRequest) | [GetRequesterKycApplicantResponse](#tzero-v1-manage-kyc_sharing-GetRequesterKycApplicantResponse) | Returns the KYC form at the version the applicant is bound to plus their stored values, for editing. Read-only: FailedPrecondition when the applicant does not exist — create it first — and InvalidArgument when the `client_id` has a KYB applicant. |
| ListRequesterApplicants | [ListRequesterApplicantsRequest](#tzero-v1-manage-kyc_sharing-ListRequesterApplicantsRequest) | [ListRequesterApplicantsResponse](#tzero-v1-manage-kyc_sharing-ListRequesterApplicantsResponse) | Lists the calling Payout Requester's own applicants, optionally filtered by form type (KYB or KYC), Payout Provider, and/or lifecycle state. Paged: one page per call (default size 10), with `page_info.has_next` telling the caller whether to ask for the next one. |
| ListProviderForms | [ListProviderFormsRequest](#tzero-v1-manage-kyc_sharing-ListProviderFormsRequest) | [ListProviderFormsResponse](#tzero-v1-manage-kyc_sharing-ListProviderFormsResponse) | Lists the Payout Providers the calling Payout Requester has mutual granted consent with, each with the FormType values the provider has published. Only providers with at least one published KYB or KYC form appear. |
| SaveKybApplicant | [SaveKybApplicantRequest](#tzero-v1-manage-kyc_sharing-SaveKybApplicantRequest) | [SaveKybApplicantResponse](#tzero-v1-manage-kyc_sharing-SaveKybApplicantResponse) | Stores the applicant's KYB values against the form version the client is bound to (the provider's current version on the first save), echoing the stored values for the edit UI. While the applicant is rejected, the values must fill every field its form requires; to save partial progress, withdraw it to draft first. |
| SaveKycApplicant | [SaveKycApplicantRequest](#tzero-v1-manage-kyc_sharing-SaveKycApplicantRequest) | [SaveKycApplicantResponse](#tzero-v1-manage-kyc_sharing-SaveKycApplicantResponse) | Stores the applicant's KYC values against the form version the client is bound to (the provider's current version on the first save). While the applicant is rejected, the values must fill every field its form requires; to save partial progress, withdraw it to draft first. |
| SubmitApplicant | [SubmitApplicantRequest](#tzero-v1-manage-kyc_sharing-SubmitApplicantRequest) | [SubmitApplicantResponse](#tzero-v1-manage-kyc_sharing-SubmitApplicantResponse) | Submits a draft Applicant — or resubmits a rejected one — for review, moving it to `requested`. A no-op when the Applicant is already `requested`. |
| WithdrawApplicant | [WithdrawApplicantRequest](#tzero-v1-manage-kyc_sharing-WithdrawApplicantRequest) | [WithdrawApplicantResponse](#tzero-v1-manage-kyc_sharing-WithdrawApplicantResponse) | Withdraws an Applicant back to `draft` from `requested`, `approved`, or `rejected`, retaining its field values. A no-op when already `draft`. |
| DeleteApplicant | [DeleteApplicantRequest](#tzero-v1-manage-kyc_sharing-DeleteApplicantRequest) | [DeleteApplicantResponse](#tzero-v1-manage-kyc_sharing-DeleteApplicantResponse) | Deletes a `draft` or `rejected` Applicant, freeing its identity for a fresh Applicant for the same customer and provider; from `requested` or `approved`, withdraw to `draft` first. Provider-side review transitions (approve/reject) live on KycApplicantProviderService. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-manage-kyc_sharing-CreateRequesterKybApplicantRequest"></a>

### CreateRequesterKybApplicantRequest
Identifies the applicant to create: the payout provider (whose KYB form is filled) plus the end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-CreateRequesterKybApplicantResponse"></a>

### CreateRequesterKybApplicantResponse
The bound form version and lifecycle state of the freshly created applicant.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form_version | [uint32](../../scalar/#uint32) |  | The form version the new draft is bound to. |
| state | [ApplicantState](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | The new applicant's lifecycle state (draft). |







<a name="tzero-v1-manage-kyc_sharing-CreateRequesterKycApplicantRequest"></a>

### CreateRequesterKycApplicantRequest
Identifies the applicant to create: the payout provider (whose KYC form is filled) plus the end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-CreateRequesterKycApplicantResponse"></a>

### CreateRequesterKycApplicantResponse
The bound form version and lifecycle state of the freshly created applicant.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form_version | [uint32](../../scalar/#uint32) |  | The form version the new draft is bound to. |
| state | [ApplicantState](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | The new applicant's lifecycle state (draft). |







<a name="tzero-v1-manage-kyc_sharing-DeleteApplicantRequest"></a>

### DeleteApplicantRequest
Identifies the `draft` or `rejected` Applicant the Payout Requester deletes, by payout provider and end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-DeleteApplicantResponse"></a>

### DeleteApplicantResponse



This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-GetRequesterKybApplicantRequest"></a>

### GetRequesterKybApplicantRequest
Identifies the applicant: the payout provider (whose KYB form is filled) plus the end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-GetRequesterKybApplicantResponse"></a>

### GetRequesterKybApplicantResponse
The KYB form at the version the applicant is bound to plus the applicant's stored values, so the client can render and edit it in one call.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form | [KybForm](../../end-client-kyb/manage_kyc_sharing_form/#tzero-v1-manage-kyc_sharing-KybForm) |  |  |
| applicant | [KybApplicant](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybApplicant) |  | Stored main-form values, absent until any values are saved. |
| ubos | [KybUbo](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybUbo) | repeated | Stored beneficial owners, in submission order. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version these values are bound to. |
| state | [ApplicantState](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | Current lifecycle state. |
| reject_reason | [string](../../scalar/#string) | optional | The rejection reason; absent unless the applicant is currently rejected. |
| version | [uint64](../../scalar/#uint64) |  | The Applicant's current version; send it back on a transition to act on exactly this revision (a stale version is rejected as a conflict). |







<a name="tzero-v1-manage-kyc_sharing-GetRequesterKycApplicantRequest"></a>

### GetRequesterKycApplicantRequest
Identifies the applicant: the payout provider (whose KYC form is filled) plus the end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-GetRequesterKycApplicantResponse"></a>

### GetRequesterKycApplicantResponse
The KYC form at the version the applicant is bound to plus the applicant's stored values.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form | [KycForm](../../end-client-kyb/manage_kyc_sharing_form/#tzero-v1-manage-kyc_sharing-KycForm) |  |  |
| applicant | [KycApplicant](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KycApplicant) |  | Stored values, absent until any values are saved. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version these values are bound to. |
| state | [ApplicantState](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | Current lifecycle state. |
| reject_reason | [string](../../scalar/#string) | optional | The rejection reason; absent unless the applicant is currently rejected. |
| version | [uint64](../../scalar/#uint64) |  | The Applicant's current version; send it back on a transition to act on exactly this revision (a stale version is rejected as a conflict). |







<a name="tzero-v1-manage-kyc_sharing-ListProviderFormsRequest"></a>

### ListProviderFormsRequest
Carries no fields — the calling Payout Requester is taken from the auth context.


This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-ListProviderFormsResponse"></a>

### ListProviderFormsResponse
The Payout Providers the calling Payout Requester has mutual consent with, each with the form types it publishes.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| provider_forms | [ListProviderFormsResponse.ProviderForms](#tzero-v1-manage-kyc_sharing-ListProviderFormsResponse-ProviderForms) | repeated | The consented providers, each with ≥1 published form type. |







<a name="tzero-v1-manage-kyc_sharing-ListProviderFormsResponse-ProviderForms"></a>

### ListProviderFormsResponse.ProviderForms
One consented Payout Provider: its id, display name, and the form types it has published (KYB and/or KYC).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form_types | [FormType](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-FormType) | repeated | The form types this provider publishes (KYB and/or KYC), at least one. |
| payout_provider_id | [uint32](../../scalar/#uint32) |  | The consented Payout Provider's id. |
| payout_provider_name | [string](../../scalar/#string) |  | The Payout Provider's display name. |







<a name="tzero-v1-manage-kyc_sharing-ListRequesterApplicantsRequest"></a>

### ListRequesterApplicantsRequest
Lists the calling Payout Requester's own applicants, optionally filtered by form type, Payout Provider, and/or lifecycle state, one page at a time.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form_type | [FormType](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-FormType) | optional | optional filter; unset lists applicants of every form type (KYB and KYC). |
| payout_provider_id | [uint32](../../scalar/#uint32) | optional | optional filter; unset lists applicants across every Payout Provider. An explicit 0 matches no Payout Provider, so it is rejected — omit the field instead. |
| states | [ApplicantState](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) | repeated | filter; an empty list returns applicants in every state. |
| page | [Page](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-Page) | optional | no validation: absent = the first page at the default size; Page validates its own contents. |







<a name="tzero-v1-manage-kyc_sharing-ListRequesterApplicantsResponse"></a>

### ListRequesterApplicantsResponse
One page of the calling Payout Requester's applicants of the requested form type matching the filters.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| applicants | [ListRequesterApplicantsResponse.Applicant](#tzero-v1-manage-kyc_sharing-ListRequesterApplicantsResponse-Applicant) | repeated | The matching applicants on this page. |
| page_info | [PageInfo](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-PageInfo) |  | The page just read; has_next drives whether the caller asks for the next one. |







<a name="tzero-v1-manage-kyc_sharing-ListRequesterApplicantsResponse-Applicant"></a>

### ListRequesterApplicantsResponse.Applicant
One applicant in the Payout Requester's listing: the target Payout Provider, the end-client reference, plus form type, lifecycle state, and bound form version.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  | The Payout Provider the Applicant targets. |
| payout_provider_name | [string](../../scalar/#string) |  | The Payout Provider's display name. |
| client_id | [string](../../scalar/#string) |  | The end-client reference. |
| state | [ApplicantState](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | Current lifecycle state. |
| form_type | [FormType](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-FormType) |  | KYB or KYC. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version the Applicant is bound to. |







<a name="tzero-v1-manage-kyc_sharing-SaveKybApplicantRequest"></a>

### SaveKybApplicantRequest
Stores an applicant's KYB values. The form scope is implicit and the version is
server-resolved to the client's bound form version (the provider's current version on the first save), so
neither is sent.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |
| applicant | [KybApplicant](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybApplicant) |  | The complete main-form snapshot, sent on every save; an empty applicant clears all stored main-form values (same snapshot rule as `ubos`). |
| ubos | [KybUbo](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybUbo) | repeated | The full ordered UBO set (snapshot), at most 100 owners — position is the owner's index; a later save replaces the stored owners, and an omitted or empty list clears all stored owners. |







<a name="tzero-v1-manage-kyc_sharing-SaveKybApplicantResponse"></a>

### SaveKybApplicantResponse
Stored values echoed back with the payout provider's form definition and the bound form_version, ready for the edit UI.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form | [KybForm](../../end-client-kyb/manage_kyc_sharing_form/#tzero-v1-manage-kyc_sharing-KybForm) |  |  |
| applicant | [KybApplicant](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybApplicant) |  | The stored main-form values echoed back. |
| ubos | [KybUbo](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybUbo) | repeated | The stored beneficial owners, in submission order. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version these values are bound to. |
| version | [uint64](../../scalar/#uint64) |  | The Applicant's version after this save; send it back on a transition (submit/withdraw) to act on exactly this revision without re-reading (a stale version is rejected as a conflict). |







<a name="tzero-v1-manage-kyc_sharing-SaveKycApplicantRequest"></a>

### SaveKycApplicantRequest
Stores an applicant's KYC values against the client's bound form version (the provider's current version on the first save).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |
| applicant | [KycApplicant](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KycApplicant) |  | The complete snapshot, sent on every save; an empty applicant clears all stored values. |







<a name="tzero-v1-manage-kyc_sharing-SaveKycApplicantResponse"></a>

### SaveKycApplicantResponse
Stored KYC values echoed back with the payout provider's form definition and the bound form_version.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form | [KycForm](../../end-client-kyb/manage_kyc_sharing_form/#tzero-v1-manage-kyc_sharing-KycForm) |  |  |
| applicant | [KycApplicant](../../end-client-kyb/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KycApplicant) |  | The stored values echoed back. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version these values are bound to. |
| version | [uint64](../../scalar/#uint64) |  | The Applicant's version after this save; send it back on a transition (submit/withdraw) to act on exactly this revision without re-reading (a stale version is rejected as a conflict). |







<a name="tzero-v1-manage-kyc_sharing-SubmitApplicantRequest"></a>

### SubmitApplicantRequest
Identifies the Applicant the Payout Requester submits for review, by payout provider and end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |
| version | [uint64](../../scalar/#uint64) |  | The Applicant version being submitted, from the last Get*Applicant read or save (0 is the initial version); a stale one is rejected as a conflict. no validation: any value is checked against the stored version. |







<a name="tzero-v1-manage-kyc_sharing-SubmitApplicantResponse"></a>

### SubmitApplicantResponse



This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-WithdrawApplicantRequest"></a>

### WithdrawApplicantRequest
Identifies the Applicant the Payout Requester withdraws to `draft`, by payout provider and end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |
| version | [uint64](../../scalar/#uint64) |  | The Applicant version being withdrawn, from the last Get*Applicant read or save; a stale one is rejected as a conflict. no validation: any value is checked against the stored version. |







<a name="tzero-v1-manage-kyc_sharing-WithdrawApplicantResponse"></a>

### WithdrawApplicantResponse



This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->


