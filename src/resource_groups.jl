# =============================================================================
# Milvus.jl - Resource Group Operations (V2)
# =============================================================================

"""
    create_resource_group(client::MilvusClient; kwargs...) -> Dict

Create a resource group.

**POST** `/v2/vectordb/resource_groups/create`

# Keyword Arguments
- `name::String` **(required)**: Name of the resource group.
- `config::Dict`: Configuration of the resource group.
  - `requests::Dict`: Number of query nodes to allocate.
  - `limits::Dict`: Maximum number of query nodes.
  - `transfer_from::Vector{Dict}`: Source resource groups.
  - `transfer_to::Vector{Dict}`: Target resource groups.
"""
function create_resource_group(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/resource_groups/create"; kwargs...)
end

"""
    describe_resource_group(client::MilvusClient; kwargs...) -> Dict

Describe the configuration of a specified resource group.

**POST** `/v2/vectordb/resource_groups/describe`

# Keyword Arguments
- `name::String`: Name of the resource group to describe.
"""
function describe_resource_group(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/resource_groups/describe"; kwargs...)
end

"""
    list_resource_groups(client::MilvusClient; kwargs...) -> Dict

List all resource group names.

**POST** `/v2/vectordb/resource_groups/list`
"""
function list_resource_groups(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/resource_groups/list"; kwargs...)
end

"""
    drop_resource_group(client::MilvusClient; kwargs...) -> Dict

Drop a specified resource group.

**POST** `/v2/vectordb/resource_groups/drop`

# Keyword Arguments
- `name::String`: Name of the resource group to drop.
"""
function drop_resource_group(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/resource_groups/drop"; kwargs...)
end

"""
    update_resource_group(client::MilvusClient; kwargs...) -> Dict

Update the configuration of a specified resource group.

**POST** `/v2/vectordb/resource_groups/alter`

# Keyword Arguments
- `resource_groups::Dict` **(required)**: Configurations of resource groups to update.
  Keys are resource group names, values are their configurations.
"""
function update_resource_group(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/resource_groups/alter"; kwargs...)
end

"""
    transfer_replica(client::MilvusClient; kwargs...) -> Dict

Transfer replicas of a collection from one resource group to another.

**POST** `/v2/vectordb/resource_groups/transfer_replica`

# Keyword Arguments
- `sourceRgName::String`: Name of the source resource group.
- `targetRgName::String`: Name of the target resource group.
- `collectionName::String`: Name of the target collection.
- `replicaNum::Int`: Number of replicas to transfer.
"""
function transfer_replica(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/resource_groups/transfer_replica"; kwargs...)
end
