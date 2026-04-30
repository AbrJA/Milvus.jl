# Create Collection

**POST** `/v2/vectordb/collections/create`

This operation creates a collection in a specified cluster.

**Tags:** Collection Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Description:** Creates a collection in either the quick-setup mode or the custom-setup mode. 

In the quick-setup mode, the schema of the created collection has two schema-defined fields named `id` and `vector` and enabled the dynamic field feature. 

In the custom-setup mode, the schema is defined by the user and the dynamic field feature is disabled by default.

### Responses

**200:** Returns a collection object.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which is an empty object.

**failure:**

- **Type:** `object`
- **Description:** A failure response.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
