# List Roles

**POST** `/v2/vectordb/roles/list`

This operation lists the information about all existing roles.

**Tags:** Role Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Description:** An empty object.
- **Properties:**

### Responses

**200:** A RoleInfo object that contains a list of RoleItem objects.

- **Type:** `object`
