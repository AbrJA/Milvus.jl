# List Users

**POST** `/v2/vectordb/users/list`

This operation lists the information of all existing users.

**Tags:** User Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Description:** An empty object.
- **Properties:**

### Responses

**200:** An object that contains contains the user information.

- **Type:** `object`
