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
## Key Management

The T-ZERO Network uses secp256k1 key pairs for request authentication and verification:

### Key Types and Usage

- **Provider Private Key**: Signs outgoing requests to the T-ZERO Network
- **Provider Public Key**: Shared with T-ZERO Network for request verification
- **T-ZERO Network Public Key**: Verifies incoming requests from T-ZERO Network
- **T-ZERO Network Private Key**: Used by T-ZERO Network to sign requests to your service

## Prerequisites

- OpenSSL (for key generation)

### Key Generation

Generate secp256k1 key pairs using the provided `Makefile`:

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


## Publicly available SDKs:
* [Go](https://github.com/t-0-network/provider-sdk-go) - Golang 
* [NodeJS](https://github.com/t-0-network/provider-sdk-ts) - Typescript, Javascript etc.

SDKs for other tech stacks (Java, Python etc.) are available by request
