import socket
import sys

s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(0x0003))

#f = open('/tmp/fifo', 'wb')

while 1:
  a = s.recvfrom(100000)[0]
  if(a[6:12] == '\x01\x02\x03\x04\x05\x06'):
    sys.stdout.write(s.recvfrom(10000)[0][42:])

