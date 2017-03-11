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
; Subroutine for clearing sprite bytes on thing 
; Inputs:
;	HL = Address of vram to write to
; Outputs:
;
; ------------------------------------------------------------------------------
clear_sprite:
    ld bc,48
_clear_sprite_loop:
    ld a,0
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    inc hl
    ld (hl),a
    ld a,l
    sub 6
    ld l,a
    inc h
    djnz _clear_sprite_loop
    ret 



; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen
;
; Inputs:
;   C  = 0 for overwrite mode, 1 for blending mode
;   E  = Number of columns to skip from right side
;   HL = Address of vram to write to
;   IX = Address of sprite pixel data
; Outputs:
;
; ------------------------------------------------------------------------------
draw_sprite:
	ld d,6
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
; Routine for drawing a single black character cell on screen  
;
; Inputs:
;	b = x
; 	c = y 
; Outputs: 
; ------------------------------------------------------------------------------
draw_black_character_cell:
	call calculate_color_cell_pixel_address ; This will put the pixel address to draw to in the HL register
	ld c, 0
	ld e, 5
	ld ix, black_character_cell
	call draw_sprite
	ret

; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen one pixel* to the 
; right of it's current location 
;
; Inputs: 
; 	IX - the input sprite data, to be passed into draw_sprite routine 
; 	A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; Outputs: 
; 	A - 0 if no movement was allowed 1 if movement was successful 
; ------------------------------------------------------------------------------
move_sprite_left:
	cp 0
	jp nz, _move_sprite_left_2     		; Check if the first or second sprite

	ld a,(sprite_one_x_location)  		; Load first sprite x location
	cp 0			      		; Is sprite at left edge?
	jp z, _move_sprite_left_done_edge  	; If it is, then skip to the end 
	;for smoother movement 
	ld a, (sprite_one_x_bit_offset)		; Load the bit offsett to check to see where we are in the character cell 
	cp 0; 6					; Check if the bit offset is = 0 (after 0 moves to the left character cell)
	jp nz,move_left_bit_offset_normal	; If equal to 7 then increment sprite_one_x_location 
	xor a 					; Clear the a register 
	ld a, 4 
	ld (sprite_one_x_bit_offset), a 	; Save 4 as the bit offset 
	jp resume_move_sprite_left 		; Absolute jump to skip normal case 
move_left_bit_offset_normal:
	dec a	 				; CAn be 0, 2, 4
	dec a
	ld (sprite_one_x_bit_offset), a 	; Save the new bit offset into memory 

resume_move_sprite_left:
	ld a, (sprite_one_x_location)		; For now always increment since we're doing single pixel movement
	dec a					; Else increment a to move to the right of the screen
	ld (sprite_one_x_location),a		; Save the updated x position in memory
	ld b,a
	ld a,(sprite_one_y_location) 		; Load sprite one y location into a, in order to load c
	ld c,a			      		; Load c with the y location of sprite 1 from a 
	ld a, (sprite_one_x_bit_offset)		; 
	inc a 					; a will be 1, 3, 5, 7---- 0 is for failure 
	ret 

_move_sprite_left_2: 
	ld a,(sprite_two_x_location)  		; Load second sprite x location 
	cp 0                          		; Is sprite at left edge?
	jp z, _move_sprite_left_done_edge  	; If so, then skip to end and return 
	;for smoother movement 
	ld a, (sprite_two_x_bit_offset)		; Load the bit offsett to check to see where we are in the character cell 
	cp 0; 6					; Check if the bit offset is = 0 (after 0 moves to the left character cell)
	jp nz,move_left_bit_offset_normal_2	; If equal to 7 then increment sprite_one_x_location 
	xor a 					; Clear the a register 
	ld a, 4 
	ld (sprite_one_x_bit_offset), a 	; Save 4 as the bit offset 
	jp resume_move_sprite_left_2 		; Absolute jump to skip normal case 
move_left_bit_offset_normal_2:
	dec a	 				; CAn be 0, 2, 4
	dec a
	ld (sprite_two_x_bit_offset), a 	; Save the new bit offset into memory 

resume_move_sprite_left_2:
	ld a, (sprite_two_x_location)		; For now always increment since we're doing single pixel movement
	dec a					; Else increment a to move to the right of the screen
	ld (sprite_two_x_location),a		; Save the updated x position in memory
	ld b,a
	ld a,(sprite_two_y_location) 		; Load sprite one y location into a, in order to load c
	ld c,a			      		; Load c with the y location of sprite 1 from a 

	call check_sprite_overlap
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_left_2 		; a = 1 means overlapping now

	ld a, (sprite_two_x_bit_offset)		; 
	inc a 					; a will be 1, 3, 5 ---- 0 is for failure 
	ret 

