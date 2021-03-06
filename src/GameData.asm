round_select_instructions:
	defb 'G/H to change num rounds'
first_to_label:
	defb 'First to: '
; number_of_rounds_string:
; 	defb '1'
character_select_instructions_1:
	defb 'A/D & J/L to select character'
character_select_instructions_2:
	defb 'Press Enter to start'
left_arrow:
	defb '<'
right_arrow:
	defb '>'
frame_counter:
	defb 0

; Player data for storing runtime game information
player_1:

player_1_rounds_won:
	defb 0 
player_1_current_location:
	defb 4
player_1_last_location:
	defb 4			
; player_1_current_bit_offset:
player_1_current_walking_sprite:
	defb 0
player_1_current_sprite:
	defw 0
player_1_last_sprite:
	defw 0
player_1_current_idle_sprite:
	defb 0 ; 0 means not idle, 1 means idle 1 2 means idle 2 

player_1_idle_counter: 
	defb 0 ; To fine tune the speed of idling 

player_1_damage_taken:
	defb 0
player_1_health_bar_address:
	defw 0
player_1_energy:
	defb 0
player_1_energy_bar_address:
	defw 0
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
player_1_blocking:
	defb 0
player_1_blocking_active:
	defb 0
player_1_blocking_damage_taken:
	defb 0
player_1_name:
	defw 0
player_1_sprites:
player_1_sprite_idle_1:
	defw 0 ; sprite for standing still animation
player_1_sprite_idle_2:
	defw 0 ; second sprite for standing still animation
player_1_sprite_walk_forward_1:
	defw 0 ; sprite for walking first 4 bits
player_1_sprite_walk_forward_2:
	defw 0 ; sprite for walking second 4 bits
player_1_sprite_block:
	defw 0 ; blocking animation
player_1_sprite_hit:
	defw 0 ; getting hit animation
player_1_attack_1:
player_1_attack_1_starting_active_frame:
	defb 0
player_1_attack_1_ending_active_frame:
	defb 0
player_1_attack_1_total_frames:
	defb 0
player_1_sprite_attack_1_1:
	defw 0 ; attack windup
player_1_sprite_attack_1_2:
	defw 0 ; attack is out
player_1_attack_1_execute:
	defb 0xc3
	defw 0
player_1_attack_2:
player_1_attack_2_starting_active_frame:
	defb 0
player_1_attack_2_ending_active_frame:
	defb 0
player_1_attack_2_total_frames:
	defb 0
player_1_sprite_attack_2_1:
	defw 0 ; attack windup
player_1_sprite_attack_2_2:
	defw 0 ; attack is out
player_1_attack_2_execute:
	defb 0xc3
	defw 0
player_1_attack_3:
player_1_attack_3_starting_active_frame:
	defb 0
player_1_attack_3_ending_active_frame:
	defb 0
player_1_attack_3_total_frames:
	defb 0
player_1_sprite_attack_3_1:
	defw 0 ; attack windup
player_1_sprite_attack_3_2:
	defw 0 ; attack is out
player_1_attack_3_execute:
	defb 0xc3
	defw 0

player_2:

player_2_rounds_won:
	defb 0 
player_2_current_location:
	defb 4
player_2_last_location:
	defb 4			
; player_2_current_bit_offset:
player_2_current_walking_sprite:
	defb 0
player_2_current_sprite:
	defw 0
player_2_last_sprite:
	defw 0
player_2_current_idle_sprite:
	defb 0 ; 0 means not idle, 1 means idle 1 2 means idle 2 

player_2_idle_counter: 
	defb 0 ; To fine tune the speed of idling 

player_2_damage_taken:
	defb 0
player_2_health_bar_address:
	defw 0
player_2_energy:
	defb 0
player_2_energy_bar_address:
	defw 0
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
player_2_blocking:
	defb 0
player_2_blocking_active:
	defb 0
player_2_blocking_damage_taken:
	defb 0
