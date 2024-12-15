# Day 12: [Garden Groups](https://adventofcode.com/2024/day/12)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/12/part1.pi) (00:34:57, rank 4074), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/12/part2.pi) (05:56:18, rank 9565)*

### Part 1

This was alright -- DFS to discover regions and build up an edge count.

### Part 2

This was not alright and took me 5 more hours after solving part 1. I was trying to do everything in `expand_region`, but eventually made it just return the set of edges, represented as a tuple `{X,Y,Dir}`. Actually not a set; a map from edge to "parent" edge, but initially with each edge pointing to itself. Then I wrote a horrible edge propagation algorithm that repeatedly:

* iterates over all pairs of edges,
* tests if they're connected as an unbroken edge,
* then sets their parent edges to the minimum of their parent edges.

This has the effect of propagating each edge's parent to the lexicographically minimal (most northwesterly on the grid) edge it shares. We then take the set of unique parent edges and count them to get the perimeter. This is extremely inefficient, but completes on my input in 2.4s. A smarter approach would be to use the [union-find algorithm aka disjoint-set trees](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) to perform this edge coalescing step more efficiently.

#### Corners

Then [pitr](https://www.twitch.tv/pitrapen) shared his much cooler approach: the number of "sides" is actually equal to the number of corners. This is absolutely crazy, but it's true... somehow. Afterwards, I tried this method and it completed in 1.6s. Finding the corners proved difficult in itself -- eventually I settled on looking at 3 consecutive clockwise segments, starting with `{west,northwest,north}` to check the northwest corner. If we mark each segment as 0 for empty and 1 for full (within the same region/group), then a corner matches either `{0,_,0}` or `{1,0,1}` (where `_` matches anything). The second case is required when there is a diagonal gap to another cell in the same region, like this:

```
..BB
..BB
BB.B
BBBB
```

So, it's a corner if the cell on the opposite (diagonal) side is not inside this region, or if it's more than two moves away (i.e. no neighbouring cell is directly connected to it -- I probably could have easily tested this with backtracking).

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      25.1 ms ±   0.9 ms    [User: 14.0 ms, System: 11.0 ms]
  Range (min … max):    23.8 ms …  29.3 ms    117 runs
``` 

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      27.8 ms ±   0.7 ms    [User: 16.6 ms, System: 11.1 ms]
  Range (min … max):    26.6 ms …  30.7 ms    105 runs
``` 
