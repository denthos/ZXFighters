character_select_instructions_1:
	defb 'A/D & J/L to select character'
character_select_instructions_2:
	defb 'Press Enter to start'
left_arrow:
	defb '<'
right_arrow:
	defb '>'

black_background:
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,255
	defb 0,2
	defb 7,255
	defb 7,255
	defb 7,255
	defb 7,3

black_sprite:
	defb 0,255
	defb 0,33
	defb 0,0
black_sprite_attr_bytes:
	defb 0,36
	defb 0,0

black_character_cell:
	defb 0,8
	defb 0,0
black_character_cell_attr_bytes:
	defb 0,1
	defb 0,0


title_screen_data:
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,240
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,223
	defb 63,1
	defb 255,31
	defb 63,1
	defb 255,31
	defb 45,3
	defb 111,4
	defb 45,27
	defb 111,6
	defb 45,19
	defb 111,2
	defb 45,13
	defb 63,11
	defb 45,5
	defb 111,4
	defb 45,12
	defb 9,11
	defb 45,4
	defb 111,6
	defb 45,11
	defb 9,11
	defb 45,18
	defb 63,17
	defb 45,10
	defb 111,2
	defb 45,3
	defb 9,17
	defb 45,9
	defb 111,4
	defb 45,2
	defb 9,17
	defb 45,8
	defb 111,4
	defb 47,4
	defb 63,15
	defb 47,4
	defb 45,9
	defb 9,23
	defb 45,9
	defb 9,23
	defb 45,9
	defb 47,23
	defb 45,9
	defb 63,2
	defb 45,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 45,1
	defb 63,2
	defb 45,10
	defb 63,2
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,2
	defb 45,12
	defb 63,19
	defb 45,18
	defb 63,9
	defb 45,23
	defb 63,9
	defb 45,23
	defb 63,9
	defb 45,23
	defb 63,9
	defb 45,12
	defb 36,11
	defb 54,2
	defb 36,31
	defb 54,6
	defb 36,27
	defb 54,7
	defb 36,30
	defb 54,2
	defb 36,31
	defb 54,2
	defb 36,11
	defb 0,0

; Player data for storing runtime game information
player_1:
player_1_current_location:
	defb 4
player_1_last_location:
	defb 4
player_1_current_bit_offset:
	defb 0
player_1_current_sprite:
	defw 0
player_1_damage_taken:
	defb 0
player_1_hit_stun:
	defb 0
player_1_attack_stun:
	defb 0
player_1_movement_stun:
	defb 0
player_1_invincibility_frames:
	defb 0
player_1_current_attack_frame:
	defb 0
player_1_current_attack:
	defw 0
player_1_name:
	defw 0
player_1_sprites:
player_1_sprite_idle:
	defw 0 ; sprite for standing still animation
player_1_sprite_walk_forward_1:
	defw 0 ; sprite for walking first 4 bits
player_1_sprite_walk_forward_2:
	defw 0 ; sprite for walking second 4 bits
player_1_sprite_attack_1_1:
	defw 0 ; wind up for attack 1
player_1_sprite_attack_1_2:
	defw 0 ; attack is out for attack 1
player_1_sprite_attack_1_3:
	defw 0 ; wind down for attack 1
player_1_sprite_attack_2_1:
	defw 0
player_1_sprite_attack_2_2:
	defw 0
player_1_sprite_attack_2_3:
	defw 0
player_1_sprite_attack_3_1:
	defw 0
player_1_sprite_attack_3_2:
	defw 0
player_1_sprite_attack_3_3:
	defw 0
player_1_sprite_block:
	defw 0 ; blocking animation
player_1_sprite_hit:
	defw 0 ; getting hit animation
player_1_attack_1_active_frames:
	defw 0
player_1_attack_1_total_frames:
	defw 0
player_1_attack_1_execute:
	defw 0
player_1_attack_2_active_frames:
	defw 0
player_1_attack_2_total_frames:
	defw 0
player_1_attack_2_execute:
	defw 0
player_1_attack_3_active_frames:
	defw 0
