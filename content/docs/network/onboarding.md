---
weight: 210
title: "Onboarding"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---

Payment providers join the T-0 Network through a comprehensive onboarding process designed to ensure both technical compatibility and regulatory compliance. The onboarding journey begins with Know Your Business (KYB) verification, currently handled through a manual review process in the initial network iteration. This process validates the provider's regulatory standing, operational capabilities, and financial stability.

Following successful KYB approval, providers must complete several technical integration steps. Each provider generates an ECDSA private key for cryptographic operations within the network, then registers their corresponding public key, webhook URL, and Ethereum-compatible blockchain address with the network. This registration establishes the provider's digital identity and enables secure communication and settlement operations.

Credit relationships form the foundation of network liquidity, and providers must establish bilateral credit limits with counterparties before beginning payment operations. These credit limits define the maximum amount each provider is willing to extend to counterparties before requiring settlement, creating a distributed liquidity pool that enables efficient payment routing.

The onboarding process concludes with technical integration testing, where providers validate their API implementations and settlement procedures before going live on the network. This comprehensive approach ensures that all network participants meet both technical and operational standards required for reliable cross-border payment processing.
