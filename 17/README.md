# Day 17: [Chronospatial Computer](https://adventofcode.com/2024/day/17)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/17/part1.pi) (00:38:10, rank 2790), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/17/part2.pi) (10:06:01, rank 7861)*

### Part 1

Ah, it was only a matter of time before another register VM puzzle appeared. Parsing went quite well this time. As is often the case with these puzzles, part 1 is really just a check that the emulator you've built basically works.

### Part 2

Of course it would be an impossible "find the smallest input that causes this" reverse-engineering problem! I thought this would be a good candidate for CP or SAT, and spent about 2 hours recasting the problem that way. This was difficult due to some unexpected behaviour from `element/3` and other failures that seemed related to the domains -- for example, all the solver modules except `cp` produced a memory error when encountering expression like `2**X`, where X was a domain variable in the range `0..2**54`. I needed to make a new DV with a smaller range (`0..54` seemed reasonable).

Eventually I managed to get `cp` and `smt` (calling into z3) working on the sample input, albeit needing 3 or 4 minutes to solve that. So I left them running, along with a simple brute-forcer (just in case that was feasible... it wasn't).

After a couple of hours, they were still running, so I started looking more closely at the data, thinking there would be some patterns. I started counting the values of A, starting from 1, at which the first number in my input program appeared in the program output, and sure enough there was a loop starting at A=1 with cycle 80. Then I took the cycle of offsets and started stepping forward from A=1 by one offset at a time, this time counting when the first two (or more) digits of the program were produced in the output.

This was a very confusing and boring process which I probably should have automated but wasn't sure how... after a long time I was up to the 11th number, now dealing with a cycle of 2240 offsets. Thankfully at that point, the program stumbled upon a value that reproduced the whole input program as output. So... that was simultaneously satisfying and very unsatisfying, since my time trying to encode the problem for CP/SAT/SMT-solving produced no results, and even the working solution I arrived at is not an easily repeatable program (it contains output incrementally gathered over multiple runs, so it 100% will not work on any other input files).

I'll look into other people's solutions to see if there was a smarter way ("if"... come on).

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      18.6 ms ±   0.8 ms    [User: 6.9 ms, System: 11.7 ms]
  Range (min … max):    17.5 ms …  23.3 ms    150 runs
```
 
### Part 2

Possibly years or decades. Manual edit/run/copy-paste process: several hours.
