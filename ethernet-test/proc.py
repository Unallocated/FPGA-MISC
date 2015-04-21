import socket
import sys

s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(0x0003))

#f = open('/tmp/fifo', 'wb')

while 1:
  sys.stdout.write(s.recvfrom(10000)[0][14:])

