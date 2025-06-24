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

Payment providers can integrate with the T-0 Network through two primary approaches: using the provided Software Development Kit (SDK) for simplified integration, or implementing the underlying protocols directly for maximum flexibility and control. Both approaches utilize the Connect RPC framework, which provides native support for both gRPC and REST/JSON encoding, allowing providers to choose the communication protocol that best fits their existing infrastructure.

The integration process requires implementing both client-side capabilities for calling network services and server-side endpoints for receiving network callbacks. All communications within the network utilize cryptographic signatures for authentication and integrity verification, ensuring secure and verifiable message exchange between all participants.

## API Endpoints
* Production: `https://api.t-0.network`
* Sandbox: `https://api-sandbox.t-0.network`

## Idempotency and Request Safety
All network RPC methods specify idempotency levels to ensure safe retry behavior and prevent duplicate processing. Methods marked as IDEMPOTENT can be safely retried multiple times with the same parameters without causing additional side effects.

Methods marked as NO_SIDE_EFFECTS, such as GetPayoutQuote, can be called multiple times without any system state changes, making them safe for aggressive retry policies and caching strategies.

This idempotency design enables robust error handling and retry mechanisms while preventing issues such as duplicate payments or incorrect credit usage accounting that could result from network interruptions or service restarts.

## SDK Integration Approach
The T-0 Network SDK provides the most streamlined integration path for payment providers, abstracting the complexity of protocol implementation and cryptographic operations. The SDK is currently available for Go programming language, with additional language support available upon request for specific integration requirements.

The SDK handles all cryptographic operations automatically, including request signing, signature verification, and key management. This approach significantly reduces the implementation complexity for providers while ensuring compliance with network security requirements. The SDK also provides built-in error handling, retry logic, and connection management to ensure robust operation in production environments.

When using the SDK, providers implement callback handlers for network-initiated operations such as payout requests and payment status updates. The SDK framework manages the underlying HTTP server functionality, allowing providers to focus on business logic implementation rather than protocol details.

## Protocol Implementation Approach
For providers requiring maximum control over their integration or operating in environments where SDK usage is not feasible, direct protocol implementation provides complete flexibility. This approach requires implementing both the client-side and server-side aspects of the Connect RPC protocol while managing cryptographic operations manually.

### gRPC Protocol Implementation
The gRPC implementation provides high-performance, strongly-typed communication between providers and the network. gRPC's binary protocol encoding offers superior efficiency compared to JSON-based alternatives, making it particularly suitable for high-volume payment processing environments.

When implementing gRPC integration, providers must generate client and server stubs from the provided protocol buffer definitions. The network.proto file defines the NetworkService interface that providers call to interact with the network, while the provider.proto file defines the ProviderService interface that providers must implement to receive network callbacks.

gRPC implementation requires careful attention to connection management, particularly for long-lived connections used for streaming operations. Providers should implement appropriate retry logic and circuit breaker patterns to handle network interruptions and service unavailability scenarios.

The gRPC approach provides excellent tooling support across multiple programming languages and integrates well with modern microservices architectures. The strongly-typed nature of gRPC interfaces helps prevent integration errors and provides clear API contracts between providers and the network.

### REST/JSON Protocol Implementation
The REST/JSON implementation offers broader compatibility and easier debugging compared to gRPC, making it suitable for providers with existing REST-based architectures or those requiring human-readable message formats for monitoring and troubleshooting.

REST/JSON implementation uses standard HTTP methods and JSON message encoding, following RESTful design principles. The Connect RPC framework automatically generates REST endpoints corresponding to each gRPC service method, maintaining consistent functionality across both protocol options.

When implementing REST/JSON integration, providers must carefully handle HTTP status codes, error responses, and content negotiation. The JSON message format follows the protocol buffer JSON mapping specification, ensuring consistency with gRPC implementations while providing human-readable message content.

REST implementation provides excellent debugging capabilities through standard HTTP debugging tools and offers straightforward integration with web-based monitoring and analytics platforms. The stateless nature of REST also simplifies load balancing and horizontal scaling of provider services.