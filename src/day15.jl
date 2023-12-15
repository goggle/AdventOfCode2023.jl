module Day15

using AdventOfCode2023


function day15(input::String = readInput(joinpath(@__DIR__, "..", "data", "day15.txt")))
    p1 = sum(hash(x) for x ∈ eachsplit(rstrip(input), ","))
    return [p1, part2(input)]
end

function hash(s::AbstractString)
    value = 0
    for c ∈ s
        value = mod((value + Int(codepoint(c))) * 17, 256)
    end
    return value
end

function part2(input::String)
    boxes = Dict{Int,Vector{Tuple{String,Int}}}()
    for i ∈ 0:255
        boxes[i] = Vector{Tuple{String,Int}}()
    end
    for instruction ∈ eachsplit(rstrip(input), ",")
        if endswith(instruction, '-')
            label = instruction[begin:end-1]
            box = hash(label)
            filter!(x -> x[1] != label, boxes[box])
        else
            label, focal_length = split(instruction, '=')
            box = hash(label)
            i = findfirst(x -> x[1] == label, boxes[box])
            if i !== nothing
                boxes[box][i] = (label, parse(Int, focal_length))
            else
                push!(boxes[box], (label, parse(Int, focal_length)))
            end
        end
    end
    psum = 0
    for i ∈ 0:255
        for (j, elem) ∈ enumerate(boxes[i])
            psum += (i + 1) * j * elem[2]
        end
    end
    return psum
end

end # module
