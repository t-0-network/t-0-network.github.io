---
weight: 345
title: "Provider"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

<a name="tzero-v1-manage-kyc_sharing-KycApplicantProviderService"></a>

## KycApplicantProviderService
Payout-Provider-facing applicant review: read a submitted Applicant, decide on it
(approve/reject), and list submitted Applicants.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| GetProviderKybApplicant | [GetProviderKybApplicantRequest](#tzero-v1-manage-kyc_sharing-GetProviderKybApplicantRequest) | [GetProviderKybApplicantResponse](#tzero-v1-manage-kyc_sharing-GetProviderKybApplicantResponse) | Returns a submitted KYB Applicant for review — the bound form, the submitted values and beneficial owners, the form version, and current lifecycle state. Fails with FailedPrecondition for a draft or missing Applicant, and with InvalidArgument when the `client_id` has a KYC applicant. |
| GetProviderKycApplicant | [GetProviderKycApplicantRequest](#tzero-v1-manage-kyc_sharing-GetProviderKycApplicantRequest) | [GetProviderKycApplicantResponse](#tzero-v1-manage-kyc_sharing-GetProviderKycApplicantResponse) | Returns a submitted KYC Applicant for review — the bound form, the submitted values, the form version, and current lifecycle state. Fails with FailedPrecondition for a draft or missing Applicant, and with InvalidArgument when the `client_id` has a KYB applicant. |
| ApproveApplicant | [ApproveApplicantRequest](#tzero-v1-manage-kyc_sharing-ApproveApplicantRequest) | [ApproveApplicantResponse](#tzero-v1-manage-kyc_sharing-ApproveApplicantResponse) | Approves a `requested` or `rejected` Applicant, moving it to `approved` (approve-from-rejected reverses an earlier rejection and clears its reason). Approving an already-`approved` Applicant is the idempotent no-op; `draft` is rejected as a failed precondition, since it was never submitted. |
| RejectApplicant | [RejectApplicantRequest](#tzero-v1-manage-kyc_sharing-RejectApplicantRequest) | [RejectApplicantResponse](#tzero-v1-manage-kyc_sharing-RejectApplicantResponse) | Rejects a `requested`, `approved`, or already-`rejected` Applicant with a mandatory free-text reason, moving it to `rejected`. Re-rejecting an already-`rejected` Applicant overwrites the stored reason; `draft` is rejected as a failed precondition, since the Applicant was never submitted for review. |
| ListProviderApplicants | [ListProviderApplicantsRequest](#tzero-v1-manage-kyc_sharing-ListProviderApplicantsRequest) | [ListProviderApplicantsResponse](#tzero-v1-manage-kyc_sharing-ListProviderApplicantsResponse) | Lists applicants submitted to the calling Payout Provider (always past `draft`), optionally filtered by form type (KYB or KYC), Payout Requester, and/or lifecycle state. Paged: one page per call (default size 10), with `page_info.has_next` telling the caller whether to ask for the next one. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-manage-kyc_sharing-ApproveApplicantRequest"></a>

### ApproveApplicantRequest
Identifies the Applicant the Payout Provider approves, by payout requester and end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_requester_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |
| version | [uint64](../../scalar/#uint64) |  | The Applicant version being approved, from the Get*Applicant read the provider reviewed; a stale one is rejected as a conflict. no validation: any value is checked against the stored version. |







<a name="tzero-v1-manage-kyc_sharing-ApproveApplicantResponse"></a>

### ApproveApplicantResponse



This message has no fields defined.






<a name="tzero-v1-manage-kyc_sharing-GetProviderKybApplicantRequest"></a>

### GetProviderKybApplicantRequest
Identifies the submitted Applicant the Payout Provider reads, by payout requester and end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_requester_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-GetProviderKybApplicantResponse"></a>

### GetProviderKybApplicantResponse
The submitted KYB Applicant: the bound form, the submitted main-form values and beneficial owners, the form version, and current lifecycle state.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form | [KybForm](../../kyc-sharing/manage_kyc_sharing_form/#tzero-v1-manage-kyc_sharing-KybForm) |  |  |
| applicant | [KybApplicant](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybApplicant) |  | The submitted main-form values. |
| ubos | [KybUbo](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KybUbo) | repeated | The submitted beneficial owners, in submission order. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version the Applicant is bound to. |
| state | [ApplicantState](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | Current lifecycle state. |
| reject_reason | [string](../../scalar/#string) | optional | The rejection reason; absent unless the applicant is currently rejected. |
| version | [uint64](../../scalar/#uint64) |  | The Applicant's current version; send it back on a transition to act on exactly this revision (a stale version is rejected as a conflict). |







<a name="tzero-v1-manage-kyc_sharing-GetProviderKycApplicantRequest"></a>

### GetProviderKycApplicantRequest
Identifies the submitted Applicant the Payout Provider reads, by payout requester and end-client reference.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_requester_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |







<a name="tzero-v1-manage-kyc_sharing-GetProviderKycApplicantResponse"></a>

### GetProviderKycApplicantResponse
The submitted KYC Applicant: the bound form, the submitted values, the form version, and current lifecycle state.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form | [KycForm](../../kyc-sharing/manage_kyc_sharing_form/#tzero-v1-manage-kyc_sharing-KycForm) |  |  |
| applicant | [KycApplicant](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-KycApplicant) |  | The submitted values. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version the Applicant is bound to. |
| state | [ApplicantState](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | Current lifecycle state. |
| reject_reason | [string](../../scalar/#string) | optional | The rejection reason; absent unless the applicant is currently rejected. |
| version | [uint64](../../scalar/#uint64) |  | The Applicant's current version; send it back on a transition to act on exactly this revision (a stale version is rejected as a conflict). |







<a name="tzero-v1-manage-kyc_sharing-ListProviderApplicantsRequest"></a>

### ListProviderApplicantsRequest
Lists applicants submitted to the calling Payout Provider, optionally filtered by form type, Payout Requester, and/or lifecycle state, one page at a time.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| form_type | [FormType](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-FormType) | optional | optional filter; unset lists applicants of every form type (KYB and KYC). |
| payout_requester_id | [uint32](../../scalar/#uint32) | optional | optional filter; unset lists applicants from every Payout Requester. An explicit 0 matches no Payout Requester, so it is rejected — omit the field instead. |
| states | [ApplicantState](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) | repeated | filter; an empty list returns applicants in every (post-draft) state — pass [REQUESTED] for the review queue. DRAFT is never visible to a Payout Provider (an Applicant reaches it only once submitted), so it is not an accepted value. |
| page | [Page](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-Page) | optional | no validation: absent = the first page at the default size; Page validates its own contents. |







<a name="tzero-v1-manage-kyc_sharing-ListProviderApplicantsResponse"></a>

### ListProviderApplicantsResponse
One page of the applicants of the requested form type submitted to the calling Payout Provider matching the filters.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| applicants | [ListProviderApplicantsResponse.Applicant](#tzero-v1-manage-kyc_sharing-ListProviderApplicantsResponse-Applicant) | repeated | The matching applicants on this page. |
| page_info | [PageInfo](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-PageInfo) |  | The page just read; has_next drives whether the caller asks for the next one. |







<a name="tzero-v1-manage-kyc_sharing-ListProviderApplicantsResponse-Applicant"></a>

### ListProviderApplicantsResponse.Applicant
One applicant in the Payout Provider's listing: the owning Payout Requester, the end-client reference, plus form type, lifecycle state, and bound form version.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_requester_id | [uint32](../../scalar/#uint32) |  | The Payout Requester that owns the Applicant. |
| payout_requester_name | [string](../../scalar/#string) |  | The Payout Requester's display name. |
| client_id | [string](../../scalar/#string) |  | The end-client reference. |
| state | [ApplicantState](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-ApplicantState) |  | Current lifecycle state. |
| form_type | [FormType](../../kyc-sharing/manage_kyc_sharing_common/#tzero-v1-manage-kyc_sharing-FormType) |  | KYB or KYC. |
| form_version | [uint32](../../scalar/#uint32) |  | The form version the Applicant is bound to. |







<a name="tzero-v1-manage-kyc_sharing-RejectApplicantRequest"></a>

### RejectApplicantRequest
Identifies the Applicant the Payout Provider rejects (by payout requester and end-client reference), plus the mandatory free-text reason.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_requester_id | [uint32](../../scalar/#uint32) |  |  |
| client_id | [string](../../scalar/#string) |  |  |
| reason | [string](../../scalar/#string) |  | Mandatory free-text rejection reason (no predefined categories). |
| version | [uint64](../../scalar/#uint64) |  | The Applicant version being rejected, from the Get*Applicant read the provider reviewed; a stale one is rejected as a conflict. no validation: any value is checked against the stored version. |







<a name="tzero-v1-manage-kyc_sharing-RejectApplicantResponse"></a>

### RejectApplicantResponse



This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->


