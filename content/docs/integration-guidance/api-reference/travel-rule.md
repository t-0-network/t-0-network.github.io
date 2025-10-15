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

