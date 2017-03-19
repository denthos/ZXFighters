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
;   HL = Address of vram to write to
;   IX = Address of sprite pixel data
; Outputs:
;
; ------------------------------------------------------------------------------
draw_sprite:
	ld e,(ix+0)            ; get the number of columns to cut off at rightside of sprite
	ld d,6                 ; number of columns (not variable)
	ld (draw_memory_store),hl
	dec ix                 ; decrement ix so double increment at start of unpack gets us to the data
_draw_sprite_unpack:
	inc ix
	inc ix
	ld a,(ix+1)
	or a
	jp z,_draw_sprite_attributes ; maybe need to store hl first
	ld b,a
_draw_sprite_loop_start:
	ld a,e
	cp d
	jp nc,_draw_sprite_write_byte_skip
	bit 0,c                ; set zero flag if we are in overwrite mode (c==0)
	ld a,(ix+0)            ; load byte of sprite data
	                       ; skip blend logic if we are in overwrite mode
	jr z,_draw_sprite_write_byte
	or (hl)                ; blend with screen data
_draw_sprite_write_byte:
	ld (hl),a              ; write pixel byte to screen
_draw_sprite_write_byte_skip:
	inc l                  ; move to next cell on right
	dec d
	ld a,d
	or a
	jp z,_draw_sprite_row_decrement
_draw_sprite_row_decrement_return:
	djnz _draw_sprite_loop_start
	jp _draw_sprite_unpack

_draw_sprite_attributes:
	ld d,6
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
	ld a,e
	cp d
	jp nc,_draw_sprite_attributes_write_byte_skip
	bit 0,c                ; set zero flag if we are in overwrite mode
	ld a,(ix+0)
	jr z,_draw_sprite_attributes_write_byte
	ld a,(hl)
	and 0x38
	ld (hl),a
	ld a,(ix+0)
	and 0xc7
	or (hl)
_draw_sprite_attributes_write_byte:
	ld (hl),a
_draw_sprite_attributes_write_byte_skip:
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
	ld d,6                 ; restore column counter
	ld a,l                 ; move to next pixel row down in cell <e> to left
	sub 6
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
	ld d,6
	ld c,26
	ld a,b
	ld b,0
	add hl,bc
	ld b,a
	jp _draw_sprite_attributes_row_decrement_return


; ------------------------------------------------------------------------------
; Subroutine for clearing a sprite sized block of the screen
;
; Inputs:
;   HL = Address of vram to start clearing
; Outputs:
;
; ------------------------------------------------------------------------------
clear_sprite:
	ld b,48
_clear_sprite_loop:
	ld a,0
	ld (hl),a
	inc l
	ld (hl),a
	inc l
	ld (hl),a
	inc l
	ld (hl),a
	inc l
	ld (hl),a
	inc l
	ld (hl),a
	jp _clear_sprite_row_decrement
_clear_sprite_row_decrement_return:
	djnz _clear_sprite_loop
	ret

_clear_sprite_row_decrement:
	ld a,l                 ; move to next pixel row down in cell <e> to left
	sub 5
	ld l,a
	inc h
	ld a,h                 ; check if we overflowed into y6
	and 7
	jr nz,_clear_sprite_row_decrement_return
	ld a,h
	sub 8                  ; decrement y6
	ld h,a
	ld a,l
	add a,32               ; increment y3
	ld l,a
	and 224                ; check if we overflowed into y0
	jr nz,_clear_sprite_row_decrement_return
	ld a,h
	add a,8                ; increment y6
	ld h,a
	jp _clear_sprite_row_decrement_return

; -----------------------------------------------------------------------
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
	ld a,(selected_character_p1)
	call ld_character_sprite_address
	ld c,0                 ; overwrite mode
	ld hl,0x4882           ; color cell (2,12)
	jp draw_sprite

draw_title_character_p2:
	ld a,(selected_character_p2)
	call ld_character_data_address
	ld c,10               ; length of sprite name (always 10)
	ld de,0x5056          ; color cell (22,18)
	call print_string
	ld a,(selected_character_p2)
	call ld_character_sprite_address
	ld c,0                ; overwrite mode
	ld hl,0x4898          ; color cell (24,12)
	jp draw_sprite


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
	ld ix,punchy_data
	ret
_ld_character_data_address_char_1:
	ld ix,punchy_data
	ret

ld_character_sprite_address:
	cp 0
	jp z,_ld_character_sprite_address_char_0
	cp 1
	jp z,_ld_character_sprite_address_char_1
_ld_character_sprite_address_char_0:
	ld ix,punchy_sprites
	ret
_ld_character_sprite_address_char_1:
	ld ix,punchy_sprites
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

; ------------------------------------------------------------------------------
; Subroutine for updating health bar for both players. TODO: could be optimized
; by only updating the pixels that have changed. Currently updates entire health
; bar.
;
; Inputs: N/A
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
update_health:
        ld a,(player_1_damage_taken)
        ld c,a
        ld e,0                                  ; flag for player one
        ld h,01010000B                          ; upper byte of start address
        ld a,(player_one_last_update_address)   ; lower byte of start address
        ld l,a
        call individual_health

        ld a,(player_2_damage_taken)
        ld c,a
        ld e,1                                  ; flag for player two
        ld h,01010000B                          ; upper byte of start address
        ld a,(player_two_last_update_address)   ; lower byte of start address
        ld l,a
        call individual_health
        ret

