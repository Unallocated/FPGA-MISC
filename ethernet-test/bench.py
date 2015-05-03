#!/usr/bin/python

import socket
import time

s = socket.socket( socket.AF_PACKET , socket.SOCK_RAW , socket.ntohs(0x0003))

startTime = time.time()
byteCount = 0
while 1:
  byteCount += len(s.recvfrom(10000)[0]) - 20 - 8 - 14

  if byteCount >= 1024 * 1024  * 1:
    print "BW: read %d bytes in %f seconds (%0.2f)" % (byteCount, time.time() - startTime, byteCount / (time.time() - startTime))
    startTime = time.time()
    byteCount = 0


