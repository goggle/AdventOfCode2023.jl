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

function perform_mapping(data::Dict{Tuple{String,String},Matrix{Int}}, source::String, destination::String, number::Int)
    M = data[(source, destination)]
    for row ∈ axes(M, 1)
        if number ∈ M[row, 2]:M[row, 2]+M[row, 3]-1
            return number - M[row, 2] + M[row, 1]
        end
    end
    return number
end

function perform_mapping(data::Dict{Tuple{String,String},Matrix{Int}}, source::String, destination::String, numbers::Set{UnitRange{Int}})
    M = data[(source, destination)]
    newset = Set{UnitRange{Int}}()
    while !isempty(numbers)
        mapped = false
        ran = pop!(numbers)
        for row ∈ axes(M, 1)
            inter = intersect(ran, M[row, 2]:M[row, 2]+M[row, 3]-1)
            if !isempty(inter)
                mapped = true
                push!(newset, inter[1] - M[row,2] + M[row,1] : inter[end] - M[row,2] + M[row,1])
                left = ran[1]:inter[1]-1
                isempty(left) || push!(numbers, left)
                right = inter[end]+1:ran[end]
                isempty(right) || push!(numbers, right)
                break
            end
        end
        mapped || push!(newset, ran)
    end
    return newset
end

function part1(seeds::Vector{Int}, data::Dict{Tuple{String,String},Matrix{Int}})
    locations = Set{Int}()
    chain = ("seed", "soil", "fertilizer", "water", "light", "temperature", "humidity", "location")
    for number ∈ seeds
        for (src, dest) ∈ zip(chain[1:end-1], chain[2:end])
            number = perform_mapping(data, src, dest, number)
        end
        push!(locations, number)
    end
    return minimum(locations)
end

function part2(seeds::Vector{Int}, data::Dict{Tuple{String,String},Matrix{Int}})
    locations = Set{UnitRange{Int}}()
    chain = ("seed", "soil", "fertilizer", "water", "light", "temperature", "humidity", "location")
    seedstarts = seeds[1:2:end]
    seedlengths = seeds[2:2:end]
    for (ss, sl) ∈ zip(seedstarts, seedlengths)
        numbers = Set([ss:ss+sl-1])
        for (src, dest) ∈ zip(chain[1:end-1], chain[2:end])
            numbers = perform_mapping(data, src, dest, numbers)
        end
        push!(locations, numbers...)
    end
    return minimum(x -> x[1], locations)
end

end # module
