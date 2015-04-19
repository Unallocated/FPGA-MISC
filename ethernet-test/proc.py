import socket

s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW, socket.ntohs(0x0003))

f = open('/tmp/samps', 'wb')


while 1:
  f.write(s.recvfrom(10000)[0][14:])
  print "Read packet"
