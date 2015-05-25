from struct import pack
from serial import Serial
import sys

port = sys.argv[1]
rate = sys.argv[2]

flags = sys.argv[3]

s = Serial(port, rate)
s.write('\x55\x55\x03\x01')

cs = 0x03 ^ 0x01

for i in bytearray(pack('H', int(flags, 2))):
	cs = cs ^ i
	s.write(pack('B', i))

s.write(pack('B', cs))
