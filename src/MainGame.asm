main_game_loop:
	di
	; save registers
	;push af
	;push bc
	;push hl
	;push de
	;push ix
	ld hl,frame_counter            ; increment frame counter
	inc (hl)
_main_game_loop_start:

	;;;;;;;;;; START MAIN GAME LOOP ;;;;;;;;;;

	;;; CLEAR OLD SPRITES, DRAW NEW ONES ;;;


	; clear old player 1 sprite
	ld a,(player_1_last_location)
	ld b,a
	ld c,14
	call calculate_color_cell_pixel_address
	call clear_sprite

	; clear old player 2 sprite
	ld a,(player_2_last_location)
	ld b,a
	ld c,14
	call calculate_color_cell_pixel_address
	call clear_sprite

	; draw new player 2 sprite
	ld a,(player_2_current_location)
	ld b,a
	ld c,14
	call calculate_color_cell_pixel_address
	ld ix,(player_2_current_sprite)
	ld c,1
	ld b,1
	call draw_sprite

	; draw new player 1 sprite
	ld a,(player_1_current_location)
	ld b,a
	ld c,14
	call calculate_color_cell_pixel_address
	ld ix,(player_1_current_sprite)
	ld c,1
	ld b,0
	call draw_sprite

	; update player positions
	ld a,(player_1_current_location)
	ld (player_1_last_location),a
	ld a,(player_2_current_location)
	ld (player_2_last_location),a



	;;; UPDATE INTERFACE ;;;
	
	; update health bar

	call update_health_bars
	call update_energy_bars



	;;; START MAIN GAME LOGIC ;;;

	;;; PLAYER 1 LOGIC ;;;

	; check if player is in hit stun
	ld a,(player_1_hit_stun)
	or a
	jp z,_player_1_no_hit_stun
_player_1_hit_stun:
	ld a,0
	ld (player_1_current_attack),a
	ld (player_1_current_attack_frame),a
	ld hl,(player_1_sprite_hit)
	ld (player_1_current_sprite),hl
	jp _player_1_done      ; if player is in hit stun, skip rest of input logic

_player_1_no_hit_stun:
	; check if player is attacking
	ld a,(player_1_current_attack)
	or a
	jp z,_player_1_not_attacking


	; init ix to be whatever attack is happening
	cp 1
	jp z,_player_1_attacking_init_1
	cp 2
	jp z,_player_1_attacking_init_2
	cp 3
	jp z,_player_1_attacking_init_3
_player_1_attacking_init_1:
	ld ix,player_1_attack_1
	jp _player_1_attacking_1
_player_1_attacking_init_2:
	ld ix,player_1_attack_2
	jp _player_1_attacking_1
_player_1_attacking_init_3:
	ld ix,player_1_attack_3
	jp _player_1_attacking_1

	; begin attack logic
_player_1_attacking_1:
	; if current_attack_frame < starting_active_frame, draw wind up sprite
	ld a,(ix+0)
	ld b,a
	ld a,(player_1_current_attack_frame)
	cp b
	jp nc,_player_1_attacking_2
	ld h,(ix+4)
	ld l,(ix+3)
	ld (player_1_current_sprite),hl
	jp _player_1_attacking_done

_player_1_attacking_2:
	; if current_attack_frame < ending_active_frame, draw attack sprite 2
	;   and execute attack code
	ld a,(ix+1)
	ld b,a
	ld a,(player_1_current_attack_frame)
	cp b
	jp nc,_player_1_attacking_3
	ld h,(ix+6)
	ld l,(ix+5)
	ld (player_1_current_sprite),hl
	call player_1_attack
	jp _player_1_attacking_done

_player_1_attacking_3:
	; if current_attack_frame < total_attack_frames, draw wind down sprite
	ld a,(ix+2)
	ld b,a
	ld a,(player_1_current_attack_frame)
	cp b
	jp nc,_player_1_attacking_4
	ld h,(ix+4)
	ld l,(ix+3)
	ld (player_1_current_sprite),hl
	jp _player_1_attacking_done

_player_1_attacking_4:
	; attack has finished if we get here, clean up and process inputs like normal
	ld hl,(player_1_sprite_idle_1)
	ld (player_1_current_sprite),hl
	xor a
	ld (player_1_current_attack),a
	ld (player_1_current_attack_frame),a
	jp _player_1_not_attacking


_player_1_attacking_done:
	ld hl,player_1_current_attack_frame
	inc (hl)
	jp _player_1_done

_player_1_not_attacking:
	ld a,(player_1_blocking)
	or a
	jp z,_player_1_not_blocking
_player_1_blocking:
	ld hl,(player_1_sprite_block)
	ld (player_1_current_sprite),hl
	ld hl,player_1_blocking_damage_taken
	inc (hl)
	ld a,(hl)
	cp 40
	jp nc,_player_1_blocking_expired
	ld a,5
	ld (player_1_movement_stun),a
	xor a
	ld (player_1_blocking),a
	jp _player_1_done
