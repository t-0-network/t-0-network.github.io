---
weight: 343
title: "Guide"
description: ""
icon: "article"
date: "2026-10-27T00:00:00+01:00"
lastmod: "2026-10-27T00:00:00+01:00"
draft: false
toc: true
---

A payout provider can require KYB or KYC data about the end clients of a payout requester before it serves them. With KYC sharing, the requester sends that data through the KYB API, and the provider reviews it there.

The requester registers each end client as an **applicant**: a KYB applicant for a business, a KYC applicant for a person. It fills in the provider's form for each applicant and submits it for review. The provider approves or rejects it.

| Role | Service | Purpose |
|---|---|---|
| Payout requester | [`KycApplicantRequesterService`](/docs/integration-guidance/api-reference/kyc-sharing/manage_kyc_sharing_applicant_requester/) | Creates applicants and submits them for review |
| Payout provider | [`KycApplicantProviderService`](/docs/integration-guidance/api-reference/kyc-sharing/manage_kyc_sharing_applicant_provider/) | Reviews submitted applicants |

Both roles use [`KycFileService`](/docs/integration-guidance/api-reference/kyc-sharing/manage_kyc_sharing_file/) for documents.

## Before You Start

- **Consent.** The requester and the provider grant each other KYB access in the dashboard. Without that consent, the requester's create, get, and save calls and `UploadFile` fail with `PermissionDenied`.
- **Forms.** The provider builds and publishes its KYB and KYC forms in the dashboard. `ListProviderForms` returns the providers you share consent with, each with the form types it has published.
- **Key pair.** Sign KYB API requests with a separate KYB key pair, which T-0 registers for you (see [Onboarding](/docs/network/onboarding/)). Your Network key does not work on the KYB API.

## Requests

Sign each request with the headers and algorithm from [Request Authentication](/docs/integration-guidance/protocol/authentication/), using your KYB key pair.

Send each call as POST. The KYB API rejects signed GET requests, so do not enable `WithHTTPGet` in your Connect client.

## Applicants

The requester picks a `client_id` of 1 to 64 characters as its own reference for each end client. The requester addresses an applicant by `payout_provider_id` and `client_id`. The provider uses `payout_requester_id` and `client_id`.

Each requester and provider pair has one applicant per `client_id`, KYB or KYC. A KYC call for the `client_id` of a KYB applicant fails with `InvalidArgument`, and so does the reverse.

| State | Meaning |
|---|---|
| `APPLICANT_STATE_DRAFT` | The requester is filling in the form. The provider cannot see the applicant. |
| `APPLICANT_STATE_REQUESTED` | The requester submitted the applicant. The provider has not decided yet. |
| `APPLICANT_STATE_APPROVED` | The provider approved the applicant. |
| `APPLICANT_STATE_REJECTED` | The provider rejected the applicant. `reject_reason` holds the provider's reason. |

## Requester Flow

1. Call `ListProviderForms` to find the provider and check that it publishes the form type you need.
2. Create the applicant with `CreateRequesterKybApplicant` or `CreateRequesterKycApplicant`. T-0 binds the applicant to the form version the provider has published at that moment, and later form versions do not change it. If you skip this call, the first save in step 5 creates the applicant, but you cannot read the form in step 3 before that.
3. Read the form with `GetRequesterKybApplicant` or `GetRequesterKycApplicant`. The response holds the form and any stored values.
4. Upload each document with `UploadFile` and put the returned `file_id` in the matching file field. See [Files](#files).
5. Save the values with `SaveKybApplicant` or `SaveKycApplicant`. A save replaces all stored values, so send the full set each time. In draft, you can save an incomplete set. A rejected applicant needs a complete set, so withdraw it first to save a partial one.
6. Once all required fields hold values, submit with `SubmitApplicant` and the `version` from your last read or save.
7. Track the review with `ListRequesterApplicants` or a `Get` call. On a rejection, read `reject_reason`, save a complete set of corrected values, and submit again.

### Withdraw and Delete

`WithdrawApplicant` returns an applicant to draft from any state and keeps its values. After you withdraw an applicant, approved or not, the provider's `Get` and `List` calls stop returning it until you submit it again.

`DeleteApplicant` deletes a draft or rejected applicant together with its uploaded files. To delete a requested or approved applicant, withdraw it first. Deleting an applicant that does not exist succeeds.

## Provider Flow

1. List your review queue with `ListProviderApplicants` and `states: [APPLICANT_STATE_REQUESTED]`.
2. Read each applicant with `GetProviderKybApplicant` or `GetProviderKycApplicant`. The response holds the form and the submitted values.
3. Download the documents with `DownloadFile`.
4. Approve with `ApproveApplicant`, or reject with `RejectApplicant` and a reason of up to 2000 characters. Pass the `version` from step 2. You can reverse a decision: approve a rejected applicant, or reject an approved one.

## Version Check

Reads and saves return the applicant's `version`. `SubmitApplicant`, `WithdrawApplicant`, `ApproveApplicant`, and `RejectApplicant` take the `version` from your last read or save. If the applicant changed since then, the call fails with `AlreadyExists`: read it again, check the change, and retry with the new `version`. Saves skip the check, so the last save overwrites earlier ones.

## Form Fields

Read the fields to fill from the `form` in a `Get` response.

- **Network-mandatory standard fields** carry `(network_mandatory) = true` in the field catalogue. `form.standard_fields` omits them, so add them to your form as required fields.
- **Optional standard fields** appear in `form.standard_fields` when the provider chooses them, each with a `required` flag.
- **Custom fields** come from the provider, with their full definitions in `form.custom_fields`.

The applicant messages `KybApplicant`, `KybUbo`, and `KycApplicant` define the value type, rules, and options of each standard field. See [Common](/docs/integration-guidance/api-reference/kyc-sharing/manage_kyc_sharing_common/). Send date values as midnight UTC.

## Files

Upload and download files with the Connect streaming RPCs `KycFileService.UploadFile` and `KycFileService.DownloadFile`. The first message of each stream is `Metadata`. Each later message is a `Chunk` of at most 1 MiB, and a file holds at most 50 MiB.

- `UploadFile` returns a `file_id`. Put it in a file field as a `FileValue`.
- Set `Metadata.upload_id` to make an upload safe to retry. A retry with the same `upload_id` returns the stored file. Without `upload_id`, each call stores a new file.
- To download, pass the `file_id` with the applicant's `payout_requester_id`, `payout_provider_id`, and `client_id`.
- The requester can download its files in any state. The provider can download them once the applicant leaves draft.

## Lists

`ListRequesterApplicants` and `ListProviderApplicants` return one page per call. Set `page.page` (from 1) and `page.size` (10 by default, 50 at most), and ask for the next page while `page_info.has_next` is true. To track state changes in your own system, poll these calls with a `states` filter.

## Errors

| Code | When |
|---|---|
| `FailedPrecondition` | The applicant does not exist, the caller cannot see it (a draft, for the provider), its state does not allow the call, or the provider has no published form of that type. |
| `AlreadyExists` | A stale `version`, or a create for an existing applicant. |
| `PermissionDenied` | The requester and provider have no mutual consent. The requester's create, get, and save calls and `UploadFile` check consent. Other calls skip the check. |
| `InvalidArgument` | A field breaks its rules, a required field has no value at submit, or the `client_id` belongs to an applicant of the other form type. |
