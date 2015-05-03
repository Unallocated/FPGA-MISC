#!/bin/python

import sys
from struct import unpack

f = open(sys.argv[1], "rb")

f.read(int(sys.argv[2]))

counter = -1
sinceError = 0
totalBytes = 0
totalErrors = 0
while True:
  d = f.read(1024)
  if not d:
    break
  
  for i in range(0, len(d)):
    val = unpack('B', d[i])[0]
    totalBytes += 1
    if counter == -1:
      counter = val
    else:
      if ((counter + 1) & 0xff) != val:
        print "Error after %d bytes.  Expected %02x got %02x" % (sinceError, counter+1, val)
        sinceError = 0
        totalErrors += 1
        counter = val
      else:
        sinceError += 1
        counter = (counter + 1) & 0xff


    #print "%02x" % unpack('B', f.read(1))

print "Read %d bytes with %d errors giving a BER of %f" % (totalBytes, totalErrors, float(totalErrors)/float(totalBytes))
