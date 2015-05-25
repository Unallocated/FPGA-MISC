#!/usr/bin/python

import serial
import struct
import sys

ser = serial.Serial(sys.argv[1], int(sys.argv[2]))
def send(byte):
  print "Sending %02x" % (ord(byte))
  ser.write(byte)


ser.write('\x55\x55')

hexString = sys.argv[3].replace(' ','').decode('hex')

#ser.write(struct.pack('B', len(hexString) / 2))
send(struct.pack('B', len(sys.argv[3]) / 2))

cs = len(sys.argv[3]) / 2

for i in bytearray(hexString):
  #ser.write(struct.pack('B', i))
  send(struct.pack('B', i))
  cs = cs ^ i
  print "cs: %02x" % cs


#ser.write(struct.pack('B', cs))
send(struct.pack('B', cs))



