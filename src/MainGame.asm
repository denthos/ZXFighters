main_game_loop:
	di
	; save registers
	;push af
	;push bc
	;push hl
	;push de
	;push ix
	ld hl,23672            ; increment frame counter
	inc (hl)
	ld a,(hl)
	bit 0,a
	jp z,_main_game_loop_done
_main_game_loop_start:

	;;;;;;;;;; START MAIN GAME LOOP ;;;;;;;;;;

	;;; CLEAR OLD SPRITES, DRAW NEW ONES ;;;

	; clear old player 1 sprite
	ld a,(player_1_last_location)
	ld b,a
	ld c,10
	call calculate_color_cell_pixel_address
	call clear_sprite

	; clear old player 2 sprite
	ld a,(player_2_last_location)
	ld b,a
	ld c,10
	call calculate_color_cell_pixel_address
	;call clear_sprite

	; draw new player 1 sprite
	ld a,(player_1_current_location)
	ld b,a
	ld c,10
	call calculate_color_cell_pixel_address
	ld ix,(player_1_current_sprite)
	ld c,0
	call draw_sprite

	; draw new player 2 sprite
	ld a,(player_2_current_location)
	ld b,a
	ld c,10
	call calculate_color_cell_pixel_address
	ld ix,(player_2_current_sprite)
	ld c,1
	;call draw_sprite

	; update player positions
	ld a,(player_1_current_location)
	ld (player_1_last_location),a
	ld a,(player_2_current_location)
	ld (player_2_last_location),a



	;;; UPDATE INTERFACE ;;;
	
	; update health bar
	call update_health



	;;; START MAIN GAME LOGIC ;;;

	;;; PLAYER 1 LOGIC ;;;

	; check if player is in hit stun
	ld a,(player_1_hit_stun)
	or a
	jp z,_player_1_no_hit_stun
	ld hl,(player_1_sprite_hit)
	ld (player_1_current_sprite),hl
	ld hl,player_1_hit_stun
	dec (hl)               ; decrement hit stun counter
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
	ld ix,player_1_attack_3
	jp _player_1_attacking_1
_player_1_attacking_init_1:
	ld ix,player_1_attack_1
	jp _player_1_attacking_1
_player_1_attacking_init_2:
	ld ix,player_1_attack_2

	; begin attack logic
_player_1_attacking_1:
	; if current_attack_frame < starting_active_frame, draw wind up sprite
	ld a,(ix+0)
	ld b,a
	ld a,(player_1_current_attack_frame)
	cp b
	jp nc,_player_1_attacking_2
	ld h,(ix+3)
	ld l,(ix+4)
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
	ld h,(ix+5)
	ld l,(ix+6)
	ld (player_1_current_sprite),hl
	call player_1_attack_1_execute
	jp _player_1_attacking_done

_player_1_attacking_3:
	; if current_attack_frame < total_attack_frames, draw wind down sprite
	ld a,(ix+2)
	ld b,a
	ld a,(player_1_current_attack_frame)
	cp b
	jp nc,_player_1_attacking_4
	ld h,(ix+3)
	ld l,(ix+4)
	ld (player_1_current_sprite),hl
	jp _player_1_attacking_done

_player_1_attacking_4:
	; attack has finished if we get here, clean up and process inputs like normal
	ld hl,(player_1_sprite_idle_1)
	ld (player_1_current_sprite),hl
	ld bc,0
	ld (player_1_current_attack),bc
	jp _player_1_not_attacking


_player_1_attacking_done:
	ld hl,player_1_current_attack_frame
	inc (hl)
	jp _player_1_done

_player_1_not_attacking:

	; read player input
	call read_player_1_input


	; check if player is in attack stun
	ld a,(player_1_attack_stun)
	or a
	jp z,_player_1_no_attack_stun
	ld hl,player_1_attack_stun
	dec (hl)
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
	ld hl,player_1_movement_stun
	dec (hl)
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
	ld hl,(player_2_sprite_hit)
	ld (player_2_current_sprite),hl
	ld hl,player_2_hit_stun
	dec (hl)               ; decrement hit stun counter
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
	ld ix,player_2_attack_3
	jp _player_2_attacking_1
_player_2_attacking_init_1:
	ld ix,player_2_attack_1
	jp _player_2_attacking_1
_player_2_attacking_init_2:
	ld ix,player_2_attack_2

	; begin attack logic
_player_2_attacking_1:
	; if current_attack_frame < starting_active_frame, draw wind up sprite
	ld a,(ix+0)
	ld b,a
	ld a,(player_2_current_attack_frame)
	cp b
	jp nc,_player_2_attacking_2
	ld h,(ix+3)
	ld l,(ix+4)
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
	ld h,(ix+5)
	ld l,(ix+6)
	ld (player_2_current_sprite),hl
	call player_2_attack_1_execute
	jp _player_2_attacking_done

_player_2_attacking_3:
	; if current_attack_frame < total_attack_frames, draw wind down sprite
	ld a,(ix+2)
	ld b,a
	ld a,(player_2_current_attack_frame)
	cp b
	jp nc,_player_2_attacking_4
	ld h,(ix+3)
	ld l,(ix+4)
	ld (player_2_current_sprite),hl
	jp _player_2_attacking_done

_player_2_attacking_4:
	; attack has finished if we get here, clean up and process inputs like normal
	ld hl,(player_2_sprite_idle_1)
	ld (player_2_current_sprite),hl
	ld bc,0
	ld (player_2_current_attack),bc
	jp _player_2_not_attacking


_player_2_attacking_done:
	ld hl,player_2_current_attack_frame
	inc (hl)
	jp _player_2_done

_player_2_not_attacking:

	; read player input
	call read_player_2_input


	; check if player is in attack stun
	ld a,(player_2_attack_stun)
	or a
	jp z,_player_2_no_attack_stun
	ld hl,player_2_attack_stun
	dec (hl)
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
	ld hl,player_2_movement_stun
	dec (hl)
	jp _player_2_done


_player_2_no_movement_stun:
	; process movement commands
	call update_player_2_movements


_player_2_done:

	; clear inputs
	call clear_input

_main_game_loop_done:
	; restore registers
	;pop ix
	;pop de
	;pop hl
	;pop bc
	;pop af
	ei
	reti