; This is a temporary placeholder function
start_main_game:
	ld d,0x47
	call clear_screen

	ld a,0
_start_main_game_loop:
	inc a
	cp 16
	jp nz,_start_main_game_continue
	ld a,0
_start_main_game_continue:
	out (0xfe),a
	jp _start_main_game_loop
	ret
