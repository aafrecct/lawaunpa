import std/lists
import std/strutils
import os

let DEBUG = if os.paramCount() == 1: os.paramStr(1) == "-d" else: false

var base = initDoublyLinkedRing[range[0..255]]()

for i in countup(1, 64):
  let n = newDoublyLinkedNode[range[0..255]](0)
  base.add n

var head = base.head
type
  loopn = tuple[sike: int, pini: int]
var loopl= initSinglyLinkedList[loopn]()
var instrp: int = 0

proc sinpin() =
  head = head.next

proc monsi() =
  head = head.prev

proc wan() =
  head.value = (head.value + 1) mod 256

proc to() =
  head.value = (head.value + 2) mod 256

proc luka() =
  head.value = (head.value + 5) mod 256

proc ala() =
  head.value = 0

proc ike() =
  head.value = (256 - head.value) mod 256

proc unpa() =
  head.value = (head.prev.value + head.value) mod 256

proc toki() =
  stdout.write char(head.value)

proc sike() =
  if head.value != 0:
    if loopl.head == nil or loopl.head.value.sike != instrp:
      var tup: loopn = (sike: instrp, pini: -1)
      let tupn = newSinglyLinkedNode[loopn](tup)
      loopl.add(tupn)
  else:
    instrp = loopl.head.value.pini
    loopl.remove(loopl.head)

proc pini(): range[-1..255] =
  if loopl.head == nil:
    return head.value
  else:
    if loopl.head.value.pini == -1:
      loopl.head.value.pini = instrp
    instrp = loopl.head.value.sike - 1
    return -1


let program = split(readAll(stdin))
while instrp < len(program):
  if DEBUG:
    echo program[instrp]
    echo "... - ", head.prev.value, " - ", head.value, " - " , head.next.value, " - ..."
    echo ""

  case program[instrp]
  of "sinpin":
    sinpin()
  of "monsi":
    monsi()
  of "wan":
    wan()
  of "to":
    to()
  of "luka":
    luka()
  of "ala":
    ala()
  of "ike":
    ike()
  of "unpa":
    unpa()
  of "sike":
    sike()
  of "toki":
    toki()
  of "pini":
    if pini() != -1:
      break

  instrp += 1

echo ""
system.quit(head.value)
