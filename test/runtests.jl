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

@testset "Day 4" begin
    sample = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53\n" *
             "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19\n" *
             "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1\n" *
             "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83\n" *
             "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36\n" *
             "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11\n"
    @test AdventOfCode2023.Day04.day04(sample) == [13, 30]
    @test AdventOfCode2023.Day04.day04() == [25231, 9721255]
end