module Day10

using AdventOfCode2023


function day10(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    spos = findfirst(x -> x == 'S', data)
    data[spos] = 'F'
    p1, x2positions = part1(data, spos)
    return [p1, part2(x2positions, size(data))]
end

function part1(data::Matrix{Char}, spos::CartesianIndex{2})
    distancemap = -ones(Int, size(data))
    distancemap[spos] = 0
    positions = Vector{CartesianIndex{2}}([CartesianIndex(spos[1] + 1, spos[2]), CartesianIndex(spos[1], spos[2] + 1)])
    x2positions = Vector{CartesianIndex{2}}([
        CartesianIndex(spos[1] * 2 - 1, spos[2] * 2 - 1),
        CartesianIndex(spos[1] * 2, spos[2] * 2 - 1),
        CartesianIndex(spos[1] * 2 - 1, spos[2] * 2),
        CartesianIndex(spos[1] * 2 + 1, spos[2] * 2 - 1),
        CartesianIndex(spos[1] * 2 - 1, spos[2] * 2 + 1),
    ])
    distance = 0
    while !isempty(positions)
        for _ ∈ 1:2
            cpos = popfirst!(positions)
            if distancemap[cpos] == -1
                distancemap[cpos] = distance + 1
                push_next_positions!(positions, x2positions, distancemap, cpos, data[cpos])
            end
        end
        distance += 1
    end
    return maximum(distance), x2positions
end

function push_next_positions!(positions::Vector{CartesianIndex{2}}, x2pos::Vector{CartesianIndex{2}}, dmap::Matrix{Int}, cpos::CartesianIndex, c::Char)
    if c == '|'
        if dmap[cpos[1] + 1, cpos[2]] == -1
            push!(positions, CartesianIndex(cpos[1] + 1, cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1], 2*cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] + 1, 2*cpos[2] - 1))
        elseif dmap[cpos[1] - 1, cpos[2]] == -1
            push!(positions, CartesianIndex(cpos[1] - 1, cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1] - 2, 2*cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 3, 2*cpos[2] - 1))
        end
    elseif c == '-'
        if dmap[cpos[1], cpos[2] + 1] == -1
            push!(positions, CartesianIndex(cpos[1], cpos[2] + 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] + 1))
        elseif dmap[cpos[1], cpos[2] - 1] == -1
            push!(positions, CartesianIndex(cpos[1], cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] - 2))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] - 3))
        end
    elseif c == 'F'
        if dmap[cpos[1] + 1, cpos[2]] == -1
            push!(positions, CartesianIndex(cpos[1] + 1, cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1], 2*cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] + 1, 2*cpos[2] - 1))
        elseif dmap[cpos[1], cpos[2] + 1] == -1
            push!(positions, CartesianIndex(cpos[1], cpos[2] + 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] + 1))
        end
    elseif c == '7'
        if dmap[cpos[1] + 1, cpos[2]] == -1
            push!(positions, CartesianIndex(cpos[1] + 1, cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1], 2*cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] + 1, 2*cpos[2] - 1))
        elseif dmap[cpos[1], cpos[2] - 1] == -1
            push!(positions, CartesianIndex(cpos[1], cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] - 2))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] - 3))
        end
    elseif c == 'J'
        if dmap[cpos[1] - 1, cpos[2]] == -1
            push!(positions, CartesianIndex(cpos[1] - 1, cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1] - 2, 2*cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 3, 2*cpos[2] - 1))
        elseif dmap[cpos[1], cpos[2] - 1] == -1
            push!(positions, CartesianIndex(cpos[1], cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] - 2))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] - 3))
        end
    elseif c == 'L'
        if dmap[cpos[1] - 1, cpos[2]] == -1
            push!(positions, CartesianIndex(cpos[1] - 1, cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1] - 2, 2*cpos[2] - 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 3, 2*cpos[2] - 1))
        elseif dmap[cpos[1], cpos[2] + 1] == -1
            push!(positions, CartesianIndex(cpos[1], cpos[2] + 1))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2]))
            push!(x2pos, CartesianIndex(2*cpos[1] - 1, 2*cpos[2] + 1))
        end
    end
end

function part2(x2pos::Vector{CartesianIndex{2}}, osize::Tuple{Int,Int})
    maze = zeros(Int8, (2*osize[1], 2*osize[2]))
    maze[x2pos] .= 1
    flood!(maze)
    return count(all(isodd.(y.I)) for y ∈ findall(x -> x == 0, maze))
end

function flood!(maze::Matrix{Int8})
    positions = Set{CartesianIndex{2}}([CartesianIndex(1,1)])
    while !isempty(positions)
        pos = pop!(positions)
        maze[pos] = 2
        nextidx = [CartesianIndex(pos[1] + 1, pos[2]),
                   CartesianIndex(pos[1] - 1, pos[2]),
                   CartesianIndex(pos[1], pos[2] + 1),
                   CartesianIndex(pos[1], pos[2] - 1)]
        for idx ∈ nextidx
            if checkbounds(Bool, maze, idx) && maze[idx] == 0 && idx ∉ positions
                push!(positions, idx)
            end
        end
    end
end


end # module