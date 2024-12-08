# Day 8: [Resonant Collinearity](https://adventofcode.com/2024/day/8)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/8/part1.pi) (00:45:08, rank 5925), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/8/part2.pi) (00:59:14, rank 5639)*

### Part 1

It took me at least 5 minutes or so just to understand the problem description... eventually it made sense. I started by selecting all pairs of antennae for each frequency, then determined the X and Y step or offset between them. To avoid processing each pair of antennae twice, I required them to already be in order by asserting that the list of antennae must be sorted already.

To get the two antinode positions the x/y step is subtracted from the first node and added to the second node. If each resulting point is in bounds, it's added to a global map of antinodes -- this was required to avoid backtracking "undoing" the insertion into a set passed to the predicate, which is what I first tried. Finally we intentionally fail the predicate, to force it to continue exploring all the other antenna pairs.

### Part 2

This at first looked bad, but I soon realised that it would just be a matter of extending the part 1 logic to multiply the x/y step by a hop counter, initially starting from 0 (so every antenna that belongs to a pair will also be an antinode). At first I started the counter from 1 and the "3T" sample produced a result of 6 instead of 9.

The code worked pretty quickly but it feels pretty ugly; hopefully some nice refactoring will occur to me, but for now... I'm going back to bed.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      25.6 ms ±   1.9 ms    [User: 14.2 ms, System: 11.4 ms]
  Range (min … max):    23.0 ms …  35.2 ms    101 runs
```

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      30.4 ms ±   1.3 ms    [User: 19.1 ms, System: 11.2 ms]
  Range (min … max):    28.0 ms …  37.9 ms    98 runs
```
