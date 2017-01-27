; ------------------------------------------------------------------------------
; Subroutine for copying bytes and writing them to a new location
; Mostly useful for copying pixel data into the VRAM
;
; Inputs:
;		HL = Address of the bitmap to copy from
;		B  = Number of bytes to copy
;   DE = Address of memory to write to
; Outputs:
;
; ------------------------------------------------------------------------------
copy_bytes:
	ld a,(hl)             ; get byte of data
	ld (de),a             ; write byte of data to target location
	inc hl                ; point to next byte to read from
	inc d                 ; point to next byte to write to
	djnz copy_bytes       ; decrement B and jump to start if it is not 0
	ret

; HL = address of first byte
; IX = address of memory to write to
copy_encoded_bytes:
	ld a,(hl)
	inc hl
	ld b,(hl)
	inc hl
_copy_encoded_bytes_loop_start:
	ld (ix+0),a
	inc ix
	djnz _copy_encoded_bytes_loop_start
	ret


	; ------------------------------------------------------------------------------
	; Subroutine for drawing a sprite onto the screen
	;
	; Inputs:
	;		HL = Address of memory to write to
	;		C  = 0 if sprite should overwrite screen contents, 1 if it should blend
	;   DE = Address of sprite to draw
	; Outputs:
	;
	; ------------------------------------------------------------------------------
draw_sprite:
	ld b,16              ; 16 rows of pixels to draw
_draw_sprite_loop_start:
	bit 0,c              ; set zero flag if we are in overwrite mode
	ld a,(de)            ; load first byte of sprite
                       ; if we are in overwrite mode, skip blend logic
	jr z,_draw_sprite_write_byte
	and (hl)             ; check for collisions between the screen data and the
	ret nz               ;   sprite data, return if we find one
	ld a,(de)            ; reload first byte of sprite
	or (hl)              ; blend with background
_draw_sprite_write_byte:
	ld (hl),a            ; write new pixel byte to screen location
	inc l                ; move to next cell on right
	inc de               ; go to next byte of sprite data
	bit 0,c              ; set zero flag if we are in overwrite mode
	ld a,(de)            ; load byte of sprite data
	                     ; jump if we are in overwrite mode
	jr z,_draw_sprite_write_byte_2
	and (hl)             ; check for collisions
	ret nz               ; return if we find one
	ld a,(de)            ; load sprite byte again
	or (hl)              ; blend with background
_draw_sprite_write_byte_2:
	ld (hl),a            ; write to screen
	dec l                ; move to next pixel row down in cell on left
	inc h
	inc de               ; move to next byte in sprite data
	ld a,h               ;
	and 7                ; check if bottom pixel row has been drawn yet
	jr nz,_draw_sprite_loop_back
	ld a,h               ; otherwise move pointer to top pixel row in next cell
	sub 8                ;
	ld h,a               ;
	ld a,l               ;
	add a,32             ;
	ld l,a               ;
	and 224              ; was last pair of cells at y-coord 7 or 15?
	jr nz,_draw_sprite_loop_back
	ld a,h               ; otherwise adjust pointer
	add a,8              ; next one cell down
	ld h,a
	_draw_sprite_loop_back:
	                     ; jump back until all 16 row of pixels have been drawn
	djnz _draw_sprite_loop_start
	xor a                ; set zero flag to indicate no collision
	ret

	;;;


draw_title_screen:
	ld de,341
	ld hl,title_screen_data
	ld ix,0x4000
_draw_title_screen_loop_start:
	call copy_encoded_bytes
	dec de
	ld a,d
	or e
	jp nz,_draw_title_screen_loop_start
	ret
