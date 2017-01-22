; Utility file containing subroutines for printing strings and characters
;
; ------------------------------------------------------------------------------
; Subroutine for printing a string of characters
;
; Inputs:
;		IX = Address of the string
;		C  = Length of the string
;   DE = Address of memory to write to
; Outputs:
;
; ------------------------------------------------------------------------------
print_string:
	ld a,(ix+0)         ; load character from string
	call print_char     ; print the character
	inc ix              ; point to next character in string
	inc e               ; point to next character
	ld a,d              ; load upper bytes of address to write to
	sub 8
	ld d,a              ; decrement write address by 8
	dec c               ; decrement our counter
	jr nz,print_string  ; if counter is not zero, loop
	ret


	; ------------------------------------------------------------------------------
	; Subroutine for printing a single character
	;
	; Inputs:
	;		A  = ASCII code of the character to print
	;   DE = Address of memory to write to
	; Outputs:
	;
	; ------------------------------------------------------------------------------
	print_char:
		ld h,7
		ld l,a
		set 7,l
		add hl,hl
		add hl,hl
		add hl,hl        ; calculate address of character bitmap in ROM
		ld b,8           ; copy all 8 bytes in the character bitmap
		call copy_bytes  ; copy bitmap to vram
		ret
