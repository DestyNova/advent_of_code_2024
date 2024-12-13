# Day 13: [Claw Contraption](https://adventofcode.com/2024/day/13)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/13/part1.pi) (00:30:45, rank 3381), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/13/part2.pi) (00:32:36, rank 1197)*

### Part 1

This seemed like a fine problem for a CP or SAT solver, which comes built into Picat. Indeed, it produced the correct answer as soon as I gave it the right info, but I wasted a huge amount of time on parsing with backtracking `append` chains.

### Part 2

Thanks to the constraint solver magic, part 2 took basically the same time as part 1 and no changes were needed other than modifying the prize locations. Afterwards, I rewrote the parser and simplified it a good bit. Disappointed I took so long on that in part 1, but it's fun to reach for Picat's CP/SAT solvers at any opportunity. CP solved this in about 28ms, while SAT took 1.75s, probably due to the large domains. Always try CP first.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      25.1 ms ±   0.9 ms    [User: 14.0 ms, System: 11.0 ms]
  Range (min … max):    23.8 ms …  29.3 ms    117 runs
``` 

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      27.8 ms ±   0.7 ms    [User: 16.6 ms, System: 11.1 ms]
  Range (min … max):    26.6 ms …  30.7 ms    105 runs
``` 
