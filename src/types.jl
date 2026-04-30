# =============================================================================
# Milvus.jl - Type Definitions
# =============================================================================

"""
    MilvusException

Exception type for Milvus API errors.
"""
struct MilvusException <: Exception
    code::Int
    message::String
end

Base.showerror(io::IO, e::MilvusException) = print(io, "MilvusException($(e.code)): $(e.message)")

"""
    Optional{T}

Alias for optional values.
"""
const Optional{T} = Union{Nothing,T}

"""
    AbstractMilvusType

Root type for Milvus models.
"""
abstract type AbstractMilvusType end

"""
    AbstractMilvusData <: AbstractMilvusType

Typed data payload returned by Milvus APIs.
"""
abstract type AbstractMilvusData <: AbstractMilvusType end

"""
    MilvusObject <: AbstractMilvusData

Dictionary-like payload wrapper.
"""
StructUtils.@kwarg struct MilvusObject <: AbstractMilvusData
    values::Dict{String,Any}
end

"""
    MilvusList <: AbstractMilvusData

Array-like payload wrapper.
"""
StructUtils.@kwarg struct MilvusList <: AbstractMilvusData
    items::Vector{Any}
end

"""
    MilvusScalar{T} <: AbstractMilvusData

Scalar payload wrapper.
"""
StructUtils.@kwarg struct MilvusScalar{T} <: AbstractMilvusData
    value::T
end

StructUtils.lower(v::MilvusObject) = v.values
StructUtils.lower(v::MilvusList) = v.items
StructUtils.lower(v::MilvusScalar) = v.value

"""
    MilvusResponse{T}

Generic wrapper for Milvus API responses.
"""
struct MilvusResponse{T}
    code::Int
    data::T
    message::String
end

"""
    asdict(data::MilvusObject) -> Dict{String,Any}

Extract wrapped object data from a response payload.
"""
asdict(data::MilvusObject) = data.values

"""
    aslist(data::MilvusList) -> Vector{Any}

Extract wrapped list data from a response payload.
"""
aslist(data::MilvusList) = data.items

"""
    asvalue(data::MilvusScalar) -> Any

Extract wrapped scalar data from a response payload.
"""
asvalue(data::MilvusScalar) = data.value

"""
    MilvusClient

HTTP client for interacting with a Milvus database via the REST API v2.

# Fields
- `host::String`: Base URL of the Milvus instance (e.g., `"http://localhost:19530"`)
- `token::String`: Authentication token (`"username:password"` or API key)
- `headers::Dict{String,String}`: HTTP headers sent with every request
- `connect_timeout::Int`: Connection timeout in seconds (default: 30)
- `read_timeout::Int`: Read timeout in seconds (default: 60)
- `retries::Int`: Number of retry attempts for transient failures (default: 3)
- `retry_delay::Float64`: Base delay in seconds between retries (default: 0.5)
- `verbose::Bool`: Enable debug logging of requests/responses (default: false)
"""
mutable struct MilvusClient
    host::String
    token::String
    headers::Dict{String,String}
    connect_timeout::Int
    read_timeout::Int
    retries::Int
    retry_delay::Float64
    verbose::Bool
end

"""
    MilvusClient(; host="http://localhost:19530", token="", kwargs...)

Create a new MilvusClient with the given configuration.
"""
function MilvusClient(;
    host::String="http://localhost:19530",
    token::String="",
    connect_timeout::Int=30,
    read_timeout::Int=60,
    retries::Int=3,
    retry_delay::Float64=0.5,
    verbose::Bool=false
)
    headers = Dict{String,String}(
        "accept" => "application/json",
        "content-type" => "application/json"
    )
    if !isempty(token)
        headers["Authorization"] = "Bearer $token"
    end
    return MilvusClient(host, token, headers, connect_timeout, read_timeout, retries, retry_delay, verbose)
end

# =============================================================================
# Enums for common Milvus types
# =============================================================================

"""
    ConsistencyLevel

Consistency levels supported by Milvus.
"""
@enum ConsistencyLevel begin
    Strong
    Bounded
    Eventually
    Session
    Custom
end

"""
    IndexMetricType

Metric types for vector similarity search.
"""
@enum IndexMetricType begin
    L2
    IP
    COSINE
    HAMMING
    JACCARD
end

"""
    IndexType

Supported index types in Milvus.
"""
@enum IndexType begin
    FLAT
    IVF_FLAT
    IVF_SQ8
    IVF_PQ
    HNSW
    DISKANN
    AUTOINDEX
    GPU_IVF_FLAT
    GPU_IVF_PQ
    BIN_FLAT
    BIN_IVF_FLAT
    SCANN
end

"""
    DataType

Supported field data types in Milvus.
"""
@enum DataType begin
    MilvusBool
    MilvusInt8
    MilvusInt16
    MilvusInt32
    MilvusInt64
    MilvusFloat
    MilvusDouble
    MilvusVarChar
    MilvusArray
    MilvusJSON
    MilvusBinaryVector
    MilvusFloatVector
    MilvusFloat16Vector
end

# =============================================================================
# Helper functions
# =============================================================================

"""
    consistency_level_string(level::ConsistencyLevel) -> String

Convert a ConsistencyLevel enum to its Milvus API string representation.
"""
function consistency_level_string(level::ConsistencyLevel)::String
    return string(level)
end

"""
    metric_type_string(mt::IndexMetricType) -> String

Convert an IndexMetricType enum to its Milvus API string representation.
"""
function metric_type_string(mt::IndexMetricType)::String
    return string(mt)
end

"""
    index_type_string(it::IndexType) -> String

Convert an IndexType enum to its Milvus API string representation.
"""
function index_type_string(it::IndexType)::String
    return string(it)
end

"""
    data_type_string(dt::DataType) -> String

Convert a DataType enum to its Milvus API string representation.
"""
function data_type_string(dt::DataType)::String
    if dt == MilvusBool
        return "Bool"
    elseif dt == MilvusInt8
        return "Int8"
    elseif dt == MilvusInt16
        return "Int16"
    elseif dt == MilvusInt32
        return "Int32"
    elseif dt == MilvusInt64
        return "Int64"
    elseif dt == MilvusFloat
        return "Float"
    elseif dt == MilvusDouble
        return "Double"
    elseif dt == MilvusVarChar
        return "VarChar"
    elseif dt == MilvusArray
        return "Array"
    elseif dt == MilvusJSON
        return "JSON"
    elseif dt == MilvusBinaryVector
        return "BinaryVector"
    elseif dt == MilvusFloatVector
        return "FloatVector"
    elseif dt == MilvusFloat16Vector
        return "Float16Vector"
    end

    throw(ArgumentError("Unsupported data type enum value: $dt"))
end
