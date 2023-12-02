module Day02

using AdventOfCode2023


function day02(input::String = readInput(joinpath(@__DIR__, "..", "data", "day02.txt")))
    data = parse_input(input)
    return [part1(data), part2(data)]
end

function parse_input(input)
    data = Dict{Int, Vector{Tuple{Int,Int,Int}}}()
    for line ∈ split(rstrip(input), "\n")
        game, gdata = split(line, ":")
        gameid = parse(Int, split(game, " ")[2])
        v = Vector{Tuple{Int,Int,Int}}()
        for round ∈ split(gdata, ";")
            r = g = b = 0
            numbers = findall(r"\d+", round)
            colors = findall(r"red|green|blue", round)
            for (n, c) ∈ zip(numbers, colors)
                if round[c] == "red"
                    r = parse(Int, round[n])
                elseif round[c] == "green"
                    g = parse(Int, round[n])
                elseif round[c] == "blue"
                    b = parse(Int, round[n])
                end
            end
            push!(v, (r, g, b))
        end
        data[gameid] = v
    end
    return data
end

function part1(data::Dict{Int, Vector{Tuple{Int,Int,Int}}})
    s = sum(keys(data))
    rmax, gmax, bmax = 12, 13, 14
    for (k, v) ∈ data
        for (r, g, b) ∈ v
            if r > rmax || g > gmax || b > bmax
                s -= k
                break
            end
        end
    end
    return s
end

function part2(data::Dict{Int, Vector{Tuple{Int,Int,Int}}})
    s = 0
    for (_, v) ∈ data
        minr = maximum(x -> x[1], v)
        ming = maximum(x -> x[2], v)
        minb = maximum(x -> x[3], v)
        s += minr * ming * minb
    end
    return s
end

end # module
