---
weight: 303
title: "App API"
description: ""
icon: "article"
date: "2026-10-29T00:00:00+01:00"
lastmod: "2026-10-29T00:00:00+01:00"
draft: false
toc: true
---

The App API is the API of the T-0 app service. It serves the features outside the payment flow, while the Network API handles quotes and payments. [KYC sharing](/docs/network/kyc-sharing-flow/) is the first feature on it.

## Endpoints
* Production: `https://{{< param "app.api.domain.production" >}}`
* Sandbox: `https://{{< param "app.api.domain.sandbox" >}}`

## App API Key

{{% alert context="warning" %}}
**The App API uses its own keys, apart from the Network API.** Sign your App API requests with your App API key, and verify calls from the App API against the [App API public key](#signature-verification). If you sign an App API request with your Network key, the call fails with `Unauthenticated`.
{{% /alert %}}

Generate an ECDSA key pair for the App API and send its public key to T-0 for registration (see [Onboarding](/docs/network/onboarding/)). Sign each request with the headers and algorithm from [Request Authentication](/docs/integration-guidance/protocol/authentication/), using the App API key.

To replace the key, send the new public key to T-0. The new key works as soon as T-0 registers it, and the old key keeps working for up to 5 minutes after that.

## Signature Verification

T-0 signs each call that the App API sends to you with a separate App API key pair. Verify these calls with the steps from [Signature Verification](/docs/integration-guidance/protocol/authentication/#signature-verification), against the App API public key below. The Network public key does not verify them. Reject any call that fails verification.

| Environment | App API public key |
|---|---|
| Production | Pending |
| Sandbox | Pending |

## Requests

Send each call as POST. The App API rejects signed GET requests, so leave Connect GET off in your client. In Go, do not pass `connect.WithHTTPGet()`.

## Services

| Feature | Overview | Guide and reference |
|---|---|---|
| KYC sharing | [KYC Sharing Flow](/docs/network/kyc-sharing-flow/) | [KYC Sharing](/docs/integration-guidance/api-reference/kyc-sharing/guide/) |
