---
weight: 335
title: "Travel Rule Data"
description: ""
icon: "article"
date: "2025-06-16T12:09:09+02:00"
lastmod: "2025-06-16T12:09:09+02:00"
draft: false
toc: true
---


 <!-- end services -->


 <!-- end services -->


##  Requests And Response Types


<a name="ivms101-Address"></a>

### Address
Constraint: ValidAddress
There must be at least one occurrence of the element addressLine or (streetName and
buildingName and/or buildingNumber).


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| address_type | [AddressTypeCode](#ivms101-AddressTypeCode) |  | Definition: Identifies the nature of the address. |
| department | [string](#string) |  | Definition: Identification of a division of a large organisation or building. |
| sub_department | [string](#string) |  | Definition: Identification of a sub-division of a large organisation or building. |
| street_name | [string](#string) |  | Definition: Name of a street or thoroughfare. |
| building_number | [string](#string) |  | Definition: Number that identifies the position of a building on a street. |
| building_name | [string](#string) |  | Definition: Name of the building or house. |
| floor | [string](#string) |  | Definition: Floor or storey within a building. |
| post_box | [string](#string) |  | Definition: Numbered box in a post office, assigned to a person or organisation, where letters are kept until called for. |
| room | [string](#string) |  | Definition: Building room number. |
| post_code | [string](#string) |  | Definition: Identifier consisting of a group of letters and/or numbers that is added to a postal address to assist the sorting of mail. |
| town_name | [string](#string) |  | Definition: Name of a built-up area, with defined boundaries and a local government. |
| town_location_name | [string](#string) |  | Definition: Specific location name within the town. |
| district_name | [string](#string) |  | Definition: Identifies a subdivision within a country subdivision. |
| country_sub_division | [string](#string) |  | Definition: Identifies a subdivision of a country for example, state, region, province, départment or county. |
| address_line | [string](#string) | repeated | Definition: Information that locates and identifies a specific address, as defined by postal services, presented in free format text. |
| country | [string](#string) |  | Constraint: The value used for the field country must be present on the ISO-3166-1 alpha-2 codes or the value XX. |







<a name="ivms101-DateAndPlaceOfBirth"></a>

### DateAndPlaceOfBirth
Constraint: DateInPast
If dateOfBirth is specified, the date specified must be a historic date (i.e. a date
prior to the current date)


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| date_of_birth | [string](#string) |  | Definition: Date on which a person is born. Definition: A point in time, represented as a day within the calendar year. Compliant with ISO 8601. Format: YYYY-MM-DD |
| place_of_birth | [string](#string) |  | Definition: The town and/or the city and/or the suburb and/or the country subdivision and/or the country where the person was born. |







<a name="ivms101-LegalPerson"></a>

### LegalPerson
Definition: refers to any entity other than a natural person that can establish a
permanent customer relationship with an affected entity or otherwise own property.
This can include companies, bodies corporate, foundations, anstalt, partnerships, or
associations and other relevantly similar entities.
Constraint: OriginatorInformationLegalPerson
If the originator is a LegalPerson either geographicAddress (with an addressType
value of ‘GEOG’) and/or nationalIdentification and/or customerNumber is required.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [LegalPersonName](#ivms101-LegalPersonName) |  | Definition: The name of the legal person. Constraint: LegalNamePresentLegalPerson At least one occurrence of legalPersonNameIdentifier must have the value ‘LEGL’ specified in the element legalPersonNameIdentifierType. |
| geographic_addresses | [Address](#ivms101-Address) | repeated | Definition: The address of the legal person. |
| customer_number | [string](#string) |  | Definition: The unique identification number applied by the VASP to customer. NOTE The specification has a descrepency in that 5.2.9.3.3 specifies an element name as "customerNumber", while the table in 5.2.9.1 calls that element "customerIdentification" |
| national_identification | [NationalIdentification](#ivms101-NationalIdentification) |  | Definition: A distinct identifier used by governments of countries to uniquely identify a natural or legal person. |
| country_of_registration | [string](#string) |  | Definition: The country in which the legal person is registered. Constraint: The value used for the field country must be present on the ISO-3166-1 alpha-2 codes or the value XX. |







<a name="ivms101-LegalPersonName"></a>

### LegalPersonName



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name_identifiers | [LegalPersonNameId](#ivms101-LegalPersonNameId) | repeated | Definition: The name and type of name by which the legal person is known. Constraint: LegalNamePresent At least one occurrence of legalPersonNameIdentifier must have the value ‘LEGL’ specified in the element legalPersonNameIdentifierType. |
| local_name_identifiers | [LocalLegalPersonNameId](#ivms101-LocalLegalPersonNameId) | repeated | Definition: The name and type of name by which the legal person is known using local characters. |
| phonetic_name_identifiers | [LocalLegalPersonNameId](#ivms101-LocalLegalPersonNameId) | repeated | Definition: The name and type of name by which the legal person is known using local characters. |







<a name="ivms101-LegalPersonNameId"></a>

### LegalPersonNameId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| legal_person_name | [string](#string) |  | Definition: Name by which the legal person is known. |
| legal_person_name_identifier_type | [LegalPersonNameTypeCode](#ivms101-LegalPersonNameTypeCode) |  | Definition: The nature of the name specified. |







<a name="ivms101-LocalLegalPersonNameId"></a>

### LocalLegalPersonNameId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| legal_person_name | [string](#string) |  | Definition: Name by which the legal person is known. |
| legal_person_name_identifier_type | [LegalPersonNameTypeCode](#ivms101-LegalPersonNameTypeCode) |  | Definition: The nature of the name specified. |







<a name="ivms101-LocalNaturalPersonNameId"></a>

### LocalNaturalPersonNameId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| primary_identifier | [string](#string) |  | Definition: This may be the family name, the maiden name or the married name, the main name, the surname, and in some cases, the entire name where the natural person’s name cannot be divided into two parts, or where the sender is unable to divide the natural person’s name into two parts. |
| secondary_identifier | [string](#string) |  | Definition: These may be the forenames, familiar names, given names, initials, prefixes, suffixes or Roman numerals (where considered to be legally part of the name) or any other secondary names. |
| name_identifier_type | [NaturalPersonNameTypeCode](#ivms101-NaturalPersonNameTypeCode) |  | Definition: The nature of the name specified. |







<a name="ivms101-NationalIdentification"></a>

### NationalIdentification
Constraint: ValidNationalIdentifierLegalPerson
A legal person must have a value for nationalIdentifierType of either ‘RAID’ or
‘MISC’ or ‘LEIX’ or ‘TXID’.
Constraint: CompleteNationalIdentifierLegalPerson
A LegalPerson must not have a value for countryOfIssue and must have a value for the
element RegistrationAuthority if the value for nationalIdentifierType is not ‘LEIX’
Constraint: ValidLEI
A LegalPerson with a nationalIdentifierType of ‘LEIX’ must have a value for the
element nationalIdentifier that adheres to the convention as stated in datatype
‘LEIText’.


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| national_identifier | [string](#string) |  | Definition: An identifier issued by an appropriate issuing authority. Constraint: ValidLEI |
| national_identifier_type | [NationalIdentifierTypeCode](#ivms101-NationalIdentifierTypeCode) |  | Definition: Specifies the type of identifier specified. |
| country_of_issue | [string](#string) |  | Definition: Country of the issuing authority. |
| registration_authority | [string](#string) |  | Definition: A code specifying the registration authority. Constraint: The value used for the applicable element must be present on the GLEIF Registration Authorities List. |







<a name="ivms101-NaturalPerson"></a>

### NaturalPerson
Definition: refers to a uniquely distinguishable individual; one single person


| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name | [NaturalPersonName](#ivms101-NaturalPersonName) |  | Definition: the distinct words used as identification for an individual. |
| geographic_addresses | [Address](#ivms101-Address) | repeated | Definition: the particulars of a location at which a person may be communicated with. |
| national_identification | [NationalIdentification](#ivms101-NationalIdentification) |  | Definition: a distinct identifier used by governments of countries to uniquely identify a natural or legal person. |
| customer_identification | [string](#string) |  | Definition: a distinct identifier that uniquely identifies the person to the institution in context. |
| date_and_place_of_birth | [DateAndPlaceOfBirth](#ivms101-DateAndPlaceOfBirth) |  | Definition: date and place of birth of a person. |
| country_of_residence | [string](#string) |  | Definition: country in which a person resides (the place of a person's home). The value used for the field country must be present on the ISO-3166-1 alpha-2 codes or the value XX. |







<a name="ivms101-NaturalPersonName"></a>

### NaturalPersonName



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| name_identifiers | [NaturalPersonNameId](#ivms101-NaturalPersonNameId) | repeated | At least one occurrence of naturalPersonNameID must have the value ‘LEGL’ specified in the element naturalPersonNameIdentifierType. Definition: full name separated into primary and secondary identifier. |
| local_name_identifiers | [LocalNaturalPersonNameId](#ivms101-LocalNaturalPersonNameId) | repeated | Definition: full name separated into primary and secondary identifier using local characters. |
| phonetic_name_identifiers | [LocalNaturalPersonNameId](#ivms101-LocalNaturalPersonNameId) | repeated | Definition: Alternate representation of a name that corresponds to the manner the name is pronounced. |







<a name="ivms101-NaturalPersonNameId"></a>

### NaturalPersonNameId



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| primary_identifier | [string](#string) |  | Definition: This may be the family name, the maiden name or the married name, the main name, the surname, and in some cases, the entire name where the natural person’s name cannot be divided into two parts, or where the sender is unable to divide the natural person’s name into two parts. |
| secondary_identifier | [string](#string) |  | Definition: These may be the forenames, familiar names, given names, initials, prefixes, suffixes or Roman numerals (where considered to be legally part of the name) or any other secondary names. |
| name_identifier_type | [NaturalPersonNameTypeCode](#ivms101-NaturalPersonNameTypeCode) |  | Definition: The nature of the name specified. |







<a name="ivms101-Person"></a>

### Person



| Field | Type | Label | Description |
| ----- | ---- | ----- | ----------- |
| natural_person | [NaturalPerson](#ivms101-NaturalPerson) |  | Definition: a uniquely distinguishable individual; one single person. |
| legal_person | [LegalPerson](#ivms101-LegalPerson) |  | Definition: any entity other than a natural person that can establish a permanent customer relationship with an affected entity or otherwise own property. This can include companies, bodies corporate, foundations, anstalt, partnerships, or associations and other relevantly similar entities. |






 <!-- end messages -->

 <!-- end enums -->


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

