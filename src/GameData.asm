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

status_bar_screen_buffer:
    defs 2048

player_one_health:
	defb 79
player_two_health:
	defb 79
; length_bar:
; 	defb 0

_remainder_stuff:
	; defb 00000000B
	defb 01111111B
	defb 00111111B
	defb 00011111B
	defb 00001111B
	defb 00000111B
	defb 00000011B
	defb 00000001B
