# Update Resource Group

**POST** `/v2/vectordb/resource_groups/alter`

This operation updates the configuration of the specified resource group.

**Tags:** Resource Group (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `resource_groups` (object): The configurations of the resource group to update. You can include multiple resource groups in the request body with the name of each resource group as the key and its configuration as the value.
    - `<resource_group_name>` (object): The updated configuration of the resource group specified by the key.

### Responses

**200:** Returns an empty object.

**success:**

- **Type:** `object`
- **Description:** A success response
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which is an empty object.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