_player_1_blocking_expired:
	ld a,0
	ld (player_1_blocking_damage_taken),a
	ld a,50
	ld (player_1_hit_stun),a
	xor a
	ld (player_1_blocking),a

_player_1_not_blocking:

	; read player input
	call read_player_1_input


	; check if player is in attack stun
	ld a,(player_1_attack_stun)
	or a
	jp z,_player_1_no_attack_stun
	jp _player_1_movement_logic


_player_1_no_attack_stun:
	; process attack commands
	call update_player_1_attacks
	; check if an attack command was issued
	ld bc,(player_1_current_attack)
	ld a,b
	or c
	jp nz,_player_1_done ; if player started an attack we are done


_player_1_movement_logic:
	; check if player is in movement stun
	ld a,(player_1_movement_stun)
	or a
	jp z,_player_1_no_movement_stun
	jp _player_1_done


_player_1_no_movement_stun:
	; process movement commands
	call update_player_1_movements


_player_1_done:



	;;; PLAYER 2 LOGIC ;;;

	; check if player is in hit stun
	ld a,(player_2_hit_stun)
	or a
	jp z,_player_2_no_hit_stun
_player_2_hit_stun:
	ld a,0
	ld (player_2_current_attack),a
	ld (player_2_current_attack_frame),a
	ld hl,(player_2_sprite_hit)
	ld (player_2_current_sprite),hl
	jp _player_2_done      ; if player is in hit stun, skip rest of input logic

_player_2_no_hit_stun:
	; check if player is attacking
	ld a,(player_2_current_attack)
	or a
	jp z,_player_2_not_attacking


	; init ix to be whatever attack is happening
	cp 1
	jp z,_player_2_attacking_init_1
	cp 2
	jp z,_player_2_attacking_init_2
	cp 3
	jp z,_player_2_attacking_init_3
_player_2_attacking_init_1:
	ld ix,player_2_attack_1
	jp _player_2_attacking_1
_player_2_attacking_init_2:
	ld ix,player_2_attack_2
	jp _player_2_attacking_1
_player_2_attacking_init_3:
	ld ix,player_2_attack_3
	jp _player_2_attacking_1

	; begin attack logic
_player_2_attacking_1:
	; if current_attack_frame < starting_active_frame, draw wind up sprite
	ld a,(ix+0)
	ld b,a
	ld a,(player_2_current_attack_frame)
	cp b
	jp nc,_player_2_attacking_2
	ld h,(ix+4)
	ld l,(ix+3)
	ld (player_2_current_sprite),hl
	jp _player_2_attacking_done

_player_2_attacking_2:
	; if current_attack_frame < ending_active_frame, draw attack sprite 2
	;   and execute attack code
	ld a,(ix+1)
	ld b,a
	ld a,(player_2_current_attack_frame)
	cp b
	jp nc,_player_2_attacking_3
	ld h,(ix+6)
	ld l,(ix+5)
	ld (player_2_current_sprite),hl
	call player_2_attack
	jp _player_2_attacking_done

_player_2_attacking_3:
	; if current_attack_frame < total_attack_frames, draw wind down sprite
	ld a,(ix+2)
	ld b,a
	ld a,(player_2_current_attack_frame)
	cp b
	jp nc,_player_2_attacking_4
	ld h,(ix+4)
	ld l,(ix+3)
	ld (player_2_current_sprite),hl
	jp _player_2_attacking_done

_player_2_attacking_4:
	; attack has finished if we get here, clean up and process inputs like normal
	ld hl,(player_2_sprite_idle_1)
	ld (player_2_current_sprite),hl
	xor a
	ld (player_2_current_attack),a
	ld (player_2_current_attack_frame),a
	jp _player_2_not_attacking


_player_2_attacking_done:
	ld hl,player_2_current_attack_frame
	inc (hl)
	jp _player_2_done

_player_2_not_attacking:
	ld a,(player_2_blocking)
	or a
	jp z,_player_2_not_blocking
_player_2_blocking:
	ld hl,(player_2_sprite_block)
	ld (player_2_current_sprite),hl
	ld hl,player_2_blocking_damage_taken
	ld a,(hl)
	cp 40
	jp nc,_player_2_blocking_expired
	inc (hl)
	ld a,5
	ld (player_2_movement_stun),a
	xor a
	ld (player_2_blocking),a
	jp _player_2_done
_player_2_blocking_expired:
	ld a,0
	ld (player_2_blocking_damage_taken),a
	ld a,50
	ld (player_2_hit_stun),a
	xor a
	ld (player_2_blocking),a

_player_2_not_blocking:

	; read player input
	call read_player_2_input


	; check if player is in attack stun
	ld a,(player_2_attack_stun)
	or a
	jp z,_player_2_no_attack_stun
	jp _player_2_movement_logic


