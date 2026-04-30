# Get Import Job Progress

**POST** `/v2/vectordb/jobs/import/describe`

This operation gets the progress of the specified bulk-import job.

**Tags:** Import Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges or a pair of colon-joined username and password, like `username:password`.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `clusterId` (string): The ID of a cluster to which this operation applies.
  - `dbName` (string): The name of the target database of this operation.
  - `jobId` (string) **(required)**: The ID of the bulk-import job of your interest. 
The [Create Import Jobs](/reference/restful/create-import-jobs-v2) operation usually returns a job ID. You can also call [List Import Jobs](/reference/restful/list-import-jobs-v2) to get the IDs of all bulk-import jobs related to the specific cluster.

### Responses

**200:** 成功

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (object): Response payload which contains the progress of the specified bulk-import job in detail.
    - `collectionName` (string): The name of the target collection of this bulk-import job.
    - `completeTime` (string): The timestamp indicating when the bulk-import job is complete.
    - `details` (array): Statistics on data import oriented to data files.
    - `fileSize` (integer): The uploaded file size in bytes.
    - `jobId` (integer): The ID of this bulk-import job.
    - `progress` (integer): The progress in percentage of the current bulk-import job.
    - `state` (string): The state of this bulk-import job.
    - `reason` (string): The reason for the failure to bulk import data. The field value stays empty if this job succeeds.
    - `importedRows` (integer): The number of rows inserted into the specified collection upon this import.
    - `totalRows` (integer): The number of rows in the specified collection.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
