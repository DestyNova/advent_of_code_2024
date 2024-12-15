# Day 15: [Warehouse Woes](https://adventofcode.com/2024/day/15)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/15/part1.pi) (02:06:52, rank 7354), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/15/part2.pi) (04:21:54, rank 5783)*

### Part 1

Well, that was frustrating. I spent about an hour and a half stepping through the moves for the bigger sample, trying to understand why it diverged at a certain point (reaching a permanently different state that could never match the one shown at the end of the sample run).

After a while I noticed that my program was seeing 698 moves, but the sample input had 10 lines of moves that were each 70 characters long. Two characters were being lost.

Then I realised that Neovim must be eating (some) characters when joining lines. Sure enough, a quick investigation led me to [this bug report](https://github.com/neovim/neovim/issues/19729): (neo)vim automatically eats characters that it sees as potential comment delimiters. This includes `*` and `>`. Absolutely horrible behaviour, at least in this scenario where you're looking at an endless sea of `<<v^v^><<` spread over multiple lines.

* Lesson 1: If you're manually preprocessing the input to make it easier to parse (i.e. joining that moves onto one line), verify that the result is what you expect.
* Lesson 2: Try to avoid that anyway -- the real input data had newlines, and at some point you'll probably get them out of sync. Just parse it.

### Part 2

This was an interesting one. I figured the vertical movements would be a big issue, but that seemed to work correctly from the beginning. Horizontal movements were the problem -- I was ending up with `[[]` when handling `>` and encountering a block. Eventually I just separated the horizontal cases into two different predicates rather than trying to get a more generic one working.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      34.8 ms ±   0.7 ms    [User: 18.3 ms, System: 16.4 ms]
  Range (min … max):    33.3 ms …  36.4 ms    84 runs
 
``` 

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):      65.0 ms ±   1.2 ms    [User: 43.8 ms, System: 21.1 ms]
  Range (min … max):    61.7 ms …  67.0 ms    44 runs
 
```
