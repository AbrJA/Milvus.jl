# Grant Privilege To Role

**POST** `/v2/vectordb/roles/grant_privilege`

This operation grants a privilege to the current role.

**Tags:** Role Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `roleName` (string) **(required)**: The name of the role.
  - `objectType` (string) **(required)**:  The type of the object to which the privilege belongs.
  - `objectName` (string) **(required)**:  The name of the object to which the role is granted the specified privilege.
  - `privilege` (string) **(required)**:  The privilege that is granted to the role.

### Responses

**200:** None

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
