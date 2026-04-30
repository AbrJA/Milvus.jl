# Describe User

**POST** `/v2/vectordb/users/describe`

This operation describes the detailed information of a specific user.

**Tags:** User Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `userName` (string) **(required)**: The name of the target user. The value should start with a letter and can only contain underline, letters and numbers.

### Responses

**200:** Returns the name of the roles assigned to the specified user.

- **Type:** `object`
