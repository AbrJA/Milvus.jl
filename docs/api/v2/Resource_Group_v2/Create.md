# Create Resource Group

**POST** `/v2/vectordb/resource_groups/create`

This operation creates a resource group. A Milvus instance begins with a default resource group that includes all available query nodes. You can create additional resource groups, reassign specific query nodes from the default group, and load collections into the query nodes in these newly configured groups. This operation always succeeds no matter whether the resource group exists.

**Tags:** Resource Group (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `name` (string) **(required)**: The name of the resource group to create.
  - `config` (object): The configurations of the resource group to create.
    - `requests` (object): The number of query nodes to allocate to the resource group.
    - `limits` (object): The maximum number of query nodes to allocate to the resource group.
    - `transfer_from` (array): The list of source resource groups to transfer query nodes from.
    - `transfer_to` (array): The list of target resource groups to transfer query nodes to.

### Responses

**200:** Returns an empty object.

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
