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
;   	C  = 0 for overwrite mode, 1 for blending mode
;   	D  = Width of sprite in color cells
;	HL = Address of vram to write to
;   	IX = Address of sprite pixel data
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
; Routine for drawing 1 character cell in 6 consecutive rows in the same column 
;
; Note: There is probably some way to do this like with EXX but it all seems 
; really hard lol
; Inputs: 
; 
; 	b = x
;	c = y
; Outputs: 
; ------------------------------------------------------------------------------
clear_old_sprite_horizontal: 
	; save the x and y before drawing the thing which will modify them 
	ld a, 6 
	ld (clear_loop_counter), a
_clear_old_sprite_loop_horizontal: 
	ld a, b
	ld (current_sprite_x_location), a
	ld a, c
	ld (current_sprite_y_location), a
	call draw_black_character_cell		; This will modify a
	ld a, (clear_loop_counter)
	dec a
	cp 0
	jp z, _finish_clear_old_sprite_horizontal

; 	out (254), a 
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
	ld (clear_loop_counter), a
	ld a, (current_sprite_x_location)
	ld b, a
	ld a, (current_sprite_y_location)
	inc a
	ld c, a 
	ld (current_sprite_y_location), a
	jp _clear_old_sprite_loop_horizontal
	;update the values 
_finish_clear_old_sprite_horizontal:
	ret


; ------------------------------------------------------------------------------
; Routine for drawing 1 character cell in 6 columns in the same row
; 
; Note: There is probably some way to do this like with EXX but it all seems 
; really hard lol
; Inputs: 
; 
; 	b = x
;	c = y
; Outputs: 
; ------------------------------------------------------------------------------
clear_old_sprite_vertical: 
	; save the x and y before drawing the thing which will modify them 
	ld a, 6 
	ld (clear_loop_counter), a
_clear_old_sprite_loop_vertical: 
	ld a, b
	ld (current_sprite_x_location), a
	ld a, c
	ld (current_sprite_y_location), a
	call draw_black_character_cell		; This will modify a
	ld a, (clear_loop_counter)
	dec a
	cp 0
	jp z, _finish_clear_old_sprite_vertical

; 	out (254), a 
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
; 	halt
	ld (clear_loop_counter), a
	ld a, (current_sprite_x_location)
	inc a					; This is the only difference between the two methods...
	ld b, a
	ld a, (current_sprite_y_location)
	ld c, a 
	ld (current_sprite_y_location), a
	jp _clear_old_sprite_loop_vertical 
	;update the values 
_finish_clear_old_sprite_vertical:
	ret

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
	ld d, 1
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
	dec a                         		; Decrement the x value (move left)
	ld (sprite_one_x_location),a  		; Save this value to memory
	ld b,a			      		; Load new x into b (for calculate_color_cell_pixel_address)
	ld a,(sprite_one_y_location) 		; Load sprite one y location into a, in order to load c
	ld c,a			      		; Load c with the y location of sprite 1 from a 
	call check_sprite_overlap		; Check to make sure no sprite overlap 
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_left 		; a = 1 means overlapping now
; 	call _finish_move_sprite_left    	; Call to actual drawing of new sprite
	ld a, 1
	ret 

_erase_old_sprite_left:
	ld a, (sprite_one_y_location)		; Ensure that a has the y value of sprite 1
	ld c, a 				; Reload the old y value into b for calculate_color_cell_pixel_address
	ld a, (sprite_one_x_location)		; Load the new x location into the a register to sub 6 from 
; 	cp 24					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; 	jp nc, _move_sprite_left_done		; If it is then just don't do anything 
	add a, 6	
	ld b, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_horizontal	; Actually clear the last column of color cells occupied  
	jp _move_sprite_left_done		; Finish and return 

_move_sprite_left_2: 
	ld a,(sprite_two_x_location)  		; Load second sprite x location 
	cp 0                          		; Is sprite at left edge?
	jp z, _move_sprite_left_done_edge  	; If so, then skip to end and return 
	dec a                         		; Decrement the old x value 
	ld (sprite_two_x_location),a  		; Save the new x value to memory
	ld b,a                        		; Load into b for calculate_color_cell_pixel_address
	ld a,(sprite_two_y_location)  		; Load sprite 2 y location into a to load into c 
	ld c,a			      		; Load into c
	call check_sprite_overlap
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_left_2 		; a = 1 means overlapping now
	ld a, 1
