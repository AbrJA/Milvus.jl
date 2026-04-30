# Create User

**POST** `/v2/vectordb/users/create`

This operation creates a new user with a corresponding password.

**Tags:** User Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `userName` (string): The name of the target user. The value should start with a letter and can only contain underline, letters and numbers.
  - `password` (string): The corresponding password to the user. 
The password must must include at least three of the following character types: uppercase letters, lowercase letters, numbers, and special characters.

### Responses

**200:** None

- **Type:** `object`
