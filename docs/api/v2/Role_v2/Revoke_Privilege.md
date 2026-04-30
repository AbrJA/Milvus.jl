# Revoke Privilege From Role

**POST** `/v2/vectordb/roles/revoke_privilege`

This operation revokes a privilege granted to the current role.

**Tags:** Role Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `roleName` (string) **(required)**: The name of the role.
  - `objectType` (string) **(required)**: The type of the object to which the specified privilege belongs.
  - `objectName` (string) **(required)**: The name of the object to which the specified privilege belongs.
  - `privilege` (string) **(required)**: The privilege that is revoked from the role.

### Responses

**200:** Return an empty object or an error message.

- **Type:** `object`
