module Day24

using AdventOfCode2023
using LinearAlgebra

struct Hailstone
    p::Vector{Int}
    v::Vector{Int}
end


function day24(input::String = readInput(joinpath(@__DIR__, "..", "data", "day24.txt")))
    hailstones = parse_input(input)
    part1(hailstones)
end

function parse_input(input::AbstractString)
    data = Hailstone[]
    for line ∈ eachsplit(rstrip(input), "\n")
        left, right = strip.(split(line, "@"))
        push!(data, Hailstone(parse.(Int, split(left, ",")), parse.(Int, split(right, ","))))
    end
    return data
end

function part1(data::Vector{Hailstone}; leftbound::Int64=20_0000_000_000_000, rightbound::Int64=400_000_000_000_000)
    c = 0
    for i ∈ firstindex(data):lastindex(data)
        for j ∈ i + 1: lastindex(data)
            A = hcat(data[i].v[1:2], -data[j].v[1:2])
            rhs = data[j].p[1:2] - data[i].p[1:2]
            A[1] * A[4] - A[2] * A[3] == 0  && continue  # parallel
            t, s = A \ rhs
            x, y = data[i].p[1:2] + t * data[i].v[1:2]
            if leftbound <= x <= rightbound && leftbound <= y <= rightbound && t >= 0 && s >= 0
                c += 1
            end
        end
    end
    return c
end

end # module
