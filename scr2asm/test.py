import sys
import struct

#arg 1 should be the name of the scr file to convert to asm
#arg 2 should be the size of the sprite (assuming will always be square)
#arg 3 flag for sprite (-s)

#--------------Pre-defined functions------------------#

def byteToInt(byte):
    return int('{0:08b}'.format(ord(byte)), 2)

#int('{0:08b}'.format(ord(byte)), 2)
#int('{0:08b}'.format(ord(holder)), 2)
#-----------------------------------------------------#




#get input arguments
scr_input = sys.argv[1] #file name of the scr file
new_asm_file = scr_input.rsplit( ".", 1 )[ 0 ] + '.asm'

#check input here


#check if sprite or background
sprite = False
if len(sys.argv) > 2:
    sprite = True

if sprite:
    s_size = int(sys.argv[2]) #expecting 1 - 8 (number of pixel blocks hieght and width)
    if s_size <= 0:
        print 'error: size must be greater than 0... returning'
        raise ValueError()


    repeat_count = 0
    row = 0
    col = 0
    total_pixels_to_read = 6144

    debug1 = 0
    debug2 = 0

    with open(scr_input, "rb") as f:
        with open(new_asm_file, 'w+') as nf:
            byte = f.read(1) #byte to compare to
            holder = byte #changes every read
            # total_num_bytes_read += 1 #include the first byte just read
            # total_pixels_to_read -= 1
            while total_pixels_to_read != 0:
                while holder != "" and byteToInt(byte) == byteToInt(holder) and total_pixels_to_read != 0: 
                    if col < s_size and row < s_size:
                        debug1 += 1
                        print byteToInt(byte)

                        repeat_count += 1
                        if repeat_count >= 255:
                            repeat_count = 0
                            nf.write('\tdefb ' + str(byteToInt(byte)) + ',255' + '\n')
                    else:
                        debug2 += 1
                        if col > 31:
                            col = -1 #reset
                            row += 1
                            if row > 23:
                                row = 0 #reset


                    col += 1
                    total_pixels_to_read -= 1
                    if col < s_size and row < s_size:
                        holder = f.read(1)
                    else:
                        f.read(1)
                    
                if repeat_count != 0: #check for case when byte changes right after 255 repeats 
                    nf.write('\tdefb ' + str(byteToInt(byte)) + ',' + str(repeat_count) + '\n')
                byte = holder #set byte to holder
                repeat_count = 0 #reset repeat count

    print debug1
    print debug2






