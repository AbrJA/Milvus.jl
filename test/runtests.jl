# =============================================================================
# Milvus.jl - Test Suite
# =============================================================================

using Test
using Milvus
using HTTP
using JSON
using Sockets

_payload_dict(resp::MilvusResponse) = begin
    @test resp.data isa MilvusObject
    asdict(resp.data)
end

function _get_free_port()::Int
    sock = listen(ip"127.0.0.1", 0)
    addr = getsockname(sock)
    port = Int(addr[2])
    close(sock)
    return port
end

function _start_mock_server()
    seen_paths = String[]
    lock_ = ReentrantLock()
    port = _get_free_port()

    server = HTTP.serve!(ip"127.0.0.1", port; verbose=false) do req::HTTP.Request
        body_str = String(req.body)
        parsed_body = if isempty(strip(body_str))
            Dict{String,Any}()
        else
            try
                JSON.parse(body_str)
            catch
                Dict{String,Any}("raw" => body_str)
            end
        end

        path = String(req.target)
        lock(lock_) do
            push!(seen_paths, path)
        end

        payload = Dict{String,Any}(
            "path" => path,
            "method" => String(req.method),
            "body" => parsed_body,
        )
        response = Dict{String,Any}("code" => 0, "data" => payload, "message" => "ok")

        return HTTP.Response(200, ["Content-Type" => "application/json"], JSON.json(response))
    end

    return server, port, seen_paths, lock_
end

function _read_file_text(path::String)::String
    open(path, "r") do io
        return read(io, String)
    end
end

function _doc_post_endpoints()::Set{String}
    root = normpath(joinpath(@__DIR__, "..", "docs", "api", "v2"))
    endpoints = Set{String}()

    for (dir, _, files) in walkdir(root)
        for f in files
            endswith(f, ".md") || continue
            path = joinpath(dir, f)
            text = _read_file_text(path)
            for m in eachmatch(r"\*\*POST\*\*\s+`([^`]+)`", text)
                push!(endpoints, m.captures[1])
            end
        end
    end

    return endpoints
end

function _src_post_endpoints()::Set{String}
    root = normpath(joinpath(@__DIR__, "..", "src"))
    endpoints = Set{String}()

    for (dir, _, files) in walkdir(root)
        for f in files
            endswith(f, ".jl") || continue
            path = joinpath(dir, f)
            text = _read_file_text(path)
            pattern = Regex("request\\(client,\\s*\\\"POST\\\",\\s*\\\"(/v2/[^\\\"]+)\\\"")
            for m in eachmatch(pattern, text)
                push!(endpoints, m.captures[1])
            end
        end
    end

    return endpoints
end

function _missing_and_extra_doc_paths()
    doc_paths = _doc_post_endpoints()
    src_paths = _src_post_endpoints()
    missing_in_src = setdiff(doc_paths, src_paths)
    extra_in_src = setdiff(src_paths, doc_paths)
    return doc_paths, src_paths, missing_in_src, extra_in_src
end

# =============================================================================
# Test: Client Construction
# =============================================================================
@testset "MilvusClient" begin
    # Test default client
    client = MilvusClient()
    @test client.host == "http://localhost:19530"
    @test client.token == ""
    @test client.headers["accept"] == "application/json"
    @test client.headers["content-type"] == "application/json"
    @test !haskey(client.headers, "Authorization")

    # Test client with token
    client2 = MilvusClient(token="root:milvus")
    @test client2.token == "root:milvus"
    @test client2.headers["Authorization"] == "Bearer root:milvus"

    # Test client with custom host
    client3 = MilvusClient(host="https://my-milvus.cloud:19530", token="api-key-123")
    @test client3.host == "https://my-milvus.cloud:19530"
    @test client3.token == "api-key-123"

    # Test custom timeouts
    client4 = MilvusClient(connect_timeout=10, read_timeout=30, retries=5, verbose=true)
    @test client4.connect_timeout == 10
    @test client4.read_timeout == 30
    @test client4.retries == 5
    @test client4.verbose == true
end

