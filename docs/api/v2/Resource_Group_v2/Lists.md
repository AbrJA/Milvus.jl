# List Resource Groups

**POST** `/v2/vectordb/resource_groups/list`

This operation returns the list of resource group names.

**Tags:** Resource Group (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**

### Responses

**200:** Returns the list of resource group names.

- **Type:** `object`
