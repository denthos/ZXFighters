interrupt_handler:
	di
	; save registers
	push af
	push bc
	push hl
	push de
	push ix
	ld hl,23672            ; increment frame counter
	inc (hl)

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
	call clear_sprite

	; draw new player 1 sprite
	ld a,(player_1_current_location)
	ld b,a
	ld c,10
	call calculate_color_cell_pixel_address
	ld ix,(player_1_current_sprite)
	call draw_sprite

	; draw new player 2 sprite
	ld a,(player_2_current_location)
	ld b,a
	ld c,10
	call calculate_color_cell_pixel_address
	ld ix,(player_2_current_sprite)
	call draw_sprite

	; update health bar
	;call update_health



	; restore registers
	pop ix
	pop de
	pop hl
	pop bc
	pop af
	ei
	;halt                   ; ideally we want to just halt, and not reti
	reti