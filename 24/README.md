# Day 24: [Crossed Wires](https://adventofcode.com/2024/day/24)
*Picat: [Part 1](https://github.com/DestyNova/advent_of_code_2024/blob/main/24/part1.pi) (00:33:16, rank 2761), [Part 2](https://github.com/DestyNova/advent_of_code_2024/blob/main/24/part2.pi) (02:30:06, rank 1238)*

### Part 1

Nice -- I like these VM puzzles. Part 1 turned out to be just a case of repeatedly walking through all the gates to check if one has both inputs ready, executing it and putting the output into the `Wires` map. Eventually all gates have "fired" and we have our outputs.

While working on part 2, it occurred to me that there could have been some isolated parts of the network that never fired. But then the description did say there were no cycles, and that initial inputs would be given to any instructions that needed them. So it's probably guaranteed to terminate.

It probably would make more sense to express this as a graph problem and work backwards from the output nodes (zXX) through their dependencies to the intermediate nodes (abc) and input nodes (xXX and yXX). But my cheesy nested loop found the right answer in 24ms.

### Part 2

And now for something completely different. For part 2, the initial inputs are thrown out the window, and instead we learn that four pairs of gates have had their output wires switched. We need to discover which ones have been switched, with the knowledge that our gates represent a network that adds two numbers (X + Y = Z).

At first I was completely stumped by this, and tried writing a brute-force program that selects 4 pairs of gates from the network, swaps their output wires, and runs the network with 100 random X/Y values to verify that the adder network works.

Of course this was completely intractable. After seeing it make zero progress for a few minutes, I decided to look more closely at the input file.

The first step was to copy it to a new file and delete the initial wire values. Next, I decided to treat the gates as instructions for a virtual machine, where the wires represent registers.

Next, we know it's supposed to add two numbers, with the least significant bits (LSB) in `x00` and `y00`. Searching for those registers reveals:

```
x00 XOR y00 -> z00
x00 AND y00 -> bdj
```

Well! It seems clear that the first operation is equivalent to adding the first two binary digits and throwing away the carry. This pattern repeats throughout the file, but it's only directly assigned to an output register for `z00`. The second instruction sets `bdj` to 1 if both `x00` and `y00` were 1, so this is where we carry forward.

I moved through the file, reordering instructions that referenced the next digits `x01` and `y01`, discovering more:

```
y01 XOR x01 -> twd // sum 1
twd XOR bdj -> z01 // digit 1
twd AND bdj -> cbq // prev carry 1
y01 AND x01 -> gwd // direct carry 1
cbq OR gwd -> rhr  // any carry 1
```

Eventually I had produced 44 such blocks, with the last one writing directly to `z45`.

With this done, it was easy to go through each block and check that the pattern of outputs was correct, i.e.:

```
carry_11a OR carry_11b -> carry_11

y12 XOR x12 -> sum_12
sum_12 XOR carry_11 -> z12
sum_12 AND carry_11 -> carry_12a
y12 AND x12 -> carry_12b
carry_12a OR carry_12b -> carry_12
```

The pairs of swapped instructions were localised within these blocks, presumably to avoid loops or "islands" in the network. This meant it was easy to see instructions that violate the pattern (e.g. an AND instruction writing to one of the z registers).

After maybe 90 minutes I'd figured out the pattern and manually located all pairs of swapped instructions, sorted them in the Picat REPL and submitted the correct answer on the first attempt. Phew!

## Timings

### Part 1

```
Benchmark 1: picat_regex part1.pi < input
  Time (mean ± σ):      23.8 ms ±   0.9 ms    [User: 9.8 ms, System: 14.0 ms]
  Range (min … max):    21.9 ms …  26.7 ms    120 runs
```

### Part 2

* Brute-forcer with probabilistic "it can add" checker: Possibly billions of years
* Reverse engineering the program in vim: About 90 minutes
