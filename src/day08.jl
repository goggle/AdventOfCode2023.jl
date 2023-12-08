module Day08

using AdventOfCode2023


function day08(input::String = readInput(joinpath(@__DIR__, "..", "data", "day08.txt")))
    instructions, network = parse_input(input)
    return [part1(instructions, network, "AAA", r"ZZZ"), part2(instructions, network)]
end

function parse_input(input::AbstractString)
    instr_input, network_input = split(rstrip(input), "\n\n")
    network = Dict{String,Tuple{String,String}}()
    for line ∈ eachsplit(network_input, "\n")
        m = match(r"([A-Z]{3})\s*=\s*\(\s*([A-Z]{3})\s*,\s*([A-Z]{3})\s*\)", line)
        network[m.captures[1]] = (m.captures[2], m.captures[3])
    end
    return instr_input, network
end

function part1(instructions::AbstractString, network::Dict{String,Tuple{String,String}}, s::String, e::Regex)
    curr = s
    for (i, d) ∈ enumerate(Iterators.cycle(instructions))
        curr = network[curr][_to_index(d)]
        match(e, curr) !== nothing && return i
    end
end

function part2(instructions::AbstractString, network::Dict{String,Tuple{String,String}})
    curr = [x for x ∈ keys(network) if endswith(x, "A")]
    cycles = [part1(instructions, network, x, r"[A-Z]{2}Z") for x ∈ curr]
    return lcm(cycles)
end

_to_index(c::Char) = c == 'L' ? 1 : 2

end # module