player_1_attack_3_total_frames:
	defw 0
player_1_attack_3_execute:
	defw 0

player_2:
player_2_current_location:
	defb 21
player_2_last_location:
	defb 21
player_2_current_bit_offset:
	defb 0
player_2_current_sprite:
	defw 0
player_2_damage_taken:
	defb 0
player_2_hit_stun:
	defb 0
player_2_attack_stun:
	defb 0
player_2_movement_stun:
	defb 0
player_2_invincibility_frames:
	defb 0
player_2_current_attack_frame:
	defb 0
player_2_current_attack:
	defw 0
player_2_name:
	defw 0
player_2_sprites:
player_2_sprite_idle:
	defw 0
player_2_sprite_walk_forward_1:
	defw 0
player_2_sprite_walk_forward_2:
	defw 0
player_2_sprite_attack_1_1:
	defw 0
player_2_sprite_attack_1_2:
	defw 0
player_2_sprite_attack_1_3:
	defw 0
player_2_sprite_attack_2_1:
	defw 0
player_2_sprite_attack_2_2:
	defw 0
player_2_sprite_attack_2_3:
	defw 0
player_2_sprite_attack_3_1:
	defw 0
player_2_sprite_attack_3_2:
	defw 0
player_2_sprite_attack_3_3:
	defw 0
player_2_sprite_block:
	defw 0
player_2_sprite_hit:
	defw 0
player_2_attack_1_active_frames:
	defw 0
player_2_attack_1_total_frames:
	defw 0
player_2_attack_1_execute:
	defw 0
player_2_attack_2_active_frames:
	defw 0
player_2_attack_2_total_frames:
	defw 0
player_2_attack_2_execute:
	defw 0
player_2_attack_3_active_frames:
	defw 0
player_2_attack_3_total_frames:
	defw 0
player_2_attack_3_execute:
	defw 0

; player_1 data looks like:
; struct player_1 {
;   <name>_name - 10 bytes
;   <name>_sprite_data - 6x6 pixel bytes followed by corresponding attributes
; }
character_data:
character_name:
; 10 bytes of name data
character_sprite_idle:
; sprite data
character_sprite_walk_forward_1:
; sprite data
character_sprite_walk_forward_2:
; sprite data
character_sprite_walk_backward_1:
; sprite data
character_sprite_walk_backward_2:
; sprite data
character_sprite_attack_1_1:
; sprite data
character_sprite_attack_1_2:
; sprite data
character_sprite_attack_1_3:
; sprite data
character_sprite_attack_2_1:
; sprite data
character_sprite_attack_2_2:
; sprite data
character_sprite_attack_2_3:
; sprite data
character_sprite_attack_3_1:
; sprite data
character_sprite_attack_3_2:
; sprite data
character_sprite_attack_3_3:
; sprite data
character_sprite_block:
; sprite data
character_sprite_hit:
; sprite data
character_attack_1_active_frames:
; 2 bytes (first and last active frame)
character_attack_1_total_frames:
; 1 bytes (total number of frames that the attack is out)
character_attack_1_execute:
; code for handling the attack
character_attack_2_active_frames:
; 2 bytes (first and last active frame)
character_attack_2_total_frames:
; 1 bytes (total number of frames that the attack is out)
character_attack_2_execute:
; code for handling the attack
character_attack_3_active_frames:
; 2 bytes (first and last active frame)
character_attack_3_total_frames:
; 1 bytes (total number of frames that the attack is out)
character_attack_3_execute:
; code for handling the attack

; Character data looks like:
; struct character {
;   <name>_name - 10 bytes
;   <name>_sprite_data - 6x6 pixel bytes followed by corresponding attributes
; }
shoe_data:
shoe_name:
	defb '   Shoe   '

shoe_init:
        ld bc,shoe_sprite_idle
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_walk_forward_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_walk_forward_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_1_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_1_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_1_3
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_2_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_2_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_2_3
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_3_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_3_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_attack_3_3
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_block
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,shoe_sprite_hit
        ld (hl),b
        inc hl
        ld (hl),c
        ret


