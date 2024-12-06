# Day 6: [Guard Gallivant](https://adventofcode.com/2024/day/6)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/6/part1.pi) (00:26:35, rank 5149), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/6/part2.pi) (00:51:27, rank 3369)*

### Part 1

Now we're talking classic Advent of Code! I knew it wouldn't be long before we had a good grid puzzle.
For this one, I used backtracking to find the start position, then recursively called a `move` predicate that updates a set of visited positions (`V`) until the predicate fails.

It's pretty ugly and more verbose than I'd like, but it works.

### Part 2

For this one, I just hoisted the logic from part 1 into another backtracking predicate that tries to find an obstacle position that causes a collision in the visited position set. This produced egregiously incorrect results: 86 instead of 6, for the sample input.

It took me a good few minutes to realise that I needed to track not only the guard's co-ordinates in the visited set, but also the direction the guard is facing at that point -- otherwise, the sample path is considered a loop because it crosses itself.

In this sense it was lucky that the sample input contained a path crossing -- it could have easily left this as a hidden snag, which would have been difficult to detect because the program was also **really** slow.

Once my program worked on the sample input, I ran it and waited 124 seconds to get the correct result.

Afterwards, I realised that it makes little sense to test obstacles in locations that aren't on the guard's initial path, so I got rid of the backtracking in `loop_with_obstacle` and added yet another parameter to the already long parameter list: `Explore_path`, which when true signifies that no obstacle should be placed, so we can find all visited positions. With the visited set, we can then iterate over each of those points (5408 in my case, excluding the guard's start position) and check if adding an obstacle there causes the guard to loop.

This was better but still very slow, taking around 30 seconds. I'm not really sure how to optimise it further, and am super tired so will probably take a nap and watch other people's solution streams later to get ideas.

## Timings (with hyperfine)

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      23.4 ms ±   0.6 ms    [User: 12.5 ms, System: 10.9 ms]
  Range (min … max):    22.2 ms …  25.5 ms    121 runs
```

### Part 2

Too slow.
