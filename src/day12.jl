module Day12

using AdventOfCode2023
using Memoize


function day12(input::String = readInput(joinpath(@__DIR__, "..", "data", "day12.txt")))
    patterngroups = parse_input(input)
    p1 = sum(count_combinations(p, g) for (p, g) ∈ patterngroups)
    return [p1, part2(patterngroups)]
end

function parse_input(input::AbstractString)
    patterngroups = []
    for (pattern, instructions) ∈ split.(eachsplit(rstrip(input), "\n"), " ")
        numbers = Tuple(parse.(Int, split(instructions, ",")))
        push!(patterngroups, (pattern, numbers))
    end
    return patterngroups
end

@memoize function count_combinations(pattern::AbstractString, groups::Tuple)
    count = 0
    if isempty(groups)
        '#' ∈ pattern && return 0
        return 1
    end
    length(pattern) < sum(groups) + length(groups) - 1 && return 0
    if '.' ∉ pattern[begin:groups[begin]]
        if length(pattern) == groups[begin] || pattern[groups[begin]+1] != '#'
            count += count_combinations(pattern[groups[begin] + 2:end], groups[begin+1:end])
        end
    end
    if pattern[begin] != '#'
        count += count_combinations(pattern[begin + 1:end], groups)
    end
    return count
end

function part2(patterngroups)
    s = Int64(0)
    for (pattern, groups) ∈ patterngroups
        pattern = pattern * "?" * pattern * "?" * pattern * "?" * pattern * "?" * pattern
        s += count_combinations(pattern, Tuple(repeat(collect(groups), 5)))
    end
    return s
end

end # module
