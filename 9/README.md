# Day 9: [Disk ~~De~~fragmenter](https://adventofcode.com/2024/day/9)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/9/part1.pi) (00:27:47, rank 3373), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/9/part2.pi) (00:52:35, rank 2041)*

### Part 1

Today I wrote the most imperative-style code (apart from assembly code over the years) since I started programming in BASIC back in the early 1990s. I figured since each file and empty space could only represent up to 9 blocks, we could just explode the disk map into a big list with one element per block.
For convenience I used -1 as the "empty" value, although it could as easily have been the atom `empty` -- in fact that would probably look nicer in the source. Might do that later, but there's no shortage of ugliness in there.

### Part 2

For part 2, I added a `Starts` map so we can jump straight to the start position of each file, rather than searching for it over and over again. Remember that we only ever touch each file once, so we never even need to update the map after moving a file.

With this, and the realisation yesterday that backtracking seems to automatically undo all changes to "variables" apart from global maps (I probably knew this before and forgot), it was very straightforward to write a backtracking predicate that finds the first free position to the left of the current file pointer that can fit that file. When backtracking with `nth(I,_,_)`, it also appears to attempt values of `I` in ascending order deterministically, which is exactly what we want.

A big chunk of the `go` predicate is wrapped in a disjunction, since we don't consider it a failure if there was no space free for the current file -- we just move on to the next file.

That worked without too much trouble, but was very slow at around 16.7 seconds. I'm not sure what can be done to speed it up without fundamentally changing the approach. Perhaps we could also track free blocks, like we tracked initial file positions in `Starts`, but that seems waaaaay more complex -- consider a case like this: `00...22..1`. We want to move `22` to position 2 (counting from zero), which means the free space at 0 is removed, and one block of free space gets moved to position 6 and merged with the existing free space at position 7. Okay, maybe it's doable now that I've said it out loud: represent free space as a list of `{Pos,Size}` tuples, then walk them and erase / insert / merge as needed. Will try that later maybe.

**Later:** Yep! At first I got it working with the free space represented as a map from start position to size. I was sorta hoping for a nondet predicate like `nth`, but for keys in a map, that would attempt them in lexicographic order. So I went back to the sorted list idea, and made use of Picat's `insert_sorted` function. In this case I would have preferred for it to mutate the list, but instead I had to save the `Next_free_slots` list as an output variable from the `go` predicate.

This version is about 9x faster than the previous one, clocking in at 2 seconds. With a few more optimisations (esp. head-appending to a list repeatedly, then calling `sort` once, rather than calling `insert_sorted` repeatedly) it's down to 1.3 seconds.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):      61.6 ms ±   1.0 ms    [User: 46.1 ms, System: 15.4 ms]
  Range (min … max):    59.9 ms …  63.9 ms    47 runs
```

### Part 2

* First version: around 16.7s
* part2_smrt.pi with file map and free list move / merges: 2s
* part2_smrt.pi after replacing repeated `insert_sorted` calls with head accumulation + single call to `sort`: 1.3s
