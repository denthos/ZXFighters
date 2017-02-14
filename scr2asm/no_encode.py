import sys

#--------------Pre-defined functions------------------#

def byteToInt(byte):
    return int('{0:08b}'.format(ord(byte)), 2)

#int('{0:08b}'.format(ord(byte)), 2)
#int('{0:08b}'.format(ord(holder)), 2)
#-----------------------------------------------------#




#get input arguments
scr_input = sys.argv[1] #file name of the scr file
new_asm_file = scr_input.rsplit( ".", 1 )[ 0 ] + '2.asm'

with open(scr_input, "rb") as f:
    with open(new_asm_file, 'w+') as nf:
    	byte = f.read(1)
    	while byte != "":
    		nf.write(str(byteToInt(byte)) + '\n')
    		byte = f.read(1)