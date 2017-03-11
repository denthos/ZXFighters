#prints mirrored bits for 0-255 (lookup table)
for i in range(0,256):
    print '\tdefb: '+'{:08b}'.format(i)[::-1] + 'B'