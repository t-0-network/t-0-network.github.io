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

## Quick Start with Starter Template

Scaffold a complete provider project with a single command:

```bash
go run github.com/t-0-network/provider-sdk/go/starter@latest my-provider
```

This creates a ready-to-run project with a secp256k1 keypair, environment config, provider service stubs, and a Dockerfile.

### Generated Project Structure

```
my-provider/
├── cmd/
│   └── main.go              # Entry point
├── internal/
│   ├── handler/
│   │   ├── provider.go      # Provider service implementation
│   │   └── payment.go       # Payment handler implementation
│   ├── get_quote.go         # Quote retrieval logic
│   ├── publish_quotes.go    # Quote publishing logic
│   └── service.go           # Service utilities
├── .env                     # Environment variables (with generated keys)
├── .env.example             # Example environment file
├── .gitignore               # Git ignore rules
├── Dockerfile               # Docker configuration
├── go.mod                   # Go module definition
└── go.sum                   # Go dependencies checksums
```

### Key Files to Modify

| File | Purpose |
|------|---------|
| `internal/handler/payment.go` | Implement your payment processing logic. Look for `TODO` comments. |
| `internal/publish_quotes.go` | Replace sample quotes with your FX rate source. |

### Getting Started

#### Phase 1: Quoting

1. Review the generated keys in `.env` — share your public key (shown as a comment) with the T-0 team to register your provider.
2. Edit `internal/publish_quotes.go` to implement your quote publishing logic.
3. Start the development server: `go run ./cmd/main.go`
4. Verify quotes are received by the network.

#### Phase 2: Payments

1. Implement `UpdatePayment` handler in `internal/handler/payment.go`.
2. Deploy your service and share the base URL with the T-0 team.
3. Implement `PayOut` handler in `internal/handler/payment.go`.
4. Coordinate with the T-0 team to test end-to-end payment flows.

### Deployment

```bash
docker build -t my-provider:latest .
docker run -p 8080:8080 --env-file .env my-provider:latest
```

Full starter template source: [GitHub](https://github.com/t-0-network/provider-sdk/tree/master/go/starter/template)

---

## Architecture

The SDK consists of two main components:

- **Provider Service Handler**: Enables you to create services that respond to t-0 Network requests
- **Network Client**: Allows direct interaction with t-0 Network services

## Prerequisites

- Go 1.22 or later

## Provider Service Implementation

### Service Interface

Implement the `paymentconnect.ProviderServiceHandler` interface to create your provider service. You can check the
detailed description of each rpc in the [API Reference](https://t-0-network.github.io/docs/integration-guidance/api-reference/provider/)

```go
package main

import (
    "context"

    "connectrpc.com/connect"
    "github.com/t-0-network/provider-sdk/go/api/tzero/v1/payment"
    "github.com/t-0-network/provider-sdk/go/api/tzero/v1/payment/paymentconnect"
)

type ProviderServiceHandler interface {
    PayOut(context.Context, *connect.Request[payment.PayoutRequest]) (*connect.Response[payment.PayoutResponse], error)
    UpdatePayment(context.Context, *connect.Request[payment.UpdatePaymentRequest]) (*connect.Response[payment.UpdatePaymentResponse], error)
    UpdateLimit(context.Context, *connect.Request[payment.UpdateLimitRequest]) (*connect.Response[payment.UpdateLimitResponse], error)
    AppendLedgerEntries(context.Context, *connect.Request[payment.AppendLedgerEntriesRequest]) (*connect.Response[payment.AppendLedgerEntriesResponse], error)
    ApprovePaymentQuotes(context.Context, *connect.Request[payment.ApprovePaymentQuoteRequest]) (*connect.Response[payment.ApprovePaymentQuoteResponse], error)
}
```

### Provider Handler Setup

Initialize the provider handler with the t-0 Network public key and your service implementation:

```go
package main

import (
    "github.com/t-0-network/provider-sdk/go/api/tzero/v1/payment/paymentconnect"
    "github.com/t-0-network/provider-sdk/go/provider"
)

// t-0 Network hex formatted public key
networkPublicKey := "0x04..."

providerServiceHandler, err := provider.NewHttpHandler(
    provider.NetworkPublicKeyHexed(networkPublicKey),
    provider.Handler(paymentconnect.NewProviderServiceHandler,
        paymentconnect.ProviderServiceHandler(&ProviderServiceImplementation{})),
)
if err != nil {
    log.Fatalf("Failed to create provider service handler: %v", err)
}
```

### HTTP Server Configuration
This step is optional, you can register and serve the handler using your existing HTTP server.

#### Launch an HTTP server with the provider handler:

```go
shutdownFunc, err := provider.StartServer(
    providerServiceHandler,
    // optional configuration
    provider.WithAddr(":8080"),
)
if err != nil {
    log.Fatalf("Failed to start provider server: %v", err)
}

// Manual shutdown handling
if err := shutdownFunc(context.Background()); err != nil {
    log.Printf("Failed to shutdown server: %v", err)
}
```

## t-0 Network Client

The network client provides direct interaction capabilities with t-0 Network services, handling authentication and request signing automatically.

### Client Initialization

```go
package main

import (
    "github.com/t-0-network/provider-sdk/go/api/tzero/v1/payment/paymentconnect"
    "github.com/t-0-network/provider-sdk/go/network"
)

networkClient, err := network.NewServiceClient(
    network.PrivateKeyHexed("0x7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8"),
    paymentconnect.NewNetworkServiceClient,
    network.WithBaseURL("https://api-sandbox.t-0.network"),
)
if err != nil {
    log.Fatalf("Failed to create network service client: %v", err)
}
```

### Network Service Operations

```go
package main

import (
    "github.com/google/uuid"
    "github.com/t-0-network/provider-sdk/go/api/tzero/v1/common"
    "github.com/t-0-network/provider-sdk/go/api/tzero/v1/payment"
    "google.golang.org/protobuf/types/known/timestamppb"
)

// Example: Update quote operation
_, err := networkClient.UpdateQuote(ctx, connect.NewRequest(&payment.UpdateQuoteRequest{
    PayOut: []*payment.UpdateQuoteRequest_Quote{
        {
            Currency:      "EUR",
            QuoteType:     payment.QuoteType_QUOTE_TYPE_REALTIME,
            PaymentMethod: common.PaymentMethodType_PAYMENT_METHOD_TYPE_SEPA,
            Expiration:    timestamppb.New(time.Now().Add(30 * time.Second)),
            Timestamp:     timestamppb.New(time.Now()),
            Bands: []*payment.UpdateQuoteRequest_Quote_Band{
                {
                    ClientQuoteId: uuid.NewString(),
                    MaxAmount:     &common.Decimal{Unscaled: 1000, Exponent: 0},
                    Rate:          &common.Decimal{Unscaled: 86, Exponent: -2}, // rate 0.86
                },
            },
        },
    },
}))
if err != nil {
    log.Printf("Failed to update quote: %v", err)
    return
}
```