; 	call _finish_move_sprite_left		; Actually draw the sprite to the udpated location 
	ret


_erase_old_sprite_left_2:
	ld a, (sprite_two_y_location)		; Ensure that a has the y value of sprite 1
	ld c, a 				; Reload the old y value into b for calculate_color_cell_pixel_address
	ld a, (sprite_two_x_location)		; Load the new x location into the a register to sub 6 from 
; 	cp 24					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; 	jp nc, _move_sprite_left_done		; If it is then just don't do anything 
	add a, 6	
	ld b, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_horizontal	; Actually clear the last column of color cells occupied 
	jp _move_sprite_left_done		; Finish and return 

_finish_move_sprite_left:
	call calculate_color_cell_pixel_address ; sprite data shold already be in ix, this will set HL with address
	ld c,0					; 0 for no overwrite
	ld d,6					; 6 for the width of the sprite 
	call draw_sprite			; Draw sprite to updated location of screen
	ret

_revert_move_left:
	ld a, (sprite_one_x_location)		; Load the new faulty x position into the register a 
	inc a					; Revert the change by decrementing the x position 
	ld (sprite_one_x_location), a		; Save the position in memory
	ld a, 0
	jp _move_sprite_left_done		; Finish 

_revert_move_left_2:
	ld a, (sprite_two_x_location)		; Load the new faulty x position into the regsiter a 
	inc a                                   ; Revert the change by decrementing the x position 
	ld (sprite_two_x_location), a		; Save the position to memory
	ld a, 0 
	jp _move_sprite_left_done		; Finish 

_erase_old_sprite_left_finish: 
	call calculate_color_cell_pixel_address ; This will put the pixel address to draw to in the HL register
	ld c, 0
	ld d, 6
	ld ix, black_sprite
	call draw_sprite
	ret

_move_sprite_left_done_edge:			; Finish
	ld a, 0 				; Output a = 0 so no need to draw anything 
	ret

_move_sprite_left_done:				; Finish
	ret					; Return and assume output a was set before this 





; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen 1 pixel below it's current
; location 
;
; Inputs: 
; 	IX - the input sprite to be input to the draw_sprite routine 
; 	A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; Outputs:
;
; ------------------------------------------------------------------------------
move_sprite_down:
	cp 0					; Check if the first or second sprite
	jp nz, _move_sprite_down_2		; Load first sprite x location
; 	out (254), a		
	ld a, (sprite_one_y_location)		; Load the old y value of sprite 1 into a
	cp 18 					; Check if the sprite is at the last spot of the screen 
	jp nc, _move_sprite_down_done_edge
	inc a					; Increment a to move down 
; 	inc a					; Increment a again for some reason idk
	ld (sprite_one_y_location), a		; Save the new y location into memory
	ld c,a					; Load new y location into c for calculate_color_cell_pixel_address
	ld a, (sprite_one_x_location)		; Load sprite 1 x location into a in order to load into c
	ld b,a					; Load sprite 1 x location into b for calculate_color_cell_pixel_address
	call check_sprite_overlap		; Check to make sure no sprite overlap 
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_down  		; a = 1 means overlapping now
; 	call _finish_move_sprite_down		; Absolute jump to actually draw sprite to the new location 
	ld a, 1
	ret

_erase_old_sprite_down:
	ld a, (sprite_one_x_location)		; Ensure that a has the x value of sprite 1
	ld b, a 				; Reload the old x value into b for calculate_color_cell_pixel_address
	ld a, (sprite_one_y_location)		; Load the new y location into the a register to sub 6 from 
; 	cp 6					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; 	jp c, _move_sprite_down_done		; If it is then just don't do anything 
	sub a, 1	
	ld c, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_vertical		; Actually clear the last column of color cells occupied 
	jp _move_sprite_down_done		; Finish and return 

_move_sprite_down_2:
	
	ld a, (sprite_two_y_location)		; Load the old y value of sprite 2 into a
	cp 18 					; Check if the sprite is at the second to last spot of the screen 
	jp nc, _move_sprite_down_done_edge
	inc a					; Increment a to move down 
