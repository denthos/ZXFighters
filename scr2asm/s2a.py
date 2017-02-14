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
    counter = 0
    repeat_count = 0
    throw_out_counter = 0
    total_counter = s_size * s_size * 8 #counts the y axis to stop after s_size rows
    total_num_bytes_read = 0 #clever way to get rid of this
    with open(scr_input, "rb") as f:
        with open(new_asm_file, 'w+') as nf:
            byte = f.read(1) #byte to compare to
            holder = byte #changes every read
            total_num_bytes_read += 1
            while byte != "" and total_counter != 0:
                #while the two pointers are equal increment the counter to eventually print
                while holder != "" and byteToInt(byte) == byteToInt(holder) and total_counter != 0:
                    if throw_out_counter >= s_size:
                        if throw_out_counter >= (32): #32 - size i don't think is right 
                            throw_out_counter = 0;
                            holder = f.read(1)
                        else:
                            throw_out_counter += 1
                            f.read(1) #Keep track of this?
                        total_num_bytes_read += 1
                        continue;
                        
                        
                    throw_out_counter += 1; #keep track of how many in a row we read, only read 12 for 6x6
                    repeat_count += 1;
                    total_num_bytes_read += 1
                    total_counter -= 1 # Decrement the total number of bytes left to be read 
                    #check if throw_out_counter is now larger than the width of the size we need to read
                    if throw_out_counter >= s_size:
                        f.read(1) #throw out byte cuz it's out of range
                    else:
                        holder = f.read(1) #otherwise keep it
                    if repeat_count >= 255:
                        repeat_count = 0
                        nf.write('\tdefb ' + str(byteToInt(byte)) + ',255' + '\n')
                    
                #no longer equal 
                # nf.write('\n\nbyte: ' + str(byteToInt(byte)) + ', holder: ' + str(byteToInt(holder)) + '\n')
                if repeat_count != 0: #check for case when byte changes right after 255 repeats 
                    nf.write('\tdefb ' + str(byteToInt(byte)) + ',' + str(repeat_count) + '\n')
                byte = holder #set byte to holder
                repeat_count = 0 #reset repeat count

            #start reading the attribute bytes
            nf.write('\n\nattr_bytes:\n')
            f.read((6144 - total_num_bytes_read)) #next byte read after this will be first attr byte
            byte = f.read(1)
            print byteToInt(byte)
            holder = byte
            total_attr_bytes = s_size * s_size
            throw_out_counter = 0 #reset
            repeat_count = 0 #reset
            while byte != "" and total_attr_bytes != 0:
                while holder != "" and byteToInt(byte) == byteToInt(holder) and total_attr_bytes != 0:
                    # if throw_out_counter >= s_size:
                    #     if throw_out_counter >= (32): #32 - size i don't think is right 
                    #         throw_out_counter = 0;
                    #         holder = f.read(1) #should I decrement attr_bytes after this?
                    #     else:
                    #         throw_out_counter += 1
                    #         f.read(1) #Keep track of this?
                    #     continue;
                    # throw_out_counter += 1; #keep track of how many in a row we read, only read 12 for 6x6
                    repeat_count += 1;
                    total_num_bytes_read += 1
                    # total_attr_bytes -= 1 # Decrement the total number of bytes left to be read 
                    #check if throw_out_counter is now larger than the width of the size we need to read
                    if throw_out_counter >= s_size:
                        f.read(1) #throw out byte cuz it's out of range
                    else:
                        holder = f.read(1) #otherwise keep it
                    if repeat_count >= 255:
                        repeat_count = 0
                        nf.write('\tdefb ' + str(byteToInt(byte)) + ',255' + '\n')
                #no longer equal 
                if repeat_count != 0: #check for case when byte changes right after 255 repeats 
                    nf.write('\tdefb ' + str(byteToInt(byte)) + ',' + str(repeat_count) + '\n')
                byte = holder #set byte to holder
                repeat_count = 0 #reset repeat count



else: #regular background
    counter = 0;
    repeat_count = 0;
    with open(scr_input, "rb") as f:
        with open(new_asm_file, 'w+') as nf:
            byte = f.read(1)
            holder = byte
            while byte != "":
                #while the two pointers are equal increment the counter to eventually print
                while holder != "" and byteToInt(byte) == byteToInt(holder):
                    repeat_count += 1;
                    holder = f.read(1)
                    if repeat_count == 255:
                        repeat_count = 0
                        nf.write('\tdefb ' + str(byteToInt(byte)) + ',255' + '\n')
                #no longer equal 
                if repeat_count != 0: #check for case when byte changes right after 255 repeats 
                    nf.write('\tdefb ' + str(byteToInt(byte)) + ',' + str(repeat_count) + '\n')
                byte = holder #set byte to holder
                repeat_count = 0 #reset repeat count
                # repeat_count += 1 #add one for the first one found 

print 'Resulting asm written to ' + new_asm_file