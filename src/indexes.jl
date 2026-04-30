# =============================================================================
# Milvus.jl - Index Operations (V2)
# =============================================================================

"""
    create_index(client::MilvusClient; kwargs...) -> Dict

Create a named index for a target field (vector or scalar).

**POST** `/v2/vectordb/indexes/create`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `indexParams::Vector{Dict}` **(required)**: Parameters for the index-building process.
  Each element should be a Dict with keys like `metricType`, `params`, `fieldName`, `indexName`.
"""
function create_index(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/indexes/create"; kwargs...)
end

"""
    describe_index(client::MilvusClient; kwargs...) -> Dict

Describe the current index.

**POST** `/v2/vectordb/indexes/describe`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `indexName::String` **(required)**: Name of the index to describe.
"""
function describe_index(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/indexes/describe"; kwargs...)
end

"""
    list_indexes(client::MilvusClient; kwargs...) -> Dict

List all indexes of a specific collection.

**POST** `/v2/vectordb/indexes/list`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of an existing collection.
"""
function list_indexes(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/indexes/list"; kwargs...)
end

"""
    drop_index(client::MilvusClient; kwargs...) -> Dict

Delete an index from a specified collection.

**POST** `/v2/vectordb/indexes/drop`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `indexName::String` **(required)**: Name of the index to drop.
"""
function drop_index(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/indexes/drop"; kwargs...)
end

"""
    alter_index_properties(client::MilvusClient; kwargs...) -> Dict

Alter the properties of an index.

**POST** `/v2/vectordb/indexes/alter_properties`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `indexName::String` **(required)**: Name of the target index.
- `properties::Dict` **(required)**: New index parameters (e.g., `mmap.enabled`).
"""
function alter_index_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/indexes/alter_properties"; kwargs...)
end

"""
    drop_index_properties(client::MilvusClient; kwargs...) -> Dict

Drop the properties of an index.

**POST** `/v2/vectordb/indexes/drop_properties`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `indexName::String` **(required)**: Name of the target index.
- `propertyKeys::Vector{String}` **(required)**: Names of the properties to drop.
"""
function drop_index_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/indexes/drop_properties"; kwargs...)
end
