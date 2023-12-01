module Day01

using AdventOfCode2023


function day01(input::String = readInput(joinpath(@__DIR__, "..", "data", "day01.txt")))
    lines = split(rstrip(input), "\n")
    return [solve(lines), solve(lines; part2 = true)]
end

firstlast(s::AbstractString) = s[1] * s[end]

function repl(s::AbstractString)
    s = replace(s,
        "twone" => "twoone",
        "oneight" => "oneeight",
        "threeight" => "threeeight",
        "fiveight" => "fiveeight",
        "sevenine" => "sevennine",
        "eightwo" => "eighttwo",
        "eighthree" => "eightthree")
    return replace(s,
        "one" => "1",
        "two" => "2",
        "three" => "3",
        "four" => "4",
        "five" => "5",
        "six" => "6",
        "seven" => "7",
        "eight" => "8",
        "nine" => "9")
end

function solve(lines; part2 = false)
    modifier = part2 ? repl : identity
    return [parse(Int, firstlast(String([x for x in modifier(line) if isdigit(x)]))) for line in lines] |> sum
end

end # module
