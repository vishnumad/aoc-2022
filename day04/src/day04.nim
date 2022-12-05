import std/[strutils, strscans, sequtils]

type
  Range = tuple[low, high: int]

proc length(range: Range): int =
  return range.high - range.low + 1

proc overlap(a: Range, b: Range): int =
  let spanLength = max(a.high, b.high) - min(a.low, b.low) + 1
  let totalLength = a.length + b.length
  return totalLength - spanLength

proc parseRanges(line: string): tuple[a: Range, b: Range] =
  var lowA, highA, lowB, highB = 0
  discard line.scanf("$i-$i,$i-$i", lowA, highA, lowB, highB)
  return ((low: lowA, high: highA), (low: lowB, high: highB))

let ranges = readFile("input")
  .strip()
  .splitLines()
  .mapIt(parseRanges(it))

block part1:
  let count = ranges.countIt(overlap(it.a, it.b) == min(it.a.length, it.b.length))
  echo "Part 1: ", count

block part2:
  let count = ranges.countIt(overlap(it.a, it.b) > 0)
  echo "Part 2: ", count
