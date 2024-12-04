# Day 4: [Ceres Search](https://adventofcode.com/2024/day/4)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/4/part1.pi) (00:34:32, rank 7002), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/4/part2.pi) (00:55:45, rank 7130)*

### Part 1

This one felt hard even though the problem is super-simple. I might just be sleep-deprived. First I tried flipping the grid into each of the 4 mirrors and having separate backtracking predicates to count all left/right and diagonal possibilities, then eventually merged them into a single search predicate that takes a horizontal and vertical step, to describe all legal patterns in each direction. Ugly but eventually it worked.

### Part 2

This part felt much easier than part 1, but with a little twist that caught me out: the sample input doesn't contain some important bad matches, like:

```
S.M
.A.
M.S
```

Eventually I ended up checking that the centre of the "patch" is an `A`, and the concatenation of other four corner points are within one of four legal possibilities:

```picat
  member([Nw,Ne,Sw,Se], ["MSMS", "MMSS", "SSMM", "SMSM"]).
```

The neatness of this solution helped me get over the annoyance of taking so long on part 1.

## Timings (with hyperfine)

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      39.4 ms ±   0.8 ms    [User: 29.1 ms, System: 10.2 ms]
  Range (min … max):    38.0 ms …  41.7 ms    70 runs
```

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      49.7 ms ±   0.8 ms    [User: 39.2 ms, System: 10.3 ms]
  Range (min … max):    47.7 ms …  51.9 ms    57 runs
```
