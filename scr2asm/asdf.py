import sys
import struct

#arg 1 should be the name of the scr file to convert to asm
#arg 2 should be the size of the sprite (assuming will always be square)
#arg 3 flag for sprite (-s)


#----------------------Constants----------------------#
NUM_PIXELS = 6144
NUM_PIXELS_ATTR = 6912
NUM_COLS = 32
NUM_PIXEL_ROWS = 192
NUM_TOTAL_ROWS = 216 #includes attr bytes
NUM_BYTES_IN_BLOCK = 8
NUM_ATTR_BYTES = 768
#-----------------------------------------------------#


#--------------Pre-defined functions------------------#




def byteToInt(byte):
    return int('{0:08b}'.format(ord(byte)), 2)

#int('{0:08b}'.format(ord(byte)), 2)
#int('{0:08b}'.format(ord(holder)), 2)


def checkSSize(s_size):
    if s_size <= 0:
        print 'error: size must be greater than 0... returning'
        raise ValueError()

#-----------------------------------------------------------------------------
# Function that takes scr file and translates it into a 2D array to facilitate
# huffman encoding later on. 
#
# Note: Does not check inputs
# Inputs: 
#   1. scr_input - the scr file to be converted to asm
#   2. matrix - a 2D array of ints that should be 32 wide and 216 rows tall
# Outputs: returns the modified matrix that will match the scr file
#-----------------------------------------------------------------------------
def fillMat(scr_input, matrix):
    row = 0
    col = 0
    # count = 0
    with open(scr_input, "rb") as f:
        byte = f.read(1)
        while byte != "":
            matrix[row][col] = byteToInt(byte)
            byte = f.read(1)
            col += 1
            if col == NUM_COLS:
                col = 0
                row += 1
                if row == NUM_TOTAL_ROWS: #used to be NUM_PIXEL_ROWS
                    break
    return matrix


#-----------------------------------------------------------------------------
# Function to take the matrix of the scr file and fill two matricies with the 
# pixel and attribute bytes respectively. These will be pipelined into the 
# huffman method to write to the new file. The output matricies will be formatted
# such that it is possible to huffman encode simply by iterating through the 2D 
# array without any special logic or "skip" cases. 
#
# Note: Does not check inputs
# Inputs: 
#   1. s_size - the width and height (assume square for now) of the sprite
#   2. matrix - a 2D array of ints that should be 32 wide and 216 rows tall 
#               that matches the scr file
#   3. new_pixel_matrix - new matrix that should be s_size wide and s_size * 8 tall
#   4. new_attr_matrix - new matrix that should be s_size wide and s_size tall
# Outputs: returns a tuple of 2D arrays, the first being pixels and the second attr
#-----------------------------------------------------------------------------
def formatMat(s_size, matrix, new_pixel_matrix, new_attr_matrix):
    count = 0
    overlap = 0
    tc = 0
    for i in range(s_size * NUM_BYTES_IN_BLOCK): #loop through number of rows, 192
        new_pixel_matrix[i] = matrix[(8 * count) + overlap][0:s_size]
        # print str(matrix[(8 * count) + overlap][0:s_size])
        tc += 1

        count += 1
        if count == 8:
            count = 0
            overlap += 1

        # new_pixel_matrix[i] = matrix[count][0:s_size]
        # count += 1
        # overlap += 1
        # if (overlap) >= (s_size): #used to be len(matrix) but that's not right
        #     count += 2
        #     overlap = 0

    count = 0 #reset
    for i in range(s_size):
        new_attr_matrix[i] = matrix[NUM_PIXEL_ROWS + count][0:s_size]
        print matrix[NUM_PIXEL_ROWS + count][0:s_size]
        count += 1
    # print(tc)
    return (new_pixel_matrix, new_attr_matrix)


