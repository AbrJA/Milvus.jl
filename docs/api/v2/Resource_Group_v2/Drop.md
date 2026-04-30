# Drop Resource Group

**POST** `/v2/vectordb/resource_groups/drop`

This operation drops the specified resource group.

**Tags:** Resource Group (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `name` (string): The name of the resource group to drop.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
