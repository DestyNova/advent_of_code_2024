import std/[sequtils, strutils, math]

let input = stdin.lines.toSeq.map(parseInt)

proc mix(x:int64, y:int64): int64 = (x xor y) mod 16777216

proc new_secret(n: int): int64 =
  let
    s2 = mix(n*64,n)
    s3 = mix(s2 div 32,s2)
    s4 = mix(s3*2048,s3)
  s4

proc iter(n: int): int64 =
  var x = n
  for i in 0..1999:
    x = new_secret(x)
  x

echo input.map(iter).sum
