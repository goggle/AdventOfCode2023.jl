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

@testset "Day 5" begin
    sample = "seeds: 79 14 55 13\n\n" *
             "seed-to-soil map:\n" *
             "50 98 2\n" *
             "52 50 48\n\n" *
             "soil-to-fertilizer map:\n" *
             "0 15 37\n" *
             "37 52 2\n" *
             "39 0 15\n\n" *
             "fertilizer-to-water map:\n" *
             "49 53 8\n" *
             "0 11 42\n" *
             "42 0 7\n" *
             "57 7 4\n\n" *
             "water-to-light map:\n" *
             "88 18 7\n" *
             "18 25 70\n\n" *
             "light-to-temperature map:\n" *
             "45 77 23\n" *
             "81 45 19\n" *
             "68 64 13\n\n" *
             "temperature-to-humidity map:\n" *
             "0 69 1\n" *
             "1 0 69\n\n" *
             "humidity-to-location map:\n" *
             "60 56 37\n" *
             "56 93 4\n"
    @test AdventOfCode2023.Day05.day05(sample) == [35, 46]
    @test AdventOfCode2023.Day05.day05() == [403695602, 219529182]
end

@testset "Day 6" begin
    sample = "Time:      7  15   30\n" *
             "Distance:  9  40  200\n"
    @test AdventOfCode2023.Day06.day06(sample) == [288, 71503]
    @test AdventOfCode2023.Day06.day06() == [1155175, 35961505]
end

@testset "Day 7" begin
    sample = "32T3K 765\n" *
             "T55J5 684\n" *
             "KK677 28\n" *
             "KTJJT 220\n" *
             "QQQJA 483\n"
    @test AdventOfCode2023.Day07.day07(sample) == [6440, 5905]
    @test AdventOfCode2023.Day07.day07() == [253910319, 254083736]
end

@testset "Day 8" begin
    sample = "LLR\n" *
             "\n" *
             "AAA = (BBB, BBB)\n" *
             "BBB = (AAA, ZZZ)\n" *
             "ZZZ = (ZZZ, ZZZ)\n"
    @test AdventOfCode2023.Day08.day08(sample) == [6, 6]
    @test AdventOfCode2023.Day08.day08() == [19637, 8811050362409]
end

@testset "Day 9" begin
    sample = "0 3 6 9 12 15\n" *
             "1 3 6 10 15 21\n" *
             "10 13 16 21 30 45\n"
    @test AdventOfCode2023.Day09.day09(sample) == [114, 2]
    @test AdventOfCode2023.Day09.day09() == [1789635132, 913]
end

@testset "Day 10" begin
    @test AdventOfCode2023.Day10.day10() == [6968, 413]
end

@testset "Day 11" begin
    sample = "...#......\n" *
             ".......#..\n" *
             "#.........\n" *
             "..........\n" *
             "......#...\n" *
             ".#........\n" *
             ".........#\n" *
             "..........\n" *
             ".......#..\n" *
             "#...#.....\n"
    @test AdventOfCode2023.Day11.day11(sample) == [374, 82000210]
    @test AdventOfCode2023.Day11.day11() == [10490062, 382979724122]
end

@testset "Day 12" begin
    sample = "???.### 1,1,3\n" *
             ".??..??...?##. 1,1,3\n" *
             "?#?#?#?#?#?#?#? 1,3,1,6\n" *
             "????.#...#... 4,1,1\n" *
             "????.######..#####. 1,6,5\n" *
             "?###???????? 3,2,1\n"
    @test AdventOfCode2023.Day12.day12(sample) == [21, 525152]
    @test AdventOfCode2023.Day12.day12() == [7939, 850504257483930]
end

@testset "Day 13" begin
    sample = "#.##..##.\n" *
             "..#.##.#.\n" *
             "##......#\n" *
             "##......#\n" *
             "..#.##.#.\n" *
             "..##..##.\n" *
             "#.#.##.#.\n" *
             "\n" *
             "#...##..#\n" *
             "#....#..#\n" *
             "..##..###\n" *
             "#####.##.\n" *
             "#####.##.\n" *
             "..##..###\n" *
             "#....#..#\n"
    @test AdventOfCode2023.Day13.day13(sample) == [405, 400]
    @test AdventOfCode2023.Day13.day13() == [37381, 28210]
end

@testset "Day 14" begin
    sample = "O....#....\n" *
             "O.OO#....#\n" *
             ".....##...\n" *
             "OO.#O....O\n" *
             ".O.....O#.\n" *
             "O.#..O.#.#\n" *
             "..O..#O..O\n" *
             ".......O..\n" *
             "#....###..\n" *
             "#OO..#....\n"
    @test AdventOfCode2023.Day14.day14(sample) == [136, 64]
    @test AdventOfCode2023.Day14.day14() == [109424, 102509]
end

@testset "Day 15" begin
    sample = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7\n"
    @test AdventOfCode2023.Day15.day15(sample) == [1320, 145]
    @test AdventOfCode2023.Day15.day15() == [510013, 268497]
end

@testset "Day 16" begin
    sample = ".|...\\...." * "\n" *
             "|.-.\\....." * "\n" *
             ".....|-..." * "\n" *
             "........|." * "\n" *
             ".........." * "\n" *
             ".........\\" * "\n" *
             "..../.\\\\.." * "\n" *
             ".-.-/..|.." * "\n" *
             ".|....-|.\\" * "\n" *
             "..//.|...." * "\n"
    @test AdventOfCode2023.Day16.day16(sample) == [46, 51]
    @test AdventOfCode2023.Day16.day16() == [7788, 7987]
end

