# Create Role

**POST** `/v2/vectordb/roles/create`

This operation creates a role.

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

**200:** Returns an empty object or an error message.

- **Type:** `object`
