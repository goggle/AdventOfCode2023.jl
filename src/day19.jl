module Day19

using AdventOfCode2023


function day19(input::String = readInput(joinpath(@__DIR__, "..", "data", "day19.txt")))
    workflows, parts = parse_input(input)
    return [part1(workflows, parts), part2(workflows)]
end

function parse_input(input::AbstractString)
    a, b = split(rstrip(input), "\n\n")
    workflows = Dict{String,Tuple{Vector{Tuple{Char,Char,Int,String}},String}}()
    for line ∈ eachsplit(a, "\n")
        m = match(r"([a-z]+)\{(.+)\}", line)
        v = Vector{Tuple{Char, Char, Int, String}}()
        for r ∈ eachsplit(m.captures[2], ',')
            m2 = match(r"([a-z])([><])(\d+):([a-zAR]+)", r)
            if m2 !== nothing
                push!(v, (m2.captures[1][1], m2.captures[2][1], parse(Int, m2.captures[3]), m2.captures[4]))
            else
                workflows[m.captures[1]] = (v, r)
            end
        end
    end

    parts = Vector{Dict{Char,Int}}()
    for line ∈ eachsplit(b, "\n")
        m = match(r"x=(\d+),m=(\d+),a=(\d+),s=(\d+)", line)
        push!(parts, Dict('x' => parse(Int, m[1]), 'm' => parse(Int, m[2]), 'a' => parse(Int, m[3]), 's' => parse(Int, m[4])))
    end

    return workflows, parts
end

function part1(workflows::Dict{String,Tuple{Vector{Tuple{Char,Char,Int,String}},String}}, parts::Vector{Dict{Char,Int}})
    accepted = Set()
    for part ∈ parts
        current_rules = "in"
        while current_rules != "A" && current_rules != "R"
            escaped = false
            for r ∈ workflows[current_rules][1]
                if (r[2] == '<' && <(part[r[1]], r[3])) || (r[2] == '>'  && >(part[r[1]], r[3]))
                    current_rules = r[4]
                    escaped = true
                    break
                end
            end
            if !escaped
                current_rules = workflows[current_rules][2]
            end
        end
        if current_rules == "A"
            push!(accepted, part)
        end
    end

    s = Int64(0)
    for part ∈ accepted
        s += part['x'] + part['m'] + part['a'] + part['s']
    end
    return s
end

function get_inter(i::Int, c::Char, v::Int, ranges::Tuple{UnitRange{Int},UnitRange{Int},UnitRange{Int},UnitRange{Int}})
    newrange = c == '<' ? (1:v-1) : (v+1:4000)
    rvec = collect(ranges)
    rvec[i] = intersect(rvec[i], newrange)
    return Tuple(rvec)
end

function get_antiinter(i::Int, c::Char, v::Int, ranges::Tuple{UnitRange{Int},UnitRange{Int},UnitRange{Int},UnitRange{Int}})
    newrange = c == '<' ? (v:4000) : (1:v)
    rvec = collect(ranges)
    rvec[i] = intersect(rvec[i], newrange)
    return Tuple(rvec)
end

function to_index(c::Char)
    c == 'x' && return 1
    c == 'm' && return 2
    c == 'a' && return 3
    c == 's' && return 4
end

function part2(workflows::Dict{String,Tuple{Vector{Tuple{Char,Char,Int,String}},String}})
    solutions = NTuple{4,UnitRange{Int}}[]
    p2rec!(solutions, (1:4000, 1:4000, 1:4000, 1:4000), "in", workflows)
    s = 0
    for sol ∈ solutions
        s += prod(length.(sol))
    end
    return s
end

function p2rec!(solutions::Vector{NTuple{4,UnitRange{Int}}}, ranges::NTuple{4,UnitRange{Int}}, rname::String, workflows::Dict{String,Tuple{Vector{Tuple{Char,Char,Int,String}},String}})
    for rule ∈ workflows[rname][1]
        posrange = get_inter(to_index(rule[1]), rule[2], rule[3], ranges)
        if rule[4] == "A"
            push!(solutions, posrange)
        elseif rule[4] != "R"
            p2rec!(solutions, posrange, rule[4], workflows)
        end
        ranges = get_antiinter(to_index(rule[1]), rule[2], rule[3], ranges)
    end
    if workflows[rname][2] == "A"
        push!(solutions, ranges)
        return
    elseif workflows[rname][2] == "R"
        return
    end
    p2rec!(solutions, ranges, workflows[rname][2], workflows)
end

end # module
