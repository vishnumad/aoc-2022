import std/[strutils, sets]

const lowercaseOffset = int('a')
const uppercaseOffset = int('A') - 26

let input = readFile("input").strip().splitLines()

proc priority(c: char): int =
  if c.isLowerAscii:
    return int(c) - lowercaseOffset + 1
  else:
    return int(c) - uppercaseOffset + 1

block part1:
  var totalPriority = 0
  for line in input:
    let midpoint = len(line) div 2
    for i in 0 ..< midpoint:
      let foundIndex = line.find(line[i], midpoint, line.high)
      if foundIndex != -1:
        totalPriority += priority(line[foundIndex])
        break

  echo "Part 1: ", totalPriority

block part2:
  var totalPriority = 0
  for i in countup(0, input.high, 3):
    let elfA = input[i].toHashSet()
    let elfB = input[i + 1].toHashSet()
    let elfC = input[i + 2].toHashSet()

    var badge = elfA.intersection(elfB).intersection(elfC)
    totalPriority += priority(badge.pop())

  echo "Part 2: ", totalPriority

