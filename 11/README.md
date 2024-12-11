# Day 11: [Plutonian Pebbles](https://adventofcode.com/2024/day/11)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/11/part1.pi) (00:22:18, rank 6001), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/11/part2.pi) (00:47:34, rank 3878)*

### Part 1

Upon reading this I knew what was coming in part 2, but decided to do the naieve implementation for part 1 anyway. This was expressed quite nicely with Picat, although I had to use Prolog-style predicate head syntax `:-` for `splat`, the function that applies the pebble update rules.

### Part 2

Looking at the numbers again, it was clear that the full list could not be stored. It was also apparent that we had many repeated numbers coming up, which means we can store their counts in a map.
It was pretty quick to convert the part 1 program into a form amenable to this, just changing `splat` to always return a list of one or two numbers.

The slightly more niggly bit was updating the counts correctly. I think the logic is simple now, but while writing it I got confused about what to do with the existing count (do we multiply it by the count in the new map after splatting? etc). After a while I landed upon the correct answer almost by trial and error: for the current number being splatted, take its count and splatted values, then add the count to the count of each of the splatted values in the new map (which defaults to zero when those values aren't in the new map yet). I mean, here:

```picat
  M2 = new_map(),
  foreach (K=V in M)
    splat(K,Xs),
    foreach (Y in Xs)
      M2.put(Y,M2.get(Y,0)+V)
    end
  end,
```

It was still a bit slow (419ms), so I tried adding a `table` declaration (a Picat directive that caches the result of calls to a function, aka dynamic programming) to the `splat` predicate which brought it down to 150ms. That is so handy.

## Timings

### Part 1

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):     433.9 ms ±   7.2 ms    [User: 379.9 ms, System: 53.8 ms]
  Range (min … max):   425.8 ms … 446.3 ms    10 runs
```

With `table`:

```
Benchmark 1: picat part1.pi < input
  Time (mean ± σ):     133.1 ms ±   2.1 ms    [User: 92.0 ms, System: 41.0 ms]
  Range (min … max):   129.8 ms … 137.8 ms    22 runs
``` 

### Part 2

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):     419.0 ms ±  28.9 ms    [User: 324.1 ms, System: 94.8 ms]
  Range (min … max):   396.2 ms … 489.0 ms    10 runs
```

After adding `table`:

```
Benchmark 1: picat part2.pi < input
  Time (mean ± σ):     149.5 ms ±   7.1 ms    [User: 108.3 ms, System: 42.0 ms]
  Range (min … max):   142.2 ms … 175.1 ms    19 runs
``` 