shoe_sprite_idle:
; sprite data
shoe_sprite_walk_forward_1:
; sprite data
shoe_sprite_walk_forward_2:
; sprite data
shoe_sprite_walk_backward_1:
; sprite data
shoe_sprite_walk_backward_2:
; sprite data
shoe_sprite_attack_1_1:
; sprite data
shoe_sprite_attack_1_2:
; sprite data
shoe_sprite_attack_1_3:
; sprite data
shoe_sprite_attack_2_1:
; sprite data
shoe_sprite_attack_2_2:
; sprite data
shoe_sprite_attack_2_3:
; sprite data
shoe_sprite_attack_3_1:
; sprite data
shoe_sprite_attack_3_2:
; sprite data
shoe_sprite_attack_3_3:
; sprite data
shoe_sprite_block:
; sprite data
shoe_sprite_hit:
; sprite data

shoe_sprite_data:
	defb 0
	defb 0,93
	defb 31,1
	defb 0,5
	defb 255,2
	defb 128,1
	defb 0,3
	defb 255,2
	defb 128,1
	defb 0,2
	defb 31,1
	defb 255,2
	defb 128,1
	defb 0,2
	defb 255,3
	defb 128,1
	defb 0,1
	defb 3,1
	defb 255,3
	defb 128,1
	defb 0,1
	defb 15,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 31,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 63,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 127,1
	defb 0,2
	defb 1,1
	defb 128,1
	defb 0,1
	defb 255,1
	defb 0,2
	defb 31,1
	defb 128,1
	defb 0,1
	defb 255,1
	defb 0,2
	defb 255,1
	defb 128,1
	defb 0,1
	defb 255,4
	defb 128,1
	defb 0,1
	defb 127,1
	defb 255,3
	defb 128,1
	defb 0,1
	defb 127,1
	defb 255,3
	defb 128,1
	defb 0,1
	defb 63,1
	defb 255,3
	defb 128,1
	defb 0,1
	defb 31,1
	defb 255,3
	defb 128,1
	defb 0,1
	defb 3,1
	defb 255,3
	defb 0,91
	defb 0,0


; 		defb 0,38
; 	defb 2,1
; 	defb 0,4
; 	defb 1,1
; 	defb 252,1
; 	defb 0,4
; 	defb 1,1
; 	defb 254,1
; 	defb 0,4
; 	defb 3,1
; 	defb 130,1
; 	defb 0,4
; 	defb 3,1
; 	defb 26,1
; 	defb 0,4
; 	defb 3,1
; 	defb 1,1
; 	defb 0,4
; 	defb 2,1
; 	defb 1,1
; 	defb 0,4
; 	defb 2,2
; 	defb 0,4
; 	defb 1,1
; 	defb 14,1
; 	defb 0,4
; 	defb 1,1
; 	defb 16,1
; 	defb 0,4
; 	defb 15,1
; 	defb 28,1
; 	defb 0,4
; 	defb 16,1
; 	defb 3,1
; 	defb 6,1
; 	defb 0,3
; 	defb 32,1
; 	defb 0,1
; 	defb 137,1
; 	defb 0,3
; 	defb 32,1
; 	defb 0,1
; 	defb 73,1
; 	defb 0,3
; 	defb 66,1
; 	defb 0,1
; 	defb 117,1
; 	defb 0,3
; 	defb 65,1
; 	defb 84,1
; 	defb 34,1
; 	defb 0,3
; 	defb 65,1
; 	defb 6,1
; 	defb 4,1
; 	defb 0,3
; 	defb 65,1
; 	defb 7,1
; 	defb 136,1
; 	defb 0,3
; 	defb 65,1
; 	defb 4,1
; 	defb 240,1
; 	defb 0,3
; 	defb 35,1
; 	defb 14,1
; 	defb 0,4
; 	defb 48,1
; 	defb 241,1
; 	defb 0,4
; 	defb 24,1
; 	defb 1,1
; 	defb 0,4
; 	defb 15,1
; 	defb 249,1
; 	defb 0,4
; 	defb 7,1
; 	defb 254,1
; 	defb 0,4
; 	defb 7,1
; 	defb 252,1
; 	defb 0,4
; 	defb 7,1
; 	defb 250,1
; 	defb 0,4
; 	defb 15,1
; 	defb 253,1
; 	defb 0,4
; 	defb 13,1
; 	defb 254,1
; 	defb 128,1
; 	defb 0,3
; 	defb 31,1
; 	defb 255,1
; 	defb 0,4
; 	defb 27,1
; 	defb 255,1
; 	defb 192,1
; 	defb 0,3
; 	defb 63,1
; 	defb 223,1
; 	defb 192,1
; 	defb 0,3
; 	defb 55,1
; 	defb 143,1
; 	defb 224,1
; 	defb 0,3
; 	defb 127,1
; 	defb 7,1
; 	defb 224,1
; 	defb 0,3
; 	defb 127,1
; 	defb 7,1
; 	defb 224,1
; 	defb 0,3
; 	defb 126,1
; 	defb 3,1
; 	defb 224,1
; 	defb 0,3
; 	defb 126,1
; 	defb 3,1
; 	defb 224,1
; 	defb 0,3
; 	defb 126,1
; 	defb 3,1
; 	defb 224,1
; 	defb 0,3
; 	defb 126,1
; 	defb 3,1
; 	defb 192,1
; 	defb 0,3
; 	defb 36,1
; 	defb 1,1
; 	defb 48,1
; 	defb 0,3
; 	defb 66,1
; 	defb 2,1
; 	defb 8,1
; 	defb 0,3
; 	defb 66,1
; 	defb 2,1
; 	defb 8,1
; 	defb 0,3
; 	defb 60,1
; 	defb 1,1
; 	defb 240,1
; 	defb 0,2
; 	defb 0,0


