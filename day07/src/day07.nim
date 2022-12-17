import std/[strutils, sequtils]

type
  NodeKind = enum Dir, File
  Node = ref object
    case kind: NodeKind
    of Dir: children: seq[Node]
    of File: size: int

    parent: Node
    name: string

let commands = readFile("input")
  .strip()
  .split("$ ")
  .filterIt(it.len > 0)

proc totalSize(node: Node): int =
  case node.kind:
    of Dir:
      for n in node.children: result += totalSize(n)
    of File:
      result = node.size

proc parseFilesystem(): Node =
  let root = Node(kind: Dir, name: "/")
  var activeDir = root

  for i in 1..commands.high:
    let line = commands[i].strip().splitLines().filterIt(it.len > 0)
    let command = line[0]

    if command.startsWith("cd"):
      let name = command.splitWhitespace()[1]
      case name:
      of "..": activeDir = activeDir.parent
      else: activeDir = activeDir.children.filterIt(it.name == name)[0]

    if command.startsWith("ls"):
      let items = line[1..line.high]
      for item in items:
        let node = item.splitWhitespace()

        if node[0] == "dir":
          activeDir.children.add(
            Node(kind: Dir, name: node[1], parent: activeDir)
          )
        else:
          activeDir.children.add(
            Node(
              kind: File,
              name: node[1],
              size: parseInt(node[0]),
              parent: activeDir
            )
          )

  return root

block part1:
  proc dirSum(node: Node): int =
    case node.kind:
    of Dir:
      let total = totalSize(node)
      if total < 100000:
        result += total
      for n in node.children:
        result += dirSum(n)
    of File:
      discard

  let fs = parseFilesystem()
  echo "Part 1: ", dirSum(fs)

block part2:
  let fs = parseFilesystem()
  let rootDirSize = totalSize(fs)
  let amountToDelete = 30000000 - (70000000 - rootDirSize)

  var closestTotal = rootDirSize
  proc closestDir(node: Node) =
    case node.kind:
      of Dir:
        let total = totalSize(node)
        if total >= amountToDelete and total < closestTotal:
          closestTotal = total
        for n in node.children:
          closestDir(n)
      of File:
        discard

  closestDir(fs)
  echo "Part 2: ", closestTotal
