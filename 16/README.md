# Day 16: [Reindeer Maze](https://adventofcode.com/2024/day/16)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/16/part1.pi) (01:23:31, rank 4660), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/16/part2.pi) (14:48:20, rank 13852)*

### Part 1

A nice little puzzle that was solved without too much trouble by Picat's planner module. Mine was very slow, and I wasn't sure which variant of `best_plan` to use. In the end I just kicked off a few different processes at once running different varations, and established that `best_plan_bin` was enormously faster than any other variant (and especially `best_plan_bb` which quickly established a huge upper bound, but then generated incrementally better solutions for ages). The `best_plan_bin` solution was still very slow, taking about 6 minutes to complete.

Then, following a tip from @hakank, I added a `table` directive to the `action` predicate, which made an unbelievably large improvement from 6 minutes down to 3.5 seconds. Wow, don't skip out on `table` as a quick and easy potential speedup for dynamic-programming-ish situations.

### Part 2

My first instinct was that this should be a tiny step beyond part 1 by swapping out `best_plan_bin` for `best_plan_nondet` with a `find_all` to enumerate all optimal solutions. This worked straight away, but proved completely infeasible on the full input file. Not long after launching a couple of versions, I had to go out for the day, and when I got back home about 10 hours later, neither process had made any visible progress.

`best_plan_nondet` takes a `Limit` parameter, which I set to the best cost discovered in part 1. However, this only seems to serve as an upper bound for restricting the search, and there seems to be no way to tell the planner "find plans that cost __exactly__ this much", making use of the knowledge that the exact cost is known already. I'm not sure if this is the only issue.

Anyway, while thinking about it, I guessed that either the Floyd-Warshall or Bellman-Ford algorithms could provide the requisite information:

* For every node N, the distance $$D_{S,N}$$ from the start node to N, and the distance $$D_{N,E}$$ from N to the end node.

However, it quickly became clear that running either of these algorithms on the full input was exceptionally slow, in Picat at least. I was tempted to re-implement it all in Nim and just roll the dice, but then I remembered that Dijkstra's algorithm is quite fast and can serve the same purpose -- previously I'd only thought of it as finding a single path from A to B, rather than costs to all nodes reachable from A.

So I grabbed my old Dijkstra implementation from the 2023 puzzles and altered it to suit this scenario, lazily exploring nodes from the start node with the use of a `successors` predicate, and updating distances in a map until no more nodes are reachable. I suppose it would be quicker to pass it the known best path cost so the exploration could terminate early once this is exceeded, but the runtime is pretty fast anyway.

Then, I added a new predicate `predecessors` to allow me to run the same search function backwards from the end node. Only, we need to run the reverse search four times -- one for each orientation at the end node (since we can arrive there from various directions). With this done, I just needed to find all nodes $$N$$ reachable from the start node and any of the end nodes, such that the $$D_{S,N} + D_{N,E} = Best cost$$ (note that the second term is really the reverse distance $$D'_{E,N}$$).

At this point it was returning a node count that was too high, which puzzled me for a few minutes until I remembered these nodes included orientation information. Once I dropped the orientation info and removed duplicates, we were left with the correct result. It was also much faster at 1.4s, more than twice as fast as the part 1 solution.

## Timings

### Part 1

Slow: 3.6s

**(Update 2024-12-20)**: I swapped out the Dijkstra implementation for the more generic one in `../lib/planner_star.pi` and used heap maps instead of global maps to "pass" the grid into the `action` predicate. It's probably still more efficient to pass the grid in as a sort of context variable, but I wanted to keep it compatible with the existing `planner` API. Now it completes in 0.29s; not a bad speedup!

### Part 2

```
Benchmark 1: picat part2_dijkstra.pi < input
  Time (mean ± σ):      1.369 s ±  0.027 s    [User: 1.268 s, System: 0.100 s]
  Range (min … max):    1.330 s …  1.413 s    10 runs
 
```
