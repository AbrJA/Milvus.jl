# =============================================================================
# Milvus.jl - Collection Operations (V2)
# =============================================================================

"""
    create_collection(client::MilvusClient; kwargs...) -> Dict

Create a collection in a specified cluster.

**POST** `/v2/vectordb/collections/create`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `dimension::Int`: Dimension of the vector field (quick-setup mode).
- `metricType::String`: Metric type for vector similarity (quick-setup mode).
- `primaryField::String`: Name of the primary field (quick-setup mode, default: "id").
- `vectorField::String`: Name of the vector field (quick-setup mode, default: "vector").
- `idType::String`: Data type of the primary field (quick-setup mode, default: "Int64").
- `autoID::Bool`: Whether to auto-generate IDs (quick-setup mode).
- `enableDynamicField::Bool`: Enable dynamic field (default: true in quick-setup).
- `schema::Dict`: Custom schema definition (custom-setup mode).
- `properties::Dict`: Collection properties.
- `numShards::Int`: Number of shards.
- `consistencyLevel::String`: Consistency level.
- `description::String`: Collection description.
"""
function create_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/create"; kwargs...)
end

"""
    describe_collection(client::MilvusClient; kwargs...) -> Dict

Describe the details of a collection.

**POST** `/v2/vectordb/collections/describe`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to describe.
"""
function describe_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/describe"; kwargs...)
end

"""
    list_collections(client::MilvusClient; kwargs...) -> Dict

List all collection names.

**POST** `/v2/vectordb/collections/list`

# Keyword Arguments
- `dbName::String`: Name of an existing database.
"""
function list_collections(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/list"; kwargs...)
end

"""
    drop_collection(client::MilvusClient; kwargs...) -> Dict

Drop a collection and all data within it.

**POST** `/v2/vectordb/collections/drop`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to drop.
"""
function drop_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/drop"; kwargs...)
end

"""
    rename_collection(client::MilvusClient; kwargs...) -> Dict

Rename an existing collection and optionally move it to a new database.

**POST** `/v2/vectordb/collections/rename`

# Keyword Arguments
- `collectionName::String` **(required)**: Current name of the collection.
- `newCollectionName::String` **(required)**: New name for the collection.
- `dbName::String`: Current database name.
- `newDbName::String`: Target database name (defaults to "default").
"""
function rename_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/rename"; kwargs...)
end

"""
    has_collection(client::MilvusClient; kwargs...) -> Dict

Check whether a collection exists.

**POST** `/v2/vectordb/collections/has`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to check.
"""
function has_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/has"; kwargs...)
end

"""
    get_collection_stats(client::MilvusClient; kwargs...) -> Dict

Get the number of entities in a collection.

**POST** `/v2/vectordb/collections/get_stats`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
"""
function get_collection_stats(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/get_stats"; kwargs...)
end

"""
    get_load_state(client::MilvusClient; kwargs...) -> Dict

Get the load status of a specific collection.

**POST** `/v2/vectordb/collections/get_load_state`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `partitionNames::Vector{String}`: List of partition names.
"""
function get_load_state(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/get_load_state"; kwargs...)
end

"""
    load_collection(client::MilvusClient; kwargs...) -> Dict

Load the data of a collection into memory.

**POST** `/v2/vectordb/collections/load`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to load.
"""
function load_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/load"; kwargs...)
end

"""
    release_collection(client::MilvusClient; kwargs...) -> Dict

Release the data of a collection from memory.

**POST** `/v2/vectordb/collections/release`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to release.
"""
function release_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/release"; kwargs...)
end

"""
    flush_collection(client::MilvusClient; kwargs...) -> Dict

Flush streaming data and seal segments.

**POST** `/v2/vectordb/collections/flush`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to flush.
"""
function flush_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/flush"; kwargs...)
end

"""
    compact_collection(client::MilvusClient; kwargs...) -> Dict

Compact a collection by merging small segments into larger ones.

**POST** `/v2/vectordb/collections/compact`

# Keyword Arguments
- `collectionName::String` **(required)**: Name of the collection to compact.
"""
function compact_collection(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/compact"; kwargs...)
end

"""
    refresh_load(client::MilvusClient; kwargs...) -> Dict

Refresh the load of a collection.

**POST** `/v2/vectordb/collections/refresh_load`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection to refresh.
"""
function refresh_load(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/refresh_load"; kwargs...)
end

"""
    alter_collection_properties(client::MilvusClient; kwargs...) -> Dict

Alter the properties of a collection.

**POST** `/v2/vectordb/collections/alter_properties`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `properties::Dict` **(required)**: Properties to alter (e.g., `mmmap.enabled`, `collection.ttl.seconds`).
"""
function alter_collection_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/alter_properties"; kwargs...)
end

"""
    drop_collection_properties(client::MilvusClient; kwargs...) -> Dict

Drop the properties of a collection.

**POST** `/v2/vectordb/collections/drop_properties`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `propertyKeys::Vector{String}` **(required)**: Names of the properties to drop.
"""
function drop_collection_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/drop_properties"; kwargs...)
end

"""
    add_collection_field(client::MilvusClient; kwargs...) -> Dict

Add a field to a collection without recreating it.

**POST** `/v2/vectordb/collections/fields/add`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String`: Name of the collection.
- `schema::Dict` **(required)**: Schema of the field to add.
    - `fieldName::String`: Name of the field.
    - `dataType::String`: Data type (`Int64`, `Float`, `Double`, `VarChar`, `Array`, `Vector`).
    - `elementDataType::String`: Element data type (for array fields).
    - `nullable::Bool`: Whether the field can be null.
    - `defaultValue::Any`: Default value.
    - `elementTypeParams::Dict`: Extra field parameters.
"""
function add_collection_field(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/fields/add"; kwargs...)
end

"""
    alter_field_properties(client::MilvusClient; kwargs...) -> Dict

Alter the properties of a field in a collection.

**POST** `/v2/vectordb/collections/fields/alter_properties`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `fieldName::String` **(required)**: Name of the field.
- `fieldParams::Dict` **(required)**: Properties to alter (`max_length` for VarChar, `max_capacity` for Array).
"""
function alter_field_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/collections/fields/alter_properties"; kwargs...)
end
