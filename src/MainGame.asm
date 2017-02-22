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

	ld ix,shoe_sprite_data
	ld hl,0x4000
	ld d,6
	call draw_sprite
	call move_sprite_left
