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

draw_background:
	ld de,29
	ld hl,black_background
	ld ix,0x4000
_draw_background_loop_start:
	call copy_encoded_bytes
	dec de
	ld a,d
	or e
	jp nz,_draw_background_loop_start
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

init_status_bar:
        ld hl,status_bar_attrib_bytes
        ld de,23136                             ; address in vram of start of status bar attribs
        ld bc,160                               ; number of color block attribs to set
        ldir

        ld b,10
        ld h,8
        ld de,20609
        call draw_bar_init
        ld b,10
        ld h,8
        ld de,20629
        call draw_bar_init
        call update_health
        ret

; ------------------------------------------------------------------------------
; Subroutine for drawing a solid bar on screen, only takes care of pixels, not
; attributes. Only tested when drawing within a single row of color cells.
;
; Inputs:
;       B = length of bar in color cells
;       H = height of bar
;       DE = address of top-left pixel byte of bar
;
; Outputs: N/A
;
; Uses: A, B, C, DE, H
; ------------------------------------------------------------------------------
draw_bar_init:
        ld a,255
        ld c,e
_draw_bar_loop_init:
        ld (de),a
        inc e
        djnz _draw_bar_loop_init
        dec h
        jp z,_draw_bar_done_init
        ld b,10
        inc d
        ld e,c
        jp _draw_bar_loop_init
_draw_bar_done_init:
        ret



update_health:
        ld a,(player_two_damage_taken)
        ld c,a                                  ; ld into c for division routine
        ld d,8                                  ; dividing by 8 to find # of color cells
        call cdivd                              ; a holds remainder, c holds result of C/D

        or a                                    ; check if there was a remainder (if Z flag is set for reg A after call to cdivd then no need for these two lines)
        ld d,0                                  ; clear d now, in case no remainder
        jp z,_no_remainder

        dec a                                   ; lookup table (LT) starts at 0         (4)
        ld e,a                                  ; ld remainder into e                   (4)
        xor a                                   ; clear a                               (4)
        ld d,a                                  ; ld 0's into d, DE = remainder         (4)
        ld hl,player_two_remainder_stuff        ; ld address of remainder lookup table  (20)
        add hl,de                               ; add offset (remainder) into LT address(11)
        ld d,(hl)                               ; ld remainder value into d             (7)

_no_remainder:
        ld b,c                                  ; ld bar length into b
        ld hl,20629                             ; address of start of bar
        ld a,1                                  ; clear a
;         ld (player_two_damage_taken), a       ; TODO: reset damage taken value in memory
        ld e,8                                  ; height of bar in pixel lines
        call draw_bar
        ret


; ------------------------------------------------------------------------------
; Subroutine for drawing updating health bar, should probably be expanded to
; handle special move bar too.
;
; Inputs:
;       A = used to clear bytes in vram, should always be 0 // 0=p1  1=p2
;       B = length of bar in color cells
;       D = remainder of pixels to clear
;       E = height of bar in pixel lines
;       HL = address to start at (top left)
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L, IXH
; ------------------------------------------------------------------------------
draw_bar:
        ld c,l                                  ; store lower byte of address to draw to
        push bc                                 ; store length of bar + lower byte to stack
        ld c,a                                  ; move player select to c
        xor a                                   ; clear a just in case

_draw_bar_loop:
        cp b                                    ; check that there is full bytes to write
        jp z,_draw_remainder                    ; otherwise jump to draw remainder
        cp c
        jp nz,_player_two_inner_loop
        dec l
_player_two_inner_loop:
        ld (hl),a                               ; write byte to screen
        cp c
        jp z,_player_one_inner_loop
        inc l                                   ; move on to next pixel line to the right
_player_one_inner_loop:
        djnz _draw_bar_loop                     ; keep going until b=0

_draw_remainder:
        cp d                                    ; check if there is a remainder to draw
        jp z,_draw_reset                        ; jump if not
        cp c
        jp nz,_player_two_outer_loop
        dec l
_player_two_outer_loop:
        ld (hl),d                               ; otherwise draw remainder
_draw_reset:
        dec e                                   ; e counts number of lines
        cp e                                    ; check e vs a (a should be 0)
        jp z,_draw_bar_done                     ; if no more lines, done
        pop bc
        push bc
        inc h                                   ; move on to next pixel line
        ld l,c                                  ; reset lower byte of address
        jp _draw_bar_loop
_draw_bar_done:
        pop bc
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