; ------------------------------------------------------------------------------
; Helper subroutine for updating health bar, handles preprocessing for loading in
; player info.
;
; Inputs:
;       C = damage taken
;       E = player select 0=p1 1=p2
;       HL = address to start
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
individual_health:
        push hl                                 ; save address on stack
        ld d,8                                  ; dividing by 8 to find # of color cells
        call cdivd                              ; a holds remainder, c holds result of C/D
        ld d,a                                  ; clear d now, in case no remainder
        ld b,c                                  ; ld b for call to draw_bar, in case no remainder
        or a                                    ; check if there was a remainder (if Z flag is set for reg A after call to cdivd then no need for these two lines)
        jp z,_no_remainder

        ld d,c                                  ; store result
        dec a                                   ; lookup table (LT) starts at 0         (4)

        ld c,a                                  ; ld remainder into c                   (4)
        xor a                                   ; clear a                               (4)
        ld b,a                                  ; ld 0's into b, BC = remainder         (4)

        cp e                                    ; check which player we are updating
        jp nz,_player_two_remainder

        ld hl,player_one_remainder_stuff        ; updating player one
        jp _remainder_stuff_loaded

_player_two_remainder:
        ld hl,player_two_remainder_stuff        ; ld address of remainder lookup table  (20)

_remainder_stuff_loaded:
        add hl,bc                               ; add offset (remainder) into LT address(11)
        ld b,d                                  ; ld bar length into b
        ld d,(hl)                               ; ld remainder value into d             (7)

_no_remainder:
        ld a,e                                  ; set player flag
        ld e,8                                  ; height of bar in pixel lines
        pop hl
        call draw_bar
;         ld (player_2_damage_taken), a       ; TODO: reset damage taken value in memory
        ret


; ------------------------------------------------------------------------------
; Subroutine for updating health bar, should probably be expanded to
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
        cp c                                    ; check which player
        jp nz,_player_two_inner_loop            ; if c != 0 then player 2
        dec l                                   ; moving backwards since its player 1
_player_two_inner_loop:
        ld (hl),a                               ; write byte to screen
        cp c                                    ; check player
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
        ld a,c
        pop bc
        push bc
        inc h                                   ; move on to next pixel line
        ld l,c                                  ; reset lower byte of address
        ld c,a
        xor a
        jp _draw_bar_loop
_draw_bar_done:
        pop bc
        ret

; Start character movement routines



; ------------------------------------------------------------------------------
; Routine for halting eight times lol
; ------------------------------------------------------------------------------
halt_8:
	halt
	halt
	halt
	halt
	halt
	halt
	halt
	halt
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

; need:
;       hl - address to read from
;       de - address to write to
flip_sprite_draw:
        ld b,4
_flip_sprite_draw_loop:
        ld a,(hl)
        ld (de),a
        inc l
        inc e
        djnz _flip_sprite_draw_loop
        ret
; ix - source addr - modified
flip_sprite_init:
        inc ix
        ld (sprite_flip_original_addr),ix       ; store original address
        xor a                                   ; decompress needs a=0
        ld hl, temp_sprite_flip_data_1
        call decompress_sprite                  ; decompress sprite pixel data (leaves both addrs inc by one, should be able to call again to decomp attribs)
        call decompress_sprite                  ; decompress sprite attrib data

        ld b,6                                  ; sprite width
        ld c,48                                 ; sprite height
        ld de,temp_sprite_flip_data_2           ; sprite destination
        ld hl,temp_sprite_flip_data_1           ; sprite source
        call flip_sprite                        ; flip sprite ;)
        ld b,6
        ld c,6
        call flip_attribs

        ld b,32                                 ; for pixel data, 288-256
        ld c,2                                  ; 288/256
        ld de,(sprite_flip_original_addr)       ; dest addr
        ld hl,temp_sprite_flip_data_2           ; source addr
        call compress_sprite                    ; compress pixel data
        ld b,36
        ld c,1
        inc de
        inc hl
        call compress_sprite                    ; compress attrib data
        ret;


flip_attribs:
        ld ixl,b                                ; store width
_flip_attribs_begining:
        ld a,e                                  ; load lower byte of dest addr
        add a,b                                 ; add width to it (storing to dest starting from right side)
        jp nc,_flip_attribs_begining_no_carry   ; check if there is a carry
        inc d                                   ; carry was set, so need to inc d
_flip_attribs_begining_no_carry:
        ld e,a                                  ; load e with new lower addr byte
_flip_attribs_loop:
        dec de                                  ; adding width overshoots addr by one, need to start with dec
        ld a,(hl)                               ; ld first byte of sprite
        ld (de),a                               ; write byte back
        inc hl                                  ; inc addr of source
        djnz _flip_attribs_loop                 ; done with curr row of bytes?
        ld b,ixl                                ; reset width
        ld a,e                                  ; need to move to next row
        add a,b
        jp nc,_flip_attribs_begining_no_carry2  ; check if there is a carry
        inc d                                   ; carry was set, so need to inc d
