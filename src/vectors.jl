# =============================================================================
# Milvus.jl - Vector/Entity Operations (V2)
# =============================================================================

"""
    insert(client::MilvusClient; kwargs...) -> Dict

Insert data into a specific collection.

**POST** `/v2/vectordb/entities/insert`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of an existing collection.
- `data::Any` **(required)**: An entity object or an array of entity objects.
- `partitionName::String`: Name of a partition to insert into.
"""
function insert(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/insert"; kwargs...)
end

"""
    upsert(client::MilvusClient; kwargs...) -> Dict

Insert new records or update existing ones.

**POST** `/v2/vectordb/entities/upsert`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `partitionName::String`: Name of a partition.
- `data::Any` **(required)**: An entity object or an array of entity objects.
"""
function upsert(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/upsert"; kwargs...)
end

"""
    delete_entities(client::MilvusClient; kwargs...) -> Dict

Delete entities by their IDs or with a boolean expression.

**POST** `/v2/vectordb/entities/delete`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of an existing collection.
- `filter::String` **(required)**: A scalar filtering condition.
- `partitionName::String`: Name of a partition.
"""
function delete_entities(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/delete"; kwargs...)
end

"""
    get_entities(client::MilvusClient; kwargs...) -> Dict

Get specific entities by their IDs.

**POST** `/v2/vectordb/entities/get`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `id::Any` **(required)**: A specific entity ID or a list of entity IDs.
- `outputFields::Vector{String}`: Fields to return.
- `partitionNames::Vector{String}`: Partitions to search.
"""
function get_entities(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/get"; kwargs...)
end

"""
    query(client::MilvusClient; kwargs...) -> Dict

Conduct a filtering on scalar fields with a boolean expression.

**POST** `/v2/vectordb/entities/query`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `filter::String` **(required)**: The filter expression.
- `outputFields::Vector{String}`: Fields to return.
- `partitionNames::Vector{String}`: Partitions to search.
- `limit::Int`: Maximum number of entities to return.
- `offset::Int`: Number of records to skip.
"""
function query(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/query"; kwargs...)
end

"""
    search(client::MilvusClient; kwargs...) -> Dict

Conduct a vector similarity search with an optional scalar filtering expression.

**POST** `/v2/vectordb/entities/search`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `data::Vector` **(required)**: A list of vector embeddings.
- `annsField::String` **(required)**: Name of the vector field.
- `filter::String`: Filter expression.
- `limit::Int`: Total number of entities to return.
- `offset::Int`: Number of records to skip.
- `groupingField::String`: Field name for aggregation criteria.
- `outputFields::Vector{String}`: Fields to return.
- `searchParams::Dict`: Search parameter settings (metricType, params).
- `partitionNames::Vector{String}`: Partitions to search.
- `consistencyLevel::String`: Consistency level.
"""
function search(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/search"; kwargs...)
end

"""
    hybrid_search(client::MilvusClient; kwargs...) -> Dict

Search entities based on vector similarity and scalar filtering, then rerank results.

**POST** `/v2/vectordb/entities/hybrid_search`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the collection.
- `partitionNames::Vector{String}`: Partitions to search.
- `search::Vector` **(required)**: The search parameters.
- `rerank::Dict`: The reranking strategy (strategy, params).
- `limit::Int`: Total number of entities to return.
- `outputFields::Vector{String}`: Fields to return.
- `consistencyLevel::String`: Consistency level.
"""
function hybrid_search(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/entities/hybrid_search"; kwargs...)
end
