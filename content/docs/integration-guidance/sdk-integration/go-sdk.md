---
weight: 351
title: "Golang SDK"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

# Provider SDK

## Overview

The Provider SDK is a Go library that enables payment processing services to integrate with the T-ZERO Network. The SDK provides comprehensive functionality for implementing provider services, handling cryptographic authentication, and managing network communications.

## Architecture

The SDK consists of two main components:

- **Provider Service Handler**: Enables you to create services that respond to T-ZERO Network requests
- **Network Client**: Allows direct interaction with T-ZERO Network services

## Prerequisites

- Go 1.22 or later
- OpenSSL (for key generation)

## Key Management

### Key Types and Usage

The T-ZERO Network uses secp256k1 key pairs for request authentication and verification:

- **Your Private Key**: Signs outgoing requests to the T-ZERO Network
- **Your Public Key**: Shared with T-ZERO Network for request verification
- **T-ZERO Network Public Key**: Verifies incoming requests from T-ZERO Network
- **T-ZERO Network Private Key**: Used by T-ZERO Network to sign requests to your service

### Key Generation

Generate secp256k1 key pairs using the provided Makefile:

```bash
make keygen
```

Expected output format:
```
Private Key: 7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8
Public Key: 04a1b2c3d4e5f6789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef
```

#### Manual Key Generation

```bash
# Generate private key
openssl ecparam -genkey -name secp256k1 -noout > private_key.pem

# Extract private key hex
openssl ec -in private_key.pem -text -noout 2>/dev/null | grep -A 3 'priv:' | tail -n +2 | tr -d '\n: ' | sed 's/[^0-9a-f]//g'

# Extract public key hex
openssl ec -in private_key.pem -text -noout 2>/dev/null | grep -A 5 'pub:' | tail -n +2 | tr -d '\n: ' | sed 's/[^0-9a-f]//g'
```

### Security Best Practices

1. Never commit private keys to version control
2. Store private keys securely using environment variables or secure vaults
3. Use different keys for development and production environments
4. Share only public keys with T-ZERO Network for registration

## Provider Service Implementation

### Service Interface

Implement the `networkconnect.ProviderServiceHandler` interface to create your provider service:

```go
type ProviderServiceImplementation struct{}

func (s *ProviderServiceImplementation) AppendLedgerEntries(
    ctx context.Context, req *connect.Request[networkproto.AppendLedgerEntriesRequest],
) (*connect.Response[networkproto.AppendLedgerEntriesResponse], error) {
    // Implement ledger entry logic
    return connect.NewResponse(&networkproto.AppendLedgerEntriesResponse{}), nil
}

func (s *ProviderServiceImplementation) CreatePayInDetails(
    ctx context.Context, req *connect.Request[networkproto.CreatePayInDetailsRequest],
) (*connect.Response[networkproto.CreatePayInDetailsResponse], error) {
    // Implement pay-in details creation logic
    return connect.NewResponse(&networkproto.CreatePayInDetailsResponse{}), nil
}

func (s *ProviderServiceImplementation) PayOut(
    ctx context.Context, req *connect.Request[networkproto.PayoutRequest],
) (*connect.Response[networkproto.PayoutResponse], error) {
    // Implement payout logic
    return connect.NewResponse(&networkproto.PayoutResponse{}), nil
}

func (s *ProviderServiceImplementation) UpdateLimit(
    ctx context.Context, req *connect.Request[networkproto.UpdateLimitRequest],
) (*connect.Response[networkproto.UpdateLimitResponse], error) {
    // Implement limit update logic
    return connect.NewResponse(&networkproto.UpdateLimitResponse{}), nil
}

func (s *ProviderServiceImplementation) UpdatePayment(
    ctx context.Context, req *connect.Request[networkproto.UpdatePaymentRequest],
) (*connect.Response[networkproto.UpdatePaymentResponse], error) {
    // Implement payment update logic
    return connect.NewResponse(&networkproto.UpdatePaymentResponse{}), nil
}
```

### Provider Handler Setup

Initialize the provider handler with the T-ZERO Network public key and your service implementation:

```go
// T-ZERO Network hex formatted public key
networkPublicKey := "0x049bb924680bfba3f64d924bf9040c45dcc215b124b5b9ee73ca8e32c050d042c0bbd8dbb98e3929ed5bc2967f28c3a3b72dd5e24312404598bbf6c6cc47708dc7"

providerServiceHandler, err := provider.NewProviderHandler(
    provider.NetworkPublicKeyHexed(networkPublicKey),
    &ProviderServiceImplementation{},
    // optional configuration
    provider.WithVerifySignatureFn(verifySignatureFn)
    provider.WithConnectHandlerOptions(HandlerOptions)
)
if err != nil {
    log.Fatalf("Failed to create provider service handler: %v", err)
}
```

### HTTP Server Configuration
This step is optional, you can register and serve the handler using your existing HTTP server.

#### Launch an HTTP server with the provider handler:

```go
shutdownFunc := provider.StartServer(
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

## T-ZERO Network Client

The network client provides direct interaction capabilities with T-ZERO Network services, handling authentication and request signing automatically.

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
- [Provider Service Example](https://github.com/t-0-network/provider-sdk-go/blob/main/examples/network_client_test.go)
- [Network Client Example](https://github.com/t-0-network/provider-sdk-go/blob/main/examples/provider_service_test.go)
