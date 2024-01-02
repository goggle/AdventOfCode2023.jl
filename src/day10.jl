module Day10

using AdventOfCode2023


function day10(input::String = readInput(joinpath(@__DIR__, "..", "data", "day10.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    spos = findfirst(x -> x == 'S', data)
    data[spos] = 'F'  # Note: This still depends on the users input...
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

const global d = Dict(
    '|' => ((1, 0), (-1, 0)),
    '-' => ((0, 1), (0, -1)),
    'F' => ((1, 0), (0, 1)),
    '7' => ((1, 0), (0, -1)),
    'J' => ((-1, 0), (0, -1)),
    'L' => ((-1, 0), (0, 1))
)
function push_next_positions!(positions::Vector{CartesianIndex{2}}, x2pos::Vector{CartesianIndex{2}}, dmap::Matrix{Int}, cpos::CartesianIndex, c::Char)

    if dmap[cpos[1] + d[c][1][1], cpos[2] + d[c][1][2]] == -1
        _push_position_x2pos!(positions, x2pos, cpos, d[c][1][1], d[c][1][2])
    elseif dmap[cpos[1] + d[c][2][1], cpos[2] + d[c][2][2]] == -1
        _push_position_x2pos!(positions, x2pos, cpos, d[c][2][1], d[c][2][2])
    end
end

function _push_position_x2pos!(positions::Vector{CartesianIndex{2}}, x2pos::Vector{CartesianIndex{2}}, cpos::CartesianIndex, Δx::Int, Δy::Int)
    push!(positions, CartesianIndex(cpos[1] + Δx, cpos[2] + Δy))
    push!(x2pos, CartesianIndex(2*(cpos[1] + Δx) - 1, 2*(cpos[2] + Δy) - 1))
    push!(x2pos, CartesianIndex(2*cpos[1] + Δx - 1, 2*cpos[2] + Δy - 1))
end

function part2(x2pos::Vector{CartesianIndex{2}}, osize::Tuple{Int,Int})
    maze = zeros(Int8, (2*osize[1], 2*osize[2]))
    maze[x2pos] .= 1
    flood!(maze)
    return count(all(isodd.(y.I)) for y ∈ findall(x -> x == 0, maze))
end

function flood!(maze::Matrix{Int8})
    positions = CartesianIndex{2}[CartesianIndex(1,1)]
    while !isempty(positions)
        pos = popfirst!(positions)
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