player_2_name:
	defw 0
player_2_sprites:
player_2_sprite_idle_1:
	defw 0 ; sprite for standing still animation
player_2_sprite_idle_2:
	defw 0 ; second sprite for standing still animation

player_2_sprite_walk_forward_1:
	defw 0 ; sprite for walking first 4 bits
player_2_sprite_walk_forward_2:
	defw 0 ; sprite for walking second 4 bits
player_2_sprite_block:
	defw 0 ; blocking animation
player_2_sprite_hit:
	defw 0 ; getting hit animation
player_2_attack_1:
player_2_attack_1_starting_active_frame:
	defb 0
player_2_attack_1_ending_active_frame:
	defb 0
player_2_attack_1_total_frames:
	defb 0
player_2_sprite_attack_1_1:
	defw 0 ; attack windup
player_2_sprite_attack_1_2:
	defw 0 ; attack is out
player_2_attack_1_execute:
	defb 0xc3
	defw 0
player_2_attack_2:
player_2_attack_2_starting_active_frame:
	defb 0
player_2_attack_2_ending_active_frame:
	defb 0
player_2_attack_2_total_frames:
	defb 0
player_2_sprite_attack_2_1:
	defw 0 ; attack windup
player_2_sprite_attack_2_2:
	defw 0 ; attack is out
player_2_attack_2_execute:
	defb 0xc3
	defw 0
player_2_attack_3:
player_2_attack_3_starting_active_frame:
	defb 0
player_2_attack_3_ending_active_frame:
	defb 0
player_2_attack_3_total_frames:
	defb 0
player_2_sprite_attack_3_1:
	defw 0 ; attack windup
player_2_sprite_attack_3_2:
	defw 0 ; attack is out
player_2_attack_3_execute:
	defb 0xc3
	defw 0


; 2 bytes of memory reserved for storing screen addresses in draw routines
draw_memory_store:
	defb 0,0

; label needs to go after data for stacks
character_select_input_store:
	defb 0

number_of_rounds: 
	defb 1 
default_player_1_location: 
	defb 4
default_player_2_location:
	defb 22
selected_character_p1:
	defb 0
selected_character_p2:
	defb 1
selected_character_max:
	defb 4
a_down:
	defb 0
s_down:
	defb 0
d_down:
	defb 0
q_down:
	defb 0
w_down:
	defb 0
e_down:
	defb 0
j_down:
	defb 0
k_down:
	defb 0
l_down:
	defb 0
u_down:
	defb 0
i_down:
	defb 0
o_down:
	defb 0
g_down: 
	defb 0 
h_down: 
	defb 0

; right to left remainder data
rtl_remainders:
	defb 11111110B
	defb 11111100B
	defb 11111000B
	defb 11110000B
	defb 11100000B
	defb 11000000B
	defb 10000000B
; left to right remainder data
ltr_remainders:
	defb 01111111B
	defb 00111111B
	defb 00011111B
	defb 00001111B
	defb 00000111B
	defb 00000011B
	defb 00000001B

sprite_flip_original_addr:
	defs 2
temp_sprite_flip_data_1:
	defs 324
temp_sprite_flip_data_2:
	defs 324

