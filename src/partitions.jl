# =============================================================================
# Milvus.jl - Partition Operations (V2)
# =============================================================================

"""
    create_partition(client::MilvusClient; kwargs...) -> Dict

Create a partition in a collection.

**POST** `/v2/vectordb/partitions/create`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `partitionName::String` **(required)**: Name of the partition.
"""
function create_partition(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/create"; kwargs...)
end

"""
    drop_partition(client::MilvusClient; kwargs...) -> Dict

Drop a partition. The partition must be released first.

**POST** `/v2/vectordb/partitions/drop`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `partitionName::String` **(required)**: Name of the partition to drop.
"""
function drop_partition(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/drop"; kwargs...)
end

"""
    has_partition(client::MilvusClient; kwargs...) -> Dict

Check whether a partition exists.

**POST** `/v2/vectordb/partitions/has`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of an existing collection.
- `partitionName::String` **(required)**: Name of the partition to check.
"""
function has_partition(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/has"; kwargs...)
end

"""
    list_partitions(client::MilvusClient; kwargs...) -> Dict

List all partitions in a collection.

**POST** `/v2/vectordb/partitions/list`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
"""
function list_partitions(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/list"; kwargs...)
end

"""
    load_partitions(client::MilvusClient; kwargs...) -> Dict

Load partition data into memory.

**POST** `/v2/vectordb/partitions/load`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `partitionNames::Vector{String}` **(required)**: Names of the partitions to load.
"""
function load_partitions(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/load"; kwargs...)
end

"""
    release_partitions(client::MilvusClient; kwargs...) -> Dict

Release partition data from memory.

**POST** `/v2/vectordb/partitions/release`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `partitionNames::Vector{String}` **(required)**: Names of the partitions to release.
"""
function release_partitions(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/release"; kwargs...)
end

"""
    get_partition_stats(client::MilvusClient; kwargs...) -> Dict

Get the number of entities in a partition.

**POST** `/v2/vectordb/partitions/get_stats`

# Keyword Arguments
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of an existing collection.
- `partitionName::String` **(required)**: Name of the partition.
"""
function get_partition_stats(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/partitions/get_stats"; kwargs...)
end
