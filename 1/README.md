# Day 1: [Historian Hysteria](https://adventofcode.com/2024/day/1)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/1/part1.pi) (00:14:24, rank 5509), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/1/part2.pi) (00:21:04, rank 5393)*

An incredibly simple problem for day 1. I managed to get stuck on the most basic input handling with Picat; hopefully I'm just a bit rusty with it. At some point I made at least the following errors:

1. `split(S)` is NOT the same as `split(s)`. The latter errors out with the message `*** error(failed,main/0)` and no stacktrace (possibly the worst thing about Picat, although that's probably just a Prolog thing since failures aren't always... failures...).

2. `zip` in Picat produces an array, not a list. So this expression `[abs(X-Y) : [X,Y] in zip(A,B)]` always evaluates to the empty list due to pattern match failure. Instead you need to pattern match on an array: `[abs(X-Y) : {X,Y} in zip(A,B)]`. This is one of those areas where strong static typing would help. Makes me want to try Mercury again but the boilerplate for even a Hello World program is just too intimidating.

## Timings (with hyperfine)

### Part 1

Probably dominating by parsing.

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      20.8 ms ±   0.9 ms    [User: 9.8 ms, System: 11.0 ms]
  Range (min … max):    19.4 ms …  26.1 ms    138 runs
```

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      20.2 ms ±   0.9 ms    [User: 10.1 ms, System: 10.7 ms]
  Range (min … max):    19.0 ms …  24.7 ms    132 runs
```