title_graphic_data:
	defb 255,255,255,255,255,255,255,0,0,0,0,255,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 255,255,255,255,255,255,127,128,0,0,1,254,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 255,255,255,255,255,255,127,128,0,0,1,254,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 255,255,255,255,255,255,63,192,0,0,3,252,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,0,255,31,224,0,0,7,248,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,1,254,31,224,0,0,7,248,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,1,254,15,240,0,0,15,240,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,3,252,15,240,0,0,15,240,255,255,255,255
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,7,248,7,248,0,0,31,224,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,15,240,3,252,0,0,63,192,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,15,240,3,252,0,0,63,192,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,31,224,1,254,0,0,127,128,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,63,192,0,255,0,0,255,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,127,128,0,255,0,0,255,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,127,128,0,127,128,1,254,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,0,255,0,0,63,192,3,252,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,1,254,0,0,63,192,3,252,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,1,254,0,0,31,224,7,248,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,3,252,0,0,31,224,7,248,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,7,248,0,0,15,240,15,240,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,15,240,0,0,7,248,31,224,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,15,240,0,0,7,248,31,224,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,31,224,0,0,3,252,63,192,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,63,192,0,0,1,254,127,128,0,255,0,0,0
	defb 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	defb 0,0,0,127,128,0,0,1,254,127,128,0,255,255,240,248
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,0,127,128,0,0,0,255,255,0,0,255,255,240,248
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,0,255,0,0,0,0,127,254,0,0,255,255,240,248
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,1,254,0,0,0,0,127,254,0,0,255,255,240,248
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,1,254,0,0,0,0,63,252,0,0,255,255,240,248
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,3,252,0,0,0,0,63,252,0,0,255,255,240,0
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,7,248,0,0,0,0,31,248,0,0,255,255,240,0
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,15,240,0,0,0,0,15,240,0,0,255,255,240,0
	defb 0,0,15,0,1,255,255,255,252,0,0,0,0,0,0,0
	defb 0,0,15,240,0,0,0,0,15,240,0,0,255,0,0,0
	defb 0,0,15,0,1,255,255,255,252,0,0,0,0,0,0,0
	defb 0,0,31,224,0,0,0,0,31,248,0,0,255,0,0,0
	defb 0,0,15,0,1,255,255,255,252,0,0,0,0,0,0,0
	defb 0,0,63,192,0,0,0,0,63,252,0,0,255,0,0,0
	defb 0,0,15,0,1,255,255,255,252,0,0,0,0,0,0,0
	defb 0,0,127,128,0,0,0,0,63,252,0,0,255,0,0,0
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,127,128,0,0,0,0,127,254,0,0,255,0,0,0
	defb 0,0,15,0,0,0,15,0,0,0,0,0,0,0,0,0
	defb 0,0,255,0,0,0,0,0,127,254,0,0,255,0,0,0
	defb 0,0,15,0,0,0,15,0,0,0,0,240,0,0,0,0
	defb 0,1,254,0,0,0,0,0,255,255,0,0,255,0,0,0
	defb 0,0,15,0,0,0,15,0,0,0,0,240,0,0,0,0
	defb 0,1,254,0,0,0,0,1,254,127,128,0,255,0,0,248
	defb 0,0,15,0,0,0,15,0,0,0,0,240,0,0,0,0
	defb 0,3,252,0,0,0,0,1,254,127,128,0,255,0,0,248
	defb 255,255,15,255,255,0,15,0,255,255,0,255,255,0,0,0
	defb 0,7,248,0,0,0,0,3,252,63,192,0,255,0,0,248
	defb 255,255,15,255,255,0,15,0,255,255,0,255,255,0,0,0
	defb 0,15,240,0,0,0,0,7,248,31,224,0,255,0,0,248
	defb 255,255,15,255,255,0,15,0,255,255,0,255,255,0,0,0
	defb 0,15,240,0,0,0,0,7,248,31,224,0,255,0,0,248
	defb 192,7,15,255,255,0,15,0,224,7,0,255,255,0,0,0
	defb 0,31,224,0,0,0,0,15,240,15,240,0,255,0,0,248
	defb 192,7,15,0,15,0,15,0,224,7,0,240,0,15,255,240
	defb 0,63,192,0,0,0,0,31,224,7,248,0,255,0,0,248
	defb 192,7,15,0,15,0,15,0,224,7,0,240,0,15,255,240
	defb 0,127,128,0,0,0,0,31,224,7,248,0,255,0,0,248
	defb 192,7,15,0,15,0,15,0,224,7,0,240,0,15,255,240
	defb 0,127,128,0,0,0,0,63,192,3,252,0,255,0,0,248
	defb 192,7,15,0,15,0,15,0,224,7,0,240,0,15,255,240
	defb 0,255,0,0,0,0,0,63,192,3,252,0,255,0,0,248
	defb 192,7,15,0,15,0,15,0,224,7,0,240,0,15,0,0
	defb 1,254,0,0,0,0,0,127,128,1,254,0,255,0,0,248
	defb 192,7,15,0,15,0,15,0,224,7,0,240,0,15,0,0
	defb 1,254,0,0,0,0,0,255,0,0,255,0,255,0,0,248
	defb 255,255,15,0,15,0,15,0,255,255,0,240,0,15,0,0
	defb 3,252,0,0,0,0,0,255,0,0,255,0,255,0,0,248
	defb 255,255,15,0,15,0,15,0,255,255,0,240,0,15,0,0
	defb 7,248,0,0,0,0,1,254,0,0,127,128,255,0,0,248
	defb 255,255,15,0,15,0,15,0,255,255,0,240,0,15,255,240
	defb 15,240,0,0,0,0,3,252,0,0,63,192,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,15,255,240
	defb 15,240,0,0,0,0,3,252,0,0,63,192,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,15,255,240
	defb 31,224,0,0,0,0,7,248,0,0,31,224,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,15,255,240
	defb 63,192,0,0,0,0,15,240,0,0,15,240,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,0,0,240
	defb 127,128,0,0,0,0,15,240,0,0,15,240,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,0,0,240
	defb 127,128,0,0,0,0,31,224,0,0,7,248,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,0,0,240
	defb 255,0,0,0,0,0,31,224,0,0,7,248,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,0,0,240
	defb 255,255,255,255,255,255,63,192,0,0,3,252,255,0,0,248
	defb 0,7,15,0,15,0,15,0,224,0,0,240,0,15,255,240
	defb 255,255,255,255,255,255,127,128,0,0,1,254,255,0,0,248
	defb 255,255,15,0,15,0,15,0,255,255,0,240,0,15,255,240
	defb 255,255,255,255,255,255,127,128,0,0,1,254,255,0,0,248
	defb 255,255,15,0,15,0,15,0,255,255,0,240,0,15,255,240
	defb 255,255,255,255,255,255,255,0,0,0,0,255,255,0,0,248
	defb 255,255,15,0,15,0,15,0,255,255,0,240,0,15,255,240

