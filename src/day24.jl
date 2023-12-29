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

function part2(lines::Vector{Line})
    for lind=firstindex(lines):lastindex(lines)-3
        i, j, k = lind, lind + 1, lind + 2
        cij, sij = _coeffs_rhsscalar(lines[i], lines[j])
        cik, sik = _coeffs_rhsscalar(lines[i], lines[k])
        cjk, sjk = _coeffs_rhsscalar(lines[j], lines[k])
        A = vcat(cij', cik', cjk')
        det(A) ≈ 0 && continue
        rhs = [sij, sik, sjk]
        w = round.(Int, A \ rhs)
        A = hcat((lines[i].v - w)[1:2], (w - lines[j].v)[1:2])
        rhs = (lines[j].p - lines[i].p)[1:2]
        t, _ = A \ rhs
        return round.(Int, eval_at(Line(lines[i].p, lines[i].v - w), t)) |> sum
    end
end

_coeffs_rhsscalar(l1::Line, l2::Line) = (float(l1.p) - l2.p) × (float(l1.v) - l2.v), dot(float(l1.p) - l2.p, float(l1.v) × l2.v)


end # module
