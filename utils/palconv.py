import sys, struct
# Converts ACT palette into VGA-compatible palette
data = open(sys.argv[1] + '.act', 'rb').read()
fw = open(sys.argv[1] + '.plt', 'wb')
start = 0
for i in range(0, 256):
    colors = struct.unpack('BBB', data[start:start+3])
    start += 3
    colors = struct.pack('BBB', colors[0] / 4, colors[1] / 4, colors[2] / 4)
    fw.write(colors)
fw.close()

print 'Done.'