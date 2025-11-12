---
weight: 352
title: "Golang SDK"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

## Overview

The Provider SDK is a Go library that enables payment processing services to integrate with the t-0 Network. The SDK provides comprehensive functionality for implementing provider services, handling cryptographic authentication, and managing network communications.

## Architecture

The SDK consists of two main components:

- **Provider Service Handler**: Enables you to create services that respond to t-0 Network requests
- **Network Client**: Allows direct interaction with t-0 Network services

## Prerequisites

- Go 1.22 or later

## Provider Service Implementation

### Service Interface

Implement the `networkconnect.ProviderServiceHandler` interface to create your provider service. You can check the 
detailed description of each rpc in the [API Reference](https://t-0-network.github.io/docs/integration-guidance/api-reference/provider/)

```go
type ProviderServiceHandler interface {
    PayOut(context.Context, *connect.Request[network.PayoutRequest]) (*connect.Response[network.PayoutResponse], error)
	
    UpdatePayment(context.Context, *connect.Request[network.UpdatePaymentRequest]) (*connect.Response[network.UpdatePaymentResponse], error)
	
    CreatePayInDetails(context.Context, *connect.Request[network.CreatePayInDetailsRequest]) (*connect.Response[network.CreatePayInDetailsResponse], error)
	
    UpdateLimit(context.Context, *connect.Request[network.UpdateLimitRequest]) (*connect.Response[network.UpdateLimitResponse], error)
	
    AppendLedgerEntries(context.Context, *connect.Request[network.AppendLedgerEntriesRequest]) (*connect.Response[network.AppendLedgerEntriesResponse], error)
}
```

### Provider Handler Setup

Initialize the provider handler with the t-0 Network public key and your service implementation:

```go
// t-0 Network hex formatted public key
networkPublicKey := "0x049bb924680bfba3f64d924bf9040c45dcc215b124b5b9ee73ca8e32c050d042c0bbd8dbb98e3929ed5bc2967f28c3a3b72dd5e24312404598bbf6c6cc47708dc7"

providerServiceHandler, err := provider.NewProviderHandler(
    provider.NetworkPublicKeyHexed(networkPublicKey), // t-0 Network public key
    &ProviderServiceImplementation{}, // This is your service implementation - replace with your actual implementation
    // optional configuration
    provider.WithVerifySignatureFn(verifySignatureFn) // Custom signature verification function
    provider.WithConnectHandlerOptions(HandlerOptions) // Additional Connect handler options
)
if err != nil {
    log.Fatalf("Failed to create provider service handler: %v", err)
}
```

### HTTP Server Configuration
This step is optional, you can register and serve the handler using your existing HTTP server.

#### Launch an HTTP server with the provider handler:

```go
shutdownFunc := provider.StartServer( // Start the HTTP server with the provider service handler, one-liner, you can also use your own HTTP server implementation 
    providerServiceHandler,
    // optional configuration
    provider.WithAddr(":8080"),
    provider.WithReadTimeout(10 * time.Second)
    provider.WithWriteTimeout(10 * time.Second)
    provider.WithReadHeaderTimeout(10 * time.Second)
    provider.WithTLSConfig(tlsConfig)
)

// Manual shutdown handling
if err := shutdownFunc(context.Background()); err != nil {
    log.Printf("Failed to shutdown server: %v", err)
}
```

#### Or return a ready to use HTTP Server

Create an HTTP server instance without starting it:

```go
server := provider.NewServer(
    providerServiceHandler,
    provider.WithAddr(":8080"),
)
```

## t-0 Network Client

The network client provides direct interaction capabilities with t-0 Network services, handling authentication and request signing automatically.

### Client Initialization

```go
import (
    "context"
    "log"

    "connectrpc.com/connect"
    networkproto "github.com/t-0-network/provider-sdk-go/api/gen/proto/network"
    "github.com/t-0-network/provider-sdk-go/pkg/network"
)

// Initialize with private key
yourPrivateKey := network.PrivateKeyHexed("0x7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8")

networkClient, err := network.NewServiceClient(yourPrivateKey)
if err != nil {
    log.Fatalf("Failed to create network service client: %v", err)
}
```

### Network Service Operations

```go
// Example: Update quote operation
_, err = networkClient.UpdateQuote(context.Background(), connect.NewRequest(&networkproto.UpdateQuoteRequest{
    // Request parameters
}))
if err != nil {
    log.Printf("Failed to update quote: %v", err)
    return
}
```

## Examples

Comprehensive examples are available in:
- [Pay-In Provider flow Example](https://github.com/t-0-network/provider-sdk-go/blob/main/examples/payin_provider_flow_test.go)
- [Payout Provider flow Example](https://github.com/t-0-network/provider-sdk-go/blob/main/examples/payout_provider_flow_test.go)
- [Provider Service Example](https://github.com/t-0-network/provider-sdk-go/blob/main/examples/network_client_test.go)
- [Network Client Example](https://github.com/t-0-network/provider-sdk-go/blob/main/examples/provider_service_test.go)
