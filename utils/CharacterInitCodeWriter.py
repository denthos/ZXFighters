import sys

# argv[0] - filename
# argv[1] - name of character to write init script for

# Example:        python ByteAddressUtils.py shoe

def print_extra():
	print "        ld (hl),b"
	print "        inc hl"
	print "        ld (hl),c"
	print "        inc hl"

name = sys.argv[1]
print name + "_init:"
print "        ld bc," + name + "_sprite_idle"
print_extra()
print "        ld bc," + name + "_sprite_walk_forward_1"
print_extra()
print "        ld bc," + name + "_sprite_walk_forward_2"
print_extra()
print "        ld bc," + name + "_sprite_attack_1_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_1_2"
print_extra()
print "        ld bc," + name + "_sprite_attack_1_3"
print_extra()
print "        ld bc," + name + "_sprite_attack_2_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_2_2"
print_extra()
print "        ld bc," + name + "_sprite_attack_2_3"
print_extra()
print "        ld bc," + name + "_sprite_attack_3_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_3_2"
print_extra()
print "        ld bc," + name + "_sprite_attack_3_3"
print_extra()
print "        ld bc," + name + "_sprite_block"
print_extra()
print "        ld bc," + name + "_sprite_hit"
print "        ld (hl),b"
print "        inc hl"
print "        ld (hl),c"
print "        ret"