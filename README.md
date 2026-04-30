# Milvus.jl

[![Build Status](https://github.com/AbrJA/Milvus.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/AbrJA/Milvus.jl/actions/workflows/CI.yml)

A production-ready, high-performance Julia client for the [Milvus](https://milvus.io/) vector database REST API (v2).

## Features

- **Complete API Coverage** — All documented REST API v2 endpoints in `docs/api/v2` are implemented (currently 70 POST endpoints)
- **High Performance** — Uses `HTTP.jl` with connection pooling, `JSON.jl`, and `StructUtils.jl`
- **Production Ready** — Retry logic with exponential backoff, configurable timeouts, verbose logging
- **Julia-idiomatic** — Keyword arguments, type-safe enums, comprehensive docstrings
- **Thread-safe** — All client operations are reentrant
- **Parity Guarded** — Automated test enforces docs endpoint parity so code and docs do not drift

## Validation and Test Coverage

`Pkg.test()` includes:

- Endpoint parity validation between `docs/api/v2/**/*.md` and `src/**/*.jl`
- Mock-server coverage for all implemented endpoint wrappers
- Live integration tests against a running Milvus instance

Latest verification result (April 30, 2026):

- `Endpoint Parity`: 4/4 passing
- `Endpoint Coverage (Mock Server)`: 281/281 passing
- `Live Integration`: 23/23 passing

## Installation

```julia
julia> ]
pkg> add Milvus
```

Or use the development version:

```julia
julia> ]
pkg> dev https://github.com/AbrJA/Milvus.jl.git
```

## Quick Start

```julia
using Milvus

# Connect to Milvus
client = MilvusClient(
    host="http://localhost:19530",
    token="root:milvus"
)

# Create a collection (quick-setup mode)
create_collection(client;
    collectionName="books",
    dimension=768,
    metricType="IP",
    autoID=true
)

# Insert data
insert(client;
    collectionName="books",
    data=[
        Dict("vector" => rand(Float32, 768), "title" => "Book 1"),
        Dict("vector" => rand(Float32, 768), "title" => "Book 2"),
        Dict("vector" => rand(Float32, 768), "title" => "Book 3")
    ]
)

# Vector similarity search
results = search(client;
    collectionName="books",
    data=[rand(Float32, 768)],
    annsField="vector",
    limit=10,
    outputFields=["title"]
)

# Query with scalar filter
results = query(client;
    collectionName="books",
    filter="title like \"Book%\"",
    outputFields=["title", "id"],
    limit=100
)

# Clean up
drop_collection(client; collectionName="books")
```

## API Reference

### Client

```julia
MilvusClient(;
    host="http://localhost:19530",
    token="",
    connect_timeout=30,
    read_timeout=60,
    retries=3,
    retry_delay=0.5,
    verbose=false
)
```

### Collection Operations (17 endpoints)

| Function | Description |
|---|---|
| `create_collection` | Create a collection (quick-setup or custom-setup) |
| `describe_collection` | Describe collection details |
| `list_collections` | List all collection names |
| `drop_collection` | Drop a collection and its data |
| `rename_collection` | Rename a collection |
| `has_collection` | Check if a collection exists |
| `get_collection_stats` | Get entity count |
| `get_load_state` | Get load status |
| `load_collection` | Load collection into memory |
| `release_collection` | Release collection from memory |
| `flush_collection` | Flush streaming data |
| `compact_collection` | Compact segments |
| `refresh_load` | Refresh collection load |
| `alter_collection_properties` | Modify collection properties |
| `drop_collection_properties` | Remove collection properties |
| `add_collection_field` | Add a field to a collection |
| `alter_field_properties` | Modify field properties |

### Vector/Entity Operations (7 endpoints)

| Function | Description |
|---|---|
| `insert` | Insert entities |
| `upsert` | Insert or update entities |
| `delete_entities` | Delete entities by filter |
| `get_entities` | Get entities by ID |
| `query` | Query with scalar filter |
| `search` | Vector similarity search |
| `hybrid_search` | Hybrid search with reranking |

### Partition Operations (7 endpoints)

| Function | Description |
|---|---|
| `create_partition` | Create a partition |
| `drop_partition` | Drop a partition |
| `has_partition` | Check partition existence |
| `list_partitions` | List all partitions |
| `load_partitions` | Load partitions into memory |
| `release_partitions` | Release partitions from memory |
| `get_partition_stats` | Get partition entity count |

### Index Operations (6 endpoints)

| Function | Description |
|---|---|
| `create_index` | Create an index |
| `describe_index` | Describe an index |
| `list_indexes` | List all indexes |
| `drop_index` | Drop an index |
| `alter_index_properties` | Modify index properties |
| `drop_index_properties` | Remove index properties |

### Database Operations (6 endpoints)

| Function | Description |
|---|---|
| `create_database` | Create a database |
| `describe_database` | Describe a database |
| `list_databases` | List all databases |
| `drop_database` | Drop a database |
| `alter_database_properties` | Modify database properties |
| `drop_database_properties` | Remove database properties |

### Alias Operations (5 endpoints)

| Function | Description |
|---|---|
| `create_alias` | Create a collection alias |
| `alter_alias` | Reassign an alias |
| `describe_alias` | Describe an alias |
| `list_aliases` | List all aliases |
| `drop_alias` | Drop an alias |

### Role Operations (6 endpoints)

| Function | Description |
|---|---|
| `create_role` | Create a role |
| `describe_role` | Describe a role |
| `drop_role` | Drop a role |
| `list_roles` | List all roles |
| `grant_privilege` | Grant privilege to role |
| `revoke_privilege` | Revoke privilege from role |

### User Operations (7 endpoints)

| Function | Description |
|---|---|
| `create_user` | Create a user |
| `describe_user` | Describe a user |
| `drop_user` | Drop a user |
| `list_users` | List all users |
| `update_password` | Update user password |
| `grant_role` | Grant role to user |
| `revoke_role` | Revoke role from user |

### Resource Group Operations (6 endpoints)

| Function | Description |
|---|---|
| `create_resource_group` | Create a resource group |
| `describe_resource_group` | Describe a resource group |
| `list_resource_groups` | List all resource groups |
| `drop_resource_group` | Drop a resource group |
| `update_resource_group` | Update resource group config |
| `transfer_replica` | Transfer replicas between groups |

### Import Operations (3 endpoints)

| Function | Description |
|---|---|
| `create_import_job` | Create a bulk import job |
| `get_import_progress` | Get import job progress |
| `list_import_jobs` | List all import jobs |

## Advanced Usage

### Custom Setup Mode (with schema)

```julia
schema = Dict(
    "fields" => [
        Dict(
            "fieldName" => "id",
            "dataType" => "Int64",
            "isPrimary" => true,
            "autoID" => true
        ),
        Dict(
            "fieldName" => "vector",
            "dataType" => "FloatVector",
            "elementTypeParams" => Dict("dim" => 128)
        ),
        Dict(
            "fieldName" => "title",
            "dataType" => "VarChar",
            "elementTypeParams" => Dict("max_length" => 512)
        )
    ]
)

create_collection(client;
    collectionName="books_custom",
    schema=schema,
    enableDynamicField=true
)
```

### Error Handling

```julia
try
    result = describe_collection(client; collectionName="non_existent")
catch e
    if e isa MilvusException
        println("Milvus error $(e.code): $(e.message)")
    else
        println("Network error: $e")
    end
end
```

### Verbose Debugging

```julia
client = MilvusClient(host="http://localhost:19530", token="root:milvus", verbose=true)
# All requests and responses will be logged to stdout
```

## Running Tests

```bash
# Unit tests (no server required)
julia test/runtests.jl

# Integration tests (requires running Milvus)
MILVUS_TEST_HOST="http://localhost:19530" MILVUS_TEST_TOKEN="root:milvus" julia test/runtests.jl
```

## License

MIT License
