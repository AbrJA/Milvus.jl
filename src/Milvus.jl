# =============================================================================
# Milvus.jl - Julia Client for Milvus Vector Database (REST API v2)
# =============================================================================

module Milvus

using HTTP
using JSON
using StructUtils

# =============================================================================
# Exports - Types
# =============================================================================
export MilvusClient, MilvusException, MilvusResponse
export AbstractMilvusType, AbstractMilvusData
export MilvusObject, MilvusList, MilvusScalar
export ConsistencyLevel, IndexMetricType, IndexType, DataType
export Strong, Bounded, Eventually, Session, Custom
export L2, IP, COSINE, HAMMING, JACCARD
export FLAT, IVF_FLAT, IVF_SQ8, IVF_PQ, HNSW, DISKANN, AUTOINDEX
export GPU_IVF_FLAT, GPU_IVF_PQ, BIN_FLAT, BIN_IVF_FLAT, SCANN
export MilvusBool, MilvusInt8, MilvusInt16, MilvusInt32, MilvusInt64
export MilvusFloat, MilvusDouble, MilvusVarChar, MilvusArray, MilvusJSON
export MilvusBinaryVector, MilvusFloatVector, MilvusFloat16Vector
export consistency_level_string, metric_type_string, index_type_string, data_type_string
export asdict, aslist, asvalue

# =============================================================================
# Exports - Core
# =============================================================================
export request

# =============================================================================
# Exports - Collection Operations
# =============================================================================
export create_collection, describe_collection, list_collections
export drop_collection, rename_collection, has_collection
export get_collection_stats, get_load_state
export load_collection, release_collection
export flush_collection, compact_collection, refresh_load
export alter_collection_properties, drop_collection_properties
export add_collection_field, alter_field_properties

# =============================================================================
# Exports - Vector/Entity Operations
# =============================================================================
export insert, upsert, delete_entities, get_entities
export query, search, hybrid_search

# =============================================================================
# Exports - Partition Operations
# =============================================================================
export create_partition, drop_partition, has_partition
export list_partitions, load_partitions, release_partitions
export get_partition_stats

# =============================================================================
# Exports - Index Operations
# =============================================================================
export create_index, describe_index, list_indexes
export drop_index, alter_index_properties, drop_index_properties

# =============================================================================
# Exports - Database Operations
# =============================================================================
export create_database, describe_database, list_databases
export drop_database, alter_database_properties, drop_database_properties

# =============================================================================
# Exports - Alias Operations
# =============================================================================
export create_alias, alter_alias, describe_alias
export list_aliases, drop_alias

# =============================================================================
# Exports - Role Operations
# =============================================================================
export create_role, describe_role, drop_role, list_roles
export grant_privilege, revoke_privilege

# =============================================================================
# Exports - User Operations
# =============================================================================
export create_user, describe_user, drop_user, list_users
export update_password, grant_role, revoke_role

# =============================================================================
# Exports - Resource Group Operations
# =============================================================================
export create_resource_group, describe_resource_group
export list_resource_groups, drop_resource_group
export update_resource_group, transfer_replica

# =============================================================================
# Exports - Import Operations
# =============================================================================
export create_import_job, get_import_progress, list_import_jobs

# =============================================================================
# Include source files
# =============================================================================
include("types.jl")
include("client.jl")
include("collections.jl")
include("vectors.jl")
include("partitions.jl")
include("indexes.jl")
include("databases.jl")
include("aliases.jl")
include("roles.jl")
include("users.jl")
include("resource_groups.jl")
include("import.jl")

end # module Milvus
