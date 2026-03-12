---
weight: 336
title: "Payment Receipt"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---
 <!-- end services -->


##  Requests And Response Types


<a name="tzero-v1-common-PaymentReceipt"></a>

### PaymentReceipt



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| sepa | [PaymentReceipt.Sepa](#tzero-v1-common-PaymentReceipt-Sepa) |  |  |
| swift | [PaymentReceipt.Swift](#tzero-v1-common-PaymentReceipt-Swift) |  |  |
| pix | [PaymentReceipt.Pix](#tzero-v1-common-PaymentReceipt-Pix) |  |  |
| fps | [PaymentReceipt.Fps](#tzero-v1-common-PaymentReceipt-Fps) |  |  |
| nip | [PaymentReceipt.Nip](#tzero-v1-common-PaymentReceipt-Nip) |  |  |







<a name="tzero-v1-common-PaymentReceipt-Fps"></a>

### PaymentReceipt.Fps



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| transaction_reference_id | [string](../scalar/#string) | optional |  |







<a name="tzero-v1-common-PaymentReceipt-Nip"></a>

### PaymentReceipt.Nip



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| session_id | [string](../scalar/#string) |  |  |







<a name="tzero-v1-common-PaymentReceipt-Pix"></a>

### PaymentReceipt.Pix



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| e2e_id | [string](../scalar/#string) | optional |  |







<a name="tzero-v1-common-PaymentReceipt-Sepa"></a>

### PaymentReceipt.Sepa



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| banking_transaction_reference_id | [string](../scalar/#string) | optional |  |







<a name="tzero-v1-common-PaymentReceipt-Swift"></a>

### PaymentReceipt.Swift



This message has no fields defined.





 <!-- end messages -->

 <!-- end enums -->


