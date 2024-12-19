# Day 19: [Linen Layout](https://adventofcode.com/2024/day/19)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/19/part1.pi) (00:11:39, rank 1554), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/19/part2.pi) (00:45:08, rank 3203)*

### Part 1

This was slightly reminiscent of a 2015 problem involving molecule splitting, but that one was much harder. This one was a classic combinatorial problem: how many of these strings can be formed by combinations from this set of substrings? It seems akin to the exact change problem.

I tried implementing it with the most straightforward backtracking predicate I could think of, `possible/2`, which selects a valid prefix and recursively checks if the rest of the string is also possible, until we reach an empty string in the success case.

This worked on the sample input but wasn't feasible for the real inputs which were quite long strings. However, the addition of a `table` directive was enough to fix it.

### Part 2

I was sure that this would be a trivial extension to part 1, but the version I wrote was taking forever on the first string, perhaps because it was building up the actual list of matching results which is enormous for all valid strings. I wasn't sure how to fix it in that nondet predicate, so I replaced it with a more explicit recursive counter, since we don't care about retrieving all the possible matches; just the counts. This means the dynamic programming table just needs to store a single number for each cached call, and the solution completes in reasonable (but not amazing) time.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      1.250 s ±  0.033 s    [User: 1.233 s, System: 0.014 s]
  Range (min … max):    1.181 s …  1.287 s    10 runs
```
 
### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      1.390 s ±  0.099 s    [User: 1.364 s, System: 0.014 s]
  Range (min … max):    1.255 s …  1.551 s    10 runs
```
