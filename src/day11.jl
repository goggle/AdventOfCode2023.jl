module Day11

using AdventOfCode2023


function day11(input::String = readInput(joinpath(@__DIR__, "..", "data", "day11.txt")))
    data = map(x -> x[1], reduce(vcat, permutedims.(map(x -> split(x, ""), split(input)))))
    return [solve(data, 2), solve(data, 1_000_000)]
end

function solve(data::Matrix{Char}, factor::Int)
    galaxies = findall(x -> x == '#', data)
    emptyrows = findall([all(data[i, :] .== '.') for i ∈ 1:size(data,1)])
    emptycols = findall([all(data[:, j] .== '.') for j ∈ 1:size(data,2)])
    s = Int64(0)
    for i ∈ eachindex(galaxies)
        for j ∈ Iterators.drop(eachindex(galaxies), i)
            x1, x2 = minmax(galaxies[i][1], galaxies[j][1])
            y1, y2 = minmax(galaxies[i][2], galaxies[j][2])
            expandx = count(x1 <= x <= x2 for x ∈ emptyrows) * (factor - 1)
            expandy = count(y1 <= y <= y2 for y ∈ emptycols) * (factor - 1)
            s += (x2 + expandx - x1) + (y2 + expandy - y1)
        end
    end
    return s
end


end # module
