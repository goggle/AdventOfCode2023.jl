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
    for k = 1:total_size
        not_connected = PriorityQueue{Int,Int}()
        connected = Set{Int}()
        for i ∈ 1:total_size
            not_connected[i] = 0
        end
        not_connected[k] = -1000
        while !isempty(not_connected)
            if (values(not_connected) |> sum) == -3
                return length(not_connected) * (total_size - length(not_connected))
            end
            v = dequeue!(not_connected)
            push!(connected, v)
            for n ∈ graph[v]
                if haskey(not_connected, n)
                    not_connected[n] -= 1
                end
            end
        end
    end
end

end # module
