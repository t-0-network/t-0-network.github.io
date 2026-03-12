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
The Provider SDK is a [Node.js library](https://www.npmjs.com/package/@t-0/provider-sdk) that enables payment processing services to integrate with the t-0 Network. The SDK provides comprehensive functionality for implementing provider services, handling cryptographic authentication, and managing network communications.

## Quick Start with Starter Template

Scaffold a complete provider project with a single command:

```bash
npx @t-0/provider-starter-ts
```

The CLI will prompt for a project name, then create a ready-to-run project with a secp256k1 keypair (via OpenSSL), environment config, provider service stubs, and a Dockerfile.

### Generated Project Structure

```
your-project-name/
├── src/
│   ├── index.ts              # Entry point
│   ├── service.ts            # Provider service implementation
│   ├── publish_quotes.ts     # Quote publishing logic
│   ├── get_quote.ts          # Quote retrieval logic
│   ├── submit_payment.ts     # Payment submission logic
│   └── lib.ts                # Utility functions
├── Dockerfile                # Docker configuration
├── .env                      # Environment variables (with generated keys)
├── .env.example              # Example environment file
├── .eslintrc.json            # ESLint configuration
├── .gitignore                # Git ignore rules
├── package.json              # Project dependencies
└── tsconfig.json             # TypeScript configuration
```

### Key Files to Modify

| File | Purpose |
|------|---------|
| `src/service.ts` | Implement your payment processing logic. Look for `TODO` comments. |
| `src/publish_quotes.ts` | Replace sample quotes with your FX rate source. |

### Getting Started

#### Phase 1: Quoting

1. Open `.env` and find your generated public key (marked as "Step 1.2"). Share it with the T-0 team to register your provider.
2. Implement your quote publishing logic in `src/publish_quotes.ts`.
3. Start the dev server (`npm run dev`) and verify quotes are published.
4. Confirm quote retrieval works by checking the output of `getQuote` in `src/index.ts`.

#### Phase 2: Payments

1. Implement `updatePayment` handler in `src/service.ts`.
2. Deploy your service and share the base URL with the T-0 team.
3. Implement `payOut` handler in `src/service.ts`.
4. Test payment submission by uncommenting the `submitPayment` call in `src/index.ts`.
5. Coordinate with the T-0 team to test end-to-end payment flows.

### Deployment

```bash
docker build -t my-provider .
docker run -p 3000:3000 --env-file .env my-provider
```

Full starter template source: [GitHub](https://github.com/t-0-network/provider-sdk/tree/master/node/starter/template)

---

## Architecture

The SDK consists of two main components:

- **Provider Service Handler**: Enables you to create services that respond to t-0 Network requests
- **Network Client**: Allows direct interaction with t-0 Network services

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
    AppendLedgerEntriesRequest,
    AppendLedgerEntriesResponse,
    ApprovePaymentQuoteRequest,
    ApprovePaymentQuoteResponse,
    type Client,
    HandlerContext,
    NetworkService,
    PayoutRequest,
    PayoutResponse,
    UpdateLimitRequest,
    UpdateLimitResponse,
    UpdatePaymentRequest,
    UpdatePaymentResponse,
} from "@t-0/provider-sdk";

const CreateProviderService = (networkClient: Client<typeof NetworkService>) => {
    return {
        async updatePayment(req: UpdatePaymentRequest, _: HandlerContext) {
            return {} as UpdatePaymentResponse
        },

        async payOut(req: PayoutRequest, _: HandlerContext) {
            return {} as PayoutResponse
        },

        async updateLimit(req: UpdateLimitRequest, _: HandlerContext) {
            return {} as UpdateLimitResponse
        },

        async appendLedgerEntries(req: AppendLedgerEntriesRequest, _: HandlerContext) {
            return {} as AppendLedgerEntriesResponse
        },

        async approvePaymentQuote(req: ApprovePaymentQuoteRequest, _: HandlerContext) {
            return {} as ApprovePaymentQuoteResponse
        }
    }
};
```

### HTTP Server Configuration

Register and serve the handler using the HTTP server.

```typescript
import {
  createClient,
  createService,
  NetworkService,
  nodeAdapter,
  ProviderService,
  signatureValidation,
} from "@t-0/provider-sdk";
import http from "http";

const networkClient = createClient(privateKeyHex, endpoint, NetworkService);

const server = http.createServer(
    signatureValidation(
        nodeAdapter(
            createService(networkPublicKeyHex, (r) => {
                r.service(ProviderService, CreateProviderService(networkClient));
            })))
).listen(8080);
console.log("server is listening at", server.address());
```

## t-0 Network Client

The network client provides direct interaction capabilities with t-0 Network services, handling authentication and request signing automatically.

### Client Initialization

```typescript
import { createClient, NetworkService } from "@t-0/provider-sdk";

const privateKeyHex = "0x7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8";
const endpoint = "https://api-sandbox.t-0.network";
const networkClient = createClient(privateKeyHex, endpoint, NetworkService);
```

### Network Service Operations

Example of a quote publishing operation

```typescript
import { PaymentMethodType, QuoteType } from "@t-0/provider-sdk";
import { timestampFromDate } from "@bufbuild/protobuf/wkt";
import { randomUUID } from "node:crypto";

await networkClient.updateQuote({
    payIn: [{
        bands: [{
            rate: { unscaled: 863n, exponent: -3 }, // rate 0.863
            maxAmount: { unscaled: 25000n, exponent: 0 }, // maximum amount in USD
            clientQuoteId: randomUUID(),
        }],
        currency: 'EUR',
        expiration: timestampFromDate(new Date(Date.now() + 30 * 1000)),
        quoteType: QuoteType.REALTIME,
        paymentMethod: PaymentMethodType.SEPA,
        timestamp: timestampFromDate(new Date()),
    }],
    payOut: [{
        bands: [{
            rate: { unscaled: 873n, exponent: -3 }, // rate 0.873
            maxAmount: { unscaled: 25000n, exponent: 0 },
            clientQuoteId: randomUUID(),
        }],
        currency: 'EUR',
        expiration: timestampFromDate(new Date(Date.now() + 30 * 1000)),
        quoteType: QuoteType.REALTIME,
        paymentMethod: PaymentMethodType.SEPA,
        timestamp: timestampFromDate(new Date()),
    }]
})
```

