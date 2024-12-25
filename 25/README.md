# Day 25: [Code Chronicle](https://adventofcode.com/2024/day/25)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/25/part1.pi) (00:28:55, rank 3196), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/25/part2.pi) (00:28:59, rank 2506)*

### Part 1

The description started out intimidating -- at first I thought we were going to have to simulate rotation of keys in a 2D projection or something. But it turned out to just be:

1. Parse the input
2. Figure out which grids are keys and which are locks (by comparing the top-left corner with `#`)
3. Count the `#` characters in each column (by taking the transpose and... well in my case wasting some time looking for a "count matching" predicate and eventually using `delete_all('.')`)
4. Compare all pairs of keys and locks to find the ones whose heights all sum to a value smaller than 6.
    * You can cut down duplicate comparisons by only taking the second key/lock from the portion of the list after the first item.
    * Don't forget, like I did, that we're only comparing locks against keys (or keys against locks). I got the wrong answer on the first try and was mystified for a minute before noticing, then adding a silly check that I later simplified to `L != K`.

### Part 2

As is tradition, part 2 is just an extra click after finishing part 1. Don't forget to go back and read the flavour text.

### Thoughts

I've enjoyed the Advent of Code puzzles every year and this is no exception. The puzzles felt (mostly) slightly easier than some of the previous years, but perhaps that's because I've gotten more familiar with some techniques that are crucial for solving them, like optimal pathfinding and planning, as well as with Picat's CP/SAT features (although I didn't wield the solver to great effect this year).

The main drawback is getting badly sleep-deprived for all of December every year, since the puzzles open at 5am my time. I just couldn't shift my sleep back earlier. Next time I'll probably take more naps rather than assume that I'll fall into an early bird routine, but there are so many competing demands around Christmas.

Finally it was good to chat with a couple of other code adventurers and break down the puzzles, bounce ideas off each other (or get hints when needed).

Nollaig shona! I'll come back to this (and all the previous AoC problems) as I attempt them in a few different programming languages (currently on the list are Picat, Nim, J, K, BQN and Uiua). For now, I'm heading back to the leaba.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):     149.1 ms ±   5.3 ms    [User: 135.4 ms, System: 13.5 ms]
  Range (min … max):   144.0 ms … 166.0 ms    20 runs
 
```

### Part 2

Don't forget to click the thing.
