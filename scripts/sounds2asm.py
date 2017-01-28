import sys #system
import re #regular expressions

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
     "g#" : (415.30) #207.65
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

