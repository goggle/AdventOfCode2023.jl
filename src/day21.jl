module Day21

using AdventOfCode2023

using DataStructures

function day21(input::String = readInput(joinpath(@__DIR__, "..", "data", "day21.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    start = findfirst(x -> x == 'S', data)
    M = zeros(Int8, size(data))
    M[data .== '#'] .= -1
    return [part1(M, start), part2(M, start)]
end

function part1(M::Matrix{Int8}, start::CartesianIndex{2})
    visited = zeros(Bool, size(M))
    visited[start] = true
    return bfs!(copy(M), visited, [start], start, 64)[1]
end

dist(a::CartesianIndex{2}, b::CartesianIndex{2}) = abs.((a - b).I) |> sum

function bfs!(M::Matrix{Int8}, visited::Matrix{Bool}, queue::Vector{CartesianIndex{2}}, start::CartesianIndex{2}, nsteps::Int)
    dirs = CartesianIndex.((1,0,-1,0), (0,1,0,-1))
    conqueue = Vector{CartesianIndex{2}}()
    while !isempty(queue)
        pos = popfirst!(queue)
        M[pos] = 1
        for dir ∈ dirs
            cand = pos + dir
            if checkbounds(Bool, M, cand) && !visited[cand] && M[cand] == 0
                if dist(start, cand) <= nsteps
                    push!(queue, cand)
                    visited[cand] = true
                else
                    push!(conqueue, cand)
                end
            end
        end
    end
    parity = nsteps % 2
    return [dist(pos, start) % 2 == parity for pos ∈ findall(x -> x == 1, M)] |> sum, conqueue
end

function part2(M::Matrix{Int8}, start::CartesianIndex{2})
    start = CartesianIndex(start[1] + 2 * 131, start[2] + 2 * 131)
    bigM = [M M M M M ;
            M M M M M ;
            M M M M M ;
            M M M M M ;
            M M M M M ]
    reachables = Int[0, 0, 0]
    visited = zeros(Bool, size(bigM))
    visited[start] = true
    reachables[1], queue = bfs!(bigM, visited, [start], start, 65)
    reachables[2], queue = bfs!(bigM, visited, queue, start, 65 + 131)
    reachables[3], _ = bfs!(bigM, visited, queue, start, 65 + 2 * 131)

    # Some explanations:
    #
    # We need to figure out how many garden plots can be reached after 26501365 steps.
    # Note that 26501365 = 202300 * 131 + 65, where 131 is the side length of the input grid.
    # We have stored how many garden plots can be reached after 65, 65 + 131 and 65 + 2 * 131 steps,
    # let's call these numbers r₁, r₂ and r₃.
    # Now it turns out that the number of garden plots that can be reached after x * 131 + 65 steps is
    # a quadratic function p(x) = ax² + bx + c.
    # We know that
    #    r₁ = p(0) = c
    #    r₂ = p(1) = a + b + c
    #    r₃ = p(2) = 4a + 2b + c
    #
    # Solving this linear system of equations for the unknowns a, b and c gives
    #    a = (r₃ + r₁ - 2₂) / 2
    #    b = (4r₂ - 3r₁ - r₃) / 2
    #    c = r₁
    #
    # Finally, we just need to evaluate the polynomial p at 202300.

    a = (reachables[3] - 2*reachables[2] + reachables[1]) // 2
    b = (4*reachables[2] - 3*reachables[1] - reachables[3]) // 2
    c = reachables[1] // 1
    p(x) = a*x^2 + b*x + c
    return Int(p(Int64(202300)))
end

end # module