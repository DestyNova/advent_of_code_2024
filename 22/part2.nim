import std/[sequtils, sets, strformat, strutils, tables, math]

let input = stdin.lines.toSeq.map(parseInt)
const ITERS = 2000
type Pattern = (int8,int8,int8,int8)

proc mix(x:int64, y:int64): int64 = (x xor y) mod 16777216

proc new_secret(n: int): int64 =
  let
    s2 = mix(n*64,n)
    s3 = mix(s2 div 32,s2)
    s4 = mix(s3*2048,s3)
  s4

var
  results = initTable[Pattern,int]()
  best = 0

for j in 0..input.len-1:
  let n = input[j]
  var
    secret = n
    diffs = newSeq[int8](ITERS)
    price = n mod 10
    seen: HashSet[Pattern]

  diffs[0] = 0

  for i in 1..ITERS-1:
    secret = secret.new_secret
    let price2 = secret mod 10
    diffs[i] = int8(price2 - price)
    if i > 3:
      let pattern: Pattern = (diffs[i-3],diffs[i-2],diffs[i-1],diffs[i])
      if pattern notin seen:
        results[pattern] = results.getOrDefault(pattern,0) + price2
        seen.incl(pattern)

    price = price2

for pattern,price in results.pairs:
  if price > best:
    echo fmt"{pattern}: {price}"
    best = price

echo best
