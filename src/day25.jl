module Day25

using AdventOfCode2023
using DataStructures
using Random


function day25(input::String = readInput(joinpath(@__DIR__, "..", "data", "day25.txt")))
    graph, total_size = parse_input(input)
    solve(graph, total_size)
end

function parse_input(input::AbstractString)
    i = 1
    translations = Dict{String,Int}()
    graph = Dict{Int, Set{Int}}()
    for line ∈ eachsplit(rstrip(input), "\n")
        nodes = split.(replace(line, ":" => ""), " ")
        n = Int[]
        for node ∈ nodes
            if haskey(translations, node)
                push!(n, translations[node])
            else
                translations[node] = i
                graph[i] = Set{Int}()
                push!(n, i)
                i += 1
            end
        end
        node = nodes[begin]
        for n ∈ nodes[begin+1:end]
            push!(graph[translations[node]], translations[n])
            push!(graph[translations[n]], translations[node])
        end
    end
    return graph, i - 1
end

function solve(graph::Dict{Int,Set{Int}}, total_size::Int)
    edge_count = Dict{Tuple{Int,Int},Int}()
    for i = 1:total_size
        for j = i + 1:total_size
            edge_count[(i, j)] = 0
        end
    end
    while true
        for _ ∈ 1:10
            source = rand(1:total_size)
            goals = Random.randsubseq(1:total_size, 0.1)
            isempty(goals) && continue
            prev = dijkstra(graph, source)
            for goal ∈ goals
                goal == source && continue
                u = goal
                while haskey(prev, u)
                    edge_count[minmax(u, prev[u])] += 1
                    u = prev[u]
                end
            end
        end
        ignore_edges = [x[1] for x ∈ sort(collect(edge_count), by=last, rev=true)[begin:begin+2]]
        start1, start2 = ignore_edges[1]
        size1 = bfs_count_size(graph, start1, Set(ignore_edges))
        size2 = bfs_count_size(graph, start2, Set(ignore_edges))
        if size1 + size2 == total_size
            return size1 * size2
        end
    end
end

function dijkstra(graph::Dict{Int,Set{Int}}, source::Int)
    pq = PriorityQueue{Int,Int}()
    dist = Dict{Int,Int}()
    dist[source] = 0
    prev = Dict{Int,Int}()
    for i ∈ eachindex(graph)
        if i != source
            dist[i] = typemax(Int)
            prev[i] = 0
        end
        pq[i] = dist[i]
    end
    while !isempty(pq)
        u = dequeue!(pq)
        for v ∈ graph[u]
            alt = dist[u] + 1
            if alt < dist[v]
                dist[v] = alt
                prev[v] = u
                pq[v] = alt
            end
        end
    end
    return prev
end

function bfs_count_size(graph::Dict{Int,Set{Int}}, start::Int, ignore_edges::Set{Tuple{Int,Int}})
    visited = Set{Int}([start])
    queue = [n for n ∈ graph[start] if minmax(start, n) ∉ ignore_edges]
    while !isempty(queue)
        node = popfirst!(queue)
        push!(visited, node)
        for n ∈ graph[node]
            if n ∉ visited && minmax(node, n) ∉ ignore_edges
                push!(queue, n)
            end
        end
    end
    return length(visited)
end

end # module
