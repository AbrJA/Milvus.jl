# Grant Role To User

**POST** `/v2/vectordb/users/grant_role`

This operation grants a specified role to the current user. Once granted the role, the user gets permissions allowed for the current role and can perform certain operations.To complete this operation, you need to enable authentication on your Milvus instance. For details, refer to [Authenticate User Access](https://milvus.io/docs/authenticate.md).

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
