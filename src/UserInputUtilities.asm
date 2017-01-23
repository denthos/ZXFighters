start_read:	ld hl,23560         ; LAST K system variable.
       	ld (hl),0           ; put null value there.
loop:   ld a,(hl)           ; new value of LAST K.
       	cp 0                ; is it still zero?
       	jr z,loop           ; yes, so no key pressed.
;        	ret                 ; key was pressed.

printline:              ; Routine to print out a line
        ld a,(hl)       ; Get character to print
        cp '$'          ; See if it '$' terminator
        jp z,printend   ; We're done if it is
        rst 16          ; Spectrum: Print the character in 'A'
        inc hl          ; Move onto the next character
        jp printline    ; Loop round 
printend:
	jr start_read
        ret
	


	include "DrawLettersUtils.asm"	