# Describe Role

**POST** `/v2/vectordb/roles/describe`

This operation describes the details of a specified role.

**Tags:** Role Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `roleName` (string) **(required)**: The name of the role.

### Responses

**200:** An object that contains the detailed desription of a role.

- **Type:** `object`
