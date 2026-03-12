---
weight: 354
title: "Java SDK"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

## Overview

The Provider SDK is a Java library that enables payment processing services to integrate with the t-0 Network. The SDK provides comprehensive functionality for implementing provider services, handling cryptographic authentication, and managing network communications.

## Quick Start with Starter Template

Scaffold a complete provider project with a single command:

```bash
curl -fsSL -L https://github.com/t-0-network/provider-sdk/releases/latest/download/provider-init.jar -o provider-init.jar && java -jar provider-init.jar && rm provider-init.jar
```

This will prompt for your project name and SDK repository, then create a ready-to-run project with a secp256k1 keypair, environment config, provider service stubs, and a Dockerfile.

### CLI Options

```bash
java -jar provider-init.jar [OPTIONS] [PROJECT_NAME]
```

| Option | Description |
|--------|-------------|
| `-d, --directory` | Target directory (defaults to current directory) |
| `-r, --repository` | SDK repository: `jitpack` (default) or `maven-central` |
| `-h, --help` | Show help message |

### Generated Project Structure

```
your-project/
├── src/main/java/network/t0/provider/
│   ├── Main.java                    # Entry point
│   ├── Config.java                  # Configuration
│   ├── handler/
│   │   └── PaymentHandler.java      # ProviderService implementation (modify this)
│   └── internal/
│       ├── PublishQuotes.java       # Quote publishing logic (modify this)
│       ├── GetQuote.java            # Quote fetching utility
│       └── SubmitPayment.java       # Payment submission utility
├── build.gradle.kts                 # Build configuration
├── .env                             # Your configuration (git-ignored)
└── Dockerfile                       # Docker deployment
```

### Key Files to Modify

| File | Purpose |
|------|---------|
| `PaymentHandler.java` | Implement your payment processing logic. Look for `TODO` comments. |
| `PublishQuotes.java` | Replace sample quotes with your FX rate source. |

### Getting Started

#### Phase 1: Quoting

1. Initialize your project using the quick start above.
2. Share your public key with the T-0 team (displayed on first run).
3. Replace sample quote publishing logic in `PublishQuotes.java`.
4. Start the application: `./gradlew run`
5. Verify quotes are received by checking application logs.

#### Phase 2: Payments

1. Implement `updatePayment` handler in `PaymentHandler.java`.
2. Deploy your service and share the base URL with the T-0 team.
3. Implement `payOut` handler in `PaymentHandler.java`.
4. Test payment submission using the included `SubmitPayment` utility.
5. Coordinate with the T-0 team to test end-to-end payment flows.

### Deployment

```bash
docker build -t my-provider .
docker run -p 8080:8080 --env-file .env my-provider
```

