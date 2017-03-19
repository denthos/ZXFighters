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

	ld a,e
	ld d,0
	ld e,26
	add hl,de
	ld e,a
	ld d,6
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

	ld de,0x5064
	ld ix,round_select_instructions
	ld c,24
	call print_string

	ld de,0x48d0
	ld a, (number_of_rounds)
	add a, 48
	ld c,1
	call print_char 

	ld de,0x50e6
	ld ix,character_select_instructions_2
	ld c,20
	call print_string




; 	ld de, 

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
; Outputs: N/A
;
; Uses: A, B, C, DE, H
; ------------------------------------------------------------------------------
draw_bar_init:
        ld a, 255
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

; TODO: make sure l,e dont overflow when increased
; need:
;       sprite address                   hl
;       sprite destination               de
;       sprite width                     b
;       sprite height(?)                 c
flip_sprite:
        ld ixl,b
        ld ixh,e
_flip_sprite_begining:
        ld a,e
        add a,b
        ld e,a
;         dec e
_flip_sprite_loop:
        dec e
        ld a,(hl)
        call _flip_a
        ld (de),a
        inc l
        djnz _flip_sprite_loop
        ld b,ixl
;         inc l
        ld a,e
        add a,b
        ld e,a
        dec c
        xor a
        cp c
        jp nz,_flip_sprite_begining
        ret

_flip_a:
        exx                     ; 4
        ld b,8                  ; 8
        ld c,a                  ; 4
        xor a                   ; 4
_flip_a_loop:
        rl c                    ; 8
        rra                     ; 4
        djnz _flip_a_loop       ; 8(b=0), 13(b!=0)
        exx
        ret

; need: //assumes that there will never be a sprite (288B) that has 255 of the same consecutive bytes
;       source addr             hl
;       dest addr               de
;       num bytes               b,c
compress_sprite:
        di
        ld a,(hl)

        exx
        ld b,a                                  ; initialize oldByte, otherwise a random byte gets written to dest
        ld c,1                                  ; initialize counter
        exx
        dec b

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
        djnz _compress_sprite_loop
        dec c
        jp nz,_compress_sprite_loop
        exx
        ld a,b
        exx
        ld (de),a
        exx
        ld a,c
        exx
        inc de
        ld (de),a
        xor a
        inc de
        ld (de),a
        inc de
        ld (de),a
        ei
        ret

_compress_sprite_same:
        inc c                                   ; increase counter
        exx
        jp _compress_sprite_end_exx_stuff
	
	
; ------------------------------------------------------------------------------
; This draws the panel with background colors and whatever color is in a 
;
; Inputs:
;   A = color of the panel (to do )
; ------------------------------------------------------------------------------
	
draw_status_panel:
	ld a, 0					; Load 1 into a for b 
	ld b, a 				; Load 1 for b (x coord)
	ld a, 20 				; Load 20 into a for c (y coord)
	ld c, a 				; 
	call calculate_color_cell_attr_address	; Load the address for this color cell attr in hl 
	ld b, 160				; 160 attr bytes to set 
_draw_status_panel_loop:			
	ld (hl), 0x47				; Set black color 
	inc hl 					; increment the pointer 
	djnz _draw_status_panel_loop		; Loop 
	ret 					; Done 

; ------------------------------------------------------------------------------
; Draws the health bars and sets the background color of them to green for each sprite 
; ------------------------------------------------------------------------------
draw_health_bars:
	ld a, 1
	ld b, a 	
	ld a, 21
	ld c, a 
	call calculate_color_cell_pixel_address
	ex de, hl
	ld a, 10 
  	ld b, a
  	ld a, 8 
  	ld h, a
	call draw_bar_init
	
	ld a, 1
	ld b, a 	
	ld a, 21
	ld c, a 
	call calculate_color_cell_attr_address
	ld a, 0x54 
	ld b, 10 
_draw_health_bars_color_1: 
	ld (hl), a
	inc hl 
	djnz _draw_health_bars_color_1
	ld a, 21
	ld b, a
	ld a, 21 
	ld c, a 
	call calculate_color_cell_pixel_address
	ex de, hl 
	ld a, 10 
	ld b, a 
	ld a, 8 
	ld h, a 
	call draw_bar_init

	ld a, 21
	ld b, a 	
	ld a, 21
	ld c, a 
	call calculate_color_cell_attr_address
	ld a, 0x54
	ld b, 10 
_draw_health_bars_color_2: 
	ld (hl), a
	inc hl 
	djnz _draw_health_bars_color_2



	ret 


; ------------------------------------------------------------------------------------
; Draws the health bars and sets the background color of them to green for each sprite 
; ------------------------------------------------------------------------------------
draw_energy_bar:
	ld a, 9
	ld b, a 	
	ld a, 178
	ld c, a 
	call calculate_pixel_byte_address			;calculate_color_cell_pixel_address

	ex de, hl
	ld a, 10 		
  	ld b, a
  	ld a, 1					; Height  
  	ld h, a					; Load into h fo draw_bar_init
	call draw_bar_init
	ret 


draw_number_of_rounds:
	ld de,0x48d0
	ld a, (number_of_rounds)
	add a, 48
	ld c,1
	call print_char 
	ret