@testset "Day 17" begin
    sample = "2413432311323\n" *
             "3215453535623\n" *
             "3255245654254\n" *
             "3446585845452\n" *
             "4546657867536\n" *
             "1438598798454\n" *
             "4457876987766\n" *
             "3637877979653\n" *
             "4654967986887\n" *
             "4564679986453\n" *
             "1224686865563\n" *
             "2546548887735\n" *
             "4322674655533\n"
    @test AdventOfCode2023.Day17.day17(sample) == [102, 94]
    @test AdventOfCode2023.Day17.day17() == [1065, 1249]
end

@testset "Day 18" begin
    sample = "R 6 (#70c710)\n" *
             "D 5 (#0dc571)\n" *
             "L 2 (#5713f0)\n" *
             "D 2 (#d2c081)\n" *
             "R 2 (#59c680)\n" *
             "D 2 (#411b91)\n" *
             "L 5 (#8ceee2)\n" *
             "U 2 (#caa173)\n" *
             "L 1 (#1b58a2)\n" *
             "U 2 (#caa171)\n" *
             "R 2 (#7807d2)\n" *
             "U 3 (#a77fa3)\n" *
             "L 2 (#015232)\n" *
             "U 2 (#7a21e3)\n"
    @test AdventOfCode2023.Day18.day18(sample) == [62, 952408144115]
    @test AdventOfCode2023.Day18.day18() == [56678, 79088855654037]
end

@testset "Day 19" begin
    sample = "px{a<2006:qkq,m>2090:A,rfg}\n" *
             "pv{a>1716:R,A}\n" *
             "lnx{m>1548:A,A}\n" *
             "rfg{s<537:gd,x>2440:R,A}\n" *
             "qs{s>3448:A,lnx}\n" *
             "qkq{x<1416:A,crn}\n" *
             "crn{x>2662:A,R}\n" *
             "in{s<1351:px,qqz}\n" *
             "qqz{s>2770:qs,m<1801:hdj,R}\n" *
             "gd{a>3333:R,R}\n" *
             "hdj{m>838:A,pv}\n" *
             "\n" *
             "{x=787,m=2655,a=1222,s=2876}\n" *
             "{x=1679,m=44,a=2067,s=496}\n" *
             "{x=2036,m=264,a=79,s=2244}\n" *
             "{x=2461,m=1339,a=466,s=291}\n" *
             "{x=2127,m=1623,a=2188,s=1013}\n"
    @test AdventOfCode2023.Day19.day19(sample) == [19114, 167409079868000]
    @test AdventOfCode2023.Day19.day19() == [434147, 136146366355609]
end

@testset "Day 20" begin
    sample1 = "broadcaster -> a, b, c\n" *
              "%a -> b\n" *
              "%b -> c\n" *
              "%c -> inv\n" *
              "&inv -> a\n"
    sample2 = "broadcaster -> a\n" *
              "%a -> inv, con\n" *
              "&inv -> b\n" *
              "%b -> con\n" *
              "&con -> output\n"
    data1 = AdventOfCode2023.Day20.parse_input(sample1)
    @test AdventOfCode2023.Day20.part1(data1) == 32000000
    data2 = AdventOfCode2023.Day20.parse_input(sample2)
    @test AdventOfCode2023.Day20.part1(data2) == 11687500
    @test AdventOfCode2023.Day20.day20() == [737679780, 227411378431763]
end

@testset "Day 21" begin
    @test AdventOfCode2023.Day21.day21() == [3847, 637537341306357]
end

@testset "Day 22" begin
    sample = "1,0,1~1,2,1\n" *
             "0,0,2~2,0,2\n" *
             "0,2,3~2,2,3\n" *
             "0,0,4~0,2,4\n" *
             "2,0,5~2,2,5\n" *
             "0,1,6~2,1,6\n" *
             "1,1,8~1,1,9\n"
    @test AdventOfCode2023.Day22.day22(sample) == [5, 7]
    @test AdventOfCode2023.Day22.day22() == [519, 109531]
end

@testset "Day 23" begin
    sample = "#.#####################\n" *
             "#.......#########...###\n" *
             "#######.#########.#.###\n" *
             "###.....#.>.>.###.#.###\n" *
             "###v#####.#v#.###.#.###\n" *
             "###.>...#.#.#.....#...#\n" *
             "###v###.#.#.#########.#\n" *
             "###...#.#.#.......#...#\n" *
             "#####.#.#.#######.#.###\n" *
             "#.....#.#.#.......#...#\n" *
             "#.#####.#.#.#########v#\n" *
             "#.#...#...#...###...>.#\n" *
             "#.#.#v#######v###.###v#\n" *
             "#...#.>.#...>.>.#.###.#\n" *
             "#####v#.#.###v#.#.###.#\n" *
             "#.....#...#...#.#.#...#\n" *
             "#.#########.###.#.#.###\n" *
             "#...###...#...#...#.###\n" *
             "###.###.#.###v#####v###\n" *
             "#...#...#.#.>.>.#.>.###\n" *
             "#.###.###.#.###.#.#v###\n" *
             "#.....###...###...#...#\n" *
             "#####################.#\n"
    @test AdventOfCode2023.Day23.day23(sample) == [94, 154]
    @test AdventOfCode2023.Day23.day23() == [2394, 6554]
end

@testset "Day 24" begin
    sample = "19, 13, 30 @ -2,  1, -2\n" *
             "18, 19, 22 @ -1, -1, -2\n" *
             "20, 25, 34 @ -2, -2, -4\n" *
             "12, 31, 28 @ -1, -2, -1\n" *
             "20, 19, 15 @  1, -5, -3\n"
    hailstones_sample = AdventOfCode2023.Day24.parse_input(sample)
    @test AdventOfCode2023.Day24.part1(hailstones_sample; leftbound=7, rightbound=27) == 2
end
