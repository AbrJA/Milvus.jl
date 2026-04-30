# Describe Collection

**POST** `/v2/vectordb/collections/describe`

Describes the details of a collection.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database.
  - `collectionName` (string) **(required)**: The name of the collection to describe.

### Responses

**200:** Returns the specified collection in detail.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload, which carries detailed information about the specified collection.
    - `aliases` (array): A list aliases assigned to the collection.
    - `autoID` (boolean): Whether the primary key of this collection automatically increments.
    - `collectionID` (integer): The ID assigned to the collection upon creation.
    - `collectionName` (string): The name of the current collection.
    - `consistencyLevel` (string): The consistency level of the current collection.
    - `description` (string): The description of the collection.
    - `enableDynamicField` (boolean): Whether the reserved dynamic field named $meta is enabled to save non-schema-defined fields and their values in key-value pairs.
    - `fields` (array): The collection fields in an array
    - `indexes` (array): The created indexes in an array
    - `load` (string): The load status of the current collection.
    - `partitionNum` (integer): The number of partitions in the collection.
    - `properties` (array): Extra collection properties in an array.
    - `shardsNum` (integer): The number of shards created along with the collection.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
