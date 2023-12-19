module Day18

using AdventOfCode2023


function day18(input::String = readInput(joinpath(@__DIR__, "..", "data", "day18.txt")))
    data = parse_input(input)
    solve(data)
end

function _translate(i::Int)
    i == 0 && return 'R'
    i == 1 && return 'D'
    i == 2 && return 'L'
    i == 3 && return 'U'
end

function parse_input(input::AbstractString)
    data = Vector{Tuple{Char,Int,Int,Char}}()
    for line ∈ eachsplit(rstrip(input), "\n")
        m = match(r"([RDLU])\s+(\d+)\s+\(\#([0-9a-f]{5})([0-3])\)", line)
        push!(data, (m.captures[1][1], parse(Int, m.captures[2]), parse(Int, m.captures[3], base=16), _translate(parse(Int, m.captures[4]))))
    end
    return data
end

function direction(c::Char)
    c == 'R' && return CartesianIndex(0, 1)
    c == 'D' && return CartesianIndex(1, 0)
    c == 'L' && return CartesianIndex(0, -1)
    c == 'U' && return CartesianIndex(-1, 0)
end

function solve(data::Vector{Tuple{Char,Int,Int,Char}})
    sol = Int64[]
    pos = [(1, 2), (4, 3)]
    for (i1, i2) ∈ pos
        curr = CartesianIndex(0, 0)
        poly = Vector{CartesianIndex{2}}([curr])
        for instr ∈ data
            dir = direction(instr[i1])
            curr += instr[i2] * dir
            push!(poly, curr)
        end
        push!(sol, area(poly))
    end
    return sol
end

# Apply Shoelace formula und Pick's theorem.
# References:
# 
# * https://en.wikipedia.org/wiki/Shoelace_formula
# * https://en.wikipedia.org/wiki/Pick%27s_theorem
#
function area(poly::Vector{CartesianIndex{2}})
    a = 0
    b = 0
    for i ∈ firstindex(poly):lastindex(poly)-1
        p = poly[i]
        q = poly[i+1]
        b += abs.((p - q).I) |> sum
        a += (p[1] - q[1]) * (p[2] + q[2])
    end
    a = abs(a) ÷ 2
    interior = a - b ÷ 2 + 1
    return b + interior
end

end # module
