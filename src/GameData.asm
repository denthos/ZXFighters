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
	defb 0,24
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
player_1_sprite_x_location:
	defb 4
player_1_sprite_y_location:
	defb 10
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
player_2_sprite_x_location:
	defb 21
player_2_sprite_y_location:
	defb 10
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

shoe_sprite_data:
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
