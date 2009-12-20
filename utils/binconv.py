# Converts binary sequence to asm db sequence
import sys, os, struct

srcfile = sys.argv[1]

binfile = open(srcfile, 'rb')
binseq = binfile.read()
binfile.close()

l = len(binseq)

chunkd = 0
dbchunk = 'db '
grouplen = 14
postfix = '' #'h'
separator = ' ' #', '

for i in range(0, l):
    d = struct.unpack('B', binseq[i])
    chunkd += 1
    hexd = (('%.2X' + postfix) % d)
    #if (hexd[0] >= 'A' and hexd[0] <= 'F'):
    #    hexd = '0' + hexd
    dbchunk += hexd
    if chunkd > grouplen:
        print dbchunk
        dbchunk = 'db '
        chunkd = 0
    else:
        dbchunk += separator