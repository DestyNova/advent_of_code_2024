# Day 2: [Red-Nosed Reports](https://adventofcode.com/2024/day/2)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/2/part1.pi) (00:09:51, rank 2580), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/2/part2.pi) (00:24:45, rank 3721)*

Another fairly easy problem, but the AoC server failed with a gateway timeout and I couldn't get in for about a minute. This is the first time I've seen that -- either the puzzles are rightly growing in popularity, or someone hit it with a DDOS attack.

This time I opted to write a `safe` predicate, which made it easy to express the validation of each report with quick failure on non-unifiable assertions, although I'm not very proud of the `foreach` in there. In Haskell you'd probably write something like `zipWith (-) xs (tail xs)`, then fold on equality of signums, then fold again on absolute differences being in the range 1..3. Maybe folding with `&&` allows an early return if the LHS becomes false.

Anyway, for part 2 I pushed the `safe` logic into another predicate `check`, and made `safe` into a backtracking predicate that deletes one (or zero) of the list elements and calls `check`. It took me a little while to come up with this formulation since I haven't really used backtracking a lot. But it was actually really nice and clearer than doing another `foreach`. I did however run into yet another silly issue -- I built the code for excluding a list member in the REPL, then pasted it into the program and it failed with:

```
*** error(type_args(nonvariable_expected,_220,_228),length)
```

I found this message extremely confusing, but it was because I referred to the list as `X` in the REPL, but it was `L` in the program. Therefore the last line of code below failed because `X` was a "nonvariable":

```picat
safe(L) ?=>
  member(J, 0..L.len),
  [E : {E,I} in zip(X,1..X.len), I != J].check.
```

It seems obvious now why it failed, but at the time I thought it was somehow because the previous line wasn't happy with the expression `0..L.len` or something, and started debugging that. I'm used to languages where the compiler/interpreter says something like `(3, 85) Symbol not defined: X`, and preferably a stacktrace. But Prolog and its kin are weird and things that are considered a simple coding error in other languages are often treated as backtrackable goals in Prolog.

## Timings (with hyperfine)

### Part 1

Probably dominating by parsing.

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      27.5 ms ±   1.1 ms    [User: 15.9 ms, System: 11.5 ms]
  Range (min … max):    25.7 ms …  32.3 ms    105 runs
```

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      32.5 ms ±   1.0 ms    [User: 20.7 ms, System: 11.8 ms]
  Range (min … max):    30.9 ms …  36.3 ms    90 runs
```