; 	inc a					; Increment a again for some reason idk seems to work 
	ld (sprite_two_y_location), a		; Save the new y location into memory
	ld c,a					; Load sprite 2 x location into a in order to load into c
	ld a, (sprite_two_x_location)		; Load sprite 2 x location into b for calculate_color_cell_pixel_address
	ld b,a					; Absolute jump to actually draw sprite to the new location 
	call check_sprite_overlap		; Check to make sure no sprite overlap 
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_down_2  		; a = 1 means overlapping now
; 	call _finish_move_sprite_down
	ld a, 1
	ret 

; could improve by storing this information in registers that wouldn't be used?
_erase_old_sprite_down_2:
	ld a, (sprite_two_x_location)		; Ensure that a has the x value of sprite 1
	ld b, a 				; Reload the old x value into b for calculate_color_cell_pixel_address
	ld a, (sprite_two_y_location)		; Load the new y location into the a register to sub 6 from 
; 	cp 6					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; 	jp c, _move_sprite_down_done		; If it is then just don't do anything 
	sub a, 1	
	ld c, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_vertical		; Actually clear the last column of color cells occupied  
	jp _move_sprite_down_done		; Finish and return 

_finish_move_sprite_down: 
	call calculate_color_cell_pixel_address ; This will load hl with the correct pixel address for draw sprite 
	ld c,0					; 0 for no overwrite
	ld d,6					; 6 for the width 
	call draw_sprite			; Actually draw the sprite to the new location 
	ret


_erase_old_sprite_down_finish: 
	call calculate_color_cell_pixel_address ; This will put the pixel address to draw to in the HL register
	ld c, 0
	ld d, 6
	ld ix, black_sprite
	call draw_sprite
	ret

_revert_move_down:
	ld a, (sprite_one_y_location)		; Load the new faulty x position into the register a 
	dec a					; Revert the change by decrementing the x position 
; 	dec a					; Revert the change by decrementing the x position 
	ld (sprite_one_y_location), a		; Save the position in memory
	ld a, 0 
	jp _move_sprite_down_done		; Finish 

_revert_move_down_2:
	ld a, (sprite_two_y_location)		; Load the new faulty x position into the regsiter a 
	dec a                                   ; Revert the change by decrementing the x position 
; 	dec a					; Revert the change by decrementing the x position 
	ld (sprite_two_y_location), a		; Save the position to memory
	ld a, 0 
	jp _move_sprite_down_done		; Finish 

_move_sprite_down_done_edge:
	ld a, 0 				; Output a is 0 to denote no drawing 
	ret

_move_sprite_down_done:
	ret


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
	jp nz, move_sprite_right_2		; If 1 then absolute jump to sprite 2 movement right code
	ld a,(sprite_one_x_location)		; Else load sprite 1 x position into a register
	cp 26					; Check if the sprite is already as far right as possible 
	jp z,_move_sprite_right_done_edge	; If so then skip to the end and return 


	;for smoother movement 
	ld a, (sprite_one_x_bit_offset)		; Load the bit offsett to check to see where we are in the character cell 
	cp 4					; Check if the bit offset is = 4 (after 4 moves to next character cell)
	jp nz,move_right_bit_offset_normal	; If equal to 7 then increment sprite_one_x_location 
	xor a 					; Clear the a register 
	ld (sprite_one_x_bit_offset), a 	; Save 0 as the bit offset 
	ld a,(sprite_one_x_location)		; Else load sprite 1 x position into a register
	inc a					; Else increment a to move to the right of the screen
	ld (sprite_one_x_location),a		; Save the updated x position in memory
	jp resume_move_sprite_right		; Absolute jump to skip normal case 
move_right_bit_offset_normal:
; 	inc a					; Increment the bit offset by normal (REPEATED CODE HERE)
	add a, 4 
	ld (sprite_one_x_bit_offset), a 	; Save the new bit offset into memory 
resume_move_sprite_right:
; 	inc a					; Else increment a to move to the right of the screen 
; 	ld (sprite_one_x_location),a		; Save the updated x position in memory
; 	ld b,a					; Load the updated x position into b register for calculate_color_cell_pixel_address

	ld a, (sprite_one_x_location)
	ld b, a 
	ld a,(sprite_one_y_location)		; Load the sprite 1 y location into the a register to be loaded into the c register
	ld c,a					; Load the y position into the c register for calculate_color_cell_pixel_address
	call check_sprite_overlap
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_right 		; a = 1 means overlapping now
; 	call _finish_move_sprite_right		; Absoulte jump to actually draw the sprite in the new position
	
	ld a, (sprite_one_x_bit_offset)		; 
	inc a 					; a will be 1 or 5
	ret  

