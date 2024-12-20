# Day 20: [Race Condition](https://adventofcode.com/2024/day/20)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/20/part1.pi) (01:23:36, rank 4227), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/20/part2.pi) (05:03:34, rank 6094)*

### Part 1

Another pathfinding problem, but harder. I went with the flow and implemented this using the same Dijkstra routine as previous days, then added a backtracking predicate that searches for pairs of points either side of a wall, determines the distance from one node to the start and the other node to the end, then adds an extra cost of 2 to travel through the cheat shortcut between those nodes. It was alright.

### Part 2

This was a lot harder. At first I misunderstood and thought we had to count all "Manhattan-equivalent" paths, but the docs explicitly excluded this: we only want to find unique start/end pairs.

Eventually I just searched for any reachable start point (let's call it `A`), with another reachable point whose Manhattan distance is up to 20 blocks away (`B`), and a third point adjacent to the start point (`C`), whose Manhattan distance to `B` is less than the distance from `A` to `B`. That is, the point is on a path between `A` and `B` without requiring the player to double back on themselves.

After much trial and error, I got the right result on the sample input and left it running. It took about 90 minutes to produce the correct answer. Obviously there's a much quicker way but I don't know what it is yet.

## Timings

### Part 1

Slow.
 
### Part 2

Outrageously slow.
