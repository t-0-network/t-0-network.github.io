---
weight: 346
title: "Files"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

<a name="tzero-v1-manage-kyc_sharing-KycFileService"></a>

## KycFileService
File storage for KYB/KYC sharing forms: a Payout Requester uploads a file (a
PDF or image) for one of its customers against a Payout Provider's form and
receives a stable file id to reference it; both sides can download it later.

| Method Name | Request Type | Response Type | Description |
| ----------- | ------------ | ------------- | ------------|
| UploadFile | [UploadFileRequest](#tzero-v1-manage-kyc_sharing-UploadFileRequest) stream | [UploadFileResponse](#tzero-v1-manage-kyc_sharing-UploadFileResponse) | Client-streaming upload (first message Metadata, then Chunks) that stores the file and returns its id. A retry with the same optional Metadata.upload_id returns the originally stored file; without it, each call stores a new file. |
| DownloadFile | [DownloadFileRequest](#tzero-v1-manage-kyc_sharing-DownloadFileRequest) | [DownloadFileResponse](#tzero-v1-manage-kyc_sharing-DownloadFileResponse) stream | Server-streaming download of a previously uploaded file. The first response message carries Metadata (content type, advisory original name); the rest are Chunks of the file bytes. The file is identified by its id plus the (Payout Requester, Payout Provider, client) tuple it must belong to; access is granted to the owning requester (any state) and to the provider once the matching application is past draft. |

 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-manage-kyc_sharing-DownloadFileRequest"></a>

### DownloadFileRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| file_id | [int64](../../scalar/#int64) |  | Stable id of the file to download. |
| payout_requester_id | [uint32](../../scalar/#uint32) |  | The Payout Requester that owns the file (its originator). |
| payout_provider_id | [uint32](../../scalar/#uint32) |  | The Payout Provider whose form the file was uploaded against. |
| client_id | [string](../../scalar/#string) |  | The Payout Requester's own reference for the end client (applicant), the same value as the applicant's client_id. |







<a name="tzero-v1-manage-kyc_sharing-DownloadFileResponse"></a>

### DownloadFileResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| metadata | [DownloadFileResponse.Metadata](#tzero-v1-manage-kyc_sharing-DownloadFileResponse-Metadata) |  | Exactly the first stream message. |
| chunk | [DownloadFileResponse.Chunk](#tzero-v1-manage-kyc_sharing-DownloadFileResponse-Chunk) |  | Every message after the first. |







<a name="tzero-v1-manage-kyc_sharing-DownloadFileResponse-Chunk"></a>

### DownloadFileResponse.Chunk



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| data | [bytes](../../scalar/#bytes) |  |  |







<a name="tzero-v1-manage-kyc_sharing-DownloadFileResponse-Metadata"></a>

### DownloadFileResponse.Metadata



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| content_type | [string](../../scalar/#string) |  | The effective content type of the stored file, determined server-side at upload time (e.g. application/pdf, image/png, image/jpeg). |
| file_name | [string](../../scalar/#string) | optional | The original uploaded filename, advisory only. Optional — may be absent. |







<a name="tzero-v1-manage-kyc_sharing-UploadFileRequest"></a>

### UploadFileRequest



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| metadata | [UploadFileRequest.Metadata](#tzero-v1-manage-kyc_sharing-UploadFileRequest-Metadata) |  | Exactly the first stream message. |
| chunk | [UploadFileRequest.Chunk](#tzero-v1-manage-kyc_sharing-UploadFileRequest-Chunk) |  | Every message after the first. |







<a name="tzero-v1-manage-kyc_sharing-UploadFileRequest-Chunk"></a>

### UploadFileRequest.Chunk



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| data | [bytes](../../scalar/#bytes) |  |  |







<a name="tzero-v1-manage-kyc_sharing-UploadFileRequest-Metadata"></a>

### UploadFileRequest.Metadata



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| payout_provider_id | [uint32](../../scalar/#uint32) |  | The Payout Provider that owns the form this file is uploaded against. |
| client_id | [string](../../scalar/#string) |  | The Payout Requester's own reference for the end client (applicant), the same value as the applicant's client_id. |
| file_name | [string](../../scalar/#string) | optional | Original uploaded filename, advisory only. Optional — API clients may omit it. |
| declared_content_type | [string](../../scalar/#string) | optional | Advisory only; the effective content type is determined server-side. |
| upload_id | [string](../../scalar/#string) | optional | Optional client-generated idempotency key (e.g. a UUID). When set, a retry with the same key (scoped to the authenticated Payout Requester) returns the originally stored file instead of creating a new one. |







<a name="tzero-v1-manage-kyc_sharing-UploadFileResponse"></a>

### UploadFileResponse



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| file_id | [int64](../../scalar/#int64) |  | Stable identifier for the stored file. |






 <!-- end messages -->

 <!-- end enums -->


