; This is a temporary placeholder function
start_main_game:
; 	inc a
; 	cp 16
; 	jp nz,_start_main_game_continue
; 	ld a,0
; _start_main_game_continue:
; 	out (0xfe),a
; 	halt
; 	jp start_main_game
; 	ret
	call draw_background
; 	ld b,4
; 	ld c,10
; 	call calculate_color_cell_pixel_address

	call calculate_offset_middle	; Set up the offset calculation for character overlap detection 
	call calculate_sprite_one_width

	ld b, 32
	ld c, 80 
	call calculate_pixel_byte_address
	ld c,0
	ld d,6
	ld ix,shoe_sprite_data
	call draw_sprite

	ld b,21
	ld c,10
	call calculate_color_cell_pixel_address
	ld c,0
	ld d,6
	ld ix,sprite_sprite_data
	call draw_sprite

	call play_loop
	ret 
; 	call test_draw_sprite
	

; 	ld d,0x47
; 	call clear_screen

; 	ld a,0
; _start_main_game_loop:
; 	inc a
; 	cp 16
; 	jp nz,_start_main_game_continue
; 	ld a,0
; _start_main_game_continue:
; 	out (0xfe),a
; 	jp _start_main_game_loop
; 	ret

calculate_offset_middle:
	ld a, (sprite_one_offset_middle)	; Load offset1 into a 
	ld b, a 				; Load b into a 
	ld a, (sprite_two_offset_middle)	; Load offset2 into a 
	add a, b 				; Add together into a 
	ld b, a 				; Load into b 
	ld a, 6					; Load width of sprite 
	sub a, b 				; Sub the width of sprite from offset sum 

	ld (pre_calculate_offset_middle), a 	; Save the value to memory 
	ret


; POSSIBLE OPTIMIZATION TO MOVE THIS INTO calculate_offset_middle and do this as an intermediary step 
calculate_sprite_one_width: 
	ld a, (sprite_one_offset_middle)	; Get number of columns empty on right side of sprite 1 
	ld b, a 
	ld a, 6 
	sub b 
	ld (sprite_one_width_from_left), a 
	ret 