_flip_attribs_begining_no_carry2:
        ld e,a                                  ; load e with new lower addr byte
        dec c                                   ; dec height counter
        jp nz,_flip_attribs_begining            ; jp to beginning to if not 0
        ret


; ------------------------------------------------------------------------------------
; Subroutine for flipping uncompressed sprite
;
;
; Inputs:
;       A = n/a
;       B = sprite width
;       C = sprite height
;       DE = destination addr - will be in
;       HL = source addr - will be inc
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L, exx
; -------------------------------------------------------------------------------------
flip_sprite:
        ld ixl,b                                ; store width
_flip_sprite_begining:
        ld a,e                                  ; load lower byte of dest addr
        add a,b                                 ; add width to it (storing to dest starting from right side)
        jp nc,_flip_sprite_begining_no_carry    ; check if there is a carry
        inc d                                   ; carry was set, so need to inc d
_flip_sprite_begining_no_carry:
        ld e,a                                  ; load e with new lower addr byte
_flip_sprite_loop:
        dec de                                  ; adding width overshoots addr by one, need to start with dec
        ld a,(hl)                               ; ld first byte of sprite
        call _flip_a
        ld (de),a                               ; write byte back
        inc hl                                  ; inc addr of source
        djnz _flip_sprite_loop                  ; done with curr row of bytes?
        ld b,ixl                                ; reset width
        ld a,e                                  ; need to move to next row
        add a,b
        jp nc,_flip_sprite_begining_no_carry2   ; check if there is a carry
        inc d                                   ; carry was set, so need to inc d
_flip_sprite_begining_no_carry2:
        ld e,a                                  ; load e with new lower addr byte
        dec c                                   ; dec height counter
        jp nz,_flip_sprite_begining             ; jp to beginning to if not 0
        ret

_flip_a:
        exx                     ; 4
        ld b,8                  ; 8             ; 8 bits per byte ;)
        ld c,a                  ; 4             ; ld byte to c
        xor a                   ; 4             ; clear a
        rra
        xor a
_flip_a_loop:
        rl c                    ; 8             ; rotate byte left, left bit goes into carry
        rra                     ; 4             ; rotate A right, carry bit is pushed in
        djnz _flip_a_loop       ; 8(b=0),13(b!=0) ; need to do this 8 times
        exx                                     ; done flipping sprite, switch registers back
        ret

; hl - addr to write to
; ix - source addr
; a - needs 0
decompress_sprite:
        ld d,(ix+0)                             ; load sprite byte
        inc ix                                  ; move to next addr
        ld b,(ix+0)                              ; load num times
        cp b                                    ; check if is 0
        jr z,_decompress_sprite_zero            ; if b is 0 weve reached the end
        call fill_byte_fast
        inc ix
        jp decompress_sprite
_decompress_sprite_zero:
        inc ix
        ret


; ------------------------------------------------------------------------------------
; Subroutine for compressing sprite, assumes that there will never be a sprite (288B)
; that has 255 of the same consecutive bytes
;
; *****disables interrupts*******
;
; Inputs:
;       A = n/a
;       B = num bytes (0-255)
;       C = num bytes overflow (ie. 288 bytes will be c=(288/256), b=(288-256))
;       DE = destination addr
;       HL = source addr
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L, exx
; -------------------------------------------------------------------------------------
compress_sprite:
        ld a,(hl)                               ; load first byte

        exx
        ld b,a                                  ; initialize oldByte, otherwise a random byte gets written to dest
        ld c,1                                  ; initialize counter
        exx
        dec b                                   ; dec num bytes left

_compress_sprite_loop:
        inc hl
        ld a,(hl)                               ; load next byte

        exx                                     ; a-currByte, b-oldByte, c-counter, d-holder
        cp b                                    ; same byte?
        jp z,_compress_sprite_same              ; jp if bytes are same

        ld d,a                                  ; store curr byte
        ld a,b                                  ; load old byte to write to mem
        exx

        ld (de),a                               ; write byte to memory
        inc de                                  ; move to next dest addr

        exx
        ld a,c                                  ; ld counter
        ld c,1                                  ; reset counter
        ld b,d                                  ; reset old byte
        exx

        ld (de),a                               ; write counter to memory
        inc de                                  ; move to next dest addr

_compress_sprite_end_exx_stuff:
        djnz _compress_sprite_loop              ; check if there are bytes left
        dec c                                   ; dec msb counter
        xor a
        cp c
        jp nz,_compress_sprite_loop             ; keep processing bytes

        exx                                     ; need to store last byte
        ld a,b                                  ; move last byte to a
        exx

        ld (de),a                               ; write last byte

        exx
        ld a,c                                  ; move last counter
        exx

        inc de                                  ; move to next addr
        ld (de),a                               ; write last counter
        xor a                                   ; clear a to write 0,0 terminator
        inc de
        ld (de),a
        inc de
        ld (de),a
        ret

_compress_sprite_same:
        inc c                                   ; increase counter
        exx
        jp _compress_sprite_end_exx_stuff
