# Day 22: [Monkey Market](https://adventofcode.com/2224/day/22)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2224/blob/main/22/part1.pi) (00:52:46, rank 4380), [Part 2](https://github.com/DestyNova/advent_of_code_2224/blob/main/22/part2.pi) (04:26:41, rank 6185)*

### Part 1

When reading this I was sure it was going to be a CP/SAT problem, and started encoding a solution in Picat. Eventually I realised this was completely unnecessary, and dealing with division and bitwise xor was causing a problem. After a while I got the right output in about 33 seconds.

### Part 2

I decided to continue the CP/SAT approach with Picat, but gave up after a while and decided to brute-force it in Nim. It only took a couple of minutes to replicate part 1 in Nim in about 20 lines of code (including quite a bit of whitespace since Nim likes that). This found the part 1 result in under 60ms.

However the brute-forcer wasn't quite so easy -- I nested four for-loops for the possible values of the pattern (-9..9 for each of the four slots), and in the inner loop walked over all the input lines again, calculated their secret numbers and prices, and updated the max price if applicable.

This was proving to be quite slow, so I added command line parameters that let me search the bottom and top half (pattern[0] in -9..0 and pattern[0] in 1..9) in parallel, in two tmux panes. This worked but still took over 20 minutes AND produced the wrong answer, because I was including the first "diff" of 0 in the search.

I adjusted the pattern test to only start from the 5th element of the list, looking backwards, and also stored the secret number / price / diffs for each buyer in arrays rather than recalculating them every time. This allowed the program to find the right result in about 5 minutes.

This still wasn't great, but I picked up yet another hint from @hakank that he'd solved it with tabling and maps. After thinking about it, I copped that we can just walk through the list of input lines once and keep track of the current observed pattern at each step, then add each price to the previously seen value for that pattern (or zero if we've never seen that pattern before). The only other thing that needed to be done was to only update each pattern at most once per buyer -- otherwise we'd add multiple prices together for the same buyer which isn't valid. So I added a `seen` set, testing and only adding the price to the pattern sum table if we've not seen that pattern before for this buyer. Now we get the correct answer in about 450ms.

## Timings

### Part 1

```
Benchmark 1: picat -path ../lib part1.pi < input
  Time (mean ± σ):      58.8 ms ±   1.6 ms    [User: 43.1 ms, System: 15.6 ms]
  Range (min … max):    56.1 ms …  63.6 ms    51 runs
```

### Part 2

```
Benchmark 1: ./part2 < input
  Time (mean ± σ):     417.8 ms ±  15.3 ms    [User: 414.2 ms, System: 3.5 ms]
  Range (min … max):   401.2 ms … 452.7 ms    10 runs
```
