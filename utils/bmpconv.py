#-*- encoding: cp1251 -*-
# Converts bmp into binary sprite

import sys, struct
data = open(sys.argv[1] + '.bmp', 'rb').read()
start = 0

fileHeader = {}
fileHeaderData = struct.unpack('<HIHHI', data[start:start+14])

fileHeader['bfType'] = fileHeaderData[0]
fileHeader['bfSize'] = fileHeaderData[1]
fileHeader['bfReserved1'] = fileHeaderData[2]
fileHeader['bfReserved2'] = fileHeaderData[3]
fileHeader['bfOffbits'] = fileHeaderData[4]

print fileHeader

start += 14

bitmapInfo = {}
bif = struct.unpack('<IIIHHIIIIII', data[start:start+40])

bitmapInfo['biSize'] = bif[0]
bitmapInfo['biWidth'] = bif[1]
bitmapInfo['biHeight'] = bif[2]
bitmapInfo['biPlanes'] = bif[3]
bitmapInfo['biBitCount'] = bif[4]
bitmapInfo['biCompression'] = bif[5]
bitmapInfo['biSizeImage'] = bif[6]
bitmapInfo['biXPelsPerMeter'] = bif[7]
bitmapInfo['biXPelPerMeter'] = bif[8]
bitmapInfo['biClrUsed'] = bif[9]
bitmapInfo['biClrImportant'] = bif[10]

print bitmapInfo

if bitmapInfo['biBitCount'] != 8:
    print 'Supported only 8-bit bitmaps.'
    sys.exit(1)
if bitmapInfo['biCompression'] != 0:
    print 'Compressed bitmaps is not supported.'
    sys.exit(2)

start += 40

fw = open(sys.argv[1] + '.plt', 'wb')
# Reading Palette
for i in range(0, bitmapInfo['biClrUsed']):
    colors = struct.unpack('BBB', data[start:start+3])
    start += 4
    fw.write(struct.pack('BBB', colors[2] / 4, colors[1] / 4, colors[0] / 4))
# Padding to 768 bytes
if bitmapInfo['biClrUsed'] < 256:
    for i in range(0, 256-bitmapInfo['biClrUsed']):
        fw.write('\x00\x00\x00')
fw.close()

# Reading Image
fw = open(sys.argv[1] + '.spr', 'wb')
#fw.write('BS');
#fw.write(struct.pack('HHH', bitmapInfo['biWidth'], bitmapInfo['biHeight'], bitmapInfo['biSizeImage']));
fw.write(data[fileHeader['bfOffbits']:fileHeader['bfOffbits']+bitmapInfo['biSizeImage']-2])
fw.close()

print 'Done.'