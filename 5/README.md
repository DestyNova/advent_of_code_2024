# Day 5: [Print Queue](https://adventofcode.com/2024/day/5)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/5/part1.pi) (00:29:13, rank 6230), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/5/part2.pi) (00:46:17, rank 5271)*

### Part 1

A nice and fairly straightforward graph traversal problem. We're given a dependency tree for ordering the pages in a manual, and need to find which page listings are in a valid order.

Once the input was processed, I wrote a `valid` predicate which relies on a backtracking predicate `precedes`, which finds either:

1. a direct child relationship (`A|B` was in the rules), or
2. a recursive descendant (`A|Child` was in the rules, and `Child` precedes `B`).

I'd seen predicates like this before as `ancestor(X,Y)` and `parent(X,Y)` since they appear in almost every Prolog tutorial.

### Part 2

My first attempt at part 2 was correct on the sample input, but infeasible on the real data: I wrote a `valid_permutation` predicate that backtracks through all permutations of the list until one matching the `valid` predicate is found. The longest listing in my input seems to consist of 23 pages, which means testing up to 23! permutations (25852016738884976640000). So that's not gonna work.

Then I realised we can just find the element from the list that precedes all other elements, then recursively repeat the process with the filtered list. This worked ok, although the program isn't the fastest at about 250 ms.

## Timings (with hyperfine)

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      33.0 ms ±   0.8 ms    [User: 21.9 ms, System: 11.1 ms]
  Range (min … max):    31.3 ms …  35.2 ms    86 runs
```

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):     257.9 ms ±   2.1 ms    [User: 245.8 ms, System: 12.0 ms]
  Range (min … max):   254.0 ms … 261.2 ms    11 runs
```
