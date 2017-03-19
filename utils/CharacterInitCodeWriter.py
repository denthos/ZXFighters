import sys

# argv[0] - filename
# argv[1] - name of character to write init script for

# Example:        python ByteAddressUtils.py shoe

def print_extra():
	print "        ld (hl),c"
	print "        inc hl"
	print "        ld (hl),b"
	print "        inc hl"

def print_extra2():
	print "        ld (hl),a"
	print "        inc hl"

def attack_skip():
	print "        inc hl"
	print "        inc hl"
	print "        inc hl"

name = sys.argv[1]
print name + "_init:"
print "        ld bc," + name + "_name"
print_extra()
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
print "        ld a,(" + name + "_attack_1_starting_active_frame)"
print_extra2()
print "        ld a,(" + name + "_attack_1_ending_active_frame)"
print_extra2()
print "        ld a,(" + name + "_attack_1_total_frames)"
print_extra2()
print "        ld bc," + name + "_sprite_attack_1_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_1_2"
print_extra()
print "        inc hl"
print "        ld bc," + name + "_attack_1_execute"
print_extra()
attack_skip()
print "        ld a,(" + name + "_attack_2_starting_active_frame)"
print_extra2()
print "        ld a,(" + name + "_attack_2_ending_active_frame)"
print_extra2()
print "        ld a,(" + name + "_attack_2_total_frames)"
print_extra2()
print "        ld bc," + name + "_sprite_attack_2_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_2_2"
print_extra()
print "        inc hl"
print "        ld bc," + name + "_attack_2_execute"
print_extra()
attack_skip()
print "        ld a,(" + name + "_attack_3_starting_active_frame)"
print_extra2()
print "        ld a,(" + name + "_attack_3_ending_active_frame)"
print_extra2()
print "        ld a,(" + name + "_attack_3_total_frames)"
print_extra2()
print "        ld bc," + name + "_sprite_attack_3_1"
print_extra()
print "        ld bc," + name + "_sprite_attack_3_2"
print_extra()
print "        inc hl"
print "        ld bc," + name + "_attack_3_execute"
print_extra()
print "        ret"