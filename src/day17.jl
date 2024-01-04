module Day17

using AdventOfCode2023
using DataStructures

function day17(input::String = readInput(joinpath(@__DIR__, "..", "data", "day17.txt")))
    data = map(x -> parse(Int, x[1]), reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    return [solve_v2(data, 1, 3), solve_v2(data, 4, 10)]
end

function solve_v2(data::Matrix{Int}, smin::Int, smax::Int)
    xend, yend = size(data)
    pq = PriorityQueue{Tuple{Int,Int,Int},Int}()
    cost = typemax(Int16) * ones(Int16, size(data)..., 2)
    cost[1,1,:] .= 0
    enqueue!(pq, (1, 1, 1), 0)
    enqueue!(pq, (1, 1, 2), 0)
    while !isempty(pq)
        x, y, direction = dequeue!(pq)
        if x == xend && y == yend
            return Int(min(cost[xend,yend,1], cost[xend,yend,2]))
        end

        if direction == 1  # we moved horizontal, so now we need to move vertical
            steps = 0
            for i ∈ 1:smax
                x - i < 1 && break
                steps += data[x - i, y]
                if i >= smin && cost[x-i,y,2] > steps + cost[x,y,1]
                    cost[x-i,y,2] = steps + cost[x,y,1]
                    pq[(x - i, y, 2)] = cost[x - i, y, 2]
                end
            end

            steps = 0
            for i ∈ 1:smax
                x + i > xend && break
                steps += data[x + i, y]
                if i >= smin && cost[x+i,y,2] > steps + cost[x,y,1]
                    cost[x+i,y,2] = steps + cost[x,y,1]
                    pq[(x + i, y, 2)] = cost[x + i, y, 2]
                end
            end
        else
            steps = 0
            for j ∈ 1:smax
                y - j < 1 && break
                steps += data[x, y - j]
                if j >= smin && cost[x, y - j, 1] > steps + cost[x, y, 2]
                    cost[x, y - j, 1] = steps + cost[x, y, 2]
                    pq[(x, y - j, 1)] = cost[x, y - j, 1]
                end
            end

            steps = 0
            for j ∈ 1:smax
                y + j > yend && break
                steps += data[x, y + j]
                if j >= smin && cost[x, y + j, 1] > steps + cost[x, y, 2]
                    cost[x, y + j, 1] = steps + cost[x, y, 2]
                    pq[(x, y + j, 1)] = cost[x, y + j, 1]
                end
            end
        end
    end
end

end # module
