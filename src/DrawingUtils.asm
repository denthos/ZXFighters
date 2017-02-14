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

; ------------------------------------------------------------------------------
; Subroutine for decoding and copying encoded bytes.
; Bytes should be encoded in pairs with the first value being the byte to copy
; and the second byte being the number of times to copy it.
;
; Inputs:
;		HL = Address of the encoded byte pair
;   IX = Address of memory to write to
; Outputs:
;   HL = Address of next byte after encoded byte pair
;   IX = Address of next byte after we finished writing bytes
; ------------------------------------------------------------------------------
copy_encoded_bytes:
	ld a,(hl)              ; get byte to write
	inc hl                 ; move to read next byte
	ld b,(hl)              ; get number of times to write byte
	inc hl                 ; point hl to next byte
_copy_encoded_bytes_loop_start:
	ld (ix+0),a            ; write byte
	inc ix                 ; point to next location to write to
	; do this b times
	djnz _copy_encoded_bytes_loop_start
	ret


; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen
;
; Inputs:
;		HL = Address of sprite data
;   IX = Address of memory to write to
; Outputs:
;
; ------------------------------------------------------------------------------
draw_sprite:
	ld d,6          ; bytes per row
	ld e,6         	; cells per row
	dec ix
	dec ix
_draw_sprite_loop_start:
	inc ix
	inc ix
	ld a,(ix+1)
	or a
	jp z,_draw_sprite_set_attributes
	ld b,a
	ld a,(ix+0)     ; get byte to write
_draw_sprite_unpack_loop:
	; TODO blend logic using C
	ld (hl),a       ; write byte to memory
	dec d           ; decrement column counter, if 0 go to increment row logic
	jp z,_draw_sprite_row_increment
	inc hl          ; increment address after the check to save a few cycles
_draw_sprite_unpack_loop_2:
	; check if we are done with this encoded byte pair
	djnz _draw_sprite_unpack_loop
	; load next encoded byte pair and loop again
	jp _draw_sprite_loop_start
_draw_sprite_row_increment:
	ld a,e           ; save value of e
	ld e,27          ; load 27 into e
	add hl,de        ; add 27 to hl (d is known to be 0, 27 = 32-5 bytes drawn)
	ld e,a           ; restore e value
	ld a,(ix+0)      ; reload a
	ld d,6           ; reset column counter and continue with current byte pair
	; decrement row counter, if 0 start drawing attributes
	dec e
	jp z,_draw_sprite_row_reset
	;jp z,_draw_sprite_set_attributes
	jp _draw_sprite_unpack_loop_2
_draw_sprite_row_reset:
	ld a,d
	ld d,0
	ld e,64
	add hl,de
	ld d,a
	ld a,(ix+0)
	ld e,6
	jp _draw_sprite_unpack_loop_2
_draw_sprite_set_attributes:
	; TODO
	ret

; ------------------------------------------------------------------------------
; Subroutine for drawing the base of the title screen
;
; Inputs:
;
; Outputs:
;
; ------------------------------------------------------------------------------
draw_title_screen:
	ld de, 48               ; title screen has 341 lines of encoded byte pairs
	ld hl,title_screen_data ; get the location of the encoded data
	ld ix,0x4000            ; start drawing at the beginning of the vram
_draw_title_screen_loop_start:
	call copy_encoded_bytes ; unpack first encoded byte pair
	dec de                  ; decrement our byte pair counter
	ld a,d                  ; check if counter is 0, we do it this way because
	or e                    ;   our counter needs to work for a value above 255
	jp nz,_draw_title_screen_loop_start
	ret
