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
; Subroutine for copying bytes and writing them to a new location
; Mostly useful for copying pixel data into the VRAM
;
; Inputs:
;		HL = Address of memory to fill
;		BC = Number of bytes to write
;   D  = Byte to copy
; Outputs:
;
; ------------------------------------------------------------------------------
fill_byte:
	ld (hl),d
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,fill_byte
	ret

; fill_byte_fast is the same as fill_byte except it uses only b, not bc
fill_byte_fast:
	ld (hl),d
	inc hl
	djnz fill_byte_fast
	ret


; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen
;
; Inputs:
;   C  = 0 for overwrite mode, 1 for blending mode
;   D  = Width of sprite in color cells
;		HL = Address of vram to write to
;   IX = Address of sprite pixel data
; Outputs:
;
; ------------------------------------------------------------------------------
draw_sprite:
	ld e,d
	ld (draw_memory_store),hl
	dec ix
	dec ix
_draw_sprite_unpack:
	inc ix
	inc ix
	ld a,(ix+1)
	or a
	jp z,_draw_sprite_attributes ; maybe need to store hl first
	ld b,a
_draw_sprite_loop_start:
	bit 0,c                ; set zero flag if we are in overwrite mode (c==0)
	ld a,(ix+0)            ; load byte of sprite data
	                       ; skip blend logic if we are in overwrite mode
	jr z,_draw_sprite_write_byte
	and (hl)               ; check for collisions between screen data and sprite
	ret nz
	ld a,(ix+0)            ; reload sprite data
	or (hl)                ; blend with screen data
_draw_sprite_write_byte:
	ld (hl),a              ; write pixel byte to screen
	inc l                  ; move to next cell on right
	dec d
	ld a,d
	or a
	jp z,_draw_sprite_row_decrement
_draw_sprite_row_decrement_return:
	djnz _draw_sprite_loop_start
	jp _draw_sprite_unpack

_draw_sprite_attributes:
	ld d,e
	ld hl,(draw_memory_store)
	ld a,h
	srl a
	srl a
	srl a
	or 88                  ; convert address of first pixel byte to
	ld h,a                 ;   address of first attribute byte
_draw_sprite_attributes_unpack:
	inc ix
	inc ix
	ld a,(ix+1)
	or a
	jp z,_draw_sprite_done
	ld b,a
_draw_sprite_attributes_loop_start:
	ld a,(ix+0)
	ld (hl),a
	inc hl
	dec d
	ld a,d
	or a
	jr z,_draw_sprite_attributes_row_decrement
_draw_sprite_attributes_row_decrement_return:
	djnz _draw_sprite_attributes_loop_start
	jp _draw_sprite_attributes_unpack

_draw_sprite_done:
	ret

_draw_sprite_row_decrement:
	ld d,e                 ; restore column counter
	ld a,l                 ; move to next pixel row down in cell <e> to left
	sub e
	ld l,a
	inc h
	ld a,h                 ; check if we overflowed into y6
	and 7
	jr nz,_draw_sprite_row_decrement_return
	ld a,h
	sub 8                  ; decrement y6
	ld h,a
	ld a,l
	add a,32               ; increment y3
	ld l,a
	and 224                ; check if we overflowed into y0
	jr nz,_draw_sprite_row_decrement_return
	ld a,h
	add a,8                ; increment y6
	ld h,a
	jp _draw_sprite_row_decrement_return

_draw_sprite_attributes_row_decrement:
	ld d,e
	ld a,32
	sub e
	ld c,a
	ld a,b
	ld b,0
	add hl,bc
	ld b,a
	jp _draw_sprite_attributes_row_decrement_return


; ------------------------------------------------------------------------------
; Subroutine for drawing the base of the title screen
;
; Inputs:
;
; Outputs:
;
; ------------------------------------------------------------------------------
draw_title_screen:

	; TODO: ADD TITLE GRAPHIC AT TOP

	; DRAW ARROWS AROUND P1
	ld de,0x48e1
	ld a,(left_arrow)
	call print_char

	ld de,0x48e8
	ld a,(right_arrow)
	call print_char


	; DRAW ARROWS AROUND P2
	ld de,0x48f7
	ld a,(left_arrow)
	call print_char

	ld de,0x48fe
	ld a,(right_arrow)
	call print_char


	; INSTRUCTIONS
	ld de,0x50a2
	ld ix,character_select_instructions_1
	ld c,29
	call print_string

	ld de,0x50e6
	ld ix,character_select_instructions_2
	ld c,20
	call print_string

	ret

; ------------------------------------------------------------------------------
; Subroutine for drawing the sprite and name of characters onto the character
;   select screen.
;
; Inputs:
;
; Outputs:
;
; ------------------------------------------------------------------------------

draw_title_character_p1:
	ld a,(selected_character_p1)
	call ld_character_data_address
	ld c,10                ; length of sprite name (always 10)
	ld de,0x5040           ; color cell (0,18)
	call print_string
	ld d,6                 ; width of sprite (always 6)
	ld c,0                 ; overwrite mode
	ld hl,0x4882           ; color cell (2,12)
	jp draw_sprite
	ret

draw_title_character_p2:
  ld a,(selected_character_p2)
  call ld_character_data_address
  ld c,10               ; length of sprite name (always 10)
  ld de,0x5056          ; color cell (22,18)
  call print_string
  ld d,6                ; width of sprite (always 6)
  ld c,0                ; overwrite mode
  ld hl,0x4898          ; color cell (24,12)
	jp draw_sprite
	ret


; ------------------------------------------------------------------------------
; This routine is basically a switch statement for determining which character
; is selected based on the character index passed in through A, and loading
; the address of that character's data into IX. This can't be done by storing
; pointers to the data in memory, because IX can only be loaded with constants
;
; Inputs:
;   A  = Index of the character whose data address should be loaded
; Outputs:
;   IX = Address of the data of the character
; ------------------------------------------------------------------------------
ld_character_data_address:
	cp 0
	jp z,_ld_character_data_address_char_0
	cp 1
	jp z,_ld_character_data_address_char_1
_ld_character_data_address_char_0:
	ld ix,shoe_data
	ret
_ld_character_data_address_char_1:
	ld ix,sprite_data
	ret



; ------------------------------------------------------------------------------
; This sets all pixel bytes to 0x0, and all attribute bytes to the desired
;   value. It is very inefficient and shouldn't be used outside of situations
;   where the entire screen will be different.
;
; Inputs:
;   D  = Value to set attribute bytes to
; Outputs:
;
; ------------------------------------------------------------------------------
clear_screen:
	ld hl,0x5800          ; address of first attribute byte
	ld bc,768             ; number of attribute bytes
	call fill_byte
	ld hl,0x4000
	ld bc,6144
	ld d,0x0
	jp fill_byte
