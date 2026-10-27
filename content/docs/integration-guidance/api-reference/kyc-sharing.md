---
weight: 350
title: "KYC Sharing Guide"
description: ""
icon: "article"
date: "2026-10-27T00:00:00+01:00"
lastmod: "2026-10-27T00:00:00+01:00"
draft: false
toc: true
---

KYC sharing lets a payout requester send the KYB or KYC data of its end clients to a payout provider for review. The requester calls `KycApplicantRequesterService`, and the provider calls `KycApplicantProviderService`. Providers set up their forms in the dashboard. Both services share the rules on this page.

## Requests

Sign every request with the headers and algorithm from [Request Authentication](/docs/integration-guidance/protocol/authentication/), using your KYB key pair. Your Network key does not work on the KYB API.

Send every call as POST. The KYB API rejects signed GET requests, so do not enable `WithHTTPGet` in your Connect client.

## Applicant Identity

- The requester addresses an applicant by `payout_provider_id` and `client_id`. The provider addresses it by `payout_requester_id` and `client_id`.
- `client_id` is the requester's own reference for its end client, 1 to 64 characters.
- A `client_id` has one applicant per requester and provider pair, either KYB or KYC. A call with the other form type fails with `InvalidArgument`.

## Lifecycle

1. `CreateRequesterKybApplicant` or `CreateRequesterKycApplicant` creates a draft. The first `SaveKybApplicant` or `SaveKycApplicant` for a new `client_id` also creates one. The draft binds to the form version the provider has published at that moment and keeps it.
2. A save replaces all stored values. A draft accepts an incomplete save. A rejected applicant accepts only a complete one.
3. `SubmitApplicant` sends a draft or rejected applicant for review. Every field the form requires must hold a value.
4. The provider approves with `ApproveApplicant` or rejects with a reason through `RejectApplicant`.
5. `WithdrawApplicant` returns the applicant to draft from any state. The provider never sees a draft, so a withdrawn applicant, approved ones included, disappears for the provider until the next submit.
6. `DeleteApplicant` deletes a draft or rejected applicant and its uploaded files. A delete for an applicant that does not exist succeeds.

## Version Check

- Every read and save returns `version`.
- `SubmitApplicant`, `WithdrawApplicant`, `ApproveApplicant`, and `RejectApplicant` take the `version` from your last read or save. They fail with `AlreadyExists` when the applicant changed after that read or save.
- Saves skip the version check, and the last save wins.

## Errors

| Code | When |
|---|---|
| `FailedPrecondition` | The applicant does not exist, or the caller cannot see it (a draft, for the provider). A call also gets this code when the applicant's state does not allow it, or when the provider has no published form of the requested type. |
| `AlreadyExists` | A stale `version`, or a create for an existing applicant. |
| `PermissionDenied` | The requester and provider have no mutual consent. Only the create, get, and save calls of the requester and the file upload check consent. |
| `InvalidArgument` | A field breaks its rules, or a required field has no value at submit. A call also gets this code when the `client_id` belongs to an applicant of the other form type. |

## Lists and Sync

- `ListRequesterApplicants` and `ListProviderApplicants` return one page per call. Pages start at 1. The default page size is 10 and the maximum is 50.
- To sync applicant states with your internal system, list with a state filter. A provider lists `states: [APPLICANT_STATE_REQUESTED]` to get its review queue.

## Form Fields

- **Network-mandatory standard fields** carry `(network_mandatory) = true` in the catalogue. Every form includes them as required fields.
- **Optional standard fields** appear only when the provider chose them. `form.standard_fields` carries the choice and the `required` flag.
- **Custom fields** have their full definitions in `form.custom_fields`.
- The applicant messages (`KybApplicant`, `KybUbo`, `KycApplicant`) define the metadata of every standard field: value type, options, and rules.
- Date fields accept only midnight UTC.

## Files

Upload and download files with the Connect streaming RPCs `KycFileService.UploadFile` and `KycFileService.DownloadFile`. The first message of each stream is `Metadata`. Each later message is a `Chunk` of at most 1 MiB, and a file holds at most 50 MiB.

- `UploadFile` returns a `file_id` that you reference in the file fields of the applicant.
- Set `Metadata.upload_id` to make an upload safe to retry. A retry with the same key returns the stored file. Without the key, each call stores a new file.
- The requester can download its files in any state. The provider can download them once the applicant leaves draft.
