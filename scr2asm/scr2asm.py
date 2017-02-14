import sys
import struct


new_file  = 'out.asm'
counter = 0;
with open("test_sprite.scr", "rb") as f:
    with open(new_file, 'w+') as nf:
        byte = f.read(1)
        while byte != "":
            # Do stuff with byte.
            if counter == 0:
                nf.write('\t' + 'defb: ' + str(int('{0:08b}'.format(ord(byte)), 2)) + ', ')
                counter += 1
            elif counter > 0 and counter < 15:
                nf.write(str(int('{0:08b}'.format(ord(byte)), 2)) + ', ')
                counter += 1
            elif counter >= 15:
                nf.write(str(int('{0:08b}'.format(ord(byte)), 2)) + '\n')
                counter = 0

            
            byte = f.read(1)
            # if byte > 127:
            #      print (256-byte) * (-1)
            # else:
            #      print byte 