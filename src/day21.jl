module Day21

using AdventOfCode2023

function day21(input::String = readInput(joinpath(@__DIR__, "..", "data", "day21.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    start = findfirst(x -> x == 'S', data)
    data[start] = '.'

    return [part1(data, start), part2(data, start)]
end

function part1(data::Matrix{Char}, start::CartesianIndex{2}; nsteps::Int = 64)
    data = copy(data)
    data[start] = 'O'
    for _ ∈ 1:nsteps
        step!(data)
    end
    return findall(x -> x == 'O', data) |> length
end

function part2(data::Matrix{Char}, start::CartesianIndex{2})
    sdata = copy(data)
    sdata[start] = 'O'
    M = [data data data data data;
         data data data data data;
         data data sdata data data;
         data data data data data;
         data data data data data]
    reachables = Int[]
    for _ ∈ 1:65
        step!(M)
    end
    push!(reachables, findall(x -> x == 'O', M) |> length)
    for _ ∈ 1:131
        step!(M)
    end
    push!(reachables, findall(x -> x == 'O', M) |> length)
    for _ ∈ 1:131
        step!(M)
    end
    push!(reachables, findall(x -> x == 'O', M) |> length)

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
    # Solving this linear sytem of equations for the unknowns a, b and c gives
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

function step!(data)
    positions = findall(x -> x == 'O', data)
    data[positions] .= '.'
    dirs = CartesianIndex.((1,0,-1,0),(0,1,0,-1))
    for pos ∈ positions
        for dir ∈ dirs
            if data[pos + dir] != '#'
                data[pos + dir] = 'O'
            end
        end
    end
end

end # module