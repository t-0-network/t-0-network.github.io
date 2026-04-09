---
weight: 302
title: "Idempotency"
description: ""
icon: "article"
date: "2026-04-09T00:00:00+02:00"
lastmod: "2026-04-09T00:00:00+02:00"
draft: false
toc: true
---

Connections drop. Requests time out. The network retries with exponential backoff, so your endpoint may receive the same request more than once.

If your system treats a duplicate as an error, the network believes the operation failed. In payments, this causes stuck transactions or double payouts.

The T-0 Network solves this through idempotency: **every request that changes state can be safely retried without causing duplicate side effects.**

## How Retry Safety Works

The network delivers every request at least once. If a response is lost due to a connection failure, the network resends the same request with the same identifiers.

Your system applies the business effect once and returns the same result on every subsequent attempt. The combination of at-least-once delivery and idempotent receivers produces exactly-once processing without complex coordination protocols.

Both the network and every provider must uphold their side of this contract for the guarantee to hold.

## Three Rules for Providers

### 1. Return the Original Response for Completed Requests

When you receive a request with an identifier you have already processed, return the stored response. The caller needs to know what happened, not that the request arrived twice.

**Wrong:** The network sends a payout request with `payment_id=123`. You process it and determine that a manual AML review is needed, so you return `ManualAmlCheck`. The network never receives your response because the connection drops. The network retries the same payout request with `payment_id=123`. You return `{"failed": {"details": "Payment has already been processed"}}`. The network treats this as a real failure and aborts the payment. The payment is now stuck: you are performing an AML review, but the network recorded a failure.

**Right:** Same scenario. On the retry, you look up `payment_id=123`, find it in the AML review state, and return `ManualAmlCheck` again. The network knows the payment is pending review. The flow continues.

### 2. Wait for Completion on In-Flight Requests

If your system has not yet returned a response for the original request when a duplicate arrives, wait for it to complete and return the same response for both requests. Do not reject the duplicate and do not return an error. 

**Wrong:** The network sends a payout request with `payment_id=456`. You begin processing it. The network retries before you finish. You return `{"failed":{"details": "Request is already being processed"}}`. The network treats this as a failure and aborts the payment.

**Right:** Same scenario. On the retry, you look up `payment_id=456` and see that it has not yet produced a response. You wait for it to complete, then return the same result for both requests.

### 3. Never Treat a Duplicate as an Error

A duplicate request is a normal event caused by network retries or message redelivery. Returning an error for a duplicate breaks the retry contract and causes cascading failures in payment flows.

Your system should distinguish between an invalid request and a repeated valid one. The request identifier (such as `payment_id`) tells you which case you are handling.

## Request Categories

Every network method declares one of two idempotency levels:

**IDEMPOTENT** — The request changes state (creates a payment, initiates a payout). Your system must deduplicate based on the business identifier in the request body. Retrying produces the same outcome as the original call.

**NO_SIDE_EFFECTS** — The request is read-only (fetching a quote, checking payment status). No deduplication is needed. These methods are safe for aggressive retry policies and caching strategies.

## What This Means for Your Integration

- **Build retry-safe endpoints.** Store the result of every state-changing operation and return it when the same identifier appears again.
- **Use business identifiers for deduplication.** Each request carries a field (like `payment_id`) that uniquely identifies the operation. Use it as your deduplication key.
- **Keep responses available for the lifetime of the resource.** Payment data has regulatory retention requirements. The stored response should remain retrievable for as long as the underlying resource exists.
