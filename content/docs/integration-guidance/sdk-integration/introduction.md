---
weight: 351
title: "Introduction"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
## Quick Start

The fastest way to get started is to use a starter template. Run a single command to scaffold a complete provider project with auto-generated keys, service stubs, network client, and a Dockerfile:

**Go** (requires Go 1.22+):
```bash
go run github.com/t-0-network/provider-sdk/go/starter@latest my-provider
```

**TypeScript** (requires Node.js v20+):
```bash
npx @t-0/provider-starter-ts
```

**Python** (requires Python 3.13+ and [uv](https://docs.astral.sh/uv/)):
```bash
uvx t0-provider-starter my_provider
```

**Java** (requires Java 17+):
```bash
curl -fsSL -L https://github.com/t-0-network/provider-sdk/releases/latest/download/provider-init.jar -o provider-init.jar && java -jar provider-init.jar && rm provider-init.jar
```

### After Scaffolding

1. **Share your public key** (printed during setup) with the T-0 team to register your provider.
2. **Phase 1 — Quoting:** Implement your quote publishing logic and verify quotes are received by the network.
3. **Phase 2 — Payments:** Implement payment handlers, deploy your service, and coordinate with the T-0 team for end-to-end testing.

Each generated project contains numbered `TODO` comments that guide you through these steps. See the language-specific SDK pages for detailed starter template documentation.

## SDK Packages

For direct SDK usage without the starter template:

| Platform | Package | Install |
|----------|---------|---------|
| [Go](https://github.com/t-0-network/provider-sdk/tree/master/go) | `github.com/t-0-network/provider-sdk/go` | `go get github.com/t-0-network/provider-sdk/go` |
| [NodeJS](https://github.com/t-0-network/provider-sdk/tree/master/node/sdk) | `@t-0/provider-sdk` | `npm install @t-0/provider-sdk` |
| [Python](https://github.com/t-0-network/provider-sdk/tree/master/python/sdk) | `t0-provider-sdk` | `pip install t0-provider-sdk` |
| [Java](https://github.com/t-0-network/provider-sdk/tree/master/java/sdk) | `network.t-0:provider-sdk-java` | See [Java SDK]({{< relref "java-sdk" >}}) |

---

## Key Management

The t-0 Network uses secp256k1 key pairs for request authentication and verification.

> **Note:** If you used a starter template above, keys are auto-generated for you. The section below is for manual key generation.

### Key Types and Usage

- **Provider Private Key**: Signs outgoing requests to the t-0 Network
- **Provider Public Key**: Shared with t-0 Network for request verification
- **t-0 Network Public Key**: Verifies incoming requests from t-0 Network
- **t-0 Network Private Key**: Used by t-0 Network to sign requests to your service

### Key Generation

Generate secp256k1 key pairs using OpenSSL:

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
4. Share only public keys with t-0 Network for registration