# =============================================================================
# Test: Type Conversions
# =============================================================================
@testset "Type Conversions" begin
    @test consistency_level_string(Milvus.Strong) == "Strong"
    @test consistency_level_string(Milvus.Bounded) == "Bounded"
    @test consistency_level_string(Milvus.Eventually) == "Eventually"

    @test metric_type_string(Milvus.L2) == "L2"
    @test metric_type_string(Milvus.IP) == "IP"
    @test metric_type_string(Milvus.COSINE) == "COSINE"

    @test index_type_string(Milvus.HNSW) == "HNSW"
    @test index_type_string(Milvus.FLAT) == "FLAT"
    @test index_type_string(Milvus.AUTOINDEX) == "AUTOINDEX"

    @test data_type_string(Milvus.MilvusInt64) == "Int64"
    @test data_type_string(Milvus.MilvusVarChar) == "VarChar"
    @test data_type_string(Milvus.MilvusFloatVector) == "FloatVector"
    @test data_type_string(Milvus.MilvusBinaryVector) == "BinaryVector"
end

# =============================================================================
# Test: MilvusException
# =============================================================================
@testset "MilvusException" begin
    e = MilvusException(1, "Test error")
    @test e.code == 1
    @test e.message == "Test error"
    @test sprint(showerror, e) == "MilvusException(1): Test error"
end

# =============================================================================
# Test: Request Body Building
# =============================================================================
@testset "Request Body Building" begin
    # Test _build_body with kwargs
    body = Milvus._build_body(collectionName="test", dbName="_default", limit=nothing)
    @test body["collectionName"] == "test"
    @test body["dbName"] == "_default"
    @test !haskey(body, "limit")

    # Test _build_body with base dict + kwargs
    base = Dict{String,Any}("collectionName" => "test")
    merged = Milvus._build_body(base; dbName="_default", limit=10)
    @test merged["collectionName"] == "test"
    @test merged["dbName"] == "_default"
    @test merged["limit"] == 10
end

# =============================================================================
# Test: URL Building
# =============================================================================
@testset "URL Building" begin
    client = MilvusClient()
    url = Milvus._build_url(client, "/v2/vectordb/collections/list")
    @test url == "http://localhost:19530/v2/vectordb/collections/list"

    client2 = MilvusClient(host="https://milvus.cloud:19530/")
    url2 = Milvus._build_url(client2, "v2/vectordb/collections/create")
    @test url2 == "https://milvus.cloud:19530/v2/vectordb/collections/create"
end

# =============================================================================
# Test: Response Parsing
# =============================================================================
@testset "Response Parsing" begin
    # Test empty body
    empty_response = HTTP.Response(200, [], UInt8[])
    result = Milvus._parse_response(empty_response)
    @test result == Dict{String,Any}()

    # Test JSON body
    json_response = HTTP.Response(200, [], Vector{UInt8}(codeunits("{\"code\": 0, \"data\": {\"rowCount\": 100}}")))
    result = Milvus._parse_response(json_response)
    @test result["code"] == 0
    @test result["data"]["rowCount"] == 100

    # Test non-JSON body fallback for diagnostics
    text_response = HTTP.Response(502, [], Vector{UInt8}(codeunits("upstream unavailable")))
    result = Milvus._parse_response(text_response)
    @test result["raw"] == "upstream unavailable"
end

# =============================================================================
# Test: Error Checking
# =============================================================================
@testset "Error Checking" begin
    # Test success response
    success_data = Dict{String,Any}("code" => 0, "data" => Dict{String,Any}())
    @test Milvus._check_error(success_data) === nothing

    # Test error response
    error_data = Dict{String,Any}("code" => 1, "message" => "Collection not found")
    @test_throws MilvusException Milvus._check_error(error_data)

    # Test error without message
    error_data2 = Dict{String,Any}("code" => 65535)
    @test_throws MilvusException Milvus._check_error(error_data2)

    # Test alternate message key used by some API responses
    error_data3 = Dict{String,Any}("code" => 2, "msg" => "bad request")
    ex = try
        Milvus._check_error(error_data3)
        nothing
    catch err
        err
    end
    @test ex isa MilvusException
    @test ex.code == 2
    @test ex.message == "bad request"
end

# =============================================================================
# Test: Endpoint Parity (docs/api/v2 vs src)
# =============================================================================
@testset "Endpoint Parity" begin
    doc_paths, src_paths, missing_in_src, extra_in_src = _missing_and_extra_doc_paths()

    @test length(doc_paths) > 0
    @test length(src_paths) > 0
    @test isempty(missing_in_src)
    @test isempty(extra_in_src)
end