_erase_old_sprite_right:
	ld a, (sprite_one_y_location)		; Ensure that a has the y value of sprite 1
	ld c, a 				; Reload the old y value into c for calculate_color_cell_pixel_address
	ld a, (sprite_one_x_location)		; Load the new x location into the a register to sub 6 from 
	sub a, 1				; Just draw the char cell to the left	
	ld b, a 				; Load the original(old) x into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_horizontal	; Actually clear the last column of color cells occupied
	jp _move_sprite_right_done		; Finish and return 

	
move_sprite_right_2:
	ld a,(sprite_two_x_location)		; Load the old x position of sprite 2
	cp 26					; Check if already to the farthest right of the screen 
	jp z,_move_sprite_right_done_edge	; If so then skip to the end and return 
	inc a					; Increment the old x position to move to the right 
	ld (sprite_two_x_location),a		; Save the new x position in memory
	ld b,a					; Load new x position in b register for calculate_color_cell_pixel_address
	ld a,(sprite_two_y_location)		; Load the y position of sprite 2 into the a register to be moved into the c register
	ld c,a					; Load the y position into the c register for calculate_color_cell_pixel_address
	call check_sprite_overlap
	cp 1					; Will set the Z flag if A == 1, means overlapping 
	jp z, _revert_move_right_2 		; a = 1 means overlapping now
; 	call _finish_move_sprite_right 		; Call to actually draw the sprite in the updated part of the screen 
	ld a, 1
	ret


_erase_old_sprite_right_2:
	ld a, (sprite_two_y_location)		; Ensure that a has the y value of sprite 1
	ld c, a 				; Reload the old y value into b for calculate_color_cell_pixel_address
	ld a, (sprite_two_x_location)		; Load the new x location into the a register to sub 6 from 
	sub a, 1	
	ld b, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_horizontal
	jp _move_sprite_right_done		; Finish and return 


_finish_move_sprite_right:
	call calculate_color_cell_pixel_address	; Will set up HL 	
; 	call calculate_pixel_byte_address		; To now support pixel movement 
	ld c,0					; Set to not overwrite
	ld d,6					; Set the width of the sprite to be 6
	call draw_sprite			; Actually draw the sprite in the new location 
	ret 					; return to original call 

_revert_move_right:
	ld a, (sprite_one_x_location)		; Load the new faulty x position into the register a 
	dec a					; Revert the change by decrementing the x position 
	ld (sprite_one_x_location), a		; Save the position in memory
	ld b, a
	ld a, (sprite_one_y_location)
	ld c, a
	call _finish_move_sprite_right
	ld a, 0
	jp _move_sprite_right_done		; Finish 

_revert_move_right_2:
	ld a, (sprite_two_x_location)		; Load the new faulty x position into the regsiter a 
	dec a                                   ; Revert the change by decrementing the x position 
	ld (sprite_two_x_location), a		; Save the position to memory
	ld b, a 
	ld a, (sprite_two_y_location)
	ld c, a
	call _finish_move_sprite_right
	ld a, 0
	jp _move_sprite_right_done		; Finish 

_erase_old_sprite_right_finish: 
; 	call calculate_color_cell_pixel_address ; This will put the pixel address to draw to in the HL register
; 	call calculate_pixel_byte_address		; To now support pixel movement 
; 	ld c, 0
; 	ld d, 1
; 	ld ix, black_character_cell
; 	call draw_sprite
	ret
_move_sprite_right_done_edge:
	ld a, 0					; Output that no drawing is necessary

_move_sprite_right_done:
	ret



; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen 1 pixel above it's current 
; location
;
; Inputs: 
; 	IX - the input sprite tp be input to the draw_sprite routine 
; 	A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; Outputs:
;
; ------------------------------------------------------------------------------
move_sprite_up:	
	cp 0					; Check if the sprite 1 or 2 moved
	jp nz, _move_sprite_up_2		; If so then move to the sprite 2 code
	ld a, (sprite_one_y_location)		; Load the old y location of sprite 1 into the a register
	cp 0					; Check if the sprite is at the top of screen 
	jp z,_move_sprite_up_done		; If so then skip to the end and return 
	dec a					; Else decrement a in order to move up 
	ld (sprite_one_y_location),a		; Save the new y position of sprite 1 in memory
	ld c,a					; Load the updated y position of sprite 1 into the c register for calculate_color_cell_pixel_address
	ld a,(sprite_one_x_location)		; Load the x position in a in order to load into b
	ld b,a					; Load the a register into b
	call check_sprite_overlap		; Check to make sure no sprite overlap 
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_up 	 		; a = 1 means overlapping now
; 	call _finish_move_sprite_up		; Actually draw the sprite in the new location 
	ld a, 1
	ret 

