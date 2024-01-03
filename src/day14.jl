module Day14

using AdventOfCode2023

function day14(input::String = readInput(joinpath(@__DIR__, "..", "data", "day14.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))

    # Precompute the positions of the cube-shaped rockes, so that it must
    # not be done in every tilting step again.
    cubepos = Dict{Int,Dict{Int, Vector{Int}}}()
    mat = data
    for i = 0:3
        cubepos[i] = Dict{Int,Vector{Int}}()
        for (j, col) ∈ enumerate(eachcol(mat))
            cubes = findall(x -> x == '#', col)
            pushfirst!(cubes, 0)
            push!(cubes, length(col) + 1)
            cubepos[i][j] = cubes
            mat = rotr90(mat)
        end
    end
    return [part1(data, cubepos), part2(data, cubepos)]
end

function part1(data::Matrix{Char}, cubepos::Dict{Int,Dict{Int, Vector{Int}}})
    d = copy(data)
    tilt_north!(d, 0, cubepos)
    return score(d)
end

function part2(data::Matrix{Char}, cubepos::Dict{Int,Dict{Int, Vector{Int}}})
    mat = copy(data)

    d = Dict{String,Int}()
    d[join(mat)] = 0
    first = last = 0
    for n ∈ 1:1_000_000_000
        mat = cycle!(mat, cubepos)
        s = join(mat)
        if haskey(d, s)
            first = d[s]
            last = n
            break
        end
        d[s] = n
    end
    steps_left = mod(10^9 - last, last - first)
    for _ ∈ 1:steps_left
        mat = cycle!(mat, cubepos)
    end
    return score(mat)
end

function tilt_north!(mat::Matrix{Char}, orientation::Int, cubepos::Dict{Int,Dict{Int, Vector{Int}}})
    for (j, col) ∈ enumerate(eachcol(mat))
        cubes = cubepos[orientation][j]
        for i ∈ firstindex(cubes):lastindex(cubes)-1
            c1, c2 = cubes[i], cubes[i+1]
            c2 - c1 == 1 && continue
            nround = count(x -> x == 'O', @view col[c1+1:c2-1])
            col[c1+1:c1+nround] .= 'O'
            col[c1+nround+1:c2-1] .= '.'
        end
    end
end

function score(mat::Matrix{Char})
    s = 0
    multi = size(mat,1)
    for row ∈ eachrow(mat)
        s += count(x -> x == 'O', row) * multi
        multi -= 1
    end
    return s
end

function cycle!(mat::Matrix{Char}, cubepos::Dict{Int,Dict{Int, Vector{Int}}})
    for i ∈ 0:3
        tilt_north!(mat, i, cubepos)
        mat = rotr90(mat)
    end
    return mat
end

end # module
