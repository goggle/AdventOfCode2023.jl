using AdventOfCode2023
using Test

@testset "Day 1" begin
    @test AdventOfCode2023.Day01.day01() == [54708, 54087]
end

@testset "Day 2" begin
    sample = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green\n" *
             "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue\n" *
             "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red\n" *
             "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red\n" *
             "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green\n"
    @test AdventOfCode2023.Day02.day02(sample) == [8, 2286]
    @test AdventOfCode2023.Day02.day02() == [2486, 87984]
end

@testset "Day 3" begin
    sample = "467..114..\n" *
             "...*......\n" *
             "..35..633.\n" *
             "......#...\n" *
             "617*......\n" *
             ".....+.58.\n" *
             "..592.....\n" *
             "......755.\n" *
             "...\$.*....\n" *
             ".664.598..\n"
    @test AdventOfCode2023.Day03.day03(sample) == [4361, 467835]
    @test AdventOfCode2023.Day03.day03() == [509115, 75220503]
end