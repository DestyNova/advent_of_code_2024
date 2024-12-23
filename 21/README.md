# Day 21: [Keypad Conundrum](https://adventofcode.com/2024/day/21)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/21/part1.pi) (01:18:58, rank 746), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/21/part2.pi) (15:13:02, rank 6131)*

### Part 1

Reading the description this morning gave me a headache after only 4 hours' sleep, but the puzzle is really clever (and reminded me of an old Viz comic strip...). Once I had eventually understood what the problem actually was, I reached for the planner and implemented it with some ugly nested if statements. I had to actually narrate out loud to myself to get it right. This time the `best_plan_star` Dijkstra/A* search predicate worked well.

Eventually I was amazed to get the right result and end up within the top 1,000 of the leaderboard, landing at rank 746. That was a first this year and was a nice surprise.

### Part 2

As expected, it got incredibly hard in part 2. Instead of a depth of two (i.e. two keypad robots in between the player and the number pad robot), we have a depth of 25. I refactored the part 1 program such that it bubbled forward keypresses through a list of keypad robots, rather than 3 hardcoded ones. This eventually solved part 1 again, but was completely infeasible at a depth of 25. Even depth 7 or so took a very long time.

After a couple of hours, I had to go out for a while, and came back in the evening to try to finish it. By then I had realised that there was obviously exponential-ish growth happening as we stack on more and more layers of robots. Earlier I had observed an approx. 250% growth of keypresses from level to level, but not **exactly** 250%, so we can't just run it at depth 1 and take `Presses*(2.5**24)` to get our answer... but I suspect there is some closed-form solution. Maybe a symbolic regression run on the values for the input numbers at various depths will reveal it later.

It then occurred to me that every sequence of directional inputs must be followed by an "A" button press, otherwise they were wasted inputs. So, since we know that the robot must return to the "A" position at the end of each subsequence (i.e. one button press for the next robot in the chain), then we can calculate the costs for each subsequence independently. This means we can use top-down dynamic programming (aka `table` in Picat) to cache the results. It took a while to get it working, and when I did, it was producing a suboptimal result, even for the sample data at depth 3.

At this point I really was about to give up and go to bed. But then @hakank reminded me about the `minof` and `maxof` higher-order predicates. These take a predicate call with some output variable (in this case, the number of presses at the bottom level of the stack so that this chunk gets produced at the current level), and runs the predicate with backtracking to find the minimum possible value of that output variable.

I thought this would take absolutely forever, and I needed to give it some help with extra logic in the action predicates that penalises non-sequential actions (which produce more presses at lower levels). But it produced the correct result at depth 25 in 30 seconds.

So, a real slog, but it was cool to get the right answer from Picat in mostly-reasonable time, despite feeling that I missed the "true" solution (which probably completes in less than a second).

## Timings

### Part 1

```
Benchmark 1: picat -path ../lib part1.pi < input
  Time (mean ± σ):      58.8 ms ±   1.6 ms    [User: 43.1 ms, System: 15.6 ms]
  Range (min … max):    56.1 ms …  63.6 ms    51 runs
```

### Part 2

Around 30 seconds.
