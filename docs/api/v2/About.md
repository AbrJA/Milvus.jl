# Get Started

Milvus offers RESTful API for you to manipulate your collections and data stored in them. Before you dive in, there are several things that are worth noting:

## Understanding the API endpoints

These API endpoints involve manipulating collections in a specified cluster as well as the data in a specific collection.

localhost:19530

The following is the API endpoint used to list collections in a Milvus cluster.

```bash
export CLUSTER_ENDPOINT="http://localhost:19530"

curl --request POST \
    --url "${CLUSTER_ENDPOINT}/v2/vectordb/collections/list" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    -d '{
        "dbName": "_default"
    }'
```

## Authentication credentials

root:milvus

```bash
export CLUSTER_ENDPOINT="http://localhost:19530"
export TOKEN="root:milvus"

curl --request POST \
    --url "${CLUSTER_ENDPOINT}/v2/vectordb/collections/list" \
    --header "Authorization: Bearer ${TOKEN}" \
    --header 'accept: application/json' \
    --header 'content-type: application/json' \
    -d '{
        "dbName": "_default"
    }'
```

## API endpoint versioning

Milvus offers two sets of API endpoints, namely v1 and v2. The v1 endpoints only covers collection and vector operations, while the v2 endpoints cover more operations such as index management, partition management, and role-based access control (RBAC) operations. The v1 endpoints are to be deprecated in the near future, and the v2 endpoints are the recommended ones to use.