shoe_sprite_attributes:
	defb 71,9
	defb 4,1
	defb 71,1
	defb 4,1
	defb 71,1
	defb 4,3
	defb 39,1
	defb 4,1
	defb 71,1
	defb 2,1
	defb 34,3
	defb 2,1
	defb 71,1
	defb 2,4
	defb 71,7
	defb 0,0


sprite_data:
sprite_name:
	defb '  Sprite  '

sprite_sprite_data:
	defb 0
	defb 0,20
	defb 7,1
	defb 224,1
	defb 0,4
	defb 8,1
	defb 16,1
	defb 0,4
	defb 8,1
	defb 16,1
	defb 0,4
	defb 8,1
	defb 16,1
	defb 0,4
	defb 15,1
	defb 240,1
	defb 0,4
	defb 8,1
	defb 16,1
	defb 0,4
	defb 8,1
	defb 16,1
	defb 0,4
	defb 48,1
	defb 12,1
	defb 0,4
	defb 192,1
	defb 3,1
	defb 0,3
	defb 1,1
	defb 0,2
	defb 128,1
	defb 0,2
	defb 2,1
	defb 0,2
	defb 64,1
	defb 0,2
	defb 4,1
	defb 0,2
	defb 32,1
	defb 0,2
	defb 4,1
	defb 0,2
	defb 32,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 31,1
	defb 255,2
	defb 248,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 17,1
	defb 128,1
	defb 72,1
	defb 136,1
	defb 0,2
	defb 18,1
	defb 17,1
	defb 29,1
	defb 72,1
	defb 0,2
	defb 17,1
	defb 42,1
	defb 73,1
	defb 136,1
	defb 0,2
	defb 16,1
	defb 178,1
	defb 73,1
	defb 8,1
	defb 0,2
	defb 19,1
	defb 34,1
	defb 72,1
	defb 200,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 31,1
	defb 255,2
	defb 248,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 16,1
	defb 0,2
	defb 8,1
	defb 0,2
	defb 9,1
	defb 153,2
	defb 144,1
	defb 0,2
	defb 6,1
	defb 102,2
	defb 96,1
	defb 0,1
	defb 0,0
