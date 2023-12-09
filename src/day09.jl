module Day09

using AdventOfCode2023


function day09(input::String = readInput(joinpath(@__DIR__, "..", "data", "day09.txt")))
    sequences = [parse.(Int, x) for x ∈ split.(eachsplit(rstrip(input), "\n"), " ")]
    pn = previous_next_value.(sequences)
    return [sum(x -> x[2], pn), sum(x -> x[1], pn)]
end

differences(seq::Vector{Int}) = seq[(begin+1):end] - seq[begin:(end-1)]

function previous_next_value(sequence::Vector{Int})
    diffs = [sequence]
    while !iszero(diffs[end])
        push!(diffs, differences(diffs[end]))
    end
    return sum(x[1] for x ∈ diffs[begin:2:end]) - sum(x[1] for x ∈ diffs[(begin+1):2:end]), sum(x[end] for x ∈ diffs)
end

end # module