# =============================================================================
# Test: Endpoint Coverage via Mock Server
# =============================================================================
@testset "Endpoint Coverage (Mock Server)" begin
    server, port, seen_paths, seen_lock = _start_mock_server()
    sleep(0.05)

    endpoint_cases = [
        (:create_collection, "/v2/vectordb/collections/create", (collectionName="books", dimension=4, metricType="IP", autoID=true)),
        (:describe_collection, "/v2/vectordb/collections/describe", (collectionName="books",)),
        (:list_collections, "/v2/vectordb/collections/list", (;)),
        (:drop_collection, "/v2/vectordb/collections/drop", (collectionName="books",)),
        (:rename_collection, "/v2/vectordb/collections/rename", (collectionName="books", newCollectionName="books2")),
        (:has_collection, "/v2/vectordb/collections/has", (collectionName="books",)),
        (:get_collection_stats, "/v2/vectordb/collections/get_stats", (collectionName="books",)),
        (:get_load_state, "/v2/vectordb/collections/get_load_state", (collectionName="books",)),
        (:load_collection, "/v2/vectordb/collections/load", (collectionName="books",)),
        (:release_collection, "/v2/vectordb/collections/release", (collectionName="books",)),
        (:flush_collection, "/v2/vectordb/collections/flush", (collectionName="books",)),
        (:compact_collection, "/v2/vectordb/collections/compact", (collectionName="books",)),
        (:refresh_load, "/v2/vectordb/collections/refresh_load", (collectionName="books",)),
        (:alter_collection_properties, "/v2/vectordb/collections/alter_properties", (collectionName="books", properties=Dict("mmap.enabled" => true))),
        (:drop_collection_properties, "/v2/vectordb/collections/drop_properties", (collectionName="books", propertyKeys=["mmap.enabled"])),
        (:add_collection_field, "/v2/vectordb/collections/fields/add", (collectionName="books", schema=Dict("fieldName" => "score", "dataType" => "Double"))),
        (:alter_field_properties, "/v2/vectordb/collections/fields/alter_properties", (collectionName="books", fieldName="title", fieldParams=Dict("max_length" => 512))),

        (:insert, "/v2/vectordb/entities/insert", (collectionName="books", data=[Dict("vector" => [0.1, 0.2, 0.3, 0.4])])),
        (:upsert, "/v2/vectordb/entities/upsert", (collectionName="books", data=[Dict("id" => 1, "vector" => [0.1, 0.2, 0.3, 0.4])])),
        (:delete_entities, "/v2/vectordb/entities/delete", (collectionName="books", filter="id > 0")),
        (:get_entities, "/v2/vectordb/entities/get", (collectionName="books", id=[1, 2])),
        (:query, "/v2/vectordb/entities/query", (collectionName="books", filter="id > 0")),
        (:search, "/v2/vectordb/entities/search", (collectionName="books", data=[[0.1, 0.2, 0.3, 0.4]], annsField="vector", limit=5)),
        (:hybrid_search, "/v2/vectordb/entities/hybrid_search", (collectionName="books", search=[Dict("data" => [[0.1, 0.2, 0.3, 0.4]], "annsField" => "vector")], limit=5)),

        (:create_partition, "/v2/vectordb/partitions/create", (collectionName="books", partitionName="p1")),
        (:drop_partition, "/v2/vectordb/partitions/drop", (collectionName="books", partitionName="p1")),
        (:has_partition, "/v2/vectordb/partitions/has", (collectionName="books", partitionName="p1")),
        (:list_partitions, "/v2/vectordb/partitions/list", (collectionName="books",)),
        (:load_partitions, "/v2/vectordb/partitions/load", (collectionName="books", partitionNames=["p1"])),
        (:release_partitions, "/v2/vectordb/partitions/release", (collectionName="books", partitionNames=["p1"])),
        (:get_partition_stats, "/v2/vectordb/partitions/get_stats", (collectionName="books", partitionName="p1")),

        (:create_index, "/v2/vectordb/indexes/create", (collectionName="books", indexParams=[Dict("fieldName" => "vector", "indexName" => "idx", "metricType" => "IP", "params" => Dict())])),
        (:describe_index, "/v2/vectordb/indexes/describe", (collectionName="books", indexName="idx")),
        (:list_indexes, "/v2/vectordb/indexes/list", (collectionName="books",)),
        (:drop_index, "/v2/vectordb/indexes/drop", (collectionName="books", indexName="idx")),
        (:alter_index_properties, "/v2/vectordb/indexes/alter_properties", (collectionName="books", indexName="idx", properties=Dict("mmap.enabled" => true))),
        (:drop_index_properties, "/v2/vectordb/indexes/drop_properties", (collectionName="books", indexName="idx", propertyKeys=["mmap.enabled"])),

        (:create_database, "/v2/vectordb/databases/create", (dbName="db1",)),
        (:describe_database, "/v2/vectordb/databases/describe", (dbName="db1",)),
        (:list_databases, "/v2/vectordb/databases/list", (;)),
        (:drop_database, "/v2/vectordb/databases/drop", (dbName="db1",)),
        (:alter_database_properties, "/v2/vectordb/databases/alter", (dbName="db1", properties=Dict("database.max.collections" => 16))),
        (:drop_database_properties, "/v2/vectordb/databases/drop_properties", (dbName="db1", propertyKeys=["database.max.collections"])),

        (:create_alias, "/v2/vectordb/aliases/create", (collectionName="books", aliasName="books_alias")),
        (:alter_alias, "/v2/vectordb/aliases/alter", (collectionName="books", aliasName="books_alias")),
        (:describe_alias, "/v2/vectordb/aliases/describe", (aliasName="books_alias",)),
        (:list_aliases, "/v2/vectordb/aliases/list", (;)),
        (:drop_alias, "/v2/vectordb/aliases/drop", (aliasName="books_alias",)),

        (:create_role, "/v2/vectordb/roles/create", (roleName="r1",)),
        (:describe_role, "/v2/vectordb/roles/describe", (roleName="r1",)),
        (:drop_role, "/v2/vectordb/roles/drop", (roleName="r1",)),
        (:list_roles, "/v2/vectordb/roles/list", (;)),
        (:grant_privilege, "/v2/vectordb/roles/grant_privilege", (roleName="r1", objectType="Collection", objectName="books", privilege="Query")),
        (:revoke_privilege, "/v2/vectordb/roles/revoke_privilege", (roleName="r1", objectType="Collection", objectName="books", privilege="Query")),

        (:create_user, "/v2/vectordb/users/create", (userName="u1", password="P@ssword123")),
        (:describe_user, "/v2/vectordb/users/describe", (userName="u1",)),
        (:drop_user, "/v2/vectordb/users/drop", (userName="u1",)),
        (:list_users, "/v2/vectordb/users/list", (;)),
        (:update_password, "/v2/vectordb/users/update_password", (userName="u1", password="P@ssword123", newPassword="N3wP@ssword456")),
        (:grant_role, "/v2/vectordb/users/grant_role", (userName="u1", roleName="r1")),
        (:revoke_role, "/v2/vectordb/users/revoke_role", (userName="u1", roleName="r1")),

        (:create_resource_group, "/v2/vectordb/resource_groups/create", (name="rg1",)),
        (:describe_resource_group, "/v2/vectordb/resource_groups/describe", (name="rg1",)),
        (:list_resource_groups, "/v2/vectordb/resource_groups/list", (;)),
        (:drop_resource_group, "/v2/vectordb/resource_groups/drop", (name="rg1",)),
        (:update_resource_group, "/v2/vectordb/resource_groups/alter", (resource_groups=Dict("rg1" => Dict("requests" => Dict("node_num" => 1))),)),
        (:transfer_replica, "/v2/vectordb/resource_groups/transfer_replica", (sourceRgName="rg1", targetRgName="rg2", collectionName="books", replicaNum=1)),

        (:create_import_job, "/v2/vectordb/jobs/import/create", (clusterId="cluster-1", collectionName="books", objectUrls=["s3://bucket/a.parquet"])),
        (:get_import_progress, "/v2/vectordb/jobs/import/describe", (clusterId="cluster-1", jobId="job-1")),
        (:list_import_jobs, "/v2/vectordb/jobs/import/list", (clusterId="cluster-1",)),
    ]

    client = MilvusClient(host="http://127.0.0.1:$(port)", token="token")
    expected_paths = String[path for (_, path, _) in endpoint_cases]

    try
        for (fname, expected_path, kwargs) in endpoint_cases
            fn = getfield(Milvus, fname)
            result = fn(client; kwargs...)
            @test result.code == 0

            payload = _payload_dict(result)
            @test payload["path"] == expected_path
            @test payload["method"] == "POST"
        end

        observed_paths = lock(seen_lock) do
            copy(seen_paths)
        end

        @test sort(observed_paths) == sort(expected_paths)
    finally
        close(server)
    end