_finish_move_sprite_left:
	push af 
	call calculate_color_cell_pixel_address	; Will set up HL 	
	ld c,0					; Set to not overwrite
	ld e, 0 
	; Check player one or player two because of the offset and touching 
	pop af
	cp 1					; Check if sprite 1 or 2
	jp z, _continue_finish_move_sprite_left ; Set d to 6 for sprite 2 
	ld a, (sprite_one_width_from_left)
	ld e, 0 
_continue_finish_move_sprite_left:
	call draw_sprite			; Actually draw the sprite in the new location 
	ret 					; return to original call 

; May never need this 
; _revert_move_left:
; 	ld a, (sprite_one_x_location)		; Load the new faulty x position into the register a 
; 	inc a					; Revert the change by decrementing the x position 
; 	ld (sprite_one_x_location), a		; Save the position in memory
; 	ld a, 0
; 	jp _move_sprite_left_done		; Finish 

_revert_move_left_2:
	ld a, (sprite_two_x_bit_offset)		; 
	cp 4 					; 
	jp nz, _revert_move_left_sub_offset_2	; 
	xor a 					; Now onto the next thing  
	jp _resume_revert_move_left_2
_revert_move_left_sub_offset_2: 
	add a, 2
_resume_revert_move_left_2:
	ld (sprite_two_x_bit_offset), a 	; Save the old offset back to memory 
	ld a, (sprite_two_x_location)		; Load the new faulty x position into the register a 
	inc a					; Revert the change by decrementing the x position 
	ld (sprite_two_x_location), a		; Save the position in memory
	ld a, 0					; Failure 
	jp _move_sprite_left_done		; Finish 



_move_sprite_left_done_edge:			; Finish
	ld a, 0 				; Output a = 0 so no need to draw anything 
	ret

_move_sprite_left_done:				; Finish
	ret					; Return and assume output a was set before this 


; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen 1 pixel to the right 
; of it's current location 
;
; Inputs: 
; 	IX - the input sprite to be input to draw_sprite routine 
; 	A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; Outputs:
; 	A - (0 = Character overlap no drawing)
;	    (1 = Draw the first walking sprite)
; 	    (5 = Draw the second walking sprite)
; ------------------------------------------------------------------------------
move_sprite_right:
	cp 0					; Check if sprite 1 or 2 move
	jp nz, _move_sprite_right_2		; If 1 then absolute jump to sprite 2 movement right code
	ld a,(sprite_one_x_location)		; Else load sprite 1 x position into a register
	cp 26					; Check if the sprite is already as far right as possible 
	jp z,_move_sprite_right_done_edge	; If so then skip to the end and return 
	;for smoother movement 
	ld a, (sprite_one_x_bit_offset)		; Load the bit offsett to check to see where we are in the character cell 
	cp 4; 6					; Check if the bit offset is = 4 (after 4 moves to next character cell)
	jp nz,move_right_bit_offset_normal	; If equal to 7 then increment sprite_one_x_location 
	xor a 					; Clear the a register 
	ld (sprite_one_x_bit_offset), a 	; Save 0 as the bit offset 
	jp resume_move_sprite_right
move_right_bit_offset_normal:
	add a, 2 				; CAn be 0, 2, 4
	ld (sprite_one_x_bit_offset), a 	; Save the new bit offset into memory 
resume_move_sprite_right:
	ld a, (sprite_one_x_location)		; For now always increment since we're doing single pixel movement
	inc a					; Else increment a to move to the right of the screen
	ld (sprite_one_x_location),a		; Save the updated x position in memory
	ld b,a
	ld a,(sprite_one_y_location)		; Load the sprite 1 y location into the a register to be loaded into the c register
	ld c,a					; Load the y position into the c register for calculate_color_cell_pixel_address
	call check_sprite_overlap
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_right 		; a = 1 means overlapping now, will auto end and fail the method 
	ld a, (sprite_one_x_bit_offset)		; 
	inc a 					; a will be 1, 3, 5, 7---- 0 is for failure 
	ret  
	
_move_sprite_right_2:
	ld a,(sprite_two_x_location)		; Load the old x position of sprite 2
	cp 26					; Check if already to the farthest right of the screen 
	jp z,_move_sprite_right_done_edge	; If so then skip to the end and return 
	ld a, (sprite_two_x_bit_offset)		; Load the bit offsett to check to see where we are in the character cell 
	cp 4; 6					; Check if the bit offset is = 4 (after 4 moves to next character cell)
	jp nz, move_right_bit_offset_normal_2	; If equal to 7 then increment sprite_one_x_location 
	xor a 					; Clear the a register 
	ld (sprite_two_x_bit_offset), a 	; Save 0 as the bit offset 
	jp resume_move_sprite_right_2
move_right_bit_offset_normal_2:
	add a, 2 				; CAn be 0, 2, 4
	ld (sprite_two_x_bit_offset), a 	; Save the new bit offset into memory 