_erase_old_sprite_up:
	ld a, (sprite_one_x_location)		; Ensure that a has the x value of sprite 1
	ld b, a 				; Reload the old x value into b for calculate_color_cell_pixel_address
	ld a, (sprite_one_y_location)		; Load the new y location into the a register to sub 6 from 
; 	cp 12					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; 	jp nc, _move_sprite_up_done		; If it is then just don't do anything 
	add a, 6	
	ld c, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_vertical	 	; Absolute jump to actually draw over old spot  
	jp _move_sprite_up_done			; Finish and return 

_move_sprite_up_2:
	ld a, (sprite_two_y_location)		; Load the old y postiion of sprite 2 into the a regsiter
	cp 0					; Check if at the top of the screen 
	jp z,_move_sprite_up_done		; If so then skip to the end and return 
	dec a					; Decrement a inorder to move up the screen 
	ld (sprite_two_y_location),a		; Save the new y position of sprite 2 into memory 
	ld c,a					; Load a into c in order to load the y position into b for calculate_color_cell_pixel_address
	ld a,(sprite_two_x_location)		; Load the x position of sprite 2 into a in order to move into b for calculate_color_cell_pixel_address
	ld b,a					; Load the x position into b
	call check_sprite_overlap		; Check to make sure no sprite overlap 
	cp 1					; Will set the Z flag if A == 1
	jp z, _revert_move_up_2 		; a = 1 means overlapping now
; 	call _finish_move_sprite_up		; Check overlap 
	ld a, 1
	ret 

_erase_old_sprite_up_2:
	ld a, (sprite_two_x_location)		; Ensure that a has the x value of sprite 1
	ld b, a 				; Reload the old x value into b for calculate_color_cell_pixel_address
	ld a, (sprite_two_y_location)		; Load the new y location into the a register to sub 6 from 
; 	cp 12					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; 	jp nc, _move_sprite_up_done		; If it is then just don't do anything 
	add a, 6	
	ld c, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
	call clear_old_sprite_vertical	 	; Call to actually draw over old spot  
	jp _move_sprite_up_done			; Finish and return

_finish_move_sprite_up:
	call calculate_color_cell_pixel_address	; Will load the address of the first pixel to draw to into HL 
	ld c,0					; Overwrite to false
	ld d,6					; Width of sprite to 6
	call draw_sprite			; ix has sprite data
	ret

_erase_old_sprite_up_finish: 
	call calculate_color_cell_pixel_address ; This will put the pixel address to draw to in the HL register
	ld c, 0
	ld d, 6
	ld ix, black_sprite
	call draw_sprite
	ret

_revert_move_up:
	ld a, (sprite_one_y_location)		; Load the new faulty x position into the register a 
	inc a					; Revert the change by decrementing the x position 
	ld (sprite_one_y_location), a		; Save the position in memory
	ld a, 0 
	jp _move_sprite_up_done		; Finish 

_revert_move_up_2:
	ld a, (sprite_two_y_location)		; Load the new faulty x position into the regsiter a 
	inc a                                   ; Revert the change by decrementing the x position 
	ld (sprite_two_y_location), a		; Save the position to memory
	ld a, 0
	jp _move_sprite_up_done		; Finish 


_move_sprite_up_done_edge:
	ld a,0 
	ret

_move_sprite_up_done:
	ret					; Finish 


