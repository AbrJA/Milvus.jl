# =============================================================================
# Milvus.jl - Role Operations (V2)
# =============================================================================

"""
    create_role(client::MilvusClient; kwargs...) -> Dict

Create a role.

**POST** `/v2/vectordb/roles/create`

# Keyword Arguments
- `roleName::String` **(required)**: Name of the role.
"""
function create_role(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/roles/create"; kwargs...)
end

"""
    describe_role(client::MilvusClient; kwargs...) -> Dict

Describe the details of a specified role.

**POST** `/v2/vectordb/roles/describe`

# Keyword Arguments
- `roleName::String` **(required)**: Name of the role.
"""
function describe_role(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/roles/describe"; kwargs...)
end

"""
    drop_role(client::MilvusClient; kwargs...) -> Dict

Drop an existing role.

**POST** `/v2/vectordb/roles/drop`

# Keyword Arguments
- `roleName::String` **(required)**: Name of the role to drop.
"""
function drop_role(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/roles/drop"; kwargs...)
end

"""
    list_roles(client::MilvusClient; kwargs...) -> Dict

List information about all existing roles.

**POST** `/v2/vectordb/roles/list`
"""
function list_roles(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/roles/list"; kwargs...)
end

"""
    grant_privilege(client::MilvusClient; kwargs...) -> Dict

Grant a privilege to a role.

**POST** `/v2/vectordb/roles/grant_privilege`

# Keyword Arguments
- `roleName::String` **(required)**: Name of the role.
- `objectType::String` **(required)**: Type of the object.
- `objectName::String` **(required)**: Name of the object.
- `privilege::String` **(required)**: The privilege to grant.
"""
function grant_privilege(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/roles/grant_privilege"; kwargs...)
end

"""
    revoke_privilege(client::MilvusClient; kwargs...) -> Dict

Revoke a privilege from a role.

**POST** `/v2/vectordb/roles/revoke_privilege`

# Keyword Arguments
- `roleName::String` **(required)**: Name of the role.
- `objectType::String` **(required)**: Type of the object.
- `objectName::String` **(required)**: Name of the object.
- `privilege::String` **(required)**: The privilege to revoke.
"""
function revoke_privilege(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/roles/revoke_privilege"; kwargs...)
end
