---
weight: 301
title: "Integration Guidance"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

Correspondents integrate with the t-0 Network in two ways: through the SDK, or by implementing the protocols directly. Both use the Connect RPC framework, which supports gRPC and REST/JSON encoding.

You will implement client-side calls to network services and server-side endpoints that receive network callbacks. All communication uses cryptographic signatures for authentication and integrity verification.

## SDK - Recommended Integration Approach
The SDK is the fastest integration path. It handles request signing, signature verification, and key management, so you can focus on your business logic.
We recommend running it inside a standalone adapter service that sits between your system and the t-0 Network, keeping integration concerns isolated from your existing codebase and making SDK updates straightforward to roll out.
You can run a single command to scaffold a pre-configured project, ready to deploy. Available for Go, TypeScript, Python, Java, and C# on [GitHub](https://github.com/t-0-network/provider-sdk), along with per-language documentation.

## Network API
The Network API serves payments and payment intents, with their quotes. Its endpoints:

* Production: `https://{{< param "api.domain.production" >}}`
* Sandbox: `https://{{< param "api.domain.sandbox" >}}`

### Egress IP Addresses
The network calls your provider endpoints from these IP addresses:

* Production: `{{< param "egress.ip.production" >}}`
* Sandbox: `{{< param "egress.ip.sandbox" >}}`

You decide whether to add them to your firewall allowlist. You must verify the signature of every request from the network. See sections 18.1 and 18.4 of [Schedule 1 of the Network Services Agreement](/network-services-agreement/#sch1).

## Management API
The Management API serves the features outside the payment flows. Its services sit in the `tzero.v1.manage` proto package, and each call path starts with `/tzero.v1.manage.`. The first feature on it is [End-Client KYB](/docs/network/end-client-kyb-flow/), with its services under [End-Client KYB](/docs/integration-guidance/api-reference/end-client-kyb/) in the API Reference. Its endpoints:

* Production: `https://{{< param "app.api.domain.production" >}}`
* Sandbox: `https://{{< param "app.api.domain.sandbox" >}}`

### Management API Key

{{% alert context="warning" %}}
**Sign Management API requests with your Network key.** T-0 enables that key for the Management API. Until T-0 enables it, your calls fail with `Unauthenticated`.
{{% /alert %}}

Ask T-0 to enable your key (see [Onboarding](/docs/network/onboarding/)). Sign each request with the headers and algorithm from [Request Authentication](/docs/integration-guidance/protocol/authentication/).

When you replace your Network key, send the new public key to T-0. On the Management API, the new key works as soon as T-0 enables it, and the old key keeps working for up to 5 minutes after that.

### Requests
Send each call as POST. The Management API rejects signed GET requests, so leave Connect GET off in your client. In Go, do not pass `connect.WithHTTPGet()`.

## Idempotency and Request Safety
All network methods specify idempotency levels for safe retry behavior and duplicate prevention. See [Idempotency](idempotency) for the full reliability contract and provider implementation requirements.

## Protocol Implementation Approach
If you need full control or cannot use the SDK, implement the Connect RPC protocol directly. You manage both client-side and server-side aspects, including cryptographic operations.

### gRPC Protocol Implementation
gRPC uses binary encoding for high-throughput, strongly-typed communication. It is well suited for high-volume payment processing.

Generate client and server stubs from the provided protocol buffer definitions. `network.proto` defines the NetworkService interface you call; `provider.proto` defines the ProviderService interface you implement to receive callbacks.

Pay attention to connection management for long-lived streaming connections. Implement retry logic and circuit breaker patterns for network interruptions.

gRPC tooling covers most programming languages and fits well in microservices architectures. Strongly-typed interfaces enforce clear API contracts and catch integration errors at compile time.

### REST/JSON Protocol Implementation
REST/JSON offers broader compatibility and human-readable messages, making it easier to debug and monitor. It suits providers with existing REST-based architectures.

The Connect RPC framework generates REST endpoints for each gRPC service method. Both protocols share the same functionality. JSON message formats follow the protocol buffer JSON mapping specification, so gRPC and REST implementations stay consistent.

Handle HTTP status codes, error responses, and content negotiation in your implementation. REST's stateless model simplifies load balancing and horizontal scaling.