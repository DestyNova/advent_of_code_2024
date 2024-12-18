# Day 18: [RAM Run](https://adventofcode.com/2024/day/18)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/18/part1.pi) (00:20:05, rank 2320), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/18/part2.pi) (00:26:11, rank 1955)*

### Part 1

This one seemed intimidating at first, as I started to suspect that we'd have to incrementally build an optimal path while the blocks are falling, and therefore manage multiple versions of the reachable graph during the pathfinding process.

But this turned out not to be the case, so I just lifted my Dijkstra implementation from a few days ago and altered the `successor` function to just move in the four cardinal directions without tracking orientation. No problemo!

### Part 2

This seemed like a good case for binary search, but given how quickly part 1 ran, I decided to just do a brute force search by adding one node at a time and running Dijkstra from scratch before adding the next node. My version of Dijkstra adds nodes to the graph lazily using the `successors` predicate, so a non-reachable end node will never be added to the distances map. My program then crashed since I was didn't check if the end node existed in the map, but handily it had printed the coordinates of every node it added beforehand, so I just looked up the next one in the file and entered it to get the star.

Afterwards, I turned it into a binary search, setting `Lo` to 1 and `Hi` to the total number of blocks in the file. At each step, I run Dijkstra once on the first `Mid = (Lo+Hi)//2` blocks. If we can still reach the end, then `Mid` is too low, so we set `Lo := Mid+1` and repeat. If Dijkstra failed, then `Mid` is too high, so we set `Hi := Mid` (note: not `Hi := Mid-1`, otherwise it's less obvious which case we have when the search finishes).

Eventually (after only 11 runs of Dijkstra, since we cover half the distance to the correct answer at each iteration), `Lo` and `Hi` both point to the same index -- the first block that makes the end unreachable, and we're done in just 113 ms. This is somewhat better than the brute-force run which took 20 or 30 seconds on my machine.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      67.6 ms ±   1.5 ms    [User: 53.9 ms, System: 13.6 ms]
  Range (min … max):    65.1 ms …  73.1 ms    44 runs
```
 
### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):     113.3 ms ±   4.1 ms    [User: 94.3 ms, System: 18.8 ms]
  Range (min … max):   108.7 ms … 126.6 ms    26 runs
```
