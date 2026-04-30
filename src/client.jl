# =============================================================================
# Milvus.jl - HTTP Client Core
# =============================================================================

using HTTP
using JSON

const _JSON_KW = (omit_null=true, omit_empty=true)

serialize_body(x) = JSON.json(x; _JSON_KW...)

"""
    _build_url(client::MilvusClient, path::String) -> String

Build the full URL for a Milvus API request.
"""
function _build_url(client::MilvusClient, path::String)::String
    base = strip(client.host, '/')
    path = "/" * strip(path, '/')
    return "$base$path"
end

"""
    _log(client::MilvusClient, msg::String)

Log a message if verbose mode is enabled.
"""
function _log(client::MilvusClient, msg::String)
    if client.verbose
        println("[Milvus] $msg")
    end
end

"""
    _parse_response(response::HTTP.Response) -> Dict

Parse an HTTP response into a Julia Dict, handling errors.
"""
function _parse_response(response::HTTP.Response)::Any
    if isempty(response.body)
        return Dict{String,Any}()
    end

    body_str = String(response.body)
    if isempty(strip(body_str))
        return Dict{String,Any}()
    end

    try
        return JSON.parse(body_str)
    catch
        # Preserve non-JSON response bodies for diagnostics.
        return Dict{String,Any}("raw" => body_str)
    end
end

"""
    _check_error(data::Dict)

Check if the response contains an error and throw MilvusException if so.
"""
function _check_error(data::AbstractDict{String,Any})
    code = try
        Int(get(data, "code", 0))
    catch
        0
    end

    if code != 0
        msg = string(get(data, "message", get(data, "msg", "Unknown error")))
        throw(MilvusException(code, msg))
    end

    return nothing
end

function _to_milvus_data(data::Any)::AbstractMilvusData
    if data isa AbstractDict
        normalized = Dict{String,Any}(string(k) => v for (k, v) in data)
        return MilvusObject(values=normalized)
    elseif data isa AbstractVector
        return MilvusList(items=collect(data))
    else
        return MilvusScalar(value=data)
    end
end

function _to_milvus_response(data::Any)::MilvusResponse{<:AbstractMilvusData}
    if data isa AbstractDict
        normalized = Dict{String,Any}(string(k) => v for (k, v) in data)
        code = try
            Int(get(normalized, "code", 0))
        catch
            0
        end
        message = string(get(normalized, "message", get(normalized, "msg", "")))
        payload = _to_milvus_data(get(normalized, "data", Dict{String,Any}()))
        return MilvusResponse(code, payload, message)
    end

    return MilvusResponse(0, _to_milvus_data(data), "")
end

"""
    _normalize_body(body::AbstractDict) -> Dict{String,Any}

Normalize body dictionaries so all keys are strings.
"""
function _normalize_body(body::AbstractDict)::Dict{String,Any}
    normalized = Dict{String,Any}()
    for (k, v) in body
        normalized[string(k)] = v
    end
    return normalized
end

"""
    _retry_delay_seconds(client::MilvusClient, attempt::Int) -> Float64

Compute exponential backoff delay for retries.
"""
function _retry_delay_seconds(client::MilvusClient, attempt::Int)::Float64
    return client.retry_delay * (2.0^(attempt - 1))
end

"""
    _is_retryable_status(status::Int) -> Bool

Returns true for transient HTTP statuses that should be retried.
"""
function _is_retryable_status(status::Integer)::Bool
    s = Int(status)
    return s == 429 || s >= 500
end

"""
    _is_retryable_exception(e::Exception) -> Bool

Returns true for transport-level errors that should be retried.
"""
function _is_retryable_exception(e::Exception)::Bool
    return e isa HTTP.Exceptions.ConnectError ||
           e isa HTTP.Exceptions.TimeoutError ||
           e isa HTTP.Exceptions.RequestError ||
           e isa Base.IOError ||
           e isa EOFError
end

