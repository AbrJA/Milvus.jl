# =============================================================================
# Milvus.jl - User Operations (V2)
# =============================================================================

"""
    create_user(client::MilvusClient; kwargs...) -> Dict

Create a new user with a corresponding password.

**POST** `/v2/vectordb/users/create`

# Keyword Arguments
- `userName::String`: Name of the target user.
- `password::String`: Corresponding password.
"""
function create_user(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/create"; kwargs...)
end

"""
    describe_user(client::MilvusClient; kwargs...) -> Dict

Describe the detailed information of a specific user.

**POST** `/v2/vectordb/users/describe`

# Keyword Arguments
- `userName::String` **(required)**: Name of the target user.
"""
function describe_user(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/describe"; kwargs...)
end

"""
    drop_user(client::MilvusClient; kwargs...) -> Dict

Delete an existing user.

**POST** `/v2/vectordb/users/drop`

# Keyword Arguments
- `userName::String` **(required)**: Name of the target user.
"""
function drop_user(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/drop"; kwargs...)
end

"""
    list_users(client::MilvusClient; kwargs...) -> Dict

List information of all existing users.

**POST** `/v2/vectordb/users/list`
"""
function list_users(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/list"; kwargs...)
end

"""
    update_password(client::MilvusClient; kwargs...) -> Dict

Update the password for a specific user.

**POST** `/v2/vectordb/users/update_password`

# Keyword Arguments
- `userName::String` **(required)**: Name of the target user.
- `password::String` **(required)**: Current password.
- `newPassword::String` **(required)**: New password.
"""
function update_password(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/update_password"; kwargs...)
end

"""
    grant_role(client::MilvusClient; kwargs...) -> Dict

Grant a specified role to a user.

**POST** `/v2/vectordb/users/grant_role`

# Keyword Arguments
- `userName::String` **(required)**: Name of the target user.
- `roleName::String` **(required)**: Name of the target role.
"""
function grant_role(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/grant_role"; kwargs...)
end

"""
    revoke_role(client::MilvusClient; kwargs...) -> Dict

Revoke a role from a user.

**POST** `/v2/vectordb/users/revoke_role`

# Keyword Arguments
- `userName::String` **(required)**: Name of the target user.
- `roleName::String` **(required)**: Name of the target role.
"""
function revoke_role(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/users/revoke_role"; kwargs...)
end