#-----------------------------------------------------------------------------
# Function that takes a new file and the pixel and attribute matricies and 
# huffman encodes both matricies directly into the new file. The pixel and 
# attribute section are delineated by the line "attr_bytes:\n"
#
# Note: Does not check inputs
# Inputs: 
#   1. new_asm_file - the new file to write the asm to
#   2. new_pixel_matrix - new matrix that should be s_size wide and s_size * 8 tall
#      and correctly filled with the correlated bytes in the scr
#   3. new_attr_matrix - new matrix that should be s_size wide and s_size tall
#      and correctly filled with the correlated bytes in the scr
# Outputs: None
#-----------------------------------------------------------------------------
def writeHuffToNewFile(new_asm_file, new_pixel_matrix, new_attr_matrix):
    with open(new_asm_file, 'w+') as nf:
        repeat_count = -1
        num = new_pixel_matrix[0][0]
        holder = num

        dc = 0

        dc2 = 0

        for i in range(len(new_pixel_matrix)):
            for j in range(len(new_pixel_matrix[0])):
                dc2 += 1
                if num == holder:
                    repeat_count += 1
                    if repeat_count >= 255:
                        repeat_count = 0
                        nf.write('\tdefb ' + str(num) + ',255' + '\n')
                        dc += 255
                else: 
                    if repeat_count != 0: #check for case when byte changes right after 255 repeats 
                        nf.write('\tdefb ' + str(num) + ',' + str(repeat_count) + '\n')
                        dc += repeat_count
                    num = holder #set byte to holder
                    repeat_count = 1 #reset repeat count
                    # print num
                holder = new_pixel_matrix[i][j]
        if num == holder: #the last two are the same
            repeat_count += 1
            nf.write('\tdefb ' + str(num) + ',' + str(repeat_count) + '\n')
            dc += repeat_count
        else: #the last two are not the same
            nf.write('\tdefb ' + str(num) + ',' + str(repeat_count) + '\n')
            nf.write('\tdefb ' + str(holder) + ',' + '1' + '\n')
            dc += (1 + repeat_count)
        nf.write('\tdefb 0,0\n')
        dc += 1

        #write attr bytes now, this is shitty code for now
        nf.write('attr_bytes:\n')
        num = new_attr_matrix[0][0]
        holder = num
        repeat_count = -1
        for i in range(len(new_attr_matrix)):
            for j in range(len(new_attr_matrix[0])):
                if num == holder:
                    repeat_count += 1
                    if repeat_count >= 255:
                        repeat_count = 0
                        nf.write('\tdefb ' + str(num) + ',255' + '\n')
                else: 
                    if repeat_count != 0: #check for case when byte changes right after 255 repeats 
                        nf.write('\tdefb ' + str(num) + ',' + str(repeat_count) + '\n')
                    num = holder #set byte to holder
                    repeat_count = 1 #reset repeat count
                holder = new_attr_matrix[i][j]

        if new_attr_matrix[-1][-1] == holder:
            nf.write('\tdefb ' + str(num) + ',' + str(repeat_count + 1) + '\n')
        else:
            nf.write('\tdefb ' + str(holder) + ',' + '1' + '\n')
        nf.write('\tdefb 0,0\n')
        dc += 1


#-----------------------------------------------------------------------------
# Function that takes a raw scr file and huffman encodes onto new file while 
# reading from the scr file. Encodes the whole file
#
# Note: Does not check inputs
# Inputs: 
#   1. scr_input - the scr file to huffman encode from
#   2. new_asm_file - the new file to write the asm to
# Outputs: None
#-----------------------------------------------------------------------------
def writeRegBackgroundHuff(scr_input, new_asm_file):
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

#-----------------------------------------------------#



#main

#get input arguments
scr_input = sys.argv[1] #file name of the scr file
new_asm_file = scr_input.rsplit( ".", 1 )[ 0 ] + '.asm'

#check if sprite or background
sprite = False
if len(sys.argv) > 2:
    sprite = True


if sprite: #do all the special stuff
    s_size = int(sys.argv[2]) #expecting 1 - 8 (number of pixel blocks hieght and width)
    checkSSize(s_size) # will raise value error to stop executing if wrong

    #create matrix of the scr file
    matrix = fillMat(scr_input, [[0 for x in range(NUM_COLS)] for y in range(NUM_TOTAL_ROWS)])
    #format the matrix into two seperate matricies, ready for direct translation to huffman encode
    matricies = formatMat(s_size, 
        matrix, 
        [[0 for x in range(s_size)] for y in range(s_size * NUM_BYTES_IN_BLOCK)], 
        [[0 for x in range(s_size)] for y in range(s_size)]) 
    new_pixel_matrix = matricies[0]
    new_attr_matrix = matricies[1]
    #officially write to the new file
    writeHuffToNewFile(new_asm_file, new_pixel_matrix, new_attr_matrix)

else: #regular background
    writeRegBackgroundHuff(scr_input, new_asm_file)

print 'Resulting asm written to ' + new_asm_file