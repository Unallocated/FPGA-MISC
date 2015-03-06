from struct import pack
from serial import Serial
import sys

port = sys.argv[1]
rate = sys.argv[2]

angle_inc = int(sys.argv[3])

s = Serial(port, rate)
s.write('\x55\x55\x03\x00')

cs = 0x03 ^ 0x00

print 'hi'

for i in bytearray(pack('>H', angle_inc)):
	print i
	cs = cs ^ i
	s.write(pack('B', i))

s.write(pack('B', cs))