sprite_sprite_attributes:
	defb 120,36
	defb 0,0

sprite_one_x_location:
	defb 4
sprite_one_y_location:
	defb 10

sprite_one_x_bit_offset:
	defb 0

sprite_two_x_location:
	defb 21
sprite_two_y_location:
	defb 10

current_sprite_x_location:
	defb 0 		; Will be set by appropriate methods
current_sprite_y_location:
	defb 0 		; Will be set by appropriate methods
clear_loop_counter:
	defb 0 		; Will be set by appropriate methods

jump_sprite_number:
	defb 0

jump_sprite_counter:
	defb 0

; 2 bytes of memory reserved for storing screen addresses in draw routines
draw_memory_store:
	defb 0,0

; label needs to go after data for stacks
character_select_input_store:
	defb 0

selected_character_p1:
	defb 0
selected_character_p2:
	defb 1
selected_character_max:
	defb 1
a_down:
	defb 0
d_down:
	defb 0
j_down:
	defb 0
l_down:
	defb 0
w_down:
	defb 0
s_down:
	defb 0

; stores the attribute bytes for the layout of the status bar, may need to
; "encode" if need to save space
status_bar_attrib_bytes:
    defb 72,72,72,72,72,72,72,72
    defb 72,72,72,72,72,72,72,72
    defb 72,72,72,72,72,72,72,72
    defb 72,72,72,72,72,72,72,72
    defb 77,84,84,84,84,84,84,84
    defb 84,84,84,77,77,77,79,79
    defb 79,79,77,77,77,84,84,84
    defb 84,84,84,84,84,84,84,77
    defb 77,78,78,78,78,78,78,78
    defb 78,78,78,77,77,77,79,79
    defb 79,79,77,77,77,78,78,78
    defb 78,78,78,78,78,78,78,77
    defb 77,77,77,77,77,77,77,77
    defb 77,77,77,77,77,77,79,79
    defb 79,79,77,77,77,77,77,77
    defb 77,77,77,77,77,77,77,77
    defb 77,77,77,77,77,77,77,77
    defb 77,77,77,77,77,77,77,77
    defb 77,77,77,77,77,77,77,77
    defb 77,77,77,77,77,77,77,77

;stores the pixel bytes for the status bar
;status_bar_pixels:
    ;defb 77,0,0,0,0,0,0,0,0
    ;defb 72,255,255,255,0,0,0,0,0
    ;defb 78,0,0,255,255,255,0,0,0
    ;defb 84,255,255,255,255,255,255,255,255
    ;defb 79,0,0,0,0,0,0,0,0

; status_bar_screen_buffer:
;     defs 2048

player_one_last_update_address:
	defb 10001011B

player_two_last_update_address:
	defb 10010101B

player_one_remainder_stuff:
	defb 11111110B
	defb 11111100B
	defb 11111000B
	defb 11110000B
	defb 11100000B
	defb 11000000B
	defb 10000000B
player_two_remainder_stuff:
	defb 01111111B
	defb 00111111B
	defb 00011111B
	defb 00001111B
	defb 00000111B
	defb 00000011B
	defb 00000001B


