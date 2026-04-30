# =============================================================================
# Milvus.jl - Database Operations (V2)
# =============================================================================

"""
    create_database(client::MilvusClient; kwargs...) -> Dict

Create a new database in the specified cluster.

**POST** `/v2/vectordb/databases/create`

# Keyword Arguments
- `dbName::String` **(required)**: Name of the new database.
- `properties::Dict`: Properties of the new database.
  - `database.replica.number::Int`: Number of replicas.
  - `database.resource_groups::String`: Resource groups (comma-separated).
  - `database.diskQuota.mb::Int`: Maximum disk space in MB.
  - `database.max.collections::Int`: Maximum number of collections.
  - `database.force.deny.writing::Bool`: Deny writing.
  - `database.force.deny.reading::Bool`: Deny reading.
"""
function create_database(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/databases/create"; kwargs...)
end

"""
    describe_database(client::MilvusClient; kwargs...) -> Dict

Describe the specified database.

**POST** `/v2/vectordb/databases/describe`

# Keyword Arguments
- `dbName::String` **(required)**: Name of the target database.
"""
function describe_database(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/databases/describe"; kwargs...)
end

"""
    list_databases(client::MilvusClient; kwargs...) -> Dict

List all databases in the current Milvus instance/cluster.

**POST** `/v2/vectordb/databases/list`
"""
function list_databases(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/databases/list"; kwargs...)
end

"""
    drop_database(client::MilvusClient; kwargs...) -> Dict

Drop the specified database.

**POST** `/v2/vectordb/databases/drop`

# Keyword Arguments
- `dbName::String` **(required)**: Name of the target database.
"""
function drop_database(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/databases/drop"; kwargs...)
end

"""
    alter_database_properties(client::MilvusClient; kwargs...) -> Dict

Alter the properties of the specified database.

**POST** `/v2/vectordb/databases/alter`

# Keyword Arguments
- `dbName::String` **(required)**: Name of the target database.
- `properties::Dict` **(required)**: Properties to modify.
  - `database.replica.number::Int`: Number of replicas.
  - `database.resource_groups::String`: Resource groups (comma-separated).
  - `database.diskQuota.mb::Int`: Maximum disk space in MB.
  - `database.max.collections::Int`: Maximum number of collections.
  - `database.force.deny.writing::Bool`: Deny writing.
  - `database.force.deny.reading::Bool`: Deny reading.
"""
function alter_database_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/databases/alter"; kwargs...)
end

"""
    drop_database_properties(client::MilvusClient; kwargs...) -> Dict

Drop the specified properties of the specified database.

**POST** `/v2/vectordb/databases/drop_properties`

# Keyword Arguments
- `dbName::String` **(required)**: Name of the target database.
- `propertyKeys::Vector{String}` **(required)**: Names of the properties to drop.
"""
function drop_database_properties(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/databases/drop_properties"; kwargs...)
end
