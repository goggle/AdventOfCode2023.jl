module Day23

using AdventOfCode2023


function day23(input::String = readInput(joinpath(@__DIR__, "..", "data", "day23.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    start = CartesianIndex(1, findfirst(x -> x == '.', data[begin, :]))
    goal = CartesianIndex(size(data, 1), findfirst(x -> x == '.', data[end, :]))
    return [part1(data, start, goal), part2(data, start, goal)]
end

function part1(data::Matrix{Char}, start::CartesianIndex{2}, goal::CartesianIndex{2})
    next = generate_next_p1(data)
    graph = build_graph(start, goal, next)
    return find_longest_path(start, goal, graph)
end

function part2(data::Matrix{Char}, start::CartesianIndex{2}, goal::CartesianIndex{2})
    next = generate_next_p2(data)
    graph = build_graph(start, goal, next)
    return find_longest_path(start, goal, graph)
end

function generate_next_p1(data::Matrix{Char})
    next = Dict{CartesianIndex{2}, Vector{CartesianIndex{2}}}()
    dirs = CartesianIndex.((1, 0, -1, 0), (0, -1, 0, 1))
    empty_idx = findall(x -> x == '.', data)
    for ind ∈ empty_idx
        v = CartesianIndex{2}[]
        for d ∈ dirs
            c = ind + d
            if checkbounds(Bool, data, c) && data[c] != '#'
                push!(v, c)
            end
        end
        next[ind] = v
    end
    
    chars_dirs = (('v', CartesianIndex(1, 0)), ('^', CartesianIndex(-1, 0)), ('>', CartesianIndex(0, 1)), ('<', CartesianIndex(0, -1)))
    for (c, d) ∈ chars_dirs
        idx = findall(x -> x == c, data)
        for ind ∈ idx
            next[ind] = [ind + d]
        end
    end
    return next
end

function generate_next_p2(data::Matrix{Char})
    next = Dict{CartesianIndex{2}, Vector{CartesianIndex{2}}}()
    dirs = CartesianIndex.((1, 0, -1, 0), (0, -1, 0, 1))
    idx = findall(x -> x ∈ ('.', 'v', '^', '>', '<'), data)
    for ind ∈ idx
        v = CartesianIndex{2}[]
        for d ∈ dirs
            c = ind + d
            if checkbounds(Bool, data, c) && data[c] != '#'
                push!(v, c)
            end
        end
        next[ind] = v
    end
    return next
end

function build_graph(start::CartesianIndex{2}, goal::CartesianIndex{2}, next::Dict{CartesianIndex{2}, Vector{CartesianIndex{2}}})
    nodes = Set(findall(v -> length(v) > 2, next))
    push!(nodes, start)
    push!(nodes, goal)
    graph = Dict{CartesianIndex{2},Dict{CartesianIndex{2},Int}}()
    for node ∈ nodes
        graph[node] = Dict{CartesianIndex{2},Int}()
        for path_option ∈ next[node]
            visited = Set([node])
            last = path_option
            while true
                push!(visited, last)
                if last ∈ nodes
                    graph[node][last] = length(visited) - 1
                    break
                end
                found = false
                for l ∈ next[last]
                    if l ∉ visited
                        found = true
                        last = l
                        break
                    end
                end
                !found && break
            end
        end
    end
    return graph
end

function find_longest_path(start::CartesianIndex{2}, goal::CartesianIndex{2}, graph::Dict{CartesianIndex{2},Dict{CartesianIndex{2},Int}})
    order = Dict{CartesianIndex{2},Int}()
    for (i, elem) ∈ enumerate(keys(graph))
        order[elem] = i
    end
    visited = Int64(1) << order[start]
    max_length = Int[0]
    longest_path!(max_length, visited, start, 0, goal, graph, order)
    return max_length[1]
end

function longest_path!(max_length::Vector{Int}, visited::Int64, last::CartesianIndex{2}, current_length::Int, goal::CartesianIndex{2}, graph::Dict{CartesianIndex{2},Dict{CartesianIndex{2},Int}}, order::Dict{CartesianIndex{2}, Int})
    if last == goal && current_length > max_length[begin]
        max_length[begin] = current_length
        return
    end
    for next_node ∈ keys(graph[last])
        if visited >> order[next_node] & 1 != 1
            longest_path!(max_length, visited + 1 << order[next_node], next_node, current_length + graph[last][next_node], goal, graph, order)
        end
    end
end

end # module
