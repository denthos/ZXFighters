

; test_draw_sprite:
	
; test_loop: 
; 	ld ix, shoe_sprite_data



; 	ld a, (sprite_one_x_bit_offset)		; Load the bit offsett to check to see where we are in the character cell 
; 	cp 7					; Check if the bit offset is = 7
; 	jp nz,move_right_bit_offset_normal		; If equal to 7 then increment sprite_one_x_location 
; 	xor a 					; Clear the a register 
; 	ld (sprite_one_x_bit_offset), a 	; Save 0 as the bit offset 
; 	ld a,(sprite_one_x_location)		; Else load sprite 1 x position into a register
; 	inc a					; Else increment a to move to the right of the screen 
; 	ld (sprite_one_x_location),a		; Save the updated x position in memory
; 	jp resume_move_sprite_right		; Absolute jump to skip normal case 
; move_right_bit_offset_normal:
; 	inc a					; Increment the bit offset by normal (REPEATED CODE HERE)
; 	ld (sprite_one_x_bit_offset), a 	; Save the new bit offset into memory 

; 	out (254), a 					; border color 
; 	ld a, (sprite_one_x_location)		; Save the new pixel location to memory
; 	ld b, a 					; Load a into b for the byte address method 
; 	ld a, (sprite_one_x_bit_offset)
; 	add b, a 				; get the b with the offset address 
; 	ld a, (sprite_one_y_location)		; Load y location into a to be moved to c 
; 	ld c, a 					; Load y into c for the byte address method 














; 	call calculate_pixel_byte_address		; To now support pixel movement 
; 	ld c,0					; Set to not overwrite
; 	ld d,6					; Set the width of the sprite to be 6
; 	call draw_sprite			; Actually draw the sprite in the new location 
; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; ; 	call halt_8
; 	jp test_loop