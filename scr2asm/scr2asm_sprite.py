import sys
import struct

# 62 bytes in a row  (31 pixel bytes 31 attribute bytes) assuming 6 by 6 sprites
# after reading 12 throw out the next 62 - 12 = 50

new_file  = 'out.asm'
counter = 0;
throw_out_counter = 0;
repeat_counter = 0;
total_counter = 6 * 6 * 8
with open("test_sprite.scr", "rb") as f:
    with open(new_file, 'w+') as nf:
        byte = f.read(1)
        holder = byte;
        while byte != "" and total_counter != 0:
            if throw_out_counter > 6:
                if throw_out_counter >= (32 - 6):
                    throw_out_counter = 0; #on to the next row
                else:
                    throw_out_counter += 1;
                byte = f.read(1)
                continue;
            # Do stuff with byte.
            if counter == 0:
                nf.write('\t' + 'defb ' + str(int('{0:08b}'.format(ord(byte)), 2)) + ', ')
                counter += 1
            elif counter > 0 and counter < 15:
                nf.write(str(int('{0:08b}'.format(ord(byte)), 2)) + ', ')
                counter += 1
            elif counter >= 15:
                nf.write(str(int('{0:08b}'.format(ord(byte)), 2)) + '\n')
                counter = 0

            total_counter -= 1

            throw_out_counter += 1
            byte = f.read(1)
            # if byte > 127:
            #      print (256-byte) * (-1)
            # else:
            #      print byte 