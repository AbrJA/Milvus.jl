# Alter Field Properties

**POST** `/v2/vectordb/collections/fields/alter_properties`

This operation alters the properties of a field in a collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database which the collection belongs to. Setting this to a non-existing database results in an error.
  - `collectionName` (string) **(required)**: The name of the target collection.
Setting this to a non-existing collection results in an error.
  - `fieldName` (string) **(required)**: The name of the field whose properties are to be altered.
  - `fieldParams` (object) **(required)**: The properties of the field to alter.
    - `max_length` (integer): The maximum length of the field. Setting this to a non-zero value restricts the maximum length of the field to the specified value.<br/>This parameter applies only when the field is of type `VarChar`.
    - `max_capacity` (integer): The maximum capacity of the field. Setting this to a non-zero value restricts the maximum capacity of the field to the specified value.<br/>This parameter applies only when the field is of type `Array`.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
