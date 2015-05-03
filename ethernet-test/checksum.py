#!/bin/python

import sys
import struct

hexString = sys.argv[1]

if len(hexString) %2 != 0:
  print "ACK"
  sys.exit(1)

if len(hexString) % 4 == 2:
  hexString += "00"


print hexString
val = 0
for i in range(0, len(hexString), 4):
  print hexString[i:i+4]
  val += int(hexString[i:i+4], 16)
  if val & 0xffff0000 != 0:
    val = (val & 0x0000ffff) + ((val & 0xffff0000) >> 16)
    print "shifted"

print "%08x" % (val)
#if val & 0xffff0000 != 0:
#  val = (val & 0x0000ffff) + ((val & 0xffff0000) >> 16)
#print "%08x" % val
val = (~ (val & 0xffff)) & 0xffff
print "%08x" % val
