; This is a basic hello world style example that
; simply colors the color cell in the top left of
; the screen a dark blue color by loading the
; byte 0b00001001 into the first attribute byte
; in VRAM.

        org 32768
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
        ret

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
