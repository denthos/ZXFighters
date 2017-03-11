character_select_instructions_1:
	defb 'A/D & J/L to select character'
character_select_instructions_2:
	defb 'Press Enter to start'
left_arrow:
	defb '<'
right_arrow:
	defb '>'

black_background:
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,24
; 	defb 0,255
; 	defb 0,255
; 	defb 0,255
; 	defb 0,3



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
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,24
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,3

black_sprite:
	defb 255,255
	defb 255,33
	defb 0,0
black_sprite_attr_bytes:
	defb 255,36
	defb 0,0

black_character_cell:
	defb 255,8
	defb 0,0
black_character_cell_attr_bytes:
	defb 255,1
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


; Character data looks like:
; struct character {
;   <name>_name - 10 bytes
;   <name>_sprite_data - 6x6 pixel bytes followed by corresponding attributes
; }
shoe_data:
shoe_name:
	defb '   Shoe   '

shoe_sprite_data:
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
	defb 7,1
	defb 252,1
	defb 0,4
	defb 7,1
	defb 250,1
	defb 0,4
	defb 15,1
	defb 253,1
	defb 0,4
	defb 13,1
	defb 254,1
	defb 128,1
	defb 0,3
	defb 31,1
	defb 255,1
	defb 0,4
	defb 27,1
	defb 255,1
	defb 192,1
	defb 0,3
	defb 63,1
	defb 223,1
	defb 192,1
	defb 0,3
	defb 55,1
	defb 143,1
	defb 224,1
	defb 0,3
	defb 127,1
	defb 7,1
	defb 224,1
	defb 0,3
	defb 127,1
	defb 7,1
	defb 224,1
	defb 0,3
	defb 126,1
	defb 3,1
	defb 224,1
	defb 0,3
	defb 126,1
	defb 3,1
	defb 224,1
	defb 0,3
	defb 126,1
	defb 3,1
	defb 224,1
	defb 0,3
	defb 126,1
	defb 3,1
	defb 192,1
	defb 0,3
	defb 36,1
	defb 1,1
	defb 48,1
	defb 0,3
	defb 66,1
	defb 2,1
	defb 8,1
	defb 0,3
	defb 66,1
	defb 2,1
	defb 8,1
	defb 0,3
	defb 60,1
	defb 1,1
	defb 240,1
	defb 0,2
	defb 0,0
shoe_sprite_attributes:
	defb 120,36
	defb 0,0


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

; Character cell coordinates with bit offset for sprite 1
sprite_one_x_location:
	defb 4
sprite_one_y_location:
	defb 10
sprite_one_x_bit_offset:
	defb 0
sprite_one_y_bit_offset:
	defb 0


; Character cell coordinates with bit offset for sprite 2
sprite_two_x_location:
	defb 21
sprite_two_y_location:
	defb 10
sprite_two_x_bit_offset:
	defb 0
sprite_two_y_bit_offset:
	defb 0

; Pixel coordinates 
sprite_one_x_pixel_location:
	defb 32 			; Character cell 4
sprite_one_y_pixel_location:	
	defb 80				; Character cell 10 

sprite_two_x_pixel_location:
	defb 168			; Character cell 21 
sprite_two_y_pixel_location:
	defb 80				; Character cell 10 

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