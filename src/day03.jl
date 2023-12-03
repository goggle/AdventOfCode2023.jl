module Day03

using AdventOfCode2023


function day03(input::String = readInput(joinpath(@__DIR__, "..", "data", "day03.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    return [part1(data), part2(data)]
end

function neighbour_idx(c::CartesianIndex{2}, data::Matrix{Char})
    idx = Vector{CartesianIndex{2}}()
    for i ∈ c[1] - 1 : c[1] + 1
        for j ∈ c[2] - 1 : c[2] + 1
            i == c[1] && j == c[2] && continue
            if checkbounds(Bool, data, i, j)
                push!(idx, CartesianIndex(i, j))
            end
        end
    end
    return idx
end

function part1(data::Matrix{Char})
    symbolpos = findall(x -> x ∉ ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'), data)
    numbermap = zeros(Bool, size(data))
    for pos ∈ symbolpos
        for npos ∈ neighbour_idx(pos, data)
            if isdigit(data[npos])
                numbermap[npos] = true
            end
        end
    end
    _fill!(numbermap, data)
    return _get_hit_numbers(numbermap, data) |> sum
end

function _fill!(hits::Matrix{Bool}, data::Matrix{Char})
    for c ∈ findall(x -> x == true, hits)
        ci, cj = c.I
        j = cj + 1
        while checkbounds(Bool, hits, ci, j) && isdigit(data[ci, j])
            hits[ci, j] = true
            j += 1
        end
        j = cj - 1
        while checkbounds(Bool, hits, ci, j) && isdigit(data[ci, j])
            hits[ci, j] = true
            j -= 1
        end
    end
end

function _get_hit_numbers(hits::Matrix{Bool}, data::Matrix{Char})
    numbers = Vector{Int}()
    for i ∈ 1:size(data, 1)
        j = 1
        while checkbounds(Bool, data, i, j)
            if hits[i, j]
                temp = [parse(Int, data[i,j])]
                j += 1
                while checkbounds(Bool, data, i, j) && hits[i, j]
                    push!(temp, parse(Int, data[i, j]))
                    j += 1
                end
                s, m = 0, 1
                for d ∈ reverse(temp)
                    s += d * m
                    m *= 10
                end
                push!(numbers, s)
            end
            j += 1
        end
    end
    return numbers
end

function part2(data::Matrix{Char})
    s = 0
    for pos ∈ findall(x -> x == '*', data)
        numbers = adjacent_numbers(data, pos)
        if length(numbers) == 2
            s += prod(numbers)
        end
    end
    return s
end

function get_number(data::Matrix{Char}, pos::CartesianIndex{2})
    i, j = pos[1], pos[2]
    while checkbounds(Bool, data, i, j + 1) && isdigit(data[i, j + 1])
        j += 1
    end
    m = 1
    s = 0
    while checkbounds(Bool, data, i, j) && isdigit(data[i, j])
        s += parse(Int, data[i,j]) * m
        m *= 10
        j -= 1
    end
    return s
end

function adjacent_numbers(data::Matrix{Char}, pos::CartesianIndex{2})
    numbers = Vector{Int}()
    n = 0
    i, j = pos[1], pos[2]
    for k ∈ (i - 1, i + 1)
        if checkbounds(Bool, data, k, j - 1 : j + 1)
            if isdigit(data[k, j-1]) && !isdigit(data[k, j]) && isdigit(data[k, j+1])
                n += 2
                push!(numbers, get_number(data, CartesianIndex(k, j - 1)))
                push!(numbers, get_number(data, CartesianIndex(k, j + 1)))
            else
                if isdigit(data[k, j - 1])
                    n += 1
                    push!(numbers, get_number(data, CartesianIndex(k, j - 1)))
                elseif isdigit(data[k, j])
                    n += 1
                    push!(numbers, get_number(data, CartesianIndex(k, j)))
                elseif isdigit(data[k, j + 1])
                    n += 1
                    push!(numbers, get_number(data, CartesianIndex(k, j + 1)))
                end
            end
        else
            for j2 = j - 1 : j + 1
                if checkbounds(Bool, data, k, j2) && isdigit(data[k, j2])
                    n += 1
                    push!(numbers, get_number(data, CartesianIndex(k, j2)))
                    break
                end
            end
        end
    end
    if checkbounds(Bool, data, i, j - 1) && isdigit(data[i, j - 1])
        n += 1
        push!(numbers, get_number(data, CartesianIndex(i, j - 1)))
    end
    if checkbounds(Bool, data, i, j + 1) && isdigit(data[i, j + 1])
        n += 1
        push!(numbers, get_number(data, CartesianIndex(i, j + 1)))
    end
    return numbers
end

end # module