end

# =============================================================================
# Test: Live Integration (auto-detect local Milvus)
# =============================================================================
function _detect_live_milvus_host()
    preferred = get(ENV, "MILVUS_TEST_HOST", "")
    candidates = String[]
    !isempty(preferred) && push!(candidates, preferred)
    append!(candidates, ["http://127.0.0.1:19530", "http://localhost:19530", "http://127.0.0.1:9091"])

    for host in unique(candidates)
        try
            client = MilvusClient(host=host, token=get(ENV, "MILVUS_TEST_TOKEN", ""), connect_timeout=2, read_timeout=2, retries=0)
            resp = list_databases(client)
            if resp.code == 0
                return host
            end
        catch
        end
    end

    return ""
end

function _maybe_drop_collection(client::MilvusClient, collection_name::String)
    try
        drop_collection(client; collectionName=collection_name)
    catch
    end
end

function _maybe_drop_partition(client::MilvusClient, collection_name::String, partition_name::String)
    try
        drop_partition(client; collectionName=collection_name, partitionName=partition_name)
    catch
    end
end

function _maybe_drop_alias(client::MilvusClient, alias_name::String)
    try
        drop_alias(client; aliasName=alias_name)
    catch
    end
end

@testset "Live Integration (requires running Milvus)" begin
    host = _detect_live_milvus_host()
    token = get(ENV, "MILVUS_TEST_TOKEN", "")

    if isempty(host)
        @info "Skipping live integration tests. No local Milvus REST v2 endpoint detected."
        return
    end

    @info "Running live integration tests against $host"
    client = MilvusClient(host=host, token=token)

    suffix = string(rand(10_000:99_999))
    coll = "live_coll_$suffix"
    part = "live_part_$suffix"
    alias = "live_alias_$suffix"

    @testset "Connectivity and Metadata" begin
        dbs = list_databases(client)
        @test dbs.code == 0
        @test dbs.data isa MilvusList

        colls = list_collections(client)
        @test colls.code == 0
    end

    @testset "Collection + Partition + Alias Lifecycle" begin
        try
            created = create_collection(client;
                collectionName=coll,
                dimension=4,
                metricType="IP",
                autoID=true,
                enableDynamicField=true
            )
            @test created.code == 0

            hasc = has_collection(client; collectionName=coll)
            @test hasc.code == 0
            @test get(_payload_dict(hasc), "has", false) == true

            desc = describe_collection(client; collectionName=coll)
            @test desc.code == 0
            @test get(_payload_dict(desc), "collectionName", "") == coll

            stats = get_collection_stats(client; collectionName=coll)
            @test stats.code == 0

            @test create_partition(client; collectionName=coll, partitionName=part).code == 0
            @test has_partition(client; collectionName=coll, partitionName=part).code == 0
            @test list_partitions(client; collectionName=coll).code == 0
            @test load_partitions(client; collectionName=coll, partitionNames=[part]).code == 0
            @test release_partitions(client; collectionName=coll, partitionNames=[part]).code == 0

            @test create_alias(client; collectionName=coll, aliasName=alias).code == 0
            @test describe_alias(client; aliasName=alias).code == 0
            @test list_aliases(client).code == 0
        finally
            _maybe_drop_alias(client, alias)
            _maybe_drop_partition(client, coll, part)
            _maybe_drop_collection(client, coll)
        end
    end

    @testset "Vector Insert + Query + Search" begin
        vec_coll = "live_vec_$suffix"
        try
            @test create_collection(client;
                collectionName=vec_coll,
                dimension=4,
                metricType="IP",
                autoID=true,
                enableDynamicField=true
            ).code == 0

            inserted = insert(client;
                collectionName=vec_coll,
                data=[
                    Dict("vector" => [0.1, 0.2, 0.3, 0.4], "tag" => "a"),
                    Dict("vector" => [0.5, 0.6, 0.7, 0.8], "tag" => "b")
                ]
            )
            @test inserted.code == 0

            searched = search(client;
                collectionName=vec_coll,
                data=[[0.1, 0.2, 0.3, 0.4]],
                annsField="vector",
                limit=2,
                outputFields=["tag"]
            )
            @test searched.code == 0

            queried = query(client;
                collectionName=vec_coll,
                filter="",
                limit=2,
                outputFields=["tag"]
            )
            @test queried.code == 0
        finally
            _maybe_drop_collection(client, vec_coll)
        end
    end
end

println("All tests passed!")