; flip_sprite_stuff:
;         defb 00000000B
;         defb 10000000B
;         defb 01000000B
;         defb 11000000B
;         defb 00100000B
;         defb 10100000B
;         defb 01100000B
;         defb 11100000B
;         defb 00010000B
;         defb 10010000B
;         defb 01010000B
;         defb 11010000B
;         defb 00110000B
;         defb 10110000B
;         defb 01110000B
;         defb 11110000B
;         defb 00001000B
;         defb 10001000B
;         defb 01001000B
;         defb 11001000B
;         defb 00101000B
;         defb 10101000B
;         defb 01101000B
;         defb 11101000B
;         defb 00011000B
;         defb 10011000B
;         defb 01011000B
;         defb 11011000B
;         defb 00111000B
;         defb 10111000B
;         defb 01111000B
;         defb 11111000B
;         defb 00000100B
;         defb 10000100B
;         defb 01000100B
;         defb 11000100B
;         defb 00100100B
;         defb 10100100B
;         defb 01100100B
;         defb 11100100B
;         defb 00010100B
;         defb 10010100B
;         defb 01010100B
;         defb 11010100B
;         defb 00110100B
;         defb 10110100B
;         defb 01110100B
;         defb 11110100B
;         defb 00001100B
;         defb 10001100B
;         defb 01001100B
;         defb 11001100B
;         defb 00101100B
;         defb 10101100B
;         defb 01101100B
;         defb 11101100B
;         defb 00011100B
;         defb 10011100B
;         defb 01011100B
;         defb 11011100B
;         defb 00111100B
;         defb 10111100B
;         defb 01111100B
;         defb 11111100B
;         defb 00000010B
;         defb 10000010B
;         defb 01000010B
;         defb 11000010B
;         defb 00100010B
;         defb 10100010B
;         defb 01100010B
;         defb 11100010B
;         defb 00010010B
;         defb 10010010B
;         defb 01010010B
;         defb 11010010B
;         defb 00110010B
;         defb 10110010B
;         defb 01110010B
;         defb 11110010B
;         defb 00001010B
;         defb 10001010B
;         defb 01001010B
;         defb 11001010B
;         defb 00101010B
;         defb 10101010B
;         defb 01101010B
;         defb 11101010B
;         defb 00011010B
;         defb 10011010B
;         defb 01011010B
;         defb 11011010B
;         defb 00111010B
;         defb 10111010B
;         defb 01111010B
;         defb 11111010B
;         defb 00000110B
;         defb 10000110B
;         defb 01000110B
;         defb 11000110B
;         defb 00100110B
;         defb 10100110B
;         defb 01100110B
;         defb 11100110B
;         defb 00010110B
;         defb 10010110B
;         defb 01010110B
;         defb 11010110B
;         defb 00110110B
;         defb 10110110B
;         defb 01110110B
;         defb 11110110B
;         defb 00001110B
;         defb 10001110B
;         defb 01001110B
;         defb 11001110B
;         defb 00101110B
;         defb 10101110B
;         defb 01101110B
;         defb 11101110B
;         defb 00011110B
;         defb 10011110B
;         defb 01011110B
;         defb 11011110B
;         defb 00111110B
;         defb 10111110B
;         defb 01111110B
;         defb 11111110B
;         defb 00000001B
;         defb 10000001B
;         defb 01000001B
;         defb 11000001B
;         defb 00100001B
;         defb 10100001B
;         defb 01100001B
;         defb 11100001B
;         defb 00010001B
;         defb 10010001B
;         defb 01010001B
;         defb 11010001B
;         defb 00110001B
;         defb 10110001B
;         defb 01110001B
;         defb 11110001B
;         defb 00001001B
;         defb 10001001B
;         defb 01001001B
;         defb 11001001B
;         defb 00101001B
;         defb 10101001B
;         defb 01101001B
;         defb 11101001B
;         defb 00011001B
;         defb 10011001B
;         defb 01011001B
;         defb 11011001B
;         defb 00111001B
;         defb 10111001B
;         defb 01111001B
;         defb 11111001B
;         defb 00000101B
;         defb 10000101B
;         defb 01000101B
;         defb 11000101B
;         defb 00100101B
;         defb 10100101B
;         defb 01100101B
;         defb 11100101B
;         defb 00010101B
;         defb 10010101B
;         defb 01010101B
;         defb 11010101B
;         defb 00110101B
;         defb 10110101B
;         defb 01110101B
;         defb 11110101B
;         defb 00001101B
;         defb 10001101B
;         defb 01001101B
;         defb 11001101B
;         defb 00101101B
;         defb 10101101B
;         defb 01101101B
;         defb 11101101B
;         defb 00011101B
;         defb 10011101B
;         defb 01011101B
;         defb 11011101B
;         defb 00111101B
;         defb 10111101B
;         defb 01111101B
;         defb 11111101B
;         defb 00000011B
;         defb 10000011B
;         defb 01000011B
;         defb 11000011B
;         defb 00100011B
;         defb 10100011B
;         defb 01100011B
;         defb 11100011B
;         defb 00010011B
;         defb 10010011B
;         defb 01010011B
;         defb 11010011B
;         defb 00110011B
;         defb 10110011B
;         defb 01110011B
;         defb 11110011B
;         defb 00001011B
;         defb 10001011B
;         defb 01001011B
;         defb 11001011B
;         defb 00101011B
;         defb 10101011B
;         defb 01101011B
;         defb 11101011B
;         defb 00011011B
;         defb 10011011B
;         defb 01011011B
;         defb 11011011B
;         defb 00111011B
;         defb 10111011B
;         defb 01111011B
;         defb 11111011B
;         defb 00000111B
;         defb 10000111B
;         defb 01000111B
;         defb 11000111B
;         defb 00100111B
;         defb 10100111B
;         defb 01100111B
;         defb 11100111B
;         defb 00010111B
;         defb 10010111B
;         defb 01010111B
;         defb 11010111B
;         defb 00110111B
;         defb 10110111B
;         defb 01110111B
;         defb 11110111B
;         defb 00001111B
;         defb 10001111B
;         defb 01001111B
;         defb 11001111B
;         defb 00101111B
;         defb 10101111B
;         defb 01101111B
;         defb 11101111B
;         defb 00011111B
;         defb 10011111B
;         defb 01011111B
;         defb 11011111B
;         defb 00111111B
;         defb 10111111B
;         defb 01111111B



