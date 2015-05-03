#!/usr/bin/python
import struct
import socket

s = socket.socket( socket.AF_PACKET , socket.SOCK_RAW , socket.ntohs(0x0003))

counter = -1

while 1:
  data = s.recvfrom(10000)[0]
  if data[12] == '\x08' and data[13] == '\x00':
    if counter == -1:
      counter = ord(data[14])
      start = 15
    else:
      start = 14

    for i in range(start, len(data) - 14):
      d = ord(data[i])
      
      
      expected = (counter + 1) & 0xff
      
      print "Val: %d Expecting: %d" % (d, expected)

      if d != expected:
        print "ERROR %d %d" % (d, expected)
        counter = d
      else:
        counter = (counter + 1) & 0xff

    print "Done"
