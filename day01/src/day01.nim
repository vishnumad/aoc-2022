import std/[strutils, algorithm]

let input = readFile("input").splitLines()

var elfCalories: seq[int] = @[]

var current = 0
for line in input:
  if line == "":
    elfCalories.add(current)
    current = 0
  else:
    current += parseInt(line)

elfCalories.sort(SortOrder.Descending)

block part1:
  echo "Part 1: ", elfCalories[0]

block part2:
  echo "Part 2: ", elfCalories[0] + elfCalories[1] + elfCalories[2]