resume_move_sprite_right_2:
	ld a, (sprite_two_x_location)		; For now always increment since we're doing single pixel movement
	inc a					; Else increment a to move to the right of the screen
	ld (sprite_two_x_location),a		; Save the updated x position in memory
	ld b,a
	ld a,(sprite_two_y_location)		; Load the sprite 1 y location into the a register to be loaded into the c register
	ld c,a					; Load the y position into the c register for calculate_color_cell_pixel_address

	; we may never need this because second sprite moving right should never be reverted 
; 	call check_sprite_overlap
; 	cp 1					; Will set the Z flag if A == 1
; 	jp z, _revert_move_right_2 		; a = 1 means overlapping now, will auto end and fail the method 
	ld a, (sprite_two_x_bit_offset)		; 
	inc a 					; a will be 1, 3, 5, 7---- 0 is for failure 
	ret

; Input: A - Which sprite , IX, 
_finish_move_sprite_right:
	push af 
	call calculate_color_cell_pixel_address	; Will set up HL 

	ld c, 0 ; Blend always 
	ld e, 0
	; Check player one or player two 
	pop af
	cp 1					; Check if sprite 1 or 2
	jp z, _continue_finish_move_sprite_right ; Set d to 6 for sprite 2 
	ld a, (pre_calculate_offset_middle_for_e)
	dec a
	ld e, a					; Set the width of the sprite to be 
_continue_finish_move_sprite_right:
	call draw_sprite			; Actually draw the sprite in the new location 
	ret 					; return to original call 

_revert_move_right:
	ld a, (sprite_one_x_bit_offset)		; 
	cp 0 					; 
	jp nz, _revert_move_right_sub_offset	; 
	xor a 
	ld a, 4					; 
	jp _resume_revert_move_right
_revert_move_right_sub_offset: 
	dec a 
	dec a 
_resume_revert_move_right:
	ld (sprite_one_x_bit_offset), a 	; Save the old offset back to memory 
	ld a, (sprite_one_x_location)		; Load the new faulty x position into the register a 
	dec a					; Revert the change by decrementing the x position 
	ld (sprite_one_x_location), a		; Save the position in memory
	ld a, 0					; Failure 
	jp _move_sprite_right_done		; Finish 

; _revert_move_right_2:
; 	ld a, (sprite_two_x_bit_offset)		; 
; 	cp 0 					; 
; 	jp nz, _revert_move_right_sub_offset_2	; 
; 	xor a 
; 	ld a, 4					; 
; 	jp _resume_revert_move_right_2
; _revert_move_right_sub_offset_2: 
; 	dec a 
; 	dec a 
; _resume_revert_move_right_2:
; 	ld (sprite_two_x_bit_offset), a 	; Save the old offset back to memory 
; 	ld a, (sprite_two_x_location)		; Load the new faulty x position into the register a 
; 	dec a					; Revert the change by decrementing the x position 
; 	ld (sprite_two_x_location), a		; Save the position in memory
; 	ld a, 0					; Failure 
; 	jp _move_sprite_right_done		; Finish 

_move_sprite_right_done_edge:
	ld a, 0					; Output that no drawing is necessary

_move_sprite_right_done:
	ret




; ------------------------------------------------------------------------------
; Subroutine for checking if the two sprites are now overlapping
; Outputs:
;	A - 1 for overlapping 0 for not overlapping
; ------------------------------------------------------------------------------
check_sprite_overlap:
	ld a, (sprite_one_x_location)
; 	call absA
	ld d, a
	ld a, (sprite_two_x_location)
; 	call absA
	sub d 
	push af  				; Save a on stack 
	ld a, (pre_calculate_offset_middle)	; Load pre_calculate_offset_middle into a to load to d  
	out (254), a
	ld d, a 				; Load the pre_calculate_offset_middle into d for compare with a
	pop af  				; Get back the difference into a 
	cp d ;6 					; Compare d with a 
	jp nc, return_sprite_overlap_false 	; If difference is greater than or equal to d(4) then return false

	jp return_sprite_overlap_true

return_sprite_overlap_false:
	ld a, 0
	jp check_sprite_overlap_done

return_sprite_overlap_true:
	ld a, 1

check_sprite_overlap_done:
	ret


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

draw_title_background:
	ld de, 124              ; title screen has 341 lines of encoded byte pairs
	ld hl,title_screen_data ; get the location of the encoded data
	ld ix,0x4000            ; start drawing at the beginning of the vram
_draw_title_screen_loop_start:
	call copy_encoded_bytes ; unpack first encoded byte pair
	dec de                  ; decrement our byte pair counter
	ld a,d                  ; check if counter is 0, we do it this way because
	or e                    ;   our counter needs to work for a value above 255
	jp nz,_draw_title_screen_loop_start
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
