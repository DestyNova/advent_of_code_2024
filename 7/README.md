# Day 7: [Bridge Repair](https://adventofcode.com/2024/day/7)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/7/part1.pi) (00:18:45, rank 3424), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/7/part2.pi) (00:36:41, rank 4519)*

### Part 1

As soon as I read the problem description I figured a SAT/CP formulation would be easiest, since it's otherwise it's a potentially exponential problem, although I guess some paths can be abandoned early (e.g. if the current accumulator becomes larger than the target value, it can only increase so we may as well skip this path now).

Anyway I was in the mood of using Picat's SAT solver, and it worked pretty much as I expected.

### Part 2

This should have been a 1 minute split, but somehow I forgot that the numbers were all constants, and started implementing a totally pointless predicate to count the number of digits in the second number so we could do the `(A || B)` concat operation. After a while I snapped out of it, deleted the predicate and just did a `floor(log10(B) + 1)`.

The program still takes about 35 seconds with the built-in `sat` module, and no combination of options seems to help it. It doesn't get anywhere with `cp` -- perhaps the domains are just too large; the largest number in my input was 15 digits long.

**Update:** Looking at the output of `time`, the large system time component suggested Picat was possibly spending a lot of time doing `malloc`. I added `garbage_collect(50000000)`, determining the number through trial and error, aka adding a zero until it got better. Amazingly, this reduced the runtime from 35 seconds to just over 4 seconds.

#### Planner version

For fun and curiosity I tried formulating part 2 as planning problem to be solved with Picat's built-in `planner` module. This was incredibly straightforward and concise, and produced the correct answer, albeit slowly at approx 11 seconds. The planner seems to require a **lot** of memory to do its things.

#### Backtracking version

It occurred to me that I wasn't actually using the planner's plan exploration features, since it was just backtracking and looking for any working plan, rather than seeking an optimal plan... and when I tried to mess with the cost and heuristic features to guide the search, it just made things worse.

So I took the planner program and got rid of planner, combining the `action` and `final` predicates into `go`. It turns out this program was much faster, finishing in under 3 seconds with the correct result. Huh!

## Timings (not with hyperfine)

### Part 1

1.58s

### Part 2

```
picat part2.pi < input  15.00s user 17.62s system 99% cpu 32.710 total
```

(Why so much system time? Is it chewing through memory? Probably...)

After adding a one-liner to force pre-allocation of a much larger heap:

```
picat part2.pi < input  3.90s user 0.32s system 99% cpu 4.229 total
```

Planner version:
```
picat part2_planner.pi < input  9.48s user 1.80s system 99% cpu 11.288 total
```

Backtracking version:
```
picat part2_bt.pi < input  2.93s user 0.02s system 99% cpu 2.943 total
```
