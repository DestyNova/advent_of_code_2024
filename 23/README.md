# Day 23: [LAN Party](https://adventofcode.com/2024/day/23)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/23/part1.pi) (00:10:06, rank 1080), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/23/part2.pi) (02:51:06, rank 5159)*

### Part 1

A graph problem! Part 1 was trivially solvable with Picat's backtracking and `find_all`.

### Part 2

This was harder, and quite different to part 1. Although I suspected the backtracking approach would be intractable this time, I tried it anyway using the `maxof` predicate. To little surprise, it immediately ate all the RAM in my machine and died.

So I started work on a CP/SAT encoding. At first I used a boolean matrix to represent the connections between nodes, and a `Mega_set` array (later renamed to `Clique`) which contained the references to nodes that reside within the largest clique.

This worked on the sample input but was definitely not going to finish on the full input. At this point I got a great hint from @hakank -- maybe I didn't need `From` and `To` domain variables or even the huge N*N `Conns` array. I deleted that, and simplified the logic down to this loop body running for every pair of indices in the node list:

```picat
      From = Ns[J],
      To = Ns[I],
      X = cond(D.get(From).has_key(To), 1, 0),
      Clique[J] #/\ Clique[I] #=> X #= 1,
```

...which just says, if two nodes are in the clique, they must be connected. Then we solve with a minimisation constraint on the number of zeroes in the clique. Amazingly this is enough for Picat's SAT solver to produce the correct result in 12.5 seconds. Not blazingly fast, but easy to read, and I didn't have to look up any proper clique finding algorithms (although I will, later...).

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      99.8 ms ±   3.1 ms    [User: 85.9 ms, System: 13.7 ms]
  Range (min … max):    95.5 ms … 111.1 ms    30 runs
```

### Part 2

* SAT: 12.4s
* CP: ~~19.4s~~ 11.5s with `ffd,updown`
* MaxSAT (CASHWMaxSAT-CorePlus): 5.8s
