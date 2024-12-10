# Day 10: [Hoof It](https://adventofcode.com/2024/day/10)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/10/part1.pi) (00:45:08, rank 5925), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/10/part2.pi) (00:59:14, rank 5639)*

### Part 1

This was one of those days where the problem description at first makes it seem more complex. The "as long as possible" threw me at first and I started writing a planner program that uses negative costs to find a longest path (although last time I tried that, it didn't really work).

Eventually I re-read that part and saw that they defined it as a path with strictly increasing height values at each node. This excludes non-monotonic paths (e.g. 0,1,2,2,2,3,4...9), so we know every path is exactly 9 steps.

After a while I got rid of the planner module and rewrote it as a simple backtracking predicate, and before long arrived at a program that calculated 81 for the sample file that should return 36. Then I realised my program was counting all paths from every 0 to every 9, but we needed to count the number of 9s reachable from every 0. Pretty easily fixed by returning the end coordinates from each invocation of the `move` predicate and calling `remove_dups` before getting the length of the list.

### Part 2

As soon as I saw the first couple of examples it was clear that I'd already (accidentally) solved this like 10 minutes earlier in part 1. So I just had to spend a couple of minutes recreating that.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      26.7 ms ±   0.8 ms    [User: 15.6 ms, System: 11.0 ms]
  Range (min … max):    25.2 ms …  29.6 ms    107 runs
```

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      25.6 ms ±   0.9 ms    [User: 15.3 ms, System: 10.2 ms]
  Range (min … max):    24.2 ms …  29.2 ms    111 runs
```
