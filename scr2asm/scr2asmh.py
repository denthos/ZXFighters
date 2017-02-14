import sys
import struct


new_file  = 'out2.asm'
counter = 0;
repeat_count = 0;
with open("test_sprite.scr", "rb") as f:
    with open(new_file, 'w+') as nf:
    	byte = f.read(1)
        holder = byte
        while byte != "":
            #while the two pointers are equal increment the counter to eventually print
            while holder != "" and int('{0:08b}'.format(ord(byte)), 2) == int('{0:08b}'.format(ord(holder)), 2):
                repeat_count += 1;
                holder = f.read(1)
                if repeat_count == 255:
                    repeat_count = 0
                    nf.write('\tdefb ' + str(int('{0:08b}'.format(ord(byte)), 2)) + ',255' + '\n')
            #no longer equal 
            if repeat_count != 0:
                nf.write('\tdefb ' + str(int('{0:08b}'.format(ord(byte)), 2)) + ',' + str(repeat_count) + '\n')
            byte = holder #set byte to holder
            repeat_count = 0 #reset repeat count
            # repeat_count += 1 #add one for the first one found 