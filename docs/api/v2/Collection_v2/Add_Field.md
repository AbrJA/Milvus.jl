# Add Collection Field

**POST** `/v2/vectordb/collections/fields/add`

This operation adds a field to a collection without recreating the collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database which the collection belongs to. Setting this to a non-existing database results in an error.
  - `collectionName` (string): The name of the target collection.
Setting this to a non-existing collection results in an error.
  - `schema` (object): The schema of the field to add.
    - `fieldName` (string): The name of the field to add.
    - `dataType` (string): The data type of the field to add. Supported types are `Int64`, `Float`, `Double`, `VarChar`, `Array`, and `Vector`.
    - `elementDataType` (string): The data type of the elements in an array field. This is required if the current field is of the array type.
    - `nullable` (boolean): Whether the field can be null. To be compatible with existing data in the collection, this should be set to `true`.
    - `defaultValue` (object): The default value of the field. This is required if the current field is of the `VarChar` type.
    - `elementTypeParams` (object): Extra field parameters.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
