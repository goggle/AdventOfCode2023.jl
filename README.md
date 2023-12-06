# AdventOfCode2023

[![Build Status](https://github.com/goggle/AdventOfCode2023.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/goggle/AdventOfCode2023.jl/actions/workflows/CI.yml?query=branch%3Amain)
<!-- [![CI](https://github.com/goggle/AdventOfCode2023.jl/workflows/CI/badge.svg)](https://github.com/goggle/AdventOfCode2023.jl/actions?query=workflow%3ACI+branch%3Amaster) -->
<!-- [![Code coverage](https://codecov.io/gh/goggle/AdventOfCode2023.jl/branch/master/graphs/badge.svg?branch=master)](https://codecov.io/github/goggle/AdventOfCode2023.jl?branch=master) -->

This Julia package contains my solutions for [Advent of Code 2023](https://adventofcode.com/2023/).

## Overview

| Day | Problem | Time | Allocated memory | Source |
|----:|:-------:|-----:|-----------------:|:------:|
| 1 | [:white_check_mark:](https://adventofcode.com/2023/day/1) | 2.304 ms | 3.00 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day01.jl) |
| 2 | [:white_check_mark:](https://adventofcode.com/2023/day/2) | 1.050 ms | 350.39 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day02.jl) |
| 3 | [:white_check_mark:](https://adventofcode.com/2023/day/3) | 1.894 ms | 1.80 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day03.jl) |
| 4 | [:white_check_mark:](https://adventofcode.com/2023/day/4) | 2.745 ms | 1.40 MiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day04.jl) |
| 5 | [:white_check_mark:](https://adventofcode.com/2023/day/5) | 456.675 ms | 249.62 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day05.jl) |
| 6 | [:white_check_mark:](https://adventofcode.com/2023/day/6) | 7.953 μs | 7.44 KiB | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day06.jl) |
<!-- | 7 | [:white_check_mark:](https://adventofcode.com/2023/day/7) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day07.jl) | -->
<!-- | 8 | [:white_check_mark:](https://adventofcode.com/2023/day/8) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day08.jl) | -->
<!-- | 9 | [:white_check_mark:](https://adventofcode.com/2023/day/9) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day09.jl) | -->
<!-- | 10 | [:white_check_mark:](https://adventofcode.com/2023/day/10) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day10.jl) | -->
<!-- | 11 | [:white_check_mark:](https://adventofcode.com/2023/day/11) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day11.jl) | -->
<!-- | 12 | [:white_check_mark:](https://adventofcode.com/2023/day/12) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day12.jl) | -->
<!-- | 13 | [:white_check_mark:](https://adventofcode.com/2023/day/13) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day13.jl) | -->
<!-- | 14 | [:white_check_mark:](https://adventofcode.com/2023/day/14) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day14.jl) | -->
<!-- | 15 | [:white_check_mark:](https://adventofcode.com/2023/day/15) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day15.jl) | -->
<!-- | 16 | [:white_check_mark:](https://adventofcode.com/2023/day/16) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day16.jl) | -->
<!-- | 17 | [:white_check_mark:](https://adventofcode.com/2023/day/17) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day17.jl) | -->
<!-- | 18 | [:white_check_mark:](https://adventofcode.com/2023/day/18) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day18.jl) | -->
<!-- | 19 | [:white_check_mark:](https://adventofcode.com/2023/day/19) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day19.jl) | -->
<!-- | 20 | [:white_check_mark:](https://adventofcode.com/2023/day/20) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day20.jl) | -->
<!-- | 21 | [:white_check_mark:](https://adventofcode.com/2023/day/21) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day21.jl) | -->
<!-- | 22 | [:white_check_mark:](https://adventofcode.com/2023/day/22) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day22.jl) | -->
<!-- | 23 | [:white_check_mark:](https://adventofcode.com/2023/day/23) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day23.jl) | -->
<!-- | 24 | [:white_check_mark:](https://adventofcode.com/2023/day/24) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day24.jl) | -->
<!-- | 25 | [:white_check_mark:](https://adventofcode.com/2023/day/25) |  |  | [:white_check_mark:](https://github.com/goggle/AdventOfCode2023.jl/blob/master/src/day25.jl) | -->


The benchmarks have been measured on this machine:
```
Platform Info:
  OS: Linux (x86_64-linux-gnu)
  CPU: 8 × Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-14.0.6 (ORCJIT, skylake)
  Threads: 1 on 8 virtual cores
```


## Installation and Usage

Make sure you have [Julia 1.8 or newer](https://julialang.org/downloads/)
installed on your system.


### Installation

Start Julia and enter the package REPL by typing `]`. Create a new
environment:
```julia
(@v1.8) pkg> activate aoc
```

Install `AdventOfCode2023.jl`:
```
(aoc) pkg> add https://github.com/goggle/AdventOfCode2023.jl
```

Go back to the Julia REPL by pushing the `backspace` key.


### Usage

First, activate the package:
```julia
julia> using AdventOfCode2023
```

Each puzzle can now be run with `dayXY()`:
```julia
julia> day01()
2-element Vector{Int64}:
 74711
 209481
```

This will use my personal input. If you want to use another input, provide it
to the `dayXY` method as a string. You can also use the `readInput` method
to read your input from a text file:
```julia
julia> input = readInput("/path/to/input.txt")

julia> AdventOfCode2023.Day01.day01(input)
2-element Vector{Int64}:
 74711
 209481
```