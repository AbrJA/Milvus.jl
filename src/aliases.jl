# =============================================================================
# Milvus.jl - Alias Operations (V2)
# =============================================================================

"""
    create_alias(client::MilvusClient; kwargs...) -> Dict

Create an alias for an existing collection.

**POST** `/v2/vectordb/aliases/create`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `aliasName::String` **(required)**: The alias for the collection.
"""
function create_alias(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/aliases/create"; kwargs...)
end

"""
    alter_alias(client::MilvusClient; kwargs...) -> Dict

Reassign the alias of one collection to another.

**POST** `/v2/vectordb/aliases/alter`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `aliasName::String` **(required)**: The alias to reassign.
"""
function alter_alias(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/aliases/alter"; kwargs...)
end

"""
    describe_alias(client::MilvusClient; kwargs...) -> Dict

Describe the details of a specific alias.

**POST** `/v2/vectordb/aliases/describe`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `aliasName::String` **(required)**: Name of the alias to describe.
"""
function describe_alias(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/aliases/describe"; kwargs...)
end

"""
    list_aliases(client::MilvusClient; kwargs...) -> Dict

List all existing collection aliases.

**POST** `/v2/vectordb/aliases/list`

# Keyword Arguments
- `dbName::String`: Name of an existing database.
- `collectionName::String`: Name of an existing collection (filter by collection).
"""
function list_aliases(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/aliases/list"; kwargs...)
end

"""
    drop_alias(client::MilvusClient; kwargs...) -> Dict

Drop a specified alias.

**POST** `/v2/vectordb/aliases/drop`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String`: Name of the collection.
- `aliasName::String` **(required)**: The alias to drop.
"""
function drop_alias(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/aliases/drop"; kwargs...)
end
