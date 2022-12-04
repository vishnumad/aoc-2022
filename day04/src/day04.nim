import std/[strutils, sequtils]

type
  Range = tuple[low, high: int]

proc length(range: Range): int =
  return range.high - range.low + 1

proc overlap(a: Range, b: Range): int =
  let spanLength = max(a.high, b.high) - min(a.low, b.low) + 1
  let totalLength = a.length + b.length
  return totalLength - spanLength

proc parseRange(literal: string): Range =
  let range = literal.split('-')
  return (low: parseInt(range[0]), high: parseInt(range[1]))

let ranges = readFile("input")
  .strip()
  .splitLines()
  .mapIt(it.split(','))
  .mapIt((parseRange(it[0]), parseRange(it[1])))

block part1:
  var count = 0
  for (a, b) in ranges:
    if overlap(a, b) == min(a.length, b.length):
      count += 1

  echo "Part 1: ", count

block part2:
  var count = 0
  for (a, b) in ranges:
    if overlap(a, b) > 0:
      count += 1

  echo "Part 2: ", count
