module Day06

using AdventOfCode2023


function day06(input::String = readInput(joinpath(@__DIR__, "..", "data", "day06.txt")))
    times, distances = parse_input(input)
    p1 = solve(times, distances)
    p2 = solve([parse(Int, join(times))], [parse(Int, join(distances))])
    return [p1, p2]
end

function parse_input(input::AbstractString)
    lines = split(rstrip(input), "\n")
    times = [x for x ∈ tryparse.(Int, split(strip(split(lines[1], ":")[2]), " ")) if x !== nothing]
    distances = [x for x ∈ tryparse.(Int, split(strip(split(lines[2], ":")[2]), " ")) if x !== nothing]
    return times, distances
end

function solve(times::Vector{Int}, distances::Vector{Int})
    p = 1
    for (t, d) ∈ zip(times, distances)
        r1, r2 = roots(t, d)
        intr1, intr2 = ceil(Int, r1), floor(Int, r2)
        n = intr2 - intr1 + 1

        # Correct edge cases if necessary:
        for r ∈ (intr1, intr2)
            if (t - r) * r == d
                n -= 1
            end
        end
        p *= n
    end
    return p
end

roots(t::Int, d::Int) = 0.5 * t - 0.5 * sqrt(t^2 - 4*d), 0.5 * t + 0.5 * sqrt(t^2 - 4*d)

end # module
