#!/usr/bin/python
import struct
import socket
import sys

s = socket.socket( socket.AF_PACKET , socket.SOCK_RAW , socket.ntohs(0x0003))

while 1:
  for i in s.recvfrom(10000)[0][32:]:
    sys.stdout.write("%02x " % (ord(i)))

