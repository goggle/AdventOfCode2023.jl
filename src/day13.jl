module Day13

using AdventOfCode2023


function day13(input::String = readInput(joinpath(@__DIR__, "..", "data", "day13.txt")))
    grids = parse_input(input)
    p1 = solve(grids, find_vertical, find_horizontal)
    p2 = solve(grids, find_vertical_p2, find_horizontal_p2)
    return [p1, p2]
end

function solve(grids::Vector{Matrix{Char}}, find_v, find_h)
    n_vertical = 0
    n_horizontal = 0
    for grid ∈ grids
        n_vertical += find_v(grid)
        n_horizontal += find_h(grid)
    end
    return n_vertical + 100 * n_horizontal
end

function parse_input(input::AbstractString)
    grids = Vector{Matrix{Char}}()
    for grid ∈ eachsplit(rstrip(input), "\n\n")
        push!(grids, map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(grid))))))
    end
    return grids
end

function find_horizontal(mat::Matrix{Char})
    i = size(mat, 1) - 1
    while i >= 1
        mat[i, :] == mat[i + 1, :] && _is_horizontal_mirror(mat, i) && return i
        i -= 1
    end
    return 0
end

function _is_horizontal_mirror(mat::Matrix{Char}, i::Int)
    j = i + 2
    i -= 1
    while checkbounds(Bool, mat, i, :) && checkbounds(Bool, mat, j, :)
        mat[i, :] != mat[j,:] && return false
        i -= 1
        j += 1
    end
    return true
end

function find_vertical(mat::Matrix{Char})
    j = size(mat, 2) - 1
    while j >= 1
        mat[:, j] == mat[:, j + 1] && _is_vertical_mirror(mat, j) && return j
        j -= 1
    end
    return 0
end

function _is_vertical_mirror(mat::Matrix{Char}, j::Int)
    k = j + 2
    j -= 1
    while checkbounds(Bool, mat, :, j) && checkbounds(Bool, mat, :, k)
        mat[:, j] != mat[:, k] && return false
        j -= 1
        k += 1
    end
    return true
end

n_unequal(v1::Vector, v2::Vector) = count(v1 .!= v2)

function find_horizontal_p2(mat::Matrix{Char})
    i = size(mat, 1) - 1
    while i >= 1
        n = n_unequal(mat[i, :], mat[i + 1, :])
        if n ∈ (0, 1)
            n += _sum_horizontals(mat, i)
        end
        n == 1 && return i
        i -= 1
    end
    return 0
end

function _sum_horizontals(mat::Matrix{Char}, i::Int)
    j = i + 2
    i -= 1
    s = 0
    while checkbounds(Bool, mat, i, :) && checkbounds(Bool, mat, j, :)
        s += n_unequal(mat[i, :], mat[j, :])
        s >= 2 && return s
        i -= 1
        j += 1
    end
    return s
end

function find_vertical_p2(mat::Matrix{Char})
    j = size(mat, 2) - 1
    while j >= 1
        n = n_unequal(mat[:, j], mat[:, j + 1])
        if n ∈ (0, 1)
            n += _sum_verticals(mat, j)
        end
        n == 1 && return j
        j -= 1
    end
    return 0
end

function _sum_verticals(mat::Matrix{Char}, j::Int)
    k = j + 2
    j -= 1
    s = 0
    while checkbounds(Bool, mat, :, j) && checkbounds(Bool, mat, :, k)
        s += n_unequal(mat[:, j], mat[:, k])
        s >= 2 && return s
        j -= 1
        k += 1
    end
    return s
end

end # module
