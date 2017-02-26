; This is a temporary placeholder function
start_main_game:
	inc a
	cp 16
	jp nz,_start_main_game_continue
	ld a,0
_start_main_game_continue:
	out (0xfe),a
	call update_status_bar
	halt
	jp start_main_game
	ret