; Temp stuff to keep the master making 
; For character overlap detection 
sprite_one_offset_middle:
	defb 1
sprite_two_offset_middle:
	defb 1

sprite_one_width_from_left:
	defb 0 ; Defined at run time
; sprite_two_width_from_right: ; Not needed 

; sprite_one_offset_middle + sprite_two_offset_middle
; Stores 6 - (sprite_one_offset_middle + sprite_two_offset_middle)
pre_calculate_offset_middle:
	defb 0

; Number to pass into e for draw sprite 
pre_calculate_offset_middle_for_e:
	defb 0

sprite_two_x_bit_offset:
	defb 0
sprite_two_y_bit_offset:
	defb 0
	
	
; Character data looks like:
; struct character {
;   <name>_name - 10 bytes
;   <name>_sprite_data - 6x6 pixel bytes followed by corresponding attributes
; }





; Second step walking motion 
shoe_sprite_data_2:
	defb 0,38
	defb 2,1
	defb 0,4
	defb 1,1
	defb 252,1
	defb 0,4
	defb 1,1
	defb 254,1
	defb 0,4
	defb 3,1
	defb 130,1
	defb 0,4
	defb 3,1
	defb 26,1
	defb 0,4
	defb 3,1
	defb 1,1
	defb 0,4
	defb 2,1
	defb 1,1
	defb 0,4
	defb 2,2
	defb 0,4
	defb 1,1
	defb 14,1
	defb 0,4
	defb 1,1
	defb 16,1
	defb 0,4
	defb 15,1
	defb 28,1
	defb 0,4
	defb 16,1
	defb 3,1
	defb 6,1
	defb 0,3
	defb 32,1
	defb 0,1
	defb 137,1
	defb 0,3
	defb 32,1
	defb 0,1
	defb 73,1
	defb 0,3
	defb 66,1
	defb 0,1
	defb 117,1
	defb 0,3
	defb 65,1
	defb 84,1
	defb 34,1
	defb 0,3
	defb 65,1
	defb 6,1
	defb 4,1
	defb 0,3
	defb 65,1
	defb 7,1
	defb 136,1
	defb 0,3
	defb 65,1
	defb 4,1
	defb 240,1
	defb 0,3
	defb 35,1
	defb 14,1
	defb 0,4
	defb 48,1
	defb 241,1
	defb 0,4
	defb 24,1
	defb 1,1
	defb 0,4
	defb 15,1
	defb 249,1
	defb 0,4
	defb 7,1
	defb 254,1
	defb 0,4
	defb 3,1
	defb 252,1
	defb 0,4
	defb 3,1
	defb 252,1
	defb 0,4
	defb 7,1
	defb 252,1
	defb 0,4
	defb 7,1
	defb 246,1
	defb 0,4
	defb 7,1
	defb 250,1
	defb 0,4
	defb 7,1
	defb 254,1
	defb 0,4
	defb 3,1
	defb 254,1
	defb 0,4
	defb 1,1
	defb 254,1
	defb 0,4
	defb 7,1
	defb 254,1
	defb 0,4
	defb 7,1
	defb 252,1
	defb 0,4
	defb 15,1
	defb 252,1
	defb 0,4
	defb 63,1
	defb 252,1
	defb 0,4
	defb 79,1
	defb 252,1
	defb 0,4
	defb 71,1
	defb 248,1
	defb 0,4
	defb 35,1
	defb 38,1
	defb 0,4
	defb 17,1
	defb 65,1
	defb 0,4
	defb 9,1
	defb 65,1
	defb 0,4
	defb 6,1
	defb 62,1
	defb 0,3
	defb 0,0
