from struct import pack
from serial import Serial
import sys

port = sys.argv[1]
rate = sys.argv[2]

counter_max = int(sys.argv[3])

s = Serial(port, rate)
s.write('\x55\x55\x05\x02')

cs = 0x05 ^ 0x02

print 'hi'

for i in bytearray(pack('>I', counter_max)):
	print i
	cs = cs ^ i
	s.write(pack('B', i))

s.write(pack('B', cs))
