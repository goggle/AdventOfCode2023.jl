module Day24

using AdventOfCode2023
using LinearAlgebra

struct Line
    p::Vector{Int}
    v::Vector{Int}
end

eval_at(h::Line, t::Number) = h.p + t * h.v

function day24(input::String = readInput(joinpath(@__DIR__, "..", "data", "day24.txt")))
    hailstones = parse_input(input)
    return [part1(hailstones), part2(hailstones)]
end

function parse_input(input::AbstractString)
    data = Line[]
    for line ∈ eachsplit(rstrip(input), "\n")
        left, right = strip.(split(line, "@"))
        push!(data, Line(parse.(Int, split(left, ",")), parse.(Int, split(right, ","))))
    end
    return data
end

function part1(lines::Vector{Line}; leftbound::Int64=20_0000_000_000_000, rightbound::Int64=400_000_000_000_000)
    c = 0
    for i ∈ firstindex(lines):lastindex(lines)
        for j ∈ i + 1: lastindex(lines)
            A = hcat(lines[i].v[1:2], -lines[j].v[1:2])
            rhs = lines[j].p[1:2] - lines[i].p[1:2]
            A[1] * A[4] - A[2] * A[3] == 0  && continue  # parallel
            t, s = A \ rhs
            x, y = lines[i].p[1:2] + t * lines[i].v[1:2]
            if leftbound <= x <= rightbound && leftbound <= y <= rightbound && t >= 0 && s >= 0
                c += 1
            end
        end
    end
    return c
end

function _build_equation(li::Line, lj::Line, ind1::Int, ind2::Int)
    lhs = zeros(Int, 6)
    lhs[ind1] = li.v[ind2] - lj.v[ind2]
    lhs[ind2] = lj.v[ind1] - li.v[ind1]
    lhs[ind1 + 3] = lj.p[ind2] - li.p[ind2]
    lhs[ind2 + 3] = li.p[ind1] - lj.p[ind1]
    rhs = li.p[ind1] * li.v[ind2] + lj.p[ind2] * lj.v[ind1] - li.p[ind2] * li.v[ind1] - lj.p[ind1] * lj.v[ind2]
    return lhs, rhs
end

function build_system(lines::Vector{Line})
    A = zeros(Rational{BigInt}, 6, 6)
    rhs = zeros(Rational{BigInt}, 6)
    baselineindex = 1
    objx = (
        (0, 1, 1, 2),
        (0, 2, 1, 2),
        (0, 1, 1, 3),
        (0, 2, 1, 3),
        (0, 1, 2, 3),
        (0, 2, 2, 3)
    )
    for i = 1:6
        A[i,:], rhs[i] = _build_equation(lines[baselineindex+objx[i][1]], lines[baselineindex+objx[i][2]], objx[i][3], objx[i][4])
    end
    return A, rhs
end

function part2(lines::Vector{Line})
    A, rhs =  build_system(lines)
    x = A \ rhs
    return round(Int64, sum(x[1:3]))
end

end # module
