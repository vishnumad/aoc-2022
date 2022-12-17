import std/[strutils, strscans, tables]

type
  Instr = tuple[amount: int, src: int, dest: int]

let input = readFile("input").split("\n\n")
let cratesInput = input[0].splitLines()
let instrInput = input[1].strip().splitLines()

proc parseCrates(): Table[int, seq[char]] =
  result = initTable[int, seq[char]]()
  for line in cratesInput:
    for i in countup(1, len(line), 4):
      let stackIndex = ((i - 1) div 4) + 1
      if not result.hasKey(stackIndex): result[stackIndex] = @[]
      if line[i].isUpperAscii: result[stackIndex].insert(line[i], 0)

proc parseInstruction(line: string): Instr =
  var amount, src, dest = 0
  discard line.scanf("move $i from $i to $i", amount, src, dest)
  return (amount, src, dest)

proc getTopmostCrates(crates: Table[int, seq[char]]): string =
  for i in 1 .. len(crates):
    result.add(crates[i][^1])

block part1:
  var crates = parseCrates()
  for line in instrInput:
    let instr = parseInstruction(line)
    for i in 0..<instr.amount:
      let crate = crates[instr.src].pop()
      crates[instr.dest].add(crate)

  echo "Part 1: ", getTopmostCrates(crates)

block part2:
  var crates = parseCrates()
  for line in instrInput:
    let instr = parseInstruction(line)
    let length = crates[instr.src].high
    crates[instr.dest].add(crates[instr.src][^instr.amount..length])
    crates[instr.src] = crates[instr.src][0..(length - instr.amount)]

  echo "Part 2: ", getTopmostCrates(crates)
