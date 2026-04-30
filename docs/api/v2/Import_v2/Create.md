# Create Import Jobs

**POST** `/v2/vectordb/jobs/import/create`

This operation imports the prepared data files to a Milvus instanceZilliz Cloud cluster. To learn how to prepare your data files, read [Prepare Data Import](https://milvus.io/docs/prepare-source-data.md)[Prepare Data Import](/docs/prepare-data-import).

**Tags:** Import Operations (V2)

### Parameters

- **`Authorization`** (header, `string`) **(required)**
  - The authentication token should be an API key with appropriate privileges.

### Request Body

**Content-Type:** `application/json`

- **Type:** `object`
- **Properties:**
  - `clusterId` (string) **(required)**: The ID of the cluster to which the collection belongs.
Setting this to a non-existing cluster results in an error. You can get the cluster ID by calling the [`/v2/clusters`](/reference/restful/list-clusters-v2) endpoint, or copy the cluster ID from the [Zilliz Cloud console](/docs/on-zilliz-cloud-console).
  - `dbName` (string): The name of the database that to which the collection belongs .
Setting this to a non-existing database results in an error.
  - `collectionName` (string) **(required)**: The name of the target collection.
Setting this to a non-existing collection results in an error.
  - `partitionName` (string): The name of the target partition.
Setting this to a non-existing partition results in an error.
  - `files` (array): The files that contain the data to import. The files should reside within the Milvus bucket on the MinIO instance deployed along with your Milvus instance.
  - `options` (object): Bulk-import options.
    - `timeout` (string): The timeout duration of the created import jobs. The value should be a positive number suffixed by __s__ (seconds), __m__ (minutes), and __h__(hours). For example, _300s_, _1.5h_, and _1h45_ are all valid values.
  - `objectUrl` (string): The URL of the object to import. This URL should be accessible to the S3-compatible object storage service, such as AWS S3, GCS, Azure blob storage.
  - `objectUrls` (array) **(required)**: The URLs of the objects to import. <br/>Applicable formats and how to import multiple objects in one job are as follows:<ul><li><a href="https://docs.zilliz.com/docs/data-import-parquet#import-data">Parquet</a></li><li><a href="https://docs.zilliz.com/docs/data-import-json#import-data">JSON</a></li><li><a href="https://docs.zilliz.com/docs/data-import-numpy#import-data">NumPy</a></li></ul>.
  - `accessKey` (string): The access key of the object storage service.
  - `secretKey` (string): The secret access key of the object storage service.
  - `token` (string): A temporary token for you to access the object storage service. The token name and the way to obtain it may vary with cloud providers. For details, refer to [the FAQ](/docs/faq-data-import#can-i-use-session-tokens-when-importing-data-from-an-object-storage-service).

### Responses

**200:** The ID of the bulk-import job.

**success:**

- **Type:** `object`
- **Properties:**
  - `code` (integer): Response code.
  - `data` (array): Response payload which carries the IDs of the created bulk-import jobs.

**failure:**

- **Type:** `object`
- **Description:** Returns an error message.
- **Properties:**
  - `code` (integer): Response code.
  - `message` (string): Error message.
