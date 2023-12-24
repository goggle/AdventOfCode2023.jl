module Day22

using AdventOfCode2023
using DataStructures

struct Brick
    coords::Tuple{Int,Int,Int}
    d::Tuple{Int,Int,Int}
end

function day22(input::String = readInput(joinpath(@__DIR__, "..", "data", "day22.txt")))
    data = parse_input(input)
    solids, _ = simulate_fall(data)
    p1, no_effect = part1(solids)
    p2 = part2(solids, no_effect)
    return [p1, p2]
end

function parse_input(input::AbstractString)
    data = Vector{Brick}()
    for line ∈ eachsplit(rstrip(input), "\n")
        left, right = split(line, "~")
        c1 = parse.(Int, split(left, ","))
        c2 = parse.(Int, split(right, ","))
        push!(data, Brick(Tuple(min(c1, c2)), Tuple(abs.(c1 - c2) )))
    end
    return data
end

function part1(solids::Vector{Brick})
    supports = Dict{Int,Vector{Int}}()
    for (i, brick) ∈ enumerate(solids)
        if !haskey(supports, i)
            supports[i] = Int[]
        end
        pos = findall(x -> x.coords[3] == brick.coords[3] + brick.d[3] + 1, solids)
        for j ∈ pos
            if _xy_intersect(brick, solids[j])
                push!(supports[i], j)
            end
        end
    end

    n_occurences = Dict{Int,Int}()
    for (k, _) ∈ supports
        n_occurences[k] = 0
    end
    for (_, v) ∈ supports
        for i ∈ v
            n_occurences[i] += 1
        end
    end

    no_effect = Set{Int}()
    n_remove = 0
    for (k, v) ∈ supports
        if isempty(v)
            n_remove += 1
            push!(no_effect, k)
        else
            if all((n_occurences[i] for i ∈ v) .> 1)
                n_remove += 1
                push!(no_effect, k)
            end
        end
    end
    return n_remove, no_effect
end

function part2(solids::Vector{Brick}, no_effect::Set{Int})
    total = 0
    for i ∈ eachindex(solids)
        i ∈ no_effect && continue
        total += simulate_fall(solids; ignore_brick=i)
    end
    return total
end

function simulate_fall(data::Vector{Brick}; ignore_brick::Int = 0)
    pqueue = PriorityQueue{Brick,Int}()
    solidsdict = Dict{Int,Set{Brick}}()
    for (i, brick) ∈ enumerate(data)
        i == ignore_brick && continue
        if ignore_brick != 0 && brick.coords[3] + brick.d[3] <= data[ignore_brick].coords[3]
            if !haskey(solidsdict, brick.coords[3] + brick.d[3])
                solidsdict[brick.coords[3] + brick.d[3]] = Set{Brick}()
            end
            push!(solidsdict[brick.coords[3] + brick.d[3]], brick)
        else
            pqueue[brick] = brick.coords[3]
        end
    end
    n_bricks_fall = 0
    while !isempty(pqueue)
        brick = dequeue!(pqueue)
        n = _nsteps_sinkable(brick, solidsdict)
        if n > 0
            n_bricks_fall += 1
        end
        if !haskey(solidsdict, brick.coords[3] + brick.d[3] - n)
            solidsdict[brick.coords[3] + brick.d[3] - n] = Set{Brick}()
        end
        push!(solidsdict[brick.coords[3] + brick.d[3] - n], Brick((brick.coords[1], brick.coords[2], brick.coords[3] - n), brick.d))
    end
    ignore_brick != 0 && return n_bricks_fall
    solids = Brick[]
    for (_, v) ∈ solidsdict
        push!(solids, v...)
    end
    return solids, n_bricks_fall
end

function _xy_intersect(b1::Brick, b2::Brick)
    xrinter = intersect(b1.coords[1]:b1.coords[1]+b1.d[1], b2.coords[1]:b2.coords[1]+b2.d[1])
    yrinter = intersect(b1.coords[2]:b1.coords[2]+b1.d[2], b2.coords[2]:b2.coords[2]+b2.d[2])
    return all((length(xrinter) > 0, length(yrinter) > 0))
end

function _nsteps_sinkable(b::Brick, solidsdict::Dict{Int,Set{Brick}})
    n = 0
    for level ∈ b.coords[3]-1:-1:1
        if !haskey(solidsdict, level)
            n += 1
            continue
        end
        for b1 ∈ solidsdict[level]
            _xy_intersect(b, b1) && return n
        end
        n += 1
    end
    return n
end

end # module
