module Day05

using AdventOfCode2023


function day05(input::String = readInput(joinpath(@__DIR__, "..", "data", "day05.txt")))
    seeds, data = parse_input(input)
    return [part1(seeds, data), part2(seeds, data)]
end

function parse_input(input::AbstractString)
    blocks = split(rstrip(input), "\n\n")
    seeds = parse.(Int, split(strip(split(blocks[1], ":")[2]), " "))
    data = Dict{Tuple{String,String},Matrix{Int}}()
    for block ∈ blocks[2:end]
        lines = split(block, "\n")
        m = match(r"([a-z]+)\-to\-([a-z]+).+", lines[1])
        temp = []
        for line in lines[2:end]
            push!(temp, parse.(Int, split(line, " "))')
        end
        data[(m[1], m[2])] = vcat(temp...)
    end
    return seeds, data
end

function map_number(data::Dict{Tuple{String,String},Matrix{Int}}, source::String, destination::String, number::Int)
    M = data[(source, destination)]
    for row ∈ axes(M, 1)
        if number ∈ M[row, 2]:M[row, 2]+M[row, 3]-1
            return number - M[row, 2] + M[row, 1]
        end
    end
    return number
end

function map_ranges(data::Dict{Tuple{String,String},Matrix{Int}}, source::String, destination::String, numbers::Set{UnitRange{Int}})
    M = data[(source, destination)]
    newset = Set{UnitRange{Int}}()
    while !isempty(numbers)
        mapped = false
        ran = pop!(numbers)
        for row ∈ axes(M, 1)
            inter = intersect(ran, M[row, 2]:M[row, 2]+M[row, 3]-1)
            if length(inter) > 0
                mapped = true
                push!(newset, inter[1] - M[row,2] + M[row,1] : inter[end] - M[row,2] + M[row,1])
                left = ran[1]:inter[1]-1
                if length(left) > 0
                    push!(numbers, left)
                end
                right = inter[end]+1:ran[end]
                if length(right) > 0
                    push!(numbers, right)
                end
                break
            end
        end
        if !mapped
            push!(newset, ran)
        end
    end
    return newset
end

function part1(seeds::Vector{Int}, data::Dict{Tuple{String,String},Matrix{Int}})
    locations = Vector{Int}()
    for number ∈ seeds
        number = map_number(data, "seed", "soil", number)
        number = map_number(data, "soil", "fertilizer", number)
        number = map_number(data, "fertilizer", "water", number)
        number = map_number(data, "water", "light", number)
        number = map_number(data, "light", "temperature", number)
        number = map_number(data, "temperature", "humidity", number)
        number = map_number(data, "humidity", "location", number)
        push!(locations, number)
    end
    return minimum(locations)
end

function part2(seeds::Vector{Int}, data::Dict{Tuple{String,String},Matrix{Int}})
    locations = Set{UnitRange{Int}}()
    seedstarts = seeds[1:2:end]
    seedlengths = seeds[2:2:end]
    for (ss, sl) ∈ zip(seedstarts, seedlengths)
        numbers = map_ranges(data, "seed", "soil", Set([ss:ss+sl-1]))
        numbers = map_ranges(data, "soil", "fertilizer", numbers)
        numbers = map_ranges(data, "fertilizer", "water", numbers)
        numbers = map_ranges(data, "water", "light", numbers)
        numbers = map_ranges(data, "light", "temperature", numbers)
        numbers = map_ranges(data, "temperature", "humidity", numbers)
        numbers = map_ranges(data, "humidity", "location", numbers)
        for loc ∈ numbers
            push!(locations, loc)
        end
    end
    return minimum(x -> x[1], locations)
end

end # module
