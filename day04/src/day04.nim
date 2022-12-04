import std/[strutils, sequtils]

type
  Range = tuple[low, high: int]

proc parseRange(literal: string): Range =
  let range = literal.split('-')
  return (low: parseInt(range[0]), high: parseInt(range[1]))

proc length(range: Range): int =
  return range.high - range.low + 1

proc span(a: Range, b: Range): Range =
  return (low: min(a.low, b.low), high: max(a.high, b.high))

proc overlap(a: Range, b: Range): int =
  let spanLength = span(a, b).length
  let totalLength = a.length + b.length
  return totalLength - spanLength

let ranges = readFile("input")
  .strip()
  .splitLines()
  .mapIt(it.split(','))
  .mapIt((parseRange(it[0]), parseRange(it[1])))

block part1:
  var count = 0
  for (a, b) in ranges:
    let overlap = overlap(a, b)
    if overlap >= a.length or overlap >= b.length:
      count += 1

  echo "Part 1: ", count

block part2:
  var count = 0
  for (a, b) in ranges:
    if overlap(a, b) > 0:
      count += 1

  echo "Part 2: ", count

