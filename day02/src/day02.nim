import std/[strutils, math]

const aOffset = int('A')
const xOffset = int('X')

let input = readFile("input").strip().splitLines()

proc score(oppMove: int, myMove: int): int =
  var score = myMove + 1

  let delta = myMove - oppMove
  case delta
    of 0: score += 3 # draw
    of 1, -2: score += 6 # win
    else: discard # loss

  return score


block part1:
  var total = 0
  for line in input:
    # 0: Rock, 1: Paper, 2: Scissors
    let oppMove = int(line[0]) - aOffset
    let myMove = int(line[2]) - xOffset
    total += score(oppMove, myMove)

  echo "Part 1: ", total

block part2:
  var total = 0
  for line in input:
    # 0: Rock, 1: Paper, 2: Scissors
    let oppMove = int(line[0]) - aOffset
    # -1: Lose, 0: Draw, 1: Win
    let outcome = int(line[2]) - xOffset - 1

    # Euclidean modulus to properly handle negative numbers
    let myMove = euclMod((oppMove + outcome), 3)
    total += score(oppMove, myMove)

  echo "Part 2: ", total
