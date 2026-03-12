---
weight: 353
title: "Python SDK"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

## Overview

The Provider SDK is a [Python library](https://pypi.org/project/t0-provider-sdk/) that enables payment processing services to integrate with the t-0 Network. The SDK provides comprehensive functionality for implementing provider services, handling cryptographic authentication, and managing network communications.

## Quick Start with Starter Template

Scaffold a complete provider project with a single command:

```bash
uvx t0-provider-starter my_provider
```

This creates a ready-to-run project with a secp256k1 keypair, environment config, provider service stubs (async ASGI), and a Dockerfile.

> **Note:** Requires [uv](https://docs.astral.sh/uv/) package manager.

### Generated Project Structure

```
my_provider/
├── pyproject.toml              # Project metadata, depends on t0-provider-sdk
├── Dockerfile                  # Multi-stage build with python:3.13-slim
├── .env.example                # Template environment file
├── .env                        # Generated with your private key (git-ignored)
└── src/provider/
    ├── __init__.py
    ├── main.py                 # Entry point: server, quote publishing, quote retrieval
    ├── config.py               # Environment variable loading and validation
    ├── publish_quotes.py       # Sample quote publishing loop
    ├── get_quote.py            # Sample quote retrieval
    └── handler/
        ├── __init__.py
        ├── payment.py          # ProviderServiceImplementation (async, 5 RPC methods)
        └── payment_sync.py     # ProviderServiceSyncImplementation (sync/WSGI variant)
```

### Key Files to Modify

| File | Purpose |
|------|---------|
| `src/provider/handler/payment.py` | Implement your payment processing logic. Look for `TODO` comments. |
| `src/provider/publish_quotes.py` | Replace sample quotes with your FX rate source. |

### Getting Started

#### Phase 1: Quoting

1. Install dependencies: `cd my_provider && uv sync`
2. Share the generated public key (printed during project initialization) with the T-0 team.
3. Replace the sample quote publishing logic in `src/provider/publish_quotes.py`.
4. Start the server: `uv run python -m provider.main`
5. Verify that quotes are successfully received by the network.

#### Phase 2: Payments

1. Implement `update_payment` in `src/provider/handler/payment.py`.
2. Deploy your service and share the base URL with the T-0 team.
3. Implement `pay_out` in `src/provider/handler/payment.py`.
4. Coordinate with the T-0 team to test end-to-end payment flows.

Additional optional methods in `src/provider/handler/payment.py`:
- `update_limit` — handle notifications about limit changes
- `append_ledger_entries` — handle notifications about ledger transactions
- `approve_payment_quotes` — approve quotes after AML check

### Deployment

```bash
docker build -t my-provider .
docker run --env-file .env -p 8080:8080 my-provider
```

Full starter template source: [GitHub](https://github.com/t-0-network/provider-sdk/tree/master/python/starter/src/t0_provider_starter/template)

---

## Architecture

The SDK consists of two main components:

- **Provider Service Handler**: Enables you to create services that respond to t-0 Network requests (ASGI or WSGI)
- **Network Client**: Allows direct interaction with t-0 Network services

## Prerequisites

- Python 3.13 or later

## Installation

```bash
pip install t0-provider-sdk
```

## Provider Service Implementation

### Service Interface

Implement the provider service class to handle t-0 Network requests. You can check the detailed description of each rpc in the [API Reference](https://t-0-network.github.io/docs/integration-guidance/api-reference/provider/)

```python
from connectrpc.request import RequestContext
from t0_provider_sdk.api.tzero.v1.payment.network_connect import NetworkServiceClient
from t0_provider_sdk.api.tzero.v1.payment.network_pb2 import FinalizePayoutRequest
from t0_provider_sdk.api.tzero.v1.payment.provider_pb2 import (
    AppendLedgerEntriesRequest, AppendLedgerEntriesResponse,
    ApprovePaymentQuoteRequest, ApprovePaymentQuoteResponse,
    PayoutRequest, PayoutResponse,
    UpdateLimitRequest, UpdateLimitResponse,
    UpdatePaymentRequest, UpdatePaymentResponse,
)

class ProviderServiceImplementation:
    def __init__(self, network_client: NetworkServiceClient) -> None:
        self._network_client = network_client

    async def update_payment(
        self, request: UpdatePaymentRequest, ctx: RequestContext
    ) -> UpdatePaymentResponse:
        return UpdatePaymentResponse()

    async def pay_out(
        self, request: PayoutRequest, ctx: RequestContext
    ) -> PayoutResponse:
        return PayoutResponse()

    async def update_limit(
        self, request: UpdateLimitRequest, ctx: RequestContext
    ) -> UpdateLimitResponse:
        return UpdateLimitResponse()

    async def append_ledger_entries(
        self, request: AppendLedgerEntriesRequest, ctx: RequestContext
    ) -> AppendLedgerEntriesResponse:
        return AppendLedgerEntriesResponse()

    async def approve_payment_quotes(
        self, request: ApprovePaymentQuoteRequest, ctx: RequestContext
    ) -> ApprovePaymentQuoteResponse:
        return ApprovePaymentQuoteResponse()
```

### HTTP Server Configuration

#### ASGI (recommended, using uvicorn)

```python
import uvicorn
from t0_provider_sdk.api.tzero.v1.payment.network_connect import NetworkServiceClient
from t0_provider_sdk.api.tzero.v1.payment.provider_connect import ProviderServiceASGIApplication
from t0_provider_sdk.network.client import new_service_client
from t0_provider_sdk.provider.handler import handler, new_asgi_app

# Create network client
network_client = new_service_client(
    private_key,
    NetworkServiceClient,
    base_url="https://api-sandbox.t-0.network",
)

# Create provider service
service = ProviderServiceImplementation(network_client)

# Create ASGI app with automatic signature verification
app = new_asgi_app(
    network_public_key,  # hex-encoded t-0 Network public key
    handler(ProviderServiceASGIApplication, service),
)

# Start server
server_config = uvicorn.Config(app, host="0.0.0.0", port=8080, log_level="info")
server = uvicorn.Server(server_config)
await server.serve()
```

#### WSGI (alternative, for gunicorn)

```python
from t0_provider_sdk.api.tzero.v1.payment.network_connect import NetworkServiceClientSync
from t0_provider_sdk.api.tzero.v1.payment.provider_connect import ProviderServiceWSGIApplication
from t0_provider_sdk.network.client import new_service_client_sync
from t0_provider_sdk.provider.handler import handler_sync, new_wsgi_app

network_client = new_service_client_sync(private_key, NetworkServiceClientSync, base_url=endpoint)
service = ProviderServiceSyncImplementation(network_client)
wsgi_app = new_wsgi_app(network_public_key, handler_sync(ProviderServiceWSGIApplication, service))

# Run with gunicorn:
# gunicorn provider.main:wsgi_app --bind 0.0.0.0:8080
```

## t-0 Network Client

The network client provides direct interaction capabilities with t-0 Network services, handling authentication and request signing automatically.

### Client Initialization

```python
from t0_provider_sdk.api.tzero.v1.payment.network_connect import NetworkServiceClient
from t0_provider_sdk.network.client import new_service_client

network_client = new_service_client(
    "0x7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8",
    NetworkServiceClient,
    base_url="https://api-sandbox.t-0.network",
)
```

### Network Service Operations

```python
import uuid
from google.protobuf.timestamp_pb2 import Timestamp
from t0_provider_sdk.api.tzero.v1.common.common_pb2 import Decimal
from t0_provider_sdk.api.tzero.v1.common.payment_method_pb2 import PAYMENT_METHOD_TYPE_SEPA
from t0_provider_sdk.api.tzero.v1.payment.network_pb2 import QUOTE_TYPE_REALTIME, UpdateQuoteRequest

def _now_timestamp() -> Timestamp:
    ts = Timestamp()
    ts.GetCurrentTime()
    return ts

def _expiration_timestamp(seconds_from_now: int = 30) -> Timestamp:
    ts = _now_timestamp()
    ts.seconds += seconds_from_now
    return ts

# Example: Update quote operation
await network_client.update_quote(
    UpdateQuoteRequest(
        pay_out=[
            UpdateQuoteRequest.Quote(
                currency="EUR",
                quote_type=QUOTE_TYPE_REALTIME,
                payment_method=PAYMENT_METHOD_TYPE_SEPA,
                expiration=_expiration_timestamp(30),
                timestamp=_now_timestamp(),
                bands=[
                    UpdateQuoteRequest.Quote.Band(
                        client_quote_id=str(uuid.uuid4()),
                        max_amount=Decimal(unscaled=1000, exponent=0),
                        rate=Decimal(unscaled=86, exponent=-2),  # rate 0.86
                    ),
                ],
            ),
        ],
    ),
)
```

