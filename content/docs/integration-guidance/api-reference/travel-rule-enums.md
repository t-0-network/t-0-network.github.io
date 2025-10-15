---
weight: 336
title: "Travel Rule Data Constants"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---


 <!-- end services -->


##  Requests And Response Types

 <!-- end messages -->


<a name="ivms101-AddressTypeCode"></a>

### AddressTypeCode
Definition: Identifies the nature of the address.

| Name | Number | Description |
| ---- | ------ | ----------- |
| ADDRESS_TYPE_CODE_MISC | 0 | Unspecified An address the category of which the sender is unable to determine. Use GEOG instead of this code in general use. Not an official part of the IVMS 101 Standard |
| ADDRESS_TYPE_CODE_HOME | 1 | Residential Address is the home address. |
| ADDRESS_TYPE_CODE_BIZZ | 2 | Business Address is the business address. |
| ADDRESS_TYPE_CODE_GEOG | 3 | Geographic Address is the unspecified physical (geographical) address suitable for identification of the natural or legal person. |



<a name="ivms101-LegalPersonNameTypeCode"></a>

### LegalPersonNameTypeCode
Definition: A single value corresponding to the nature of name being specified
for the legal person.

| Name | Number | Description |
| ---- | ------ | ----------- |
| LEGAL_PERSON_NAME_TYPE_CODE_MISC | 0 | Unspecified A name by which a legal person may be known but which cannot otherwise be categorized or the category of which the sender is unable to determine. Not an official part of the IVMS 101 Standard |
| LEGAL_PERSON_NAME_TYPE_CODE_LEGL | 1 | Legal name Official name under which an organisation is registered. |
| LEGAL_PERSON_NAME_TYPE_CODE_SHRT | 2 | Short name Specifies the short name of the organisation. |
| LEGAL_PERSON_NAME_TYPE_CODE_TRAD | 3 | Trading name Name used by a business for commercial purposes, although its registered legal name, used for contracts and other formal situations, may be another. |



<a name="ivms101-NationalIdentifierTypeCode"></a>

### NationalIdentifierTypeCode
Definition: Identifies the national identification type.
NationalIdentifierTypeCode applies a restriction over the codes present in ISO20022
datatype ‘TypeOfIdentification4Code’.

| Name | Number | Description |
| ---- | ------ | ----------- |
| NATIONAL_IDENTIFIER_TYPE_CODE_MISC | 0 | Unspecified A national identifier which may be known but which cannot otherwise be categorized or the category of which the sender is unable to determine. |
| NATIONAL_IDENTIFIER_TYPE_CODE_ARNU | 1 | Alien registration number Number assigned by a government agency to identify foreign nationals. |
| NATIONAL_IDENTIFIER_TYPE_CODE_CCPT | 2 | Passport number Number assigned by a passport authority. |
| NATIONAL_IDENTIFIER_TYPE_CODE_RAID | 3 | Registration authority identifier Identifier of a legal entity as maintained by a registration authority. |
| NATIONAL_IDENTIFIER_TYPE_CODE_DRLC | 4 | Driver license number Number assigned to a driver's license. |
| NATIONAL_IDENTIFIER_TYPE_CODE_FIIN | 5 | Foreign investment identity number Number assigned to a foreign investor (other than the alien number). |
| NATIONAL_IDENTIFIER_TYPE_CODE_TXID | 6 | Tax identification number Number assigned by a tax authority to an entity. |
| NATIONAL_IDENTIFIER_TYPE_CODE_SOCS | 7 | Social security number Number assigned by a social security agency. |
| NATIONAL_IDENTIFIER_TYPE_CODE_IDCD | 8 | Identity card number Number assigned by a national authority to an identity card. |
| NATIONAL_IDENTIFIER_TYPE_CODE_LEIX | 9 | Legal Entity Identifier Legal Entity Identifier (LEI) assigned in accordance with ISO 17442. The LEI is a 20-character, alpha-numeric code that enables clear and unique identification of legal entities participating in financial transactions. |



<a name="ivms101-NaturalPersonNameTypeCode"></a>

### NaturalPersonNameTypeCode
Definition: A single value corresponding to the nature of name being adopted.

| Name | Number | Description |
| ---- | ------ | ----------- |
| NATURAL_PERSON_NAME_TYPE_CODE_MISC | 0 | Unspecified A name by which a natural person may be known but which cannot otherwise be categorized or the category of which the sender is unable to determine. |
| NATURAL_PERSON_NAME_TYPE_CODE_ALIA | 1 | Alias name A name other than the legal name by which a natural person is also known. |
| NATURAL_PERSON_NAME_TYPE_CODE_BIRT | 2 | Name at birth The name given to a natural person at birth. |
| NATURAL_PERSON_NAME_TYPE_CODE_MAID | 3 | Maiden name The original name of a natural person who has changed their name after marriage. |
| NATURAL_PERSON_NAME_TYPE_CODE_LEGL | 4 | Legal name Identifies a natural person for legal, official or administrative purposes. |



<a name="ivms101-TransliterationMethodCode"></a>

### TransliterationMethodCode
Definition: Identifies the national script from which transliteration to Latin
script is applied.

| Name | Number | Description |
| ---- | ------ | ----------- |
| TRANSLITERATION_METHOD_CODE_OTHR | 0 | Script other than those listed below Unspecified Standard |
| TRANSLITERATION_METHOD_CODE_ARAB | 1 | Arabic (Arabic language) ISO 233-2:1993 |
| TRANSLITERATION_METHOD_CODE_ARAN | 2 | Arabic (Persian language) ISO 233-3:1999 |
| TRANSLITERATION_METHOD_CODE_ARMN | 3 | Armenian ISO 9985:1996 |
| TRANSLITERATION_METHOD_CODE_CYRL | 4 | Cyrillic ISO 9:1995 |
| TRANSLITERATION_METHOD_CODE_DEVA | 5 | Devanagari & related Indic ISO 15919:2001 |
| TRANSLITERATION_METHOD_CODE_GEOR | 6 | Georgian ISO 9984:1996 |
| TRANSLITERATION_METHOD_CODE_GREK | 7 | Greek ISO 843:1997 |
| TRANSLITERATION_METHOD_CODE_HANI | 8 | Han (Hanzi, Kanji, Hanja) ISO 7098:2015 |
| TRANSLITERATION_METHOD_CODE_HEBR | 9 | Hebrew ISO 259-2:1994 |
| TRANSLITERATION_METHOD_CODE_KANA | 10 | Kana ISO 3602:1989 |
| TRANSLITERATION_METHOD_CODE_KORE | 11 | Korean Revised Romanization of Korean |
| TRANSLITERATION_METHOD_CODE_THAI | 12 | Thai ISO 11940-2:2007 |


 <!-- end enums -->

