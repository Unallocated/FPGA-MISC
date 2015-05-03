#!/usr/bin/python

import socket
import time

s = socket.socket( socket.AF_PACKET , socket.SOCK_RAW , socket.ntohs(0x0003))

startTime = time.time()
byteCount = 0
while 1:
  byteCount += len(s.recvfrom(10000)[0])
  print byteCount

  if byteCount >= 1024 * 1024  * 1:
    print "BW: %0.2f" % (byteCount / int(time.time() - startTime))
    startTime = time.time()
    byteCount = 0


