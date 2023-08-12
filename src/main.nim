import std/lists
import std/sequtils
import std/strutils
import std/strformat
import os

let params = os.commandLineParams()
var 
  debug: bool = false
  file: File = stdin

for param in params:
  case param:
    of "-d":
      debug = true
    else:
      file = open(param)


var base = initDoublyLinkedRing[uint8]()

for i in countup(0, 255):
  let n = newDoublyLinkedNode[uint8](0)
  base.add n

var head = base.head
var head_index: uint8 = 0

type
  loopn = tuple[sike: uint, pini: uint]
var loopl = newSeq[loopn]()

var instrp: uint = 0

proc sinpin() =
  head = head.next
  head_index += 1

proc monsi() =
  head = head.prev
  head_index -= 1

proc wan() =
  head.value = head.value + 1

proc tu() =
  head.value = head.value + 2

proc luka() =
  head.value = head.value + 5

proc ala() =
  head.value = 0

proc ike() =
  head.value = 255 - head.value + 1

proc unpa() =
  head.value = head.prev.value + head.value

proc toki() =
  stdout.write char(head.value)

proc sike() =
  if head.value != 0:
    if len(loopl) == 0 or loopl[^1].sike != instrp:
      var tup: loopn = (sike: instrp, pini: instrp)
      loopl.add(tup)
  else:
    instrp = loopl[^1].pini
    loopl.delete(high(loopl))

proc pini(): range[-1..255] =
  if len(loopl) == 0:
    return head.value
  else:
    if loopl[^1].pini == loopl[^1].sike:
      loopl[^1].pini = instrp
    instrp = loopl[^1].sike - 1
    return -1


let program = split(readAll(file))
close(file)

var steps: uint64 = 0
let program_length: uint = uint(len(program))
while instrp < program_length:

  if debug:
    echo &"(Step counter: {steps})"
    echo &"<-- [{head_index - 1:0>3}] [{head_index:0>3}] [{head_index + 1:0>3}] -->"
    echo &"<-- [{head.prev.value:<3}] [{head.value:<3}] [{head.next.value:<3}] -->"
    echo &"Next Instruction: {program[instrp]} \n"

  case program[instrp]
  of "sinpin":
    sinpin()
  of "monsi":
    monsi()
  of "wan":
    wan()
  of "tu":
    tu()
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
  steps += 1
  if steps > 400:
    system.quit()

echo ""
system.quit(int(head.value))
