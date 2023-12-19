module Day17

using AdventOfCode2023
using DataStructures

abstract type AbstractDirection end

struct Start <: AbstractDirection end
struct Up <: AbstractDirection end
struct Right <: AbstractDirection end
struct Down <: AbstractDirection end
struct Left <: AbstractDirection end

struct Vertex
    cost::Int
    entry_dir::AbstractDirection
    streak::Int
    coords::CartesianIndex{2}
end

direction(::Up) = CartesianIndex(-1, 0)
direction(::Right) = CartesianIndex(0, 1)
direction(::Down) = CartesianIndex(1, 0)
direction(::Left) = CartesianIndex(0, -1)
nextdirs(::Start, ::Int) = (Down(), Right())
nextdirs(::Up, streak::Int) = streak == 3 ? (Left(), Right()) : (Left(), Up(), Right())
nextdirs(::Right, streak::Int) = streak == 3 ? (Up(), Down()) : (Up(), Right(), Down())
nextdirs(::Down, streak::Int) = streak == 3 ? (Right(), Left()) : (Right(), Down(), Left())
nextdirs(::Left, streak::Int) = streak == 3 ? (Down(), Up()) : (Down(), Left(), Up())

nextdirs2(::Start, ::Int) = (Down(), Right())
function nextdirs2(::Up, streak::Int)
    streak < 4 && return (Up(),)
    streak < 10 && return (Left(), Up(), Right())
    return (Left(), Right())
end

function nextdirs2(::Right, streak::Int)
    streak < 4 && return (Right(),)
    streak < 10 && return (Up(), Right(), Down())
    return (Up(), Down())
end

function nextdirs2(::Down, streak::Int)
    streak < 4 && return (Down(),)
    streak < 10 && return (Right(), Down(), Left())
    return (Right(), Left())
end

function nextdirs2(::Left, streak::Int)
    streak < 4 && return (Left(),)
    streak < 10 && return (Down(), Left(), Up())
    return (Down(), Up())
end

to_number(dir::Up) = 1
to_number(dir::Right) = 2
to_number(dir::Down) = 3
to_number(dir::Left) = 4


function day17(input::String = readInput(joinpath(@__DIR__, "..", "data", "day17.txt")))
    data = map(x -> parse(Int, x[1]), reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    return [solve(data), solvep2(data)]
end

function solve(data::Matrix{Int})
    dist = typemax(Int) * ones(Int, size(data)..., 4, 3)
    dist[1,1,:,:] .= 0
    queue = PriorityQueue{Vertex,Int}()
    enqueue!(queue, Vertex(0, Start(), 0, CartesianIndex(1, 1)), 0)
    while !isempty(queue)
        v = dequeue!(queue)
        for ndir ∈ nextdirs(v.entry_dir, v.streak)
            nidx = v.coords + direction(ndir)
            if checkbounds(Bool, data, nidx)
                streak = v.entry_dir == ndir ? v.streak + 1 : 1
                ncost = v.cost + data[nidx[1], nidx[2]]
                if dist[nidx[1], nidx[2], to_number(ndir), streak] > ncost
                    dist[nidx[1], nidx[2], to_number(ndir), streak] = ncost
                    enqueue!(queue, Vertex(ncost, ndir, streak, nidx), ncost)
                end
            end
        end
    end
    return minimum(dist[end, end, :, :])
end

function solvep2(data::Matrix{Int})
    dist = typemax(Int) * ones(Int, size(data)..., 4, 10)
    dist[1,1,:,:] .= 0
    queue = PriorityQueue{Vertex,Int}()
    enqueue!(queue, Vertex(0, Start(), 0, CartesianIndex(1, 1)), 0)
    while !isempty(queue)
        v = dequeue!(queue)
        for ndir ∈ nextdirs2(v.entry_dir, v.streak)
            ndir != v.entry_dir && !checkbounds(Bool, data, v.coords + 4*direction(ndir)) && continue
            nidx = v.coords + direction(ndir)
            if checkbounds(Bool, data, nidx)
                streak = v.entry_dir == ndir ? v.streak + 1 : 1
                ncost = v.cost + data[nidx[1], nidx[2]]
                if dist[nidx[1], nidx[2], to_number(ndir), streak] > ncost
                    dist[nidx[1], nidx[2], to_number(ndir), streak] = ncost
                    enqueue!(queue, Vertex(ncost, ndir, streak, nidx), ncost)
                end
            end
        end
    end
    return minimum(dist[end, end, :, :])
end

end # module
