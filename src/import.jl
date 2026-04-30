# =============================================================================
# Milvus.jl - Import Operations (V2)
# =============================================================================

"""
    create_import_job(client::MilvusClient; kwargs...) -> Dict

Import prepared data files to a Milvus instance/Zilliz Cloud cluster.

**POST** `/v2/vectordb/jobs/import/create`

# Keyword Arguments
- `clusterId::String` **(required)**: ID of the cluster.
- `dbName::String`: Name of the database.
- `collectionName::String` **(required)**: Name of the target collection.
- `partitionName::String`: Name of the target partition.
- `files::Vector{String}`: Files containing data to import.
- `options::Dict`: Bulk-import options (e.g., `timeout`).
- `objectUrl::String`: URL of the object to import.
- `objectUrls::Vector{String}` **(required)**: URLs of objects to import.
- `accessKey::String`: Access key for object storage.
- `secretKey::String`: Secret key for object storage.
- `token::String`: Temporary token for object storage access.
"""
function create_import_job(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/jobs/import/create"; kwargs...)
end

"""
    get_import_progress(client::MilvusClient; kwargs...) -> Dict

Get the progress of a specified bulk-import job.

**POST** `/v2/vectordb/jobs/import/describe`

# Keyword Arguments
- `clusterId::String`: ID of the cluster.
- `dbName::String`: Name of the database.
- `jobId::String` **(required)**: ID of the bulk-import job.
"""
function get_import_progress(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/jobs/import/describe"; kwargs...)
end

"""
    list_import_jobs(client::MilvusClient; kwargs...) -> Dict

List all import jobs of a specific cluster.

**POST** `/v2/vectordb/jobs/import/list`

# Keyword Arguments
- `clusterId::String` **(required)**: ID of the cluster.
- `pageSize::Int`: Number of records per page.
- `currentPage::Int`: Current page number.
- `dbName::String`: Name of the database.
"""
function list_import_jobs(client::MilvusClient; kwargs...)
    return request(client, "POST", "/v2/vectordb/jobs/import/list"; kwargs...)
end
