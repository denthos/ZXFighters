import sys

# argv[0] - filename
# argv[1] - name of character to write init script for

# Example:        python ByteAddressUtils.py shoe

def print_extra():
	print "        ld (hl),c"
	print "        inc hl"
	print "        ld (hl),b"
	print "        inc hl"

def attack_skip():
	print "        inc hl"
	print "        inc hl"
	print "        inc hl"

def attack_skip2():
	print "        inc hl"
	print "        inc hl"
	print "        inc hl"
	print "        inc hl"

name = sys.argv[1]
print name + "_init:"
print "        ld bc," + name + "_sprite_idle_1"
print_extra()
print "        ld bc," + name + "_sprite_idle_2"
print_extra()
print "        ld bc," + name + "_sprite_walk_forward_1"
print_extra()
print "        ld bc," + name + "_sprite_walk_forward_2"
print_extra()
print "        ld bc," + name + "_sprite_block"
print_extra()
print "        ld bc," + name + "_sprite_hit"
print_extra()


attack_skip()
print "        ld bc," + name + "_sprite_attack_1_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_1_2"
print_extra()
attack_skip2()


attack_skip()
print "        ld bc," + name + "_sprite_attack_2_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_2_2"
print_extra()
attack_skip2()


attack_skip()
print "        ld bc," + name + "_sprite_attack_3_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_3_2"
print_extra()

print "        ret"