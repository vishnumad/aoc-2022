import std/[strutils, sets]

let input = readFile("input").strip()

proc allItemsUnique(str: string): bool =
  return len(str) == len(toHashSet(str))

block part1:
  for i in 4..input.high:
    if allItemsUnique(input[(i - 4)..<i]):
      echo "Part 1: ", i
      break

block part2:
  for i in 14..input.high:
    if allItemsUnique(input[(i - 14)..<i]):
      echo "Part 2: ", i
      break
