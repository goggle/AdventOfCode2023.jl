module Day16

using AdventOfCode2023

struct Beam
    posx::Int
    posy::Int
    dirx::Int8
    diry::Int8
end


function day16(input::String = readInput(joinpath(@__DIR__, "..", "data", "day16.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    return [traverse_map(data, 1, 0, Int8(0), Int8(1)), part2(data)]
end

function part2(data::Matrix{Char})
    m = 0
    for x ∈ 1:size(data, 1)
        p = traverse_map(data, x, 0, Int8(0), Int8(1))
        if p > m
            m = p
        end
        p = traverse_map(data, x, size(data, 2) + 1, Int8(0), Int8(-1))
        if p > m
            m = p
        end
    end
    for y ∈ 1:size(data, 2)
        p = traverse_map(data, 0, y, Int8(1), Int8(0))
        if p > m
            m = p
        end
        p = traverse_map(data, size(data, 1) + 1, y, Int8(-1), Int8(0))
        if p > m
            m = p
        end
    end
    return m
end

function traverse_map(data::Matrix{Char}, posx::Int, posy::Int, dirx::Int8, diry::Int8)
    visited = zeros(Bool, size(data, 1), size(data, 2), 3, 3)
    beams = Vector{Beam}()
    cont = true
    while cont || !isempty(beams)
        if !cont
            beam = pop!(beams)
            posx = beam.posx
            posy = beam.posy
            dirx = beam.dirx
            diry = beam.diry
            cont = true
        end
        posx += dirx
        posy += diry
        if !checkbounds(Bool, data, posx, posy)
            cont = false
            continue
        end
        c = data[posx, posy]
        if visited[posx, posy, dirx + 2, diry + 2]
            cont = false
            continue
        end
        visited[posx, posy, dirx + 2, diry + 2] = true
        if c == '\\'
            dirx, diry = _reflect_backslash(dirx, diry)
        elseif c == '/'
            dirx, diry = _reflect_slash(dirx, diry)
        elseif c == '|'
            if diry != 0
                push!(beams, Beam(posx, posy, 1, 0))
                dirx, diry = Int8(-1), Int8(0)
            end
        elseif c == '-'
            if dirx != 0
                push!(beams, Beam(posx, posy, 0, 1))
                dirx, diry = Int8(0), Int8(-1)
            end
        end
    end
    energized = zeros(Bool, size(data))
    for i ∈ 1:3
        for j ∈ 1:3
            energized .|= @view visited[:,:,i,j]
        end
    end
    return count(energized)
end

function _reflect_backslash(dirx::Int8, diry::Int8)
    diry == 1 && return Int8(1), Int8(0)
    dirx == -1 && return Int8(0), Int8(-1)
    diry == -1 && return Int8(-1), Int8(0)
    dirx == 1 && return Int8(0), Int8(1)
end

function _reflect_slash(dirx::Int8, diry::Int8)
    diry == 1 && return Int8(-1), Int8(0)
    dirx == 1 && return Int8(0), Int8(-1)
    dirx == -1 && return Int8(0), Int8(1)
    diry == -1 && return Int8(1), Int8(0)
end


end # module
