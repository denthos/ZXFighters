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
	defb 84,255
	defb 84,255
	defb 84,255
	defb 84,3

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

; status_bar_screen_buffer:
;     defs 2048

player_one_last_update_address:
	defb 10001011B
player_one_damage_taken:
	defb 80

player_two_last_update_address:
	defb 10010101B
player_two_damage_taken:
	defb 80

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