Full starter template source: [GitHub](https://github.com/t-0-network/provider-sdk/tree/master/java/starter/template)

---

## Architecture

The SDK consists of two main components:

- **Provider Service Handler**: Enables you to create services that respond to t-0 Network requests (gRPC)
- **Network Client**: Allows direct interaction with t-0 Network services

## Prerequisites

- Java 17 or later
- Gradle or Maven

## Installation

### Gradle (JitPack - recommended)

```gradle
repositories {
    maven { url 'https://jitpack.io' }
}

dependencies {
    implementation 'com.github.t-0-network:provider-sdk:<version>'
}
```

### Gradle (Maven Central)

```gradle
dependencies {
    implementation 'network.t-0:provider-sdk-java:<version>'
}
```

### Maven

```xml
<dependency>
    <groupId>network.t-0</groupId>
    <artifactId>provider-sdk-java</artifactId>
    <version><!-- version --></version>
</dependency>
```

## Provider Service Implementation

### Service Interface

Extend `ProviderServiceGrpc.ProviderServiceImplBase` to create your provider service. You can check the detailed description of each rpc in the [API Reference](https://t-0-network.github.io/docs/integration-guidance/api-reference/provider/)

```java
import io.grpc.stub.StreamObserver;
import network.t0.sdk.proto.tzero.v1.payment.*;

public class PaymentHandler extends ProviderServiceGrpc.ProviderServiceImplBase {

    private final NetworkServiceGrpc.NetworkServiceBlockingStub networkClient;

    public PaymentHandler(NetworkServiceGrpc.NetworkServiceBlockingStub networkClient) {
        this.networkClient = networkClient;
    }

    @Override
    public void updatePayment(UpdatePaymentRequest request,
            StreamObserver<UpdatePaymentResponse> responseObserver) {
        responseObserver.onNext(UpdatePaymentResponse.newBuilder().build());
        responseObserver.onCompleted();
    }

    @Override
    public void payOut(PayoutRequest request,
            StreamObserver<PayoutResponse> responseObserver) {
        responseObserver.onNext(PayoutResponse.newBuilder()
                .setAccepted(PayoutResponse.Accepted.newBuilder().build())
                .build());
        responseObserver.onCompleted();
    }

    @Override
    public void updateLimit(UpdateLimitRequest request,
            StreamObserver<UpdateLimitResponse> responseObserver) {
        responseObserver.onNext(UpdateLimitResponse.newBuilder().build());
        responseObserver.onCompleted();
    }

    @Override
    public void appendLedgerEntries(AppendLedgerEntriesRequest request,
            StreamObserver<AppendLedgerEntriesResponse> responseObserver) {
        responseObserver.onNext(AppendLedgerEntriesResponse.newBuilder().build());
        responseObserver.onCompleted();
    }

    @Override
    public void approvePaymentQuotes(ApprovePaymentQuoteRequest request,
            StreamObserver<ApprovePaymentQuoteResponse> responseObserver) {
        responseObserver.onNext(ApprovePaymentQuoteResponse.newBuilder()
                .setAccepted(ApprovePaymentQuoteResponse.Accepted.newBuilder().build())
                .build());
        responseObserver.onCompleted();
    }
}
```

### Server Configuration

```java
import network.t0.sdk.crypto.Signer;
import network.t0.sdk.network.BlockingNetworkClient;
import network.t0.sdk.proto.tzero.v1.payment.NetworkServiceGrpc;
import network.t0.sdk.provider.ProviderServer;

Signer signer = Signer.fromHex(privateKeyHex);

var networkClient = BlockingNetworkClient.create(
        "https://api-sandbox.t-0.network",
        signer,
        NetworkServiceGrpc::newBlockingStub);

PaymentHandler handler = new PaymentHandler(networkClient.stub());

ProviderServer server = ProviderServer.create(8080, networkPublicKeyHex)
        .withService(handler)
        .start();

// Block until termination
server.awaitTermination();
```

## t-0 Network Client

The network client provides direct interaction capabilities with t-0 Network services, handling authentication and request signing automatically.

### Client Initialization

```java
import network.t0.sdk.crypto.Signer;
import network.t0.sdk.network.BlockingNetworkClient;
import network.t0.sdk.proto.tzero.v1.payment.NetworkServiceGrpc;

Signer signer = Signer.fromHex("0x7795db2f4499c04d80062c1f1614ff1e427c148e47ed23e387d62829f437b5d8");

try (var networkClient = BlockingNetworkClient.create(
        "https://api-sandbox.t-0.network",
        signer,
        NetworkServiceGrpc::newBlockingStub)) {

    // Use networkClient.stub() to make calls
}
```

### Network Service Operations

```java
import java.time.Instant;
import java.util.UUID;
import com.google.protobuf.Timestamp;
import network.t0.sdk.proto.tzero.v1.common.Decimal;
import network.t0.sdk.proto.tzero.v1.common.PaymentMethodType;
import network.t0.sdk.proto.tzero.v1.payment.QuoteType;
import network.t0.sdk.proto.tzero.v1.payment.UpdateQuoteRequest;

// Example: Update quote operation
Instant now = Instant.now();
Timestamp expiration = Timestamp.newBuilder()
        .setSeconds(now.plusSeconds(30).getEpochSecond())
        .setNanos(now.plusSeconds(30).getNano())
        .build();
Timestamp timestamp = Timestamp.newBuilder()
        .setSeconds(now.getEpochSecond())
        .setNanos(now.getNano())
        .build();

networkClient.stub().updateQuote(UpdateQuoteRequest.newBuilder()
        .addPayOut(UpdateQuoteRequest.Quote.newBuilder()
                .setCurrency("EUR")
                .setQuoteType(QuoteType.QUOTE_TYPE_REALTIME)
                .setPaymentMethod(PaymentMethodType.PAYMENT_METHOD_TYPE_SEPA)
                .setExpiration(expiration)
                .setTimestamp(timestamp)
                .addBands(UpdateQuoteRequest.Quote.Band.newBuilder()
                        .setClientQuoteId(UUID.randomUUID().toString())
                        .setMaxAmount(Decimal.newBuilder()
                                .setUnscaled(1000)
                                .setExponent(0)
                                .build())
                        .setRate(Decimal.newBuilder()
                                .setUnscaled(86) // rate 0.86
                                .setExponent(-2)
                                .build())
                        .build())
                .build())
        .build());
```

