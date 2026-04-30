# Revoke Role From User

**POST** `/v2/vectordb/users/revoke_role`

This operation revokes a privilege granted to the current role.

**Tags:** User Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `userName` (string) **(required)**: The name of the target user. The value should start with a letter and can only contain underline, letters and numbers.
  - `roleName` (string) **(required)**: The name of the target role.

### Responses

**200:** None

- **Type:** `object`