_player_2_no_attack_stun:
	; process attack commands
	call update_player_2_attacks
	; check if an attack command was issued
	ld bc,(player_2_current_attack)
	ld a,b
	or c
	jp nz,_player_2_done ; if player started an attack we are done


_player_2_movement_logic:
	; check if player is in movement stun
	ld a,(player_2_movement_stun)
	or a
	jp z,_player_2_no_movement_stun
	jp _player_2_done


_player_2_no_movement_stun:
	; process movement commands
	call update_player_2_movements


_player_2_done:

	; clear inputs
	call clear_input
	call decrement_player_counters



	; check game end conditions
	ld a,(player_1_damage_taken)
	cp 80
	jp nc,_player_2_victory
	ld a,(player_2_damage_taken)
	cp 80
	jp nc,_player_1_victory


_main_game_delay_loop:
	

_main_game_loop_done:
	; restore registers
	;pop ix
	;pop de
	;pop hl
	;pop bc
	;pop af
	ei
	reti




_player_1_victory:
	di 
	ld a, (player_1_rounds_won) 
	inc a 
	ld (player_1_rounds_won), a
	ld b, a 
	ld a, (number_of_rounds) 
	cp b 
	jp z, _show_player_1_victory_screen 

	call set_up_characters
	jp main_loop_start 
	;jp main_game_loop



_player_2_victory:
	di
	ld a, (player_2_rounds_won)
	dec a 
	ld (player_1_rounds_won), a
	ld b, a
	ld a, (number_of_rounds)
	cp b 
	jp z, _show_player_2_victory_screen 
	call set_up_characters 
	;jp main_game_loop
	jp main_loop_start

_show_player_1_victory_screen:
	ld a, 0 
	ld (player_1_rounds_won), a 
	ld (player_2_rounds_won), a 
	jp main_start

_show_player_2_victory_screen:
	ld (player_1_rounds_won), a 
	ld (player_2_rounds_won), a 
	jp main_start

set_up_characters:
	; Player 1 logic first 
; 	ld a, (default_player_1_location)	; Get the default starting position of player 1 
; 	ld (player_1_current_location), a 	; Reset the current location 
; 	ld (player_1_last_location), a 		; Reset the last location 
; 	ld a,0
; 	ld (player_1_damage_taken),a
; 	ld hl,(player_1_sprite_idle_1)
; 	ld (player_1_current_sprite),hl
; 	ld a, 1
; 	ld (player_1_current_idle_sprite), a

; 	ld a, (default_player_2_location)	; Get the default starting position of player 1 
; 	ld (player_2_current_location), a 	; Reset the current location 
; 	ld (player_2_last_location), a 		; Reset the last location 
; 	ld a,0
; 	ld (player_2_damage_taken),a
; 	ld hl,(player_2_sprite_idle_1)
; 	ld (player_2_current_sprite),hl
; 	ld a, 1
; 	ld (player_2_current_idle_sprite), a

	ld a,0
	ld (player_1_damage_taken),a
	ld (player_1_energy),a
	ld a,3
 	ld (player_1_last_location),a
	ld (player_1_current_location),a
	ld hl,(player_1_sprite_idle_1)
	ld (player_1_current_sprite),hl
	ld a, 1
	ld (player_1_current_idle_sprite), a

	; initialize player 2 data
	ld a,0
	ld (player_2_damage_taken),a
	ld (player_2_energy),a
	ld a,23
	ld (player_2_last_location),a
 	ld (player_2_current_location),a
	ld hl,(player_2_sprite_idle_1)
	ld (player_2_current_sprite),hl
	ld a, 1
	ld (player_2_current_idle_sprite), a


	; clear the screen
	;ld d,0x47             ; 0x47 = 0b01000111 (paper = black, ink = white)
	ld d,0x6f
	call clear_screen

	; draw starting interface
	call draw_status_panel
	call init_health_bars
	call init_energy_bars


	ret 
					


decrement_player_counters:
	ld hl,player_1_hit_stun
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_1
	dec (hl)
_decrement_player_counters_1:
	ld hl,player_1_attack_stun
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_2
	dec (hl)
_decrement_player_counters_2:
	ld hl,player_1_movement_stun
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_3
	dec (hl)
_decrement_player_counters_3:
	ld hl,player_1_blocking_damage_taken
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_4
	dec (hl)
_decrement_player_counters_4:
	ld hl,player_2_hit_stun
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_5
	dec (hl)
_decrement_player_counters_5:
	ld hl,player_2_attack_stun
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_6
	dec (hl)
_decrement_player_counters_6:
	ld hl,player_2_movement_stun
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_7
	dec a
	ld (hl),a
_decrement_player_counters_7:
	ld hl,player_2_blocking_damage_taken
	ld a,(hl)
	or a
	jp z,_decrement_player_counters_8
	dec (hl)
_decrement_player_counters_8:
	ret