"""
    _check_http_status(response::HTTP.Response, data::AbstractDict{String,Any})

Validate HTTP status code and raise MilvusException for non-2xx responses.
"""
function _check_http_status(response::HTTP.Response, data::Any)
    status = response.status
    if 200 <= status < 300
        return nothing
    end

    default_msg = "HTTP request failed with status $status"
    msg = if data isa AbstractDict
        normalized = Dict{String,Any}(string(k) => v for (k, v) in data)
        string(get(normalized, "message", get(normalized, "msg", get(normalized, "raw", default_msg))))
    else
        default_msg
    end
    throw(MilvusException(status, msg))
end

"""
    _request(client::MilvusClient, method::String, path::String, body::Dict{String,Any}) -> Dict{String,Any}

Make an HTTP request to the Milvus API with retry logic.

# Arguments
- `client::MilvusClient`: The Milvus client.
- `method::String`: HTTP method (e.g., "POST").
- `path::String`: API endpoint path (e.g., "/v2/vectordb/collections/list").
- `body::Dict`: Request body as a Julia Dict (will be JSON-encoded).

# Returns
- Parsed response data as a Dict.
"""
function _request(client::MilvusClient, method::String, path::String, body::Any)::MilvusResponse{<:AbstractMilvusData}
    url = _build_url(client, path)
    json_body = body === nothing ? "{}" : serialize_body(body)

    _log(client, "$method $url")
    client.verbose && _log(client, "Body: $json_body")

    last_error::Union{Nothing,Exception} = nothing

    for attempt in 1:(client.retries + 1)
        try
            response = HTTP.request(
                method,
                url,
                client.headers;
                body=json_body,
                connect_timeout=client.connect_timeout,
                read_timeout=client.read_timeout,
                retry=false,
                status_exception=false,
                verbose=0
            )

            data = _parse_response(response)

            if _is_retryable_status(response.status)
                msg = "HTTP $(response.status)"
                last_error = MilvusException(response.status, msg)
                _log(client, "Attempt $attempt failed: $msg")

                if attempt <= client.retries
                    sleep(_retry_delay_seconds(client, attempt))
                    continue
                end
            end

            _check_http_status(response, data)

            if data isa AbstractDict
                normalized = Dict{String,Any}(string(k) => v for (k, v) in data)
                _check_error(normalized)
            end

            return _to_milvus_response(data)

        catch e
            if e isa InterruptException
                rethrow()
            end

            last_error = e isa Exception ? e : ErrorException(string(e))
            _log(client, "Attempt $attempt failed: $(typeof(e)): $e")

            if attempt <= client.retries && _is_retryable_exception(last_error)
                sleep(_retry_delay_seconds(client, attempt))
                continue
            end

            rethrow(e)
        end
    end

    throw(last_error === nothing ? ErrorException("Milvus request failed without an exception") : last_error)
end

"""
    request(client::MilvusClient, method::String, path::String, body::Any) -> MilvusResponse

Make an HTTP request with an explicit body.
"""
function request(client::MilvusClient, method::String, path::String, body::Any)::MilvusResponse{<:AbstractMilvusData}
    normalized_body = body isa AbstractDict ? _normalize_body(body) : body
    return _request(client, method, path, normalized_body)
end

"""
    request(client::MilvusClient, method::String, path::String; kwargs...) -> Dict

Make an HTTP request with keyword arguments as the body.
"""
function request(client::MilvusClient, method::String, path::String; body::Any=Dict{String,Any}(), kwargs...)
    base_body = body isa AbstractDict ? _normalize_body(body) : body
    request_body = if isempty(kwargs)
        base_body
    elseif base_body isa AbstractDict
        _build_body(base_body; kwargs...)
    else
        _build_body(; kwargs...)
    end
    return _request(client, method, path, request_body)
end

"""
    _build_body(; kwargs...) -> Dict{String,Any}

Build a request body from keyword arguments, filtering out `nothing` values.
"""
function _build_body(; kwargs...)::Dict{String,Any}
    body = Dict{String,Any}()
    for (k, v) in kwargs
        if v !== nothing
            body[string(k)] = v
        end
    end
    return body
end

"""
    _build_body(body::Dict; kwargs...) -> Dict{String,Any}

Merge a base body dict with keyword arguments.
"""
function _build_body(body::AbstractDict; kwargs...)::Dict{String,Any}
    result = _normalize_body(body)
    for (k, v) in kwargs
        if v !== nothing
            result[string(k)] = v
        end
    end
    return result
end