title_graphic_data_attr_bytes:
	defb 66,66,66,66,66,66,68,68,71,71,68,68,65,65,65,65
	defb 71,71,71,71,71,71,71,71,71,71,71,71,71,71,71,71
	defb 71,71,71,71,66,66,68,68,68,68,68,68,65,71,71,71
	defb 71,71,71,71,71,71,71,71,71,71,71,71,71,71,71,71
	defb 71,71,71,66,66,71,71,68,68,68,68,71,65,71,71,71
	defb 71,71,71,71,71,71,71,71,71,71,71,71,71,71,71,71
	defb 71,71,66,66,66,71,71,68,68,68,68,71,65,65,65,67
	defb 71,71,69,71,68,68,68,68,68,71,71,71,71,71,71,71
	defb 71,66,66,66,71,71,71,68,68,68,68,71,65,71,71,67
	defb 71,71,69,71,68,68,68,68,68,71,71,67,71,71,70,70
	defb 71,66,66,71,71,71,71,68,68,68,68,71,65,71,71,67
	defb 70,70,69,69,69,71,68,71,66,66,71,67,67,70,70,70
	defb 66,66,71,71,71,71,68,68,68,68,68,68,65,71,71,67
	defb 70,70,69,71,69,71,68,71,66,66,66,67,71,70,70,70
	defb 66,66,66,66,66,66,68,68,71,71,68,68,65,71,71,67
	defb 70,70,69,71,69,71,68,71,66,66,71,67,71,70,70,70
