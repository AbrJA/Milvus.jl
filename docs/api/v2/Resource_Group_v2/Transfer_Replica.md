# Transfer Collection Replica

**POST** `/v2/vectordb/resource_groups/transfer_replica`

This operation transfers the replicas of the specified collection from the source resource group to the target resource group.

**Tags:** Resource Group (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `sourceRgName` (string): The name of the source resource group.
  - `targetRgName` (string): The name of the target resource group.
  - `collectionName` (string): The name of the target collection.
  - `replicaNum` (integer): The number of replicas to transfer.

### Responses

**200:** Returns an empty object.

- **Type:** `object`
