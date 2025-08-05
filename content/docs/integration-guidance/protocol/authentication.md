---
weight: 371
title: "Request Authentication"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
All network communications require cryptographic authentication using ECDSA signatures with Keccak-256 hashing. This approach provides strong authentication and message integrity verification while maintaining compatibility with Ethereum-based cryptographic standards.

## Request Signing Process
Every request to the network must include three critical HTTP headers for authentication. The `X-Signature` header contains the hex-encoded ECDSA signature of the request body, suffixed with the current Unix timestamp in milliseconds. The timestamp suffix prevents replay attacks by ensuring each signature is unique and time-bounded.

The signing process begins by obtaining the current **Unix timestamp in milliseconds** as a **_64-bit unsigned integer_**, encoded in **little-endian** format. This timestamp is then appended to the request body, and the combined data is hashed using **Keccak-256**. The resulting hash is signed using the provider's **ECDSA** private key to produce the final signature.

The `X-Public-Key` header contains the hex-encoded public key corresponding to the private key used for signing. The network accepts both compressed (33 bytes) and uncompressed (65 bytes) public key formats, though compressed format is preferred for efficiency.

The `X-Signature-Timestamp` header contains the **Unix timestamp in milliseconds** used as the suffix during signature generation. The network validates that this timestamp is within one minute of the current time, rejecting requests with timestamps outside this window to prevent replay attacks.

## Signature Verification
Providers must implement the corresponding signature verification logic for incoming network requests. The network signs all requests using its private key, with the public key available to all network participants for verification purposes.

The verification process reverses the signing operation, extracting the timestamp from the `X-Signature-Timestamp` header, appending it to the request body, hashing the combined data with Keccak-256, and verifying the signature against the network's known public key.

Proper signature verification is crucial for network security, as it ensures that incoming requests genuinely originate from the network and have not been tampered with during transmission. Providers should reject any requests that fail signature verification to prevent unauthorized access and maintain network integrity.