; ; ------------------------------------------------------------------------------
; ; Subroutine for drawing a sprite onto the screen 1 pixel to the right and one 
; ; pixel above.
; ;
; ; Inputs: 
; ; 	IX - the input sprite to be input to draw_sprite routine 
; ; 	A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; ; Outputs:
; ; 	N/A 
; ; ------------------------------------------------------------------------------
; move_sprite_up_right_diagonal:	
; 	cp 0					; Check if the sprite 1 or 2 moved
; 	jp nz, move_sprite_up_right_diagonal_2	; If so then move to the sprite 2 code
; 	ld a, (sprite_one_y_location)		; Load the old y location of sprite 1 into the a register
; 	cp 0					; Check if the sprite is at the top of screen 
; 	jp z,_move_sprite_up_done		; If so then skip to the end and return 
; 	dec a					; Else decrement a in order to move up 
; 	ld (sprite_one_y_location),a		; Save the new y position of sprite 1 in memory
; 	ld c,a					; Load the updated y position of sprite 1 into the c register for calculate_color_cell_pixel_address
; 	ld a,(sprite_one_x_location)		; Load the x position in a in order to load into b
; 	ld b,a					; Load the a register into b
; 	call check_sprite_overlap		; Check to make sure no sprite overlap 
; 	cp 1					; Will set the Z flag if A == 1
; 	jp z, _revert_move_up 	 		; a = 1 means overlapping now
; 	call _finish_move_sprite_up		; Actually draw the sprite in the new location 


; _erase_old_sprite_up_right_diagonal:
; 	ld a, (sprite_one_x_location)		; Ensure that a has the x value of sprite 1
; 	ld b, a 				; Reload the old x value into b for calculate_color_cell_pixel_address
; 	ld a, (sprite_one_y_location)		; Load the new y location into the a register to sub 6 from 
; ; 	cp 12					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; ; 	jp nc, _move_sprite_up_done		; If it is then just don't do anything 
; 	add a, 6	
; 	ld c, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
; 	call clear_old_sprite_vertical	 	; Absolute jump to actually draw over old spot  
; 	jp _move_sprite_up_done			; Finish and return 

; move_sprite_up_right_diagonal_2:
; 	ld a, (sprite_two_y_location)		; Load the old y postiion of sprite 2 into the a regsiter
; 	cp 0					; Check if at the top of the screen 
; 	jp z,_move_sprite_up_done		; If so then skip to the end and return 
; 	dec a					; Decrement a inorder to move up the screen 
; 	ld (sprite_two_y_location),a		; Save the new y position of sprite 2 into memory 
; 	ld c,a					; Load a into c in order to load the y position into b for calculate_color_cell_pixel_address
; 	ld a,(sprite_two_x_location)		; Load the x position of sprite 2 into a in order to move into b for calculate_color_cell_pixel_address
; 	ld b,a					; Load the x position into b
; 	call check_sprite_overlap		; Check to make sure no sprite overlap 
; 	cp 1					; Will set the Z flag if A == 1
; 	jp z, _revert_move_up_2 		; a = 1 means overlapping now
; 	call _finish_move_sprite_up_right_diagonal		; Check overlap 

; _erase_old_sprite_up_right_diagonal_2:
; 	ld a, (sprite_two_x_location)		; Ensure that a has the x value of sprite 1
; 	ld b, a 				; Reload the old x value into b for calculate_color_cell_pixel_address
; 	ld a, (sprite_two_y_location)		; Load the new y location into the a register to sub 6 from 
; ; 	cp 12					; Check if the sprite is starting within the top 6 pixel blocks of the screen 
; ; 	jp nc, _move_sprite_up_done		; If it is then just don't do anything 
; 	add a, 6	
; 	ld c, a 				; Load the original y into the c register for calculate_color_cell_pixel_address
; 	call clear_old_sprite_vertical	 	; Call to actually draw over old spot  
; 	jp _move_sprite_up_done			; Finish and return

; _finish_move_sprite_up_right_diagonal:
; 	call calculate_color_cell_pixel_address	; Will load the address of the first pixel to draw to into HL 
; 	ld c,0					; Overwrite to false
; 	ld d,6					; Width of sprite to 6
; 	call draw_sprite			; ix has sprite data
; 	ret

; _erase_old_sprite_up_right_diagonal_finish: 
; 	call calculate_color_cell_pixel_address ; This will put the pixel address to draw to in the HL register
; 	ld c, 0
; 	ld d, 6
; 	ld ix, black_sprite
; 	call draw_sprite
; 	ret

; _revert_move_up_right_diagonal:
; 	ld a, (sprite_one_y_location)		; Load the new faulty x position into the register a 
; 	inc a					; Revert the change by decrementing the x position 
; 	ld (sprite_one_y_location), a		; Save the position in memory
; 	jp _move_sprite_up_done		; Finish 

