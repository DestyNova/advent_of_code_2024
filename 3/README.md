# Day 3: [Mull It Over](https://adventofcode.com/2024/day/3)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/3/part1.pi) (00:43:04, rank 13080), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/3/part2.pi) (01:00:11, rank 10718)*

### Part 1

This is one that really wasn't suited to (vanilla) Picat. It probably would have been very easy with regexes (see [Hakan Kjellerstrand's PCRE module](https://github.com/hakank/picat_regex)), or DCGs if I understood them, which I don't.

Instead, I eventually decided to parse the input with backtracking. This was confusing but eventually worked alright.

### Part 2

Ok, now we introduce some state. At first I tried using Picat's global heap maps, but... this doesn't work with backtracking, because stuff won't get evaluated in the expected linear order. Instead, I threaded the state (the `Should_mul` boolean) through the recursive calls to the `extract` predicate.

This worked just fine, but took ages -- over 5 seconds on my input because I joined all the input lines together, which makes backtracking on string appends muuuuuch slower.
To sort this out, I reverted the line joining and just used an imperative-style `foreach`, "returning" the tuple of `{Keep_mul, Line_sum}` for each line. This reduced the runtime to about 100 ms but is pretty ugly.

## Timings (with hyperfine)

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      27.5 ms ±   1.1 ms    [User: 15.9 ms, System: 11.5 ms]
  Range (min … max):    25.7 ms …  32.3 ms    105 runs
```

### Part 2

After switching back to line-by-line processing:

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):     114.1 ms ±   2.5 ms    [User: 103.8 ms, System: 10.1 ms]
  Range (min … max):   111.2 ms … 120.2 ms    25 runs
```

Alternate way nicer implementation using Hakan Kjellerstrand's [Picat regex module](https://github.com/hakank/picat_regex):

```
Benchmark 1: picat_regex part2_regex.pi < input
  Time (mean ± σ):      23.1 ms ±   0.9 ms    [User: 9.8 ms, System: 13.2 ms]
  Range (min … max):    21.3 ms …  25.7 ms    118 runs
```