shoe_sprite_attributes_2:
	defb 120,36
	defb 0,0

shoe_sprite_data_3:
	defb 0,38
	defb 2,1
	defb 0,4
	defb 1,1
	defb 252,1
	defb 0,4
	defb 1,1
	defb 254,1
	defb 0,4
	defb 3,1
	defb 130,1
	defb 0,4
	defb 3,1
	defb 26,1
	defb 0,4
	defb 3,1
	defb 1,1
	defb 0,4
	defb 2,1
	defb 1,1
	defb 0,4
	defb 2,2
	defb 0,4
	defb 1,1
	defb 14,1
	defb 0,4
	defb 1,1
	defb 16,1
	defb 0,4
	defb 15,1
	defb 28,1
	defb 0,4
	defb 16,1
	defb 3,1
	defb 6,1
	defb 0,3
	defb 32,1
	defb 0,1
	defb 137,1
	defb 0,3
	defb 32,1
	defb 0,1
	defb 73,1
	defb 0,3
	defb 66,1
	defb 0,1
	defb 117,1
	defb 0,3
	defb 65,1
	defb 84,1
	defb 34,1
	defb 0,3
	defb 65,1
	defb 6,1
	defb 4,1
	defb 0,3
	defb 65,1
	defb 7,1
	defb 136,1
	defb 0,3
	defb 65,1
	defb 4,1
	defb 240,1
	defb 0,3
	defb 35,1
	defb 14,1
	defb 0,4
	defb 48,1
	defb 241,1
	defb 0,4
	defb 24,1
	defb 1,1
	defb 0,4
	defb 15,1
	defb 249,1
	defb 0,4
	defb 7,1
	defb 254,1
	defb 0,4
	defb 3,1
	defb 248,1
	defb 0,4
	defb 3,1
	defb 252,1
	defb 0,4
	defb 7,1
	defb 254,1
	defb 0,4
	defb 7,1
	defb 253,1
	defb 0,4
	defb 7,1
	defb 254,1
	defb 128,1
	defb 0,3
	defb 7,1
	defb 255,1
	defb 64,1
	defb 0,3
	defb 3,1
	defb 255,1
	defb 192,1
	defb 0,3
	defb 1,1
	defb 255,1
	defb 192,1
	defb 0,3
	defb 1,1
	defb 255,1
	defb 128,1
	defb 0,3
	defb 2,1
	defb 127,1
	defb 0,4
	defb 2,1
	defb 62,1
	defb 0,4
	defb 1,1
	defb 28,1
	defb 0,5
	defb 136,1
	defb 0,4
	defb 1,1
	defb 200,1
	defb 0,4
	defb 1,1
	defb 48,1
	defb 0,4
	defb 2,1
	defb 8,1
	defb 0,4
	defb 2,1
	defb 8,1
	defb 0,4
	defb 1,1
	defb 240,1
	defb 0,3
	defb 0,0
shoe_sprite_attributes_3:
	defb 120,36
	defb 0,0
