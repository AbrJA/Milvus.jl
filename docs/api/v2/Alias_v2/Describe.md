# Describe Alias

**POST** `/v2/vectordb/aliases/describe`

This operation describes the details of a specific alias.

**Tags:** Alias Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `dbName` (string): The name of the database to which the alias belongs.
  - `aliasName` (string) **(required)**: The name of the alias whose details are to be listed.

### Responses

**200:** An alias object that contains the detailed description of an alias.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which carries the detailed description of an alias.
    - `dbName` (string): The name of the database to which the collection belongs.
    - `collectionName` (string): the name of the collection to which an alias belongs.
    - `aliasName` (string): The name of the alias.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