; _revert_move_up_up_right_diagonal_2:
; 	ld a, (sprite_two_y_location)		; Load the new faulty x position into the regsiter a 
; 	inc a                                   ; Revert the change by decrementing the x position 
; 	ld (sprite_two_y_location), a		; Save the position to memory
; 	jp _move_sprite_up_done		; Finish 

; _move_sprite_up_done:
; 	ret	



; ------------------------------------------------------------------------------
; Subroutine (crud) for checking if the two sprites are now overlapping
; Outputs:
;	A - 1 for overlapping 0 for not overlapping
; ------------------------------------------------------------------------------
check_sprite_overlap:
	ld a, (sprite_one_x_location)
	call absA
	ld d, a

	ld a, (sprite_two_x_location)
	call absA

	sub d 

	call absA

	cp 6
	jp nc, return_sprite_overlap_false 	; If difference is greater than or equal to 6 then return false

	ld a, (sprite_one_y_location)
	call absA
	ld d, a

	ld a, (sprite_two_y_location)
	call absA

	sub d 
	call absA
	cp 6
	jp nc, return_sprite_overlap_false 	; If it is equal to 6 or greater then return false
	jp return_sprite_overlap_true

return_sprite_overlap_false:
	ld a, 0
	jp check_sprite_overlap_done

return_sprite_overlap_true:
	ld a, 1

check_sprite_overlap_done:
	ret


; ------------------------------------------------------------------------------
; Routine to make the sprite jump on screen
; 
; Inputs: 
;	A - the number of the sprite (0 -> sprite 1) (1 -> sprite 2)
; Outputs:
;	A - 1 for overlapping 0 for not overlapping
; ------------------------------------------------------------------------------
move_sprite_jump:
	ld (jump_sprite_number), a	; Save the sprite number to memory
	xor a				; Clear the a register 
	add a,3				; Set it to 3 
	ld b, a				; Load the counter number into b
	push ix				; Push the pointer to the sprite data 

_save_jump_sprite_counter_up:
	ld a, b 			; Load decremented b to a
	ld (jump_sprite_counter), a 	; Save counter to memory
	ld a, (jump_sprite_number)	; Set up a for call to M_S_U
	pop ix 				; Pop to get the correct pointer to sprite data 
	push ix 			; Push to save a copy of the pointer 
_move_jump_sprite_up: 		
	call move_sprite_up		; Move the sprite up 
	call _finish_move_sprite_up
	ld a, (jump_sprite_number)
	cp 1 
	jp z, _move_jump_sprite_up_erase_2
	call _erase_old_sprite_up
	jp _resume_move_jump_sprite_up
_move_jump_sprite_up_erase_2:
	call _erase_old_sprite_up_2

_resume_move_jump_sprite_up:
	ld a, (jump_sprite_counter)	; Load counter back into a
	ld b, a 			; Move a to b 
	call halt_8 
	djnz _save_jump_sprite_counter_up; Decrement b 
	ld a, b 			; end of the loop 
	add a, 3 
	ld b, a

_save_jump_sprite_counter_down:
	ld a, b
	ld (jump_sprite_counter), a 	; Save counter to memory
	ld a, (jump_sprite_number)	; Set up a for call to M_S_U
	pop ix 				; Pop to get the correct pointer to sprite data 
	push ix 			; Push to save a copy of the pointer 
_move_jump_sprite_down:	
	call move_sprite_down		; Move the sprite up 
	call _finish_move_sprite_down
	ld a, (jump_sprite_number)		; Restore the a to check which sprite needs to be erased
	cp 1
	jp z, _move_jump_sprite_down_erase_2
	call _erase_old_sprite_down
	jp _resume_move_jump_sprite_down
_move_jump_sprite_down_erase_2:
	call _erase_old_sprite_down_2

_resume_move_jump_sprite_down:
	ld a, (jump_sprite_counter)		; Load counter back into a
	ld b, a 				; Move a to b 
	call halt_8 			
	djnz _save_jump_sprite_counter_down	; Decrement b 

_move_sprite_jump_done:

	ret
; ------------------------------------------------------------------------------
; Subroutine for getting the absolute value if the accumulator register
; ------------------------------------------------------------------------------
absA:
	cp $80                         ; comparing the unsigned A to 128
 	jr c,A_Is_Positive             ; if it is less, then jump to the label given
	neg                            ; multiplying A by -1
A_Is_Positive:
	ret
;      or a
;      ret p
;      neg         ;or you can use      cpl \ inc a
;      ret


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
