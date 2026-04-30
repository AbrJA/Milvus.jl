# Update User Password

**POST** `/v2/vectordb/users/update_password`

This operation updates the password for a specific user.

**Tags:** User Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `userName` (string) **(required)**: The name of the target user. The value should start with a letter and can only contain underline, letters and numbers.
  - `password` (string) **(required)**: The corresponding password to the user. 
The password must be a string of 8 to 64 characters and must include at least three of the following character types: uppercase letters, lowercase letters, numbers, and special characters.
  - `newPassword` (string) **(required)**: The new password for the user. 
The password must be a string of 8 to 64 characters and must include at least three of the following character types: uppercase letters, lowercase letters, numbers, and special characters.

### Responses

**200:** Return an empty object or an error message

- **Type:** `object`
