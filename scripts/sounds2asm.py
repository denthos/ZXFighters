import sys #system
import re #regular expressions

###########
# Script to generate an asm file that when compiled down to tape will use the spectrum beeps to make sound.
# Input: Single file 
# 	File format: (arg1, arg2, 3arg)
# 	arg1 = note the be played: a,b,c,d,e,f,g,a#,c#,d#,e,f#,g
# 	arg2 = duration in seconds (float | int)
#	arg3 = how many octaves from the original note. positive numbers go up an octave
#        while negative numbers go down an octave. I haven't tested how many octaves 
#		 the spectrum can handle but it's safe to assume that at some point the notes
#		 will lose accuracy
# Output: An asm file (name = given_file_name + '.asm')
# Note: I may improve this script if need be later on. I check for some errors but not all
#       so be kind to the script :). Feel free to change anything, or just improve the code. 
#       This is just a quick and dirty script to save some time writing songs for the z80. 
###########

freqs = {"a"  : (440), 
     "a#" : (466.16), #233.08
     "b"  : (493.88 ), #246.94
     "c"  : (523.26), #261.63 
     "c#" : (554.36), #277.18
     "d"  : (293.66), #18.35375, 36.7075, 73.415, 146.83, 
     "d#" : (311.13), 
     "e"  : (329.63),  #164.815
     "f"  : (349.63), 
     "f#" : (369.99), 
     "g"  : (392), #196
     "g#" : (415.30), #207.65
     "r"  : (1) #rest
     }

new_file  = sys.argv[1] + '.asm'
with open(sys.argv[1],"r") as f:
	with open(new_file, 'w+') as nf:
		content = f.readlines()
		line ="".join(content).lower()
		content = re.findall('\[[^\]]*\]|\([^\)]*\)|\"[^\"]*\"|\S+',line)
		content = ["".join(x.split()) for x in content]
		for note in content:
			args = [x.strip() for x in note[1:-1].split(',')]
			if not len(args) == 3:
				raise IndexError('Please make sure all notes are a comma delimited list of 3 arguments')
			letter = args[0]
			try:
				duration = float(args[1])
			except: 
				error = '\'' + args[1] + '\' is not a valid duration'
				raise ValueError(error)
			try:
				octave = int(args[2])
			except:
				error = '\'' + args[2] + '\' is not a valid octave'
				raise ValueError(error)
			#find the letter in the dictionary d
			freq = freqs.get(letter, None)
			if freq == None:
				error = '\'' + letter + '\' is not a valid note'
				raise ValueError(error)
			#check for rest
			
			#do calculations for correct number 
			#adjust octave based on arg 3
			#if octave is negative then divide else multiply
			if octave < 0:
				freq = (freq/pow(2,octave))
			elif octave > 0:
				freq = (freq*pow(2,octave))
			pitch = (437500/freq) - 30.125
			duration = freq * duration
			nf.write('\t' + 'ld hl, ' + str(int(round(pitch))) + '\n')
			nf.write('\t' + 'ld de, ' + str(int(round(duration))) + '\n')
			nf.write('\t' + 'call 949\n')

# import fileinput
# for line in fileinput.input():
#     process(line)

