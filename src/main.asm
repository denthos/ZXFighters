; This is a basic hello world style example that
; simply colors the color cell in the top left of
; the screen a dark blue color by loading the
; byte 0b00001001 into the first attribute byte
; in VRAM.

        org 32768	; why this number?
start:
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl,line      ; Print line
        call printline
        ld b, 0
        ld c, 0
        call calculate_pixel_byte_address
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl,line      ; Print line
        call printline
       	call calculate_pixel_byte_address ; reset
       	

dms_to_ds:
	ld a, 1	; what the hell does this number do lol
	ld b, 255

draw_stuff:
	call draw_s
	inc a
	djnz draw_stuff

ds_to_dms:
	ld b, 255
	ld a, 255

draw_more_stuff:
	call draw_s
	dec a
	djnz draw_more_stuff
	jr draw_stuff
        ret		; return to prevent from running into printline routine

printline:              ; Routine to print out a line
        ld a,(hl)       ; Get character to print
        cp '$'          ; See if it '$' terminator
        jp z,printend   ; We're done if it is
        rst 16          ; Spectrum: Print the character in 'A'
        inc hl          ; Move onto the next character
        jp printline    ; Loop round
printend:
        ret


line:   defb 'Hello, world!',13,'$'

        include "src/ByteAddressUtils.asm"
        include "src/DrawLettersUtils.asm"
