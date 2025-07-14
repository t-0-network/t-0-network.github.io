---
weight: 352
title: "NodeJS SDK"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-07-14T12:09:09+02:00"
draft: false
toc: true
---

## Overview
[ts-sdk.md](ts-sdk.md)
The Provider SDK is a Node.js library that enables payment processing services to integrate with the T-ZERO Network. The SDK provides comprehensive functionality for implementing provider services, handling cryptographic authentication, and managing network communications.

## Architecture

The SDK consists of two main elements:

- **Provider Service Handler**: Enables you to create services that respond to T-ZERO Network requests
- **Network Client**: Allows direct interaction with T-ZERO Network services

## Prerequisites

- NodeJS v20 or later

## Installation
The following command will install the provider SDK
```bash
npm i @t-0/provider-sdk
```

## Provider Service Implementation

### Service Interface

Implement the `ProviderService` to create your provider service. You can check the detailed description of each rpc in the [API Reference](https://t-0-network.github.io/docs/integration-guidance/api-reference/provider/)

```typescript
import {
  PayoutRequest,
  PayoutResponse,
  UpdatePaymentRequest,
  UpdatePaymentResponse,
  CreatePayInDetailsRequest,
  CreatePayInDetailsResponse,
  UpdateLimitRequest,
  UpdateLimitResponse,
  AppendLedgerEntriesRequest,
  AppendLedgerEntriesResponse,
} from "@t-0/provider-sdk";
import {HandlerContext} from "@t-0/provider-sdk";


const CreateProviderService = () => {
  return {
    async payOut(req: PayoutRequest, context: HandlerContext) {
      return {} as PayoutResponse
    },

    async updatePayment(req: UpdatePaymentRequest, context: HandlerContext) {
      return {} as UpdatePaymentResponse
    },

    async createPayInDetails(req: CreatePayInDetailsRequest, context: HandlerContext) {
      return {} as CreatePayInDetailsResponse
    },

    async updateLimit(req: UpdateLimitRequest, context: HandlerContext) {
      return {} as UpdateLimitResponse
    },

    async appendLedgerEntries(req: AppendLedgerEntriesRequest, context: HandlerContext) {
      return {
      } as AppendLedgerEntriesResponse
    },
  }
};
```

### HTTP Server Configuration

Register and serve the handler using the HTTP server.

```typescript
import createService, {signatureValidation} from "@t-0/provider-sdk";
import * as http from "http";
import { nodeAdapter } from "@t-0/provider-sdk";

const server = http.createServer(
  signatureValidation(
    nodeAdapter(
      createService(networkPublicKeyHex, CreateProviderService())))
).listen(8080);
console.log("server is listening at", server.address());
```

## T-ZERO Network Client

The network client provides direct interaction capabilities with T-ZERO Network services, handling authentication and request signing automatically.

### Client Initialization

```typescript
import createNetworkClient from "@t-0/provider-sdk";

const privateKeyHex = "0x7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8";
const endpoint = "https://sandbox-api.t-0.network";
const networkClient = createNetworkClient(privateKeyHex, endpoint);
```

### Network Service Operations

Example of a quote pushing operation

```typescript
import {Decimal, DecimalSchema} from "@t-0/provider-sdk";

const toProtoDecimal = (unscaled: number, exponent: number): Decimal => {
  return create(DecimalSchema, {
    unscaled: BigInt(unscaled),
    exponent: exponent,
  });
}

const updateResponse = await networkClient.updateQuote({
  payIn: [{
    bands: [{
      rate: toProtoDecimal(123, -2), // meaning decimal number 1.23
      maxAmount: toProtoDecimal(1000, 0), // Maximum amount in $1000 USD equivalent
      clientQuoteId: randomUUID(),
    }],
    currency: 'EUR', // Example currency
    expiration: timestampFromDate(new Date(Date.now() + 60 * 1000)), // Example expiration time (1 minute from now)
    quoteType: QuoteType.REALTIME, // Example quote type
    timestamp: timestampNow(), // Current timestamp
  }]
})
```

## Examples

Comprehensive examples are available in:
- [Provider Service Example](https://github.com/t-0-network/provider-sdk-ts/blob/master/src/examples/server.ts)
- [Network Client Example](https://github.com/t-0-network/provider-sdk-ts/blob/master/src/examples/update-quote.ts)
