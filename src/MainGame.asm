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
	ld b,4
	ld c,10
	call calculate_color_cell_pixel_address
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

