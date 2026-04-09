---
weight: 301
title: "Introduction Guidance"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

Payment providers integrate with the T-0 Network in two ways: through the SDK, or by implementing the protocols directly. Both use the Connect RPC framework, which supports gRPC and REST/JSON encoding.

You will implement client-side calls to network services and server-side endpoints that receive network callbacks. All communication uses cryptographic signatures for authentication and integrity verification.

## API Endpoints
* Production: `https://api.t-0.network`
* Sandbox: `https://api-sandbox.t-0.network`

## Idempotency and Request Safety
All network methods specify idempotency levels for safe retry behavior and duplicate prevention. See [Idempotency](idempotency) for the full reliability contract and provider implementation requirements.

## SDK Integration Approach
The SDK is the fastest integration path. It handles request signing, signature verification, and key management for you. The Go SDK is available now; additional languages are available on request.

With the SDK, you write callback handlers for network-initiated operations like payout requests and payment status updates. The SDK manages the HTTP server, retry logic, and connection lifecycle. You focus on business logic.

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