; ------------------------------------------------------------------------------
;Example routine for reading in user input and reacting to input.
;Code can be reused anywhere.
; Ports
; 32766 B, N, M, Symbol Shift, Space
; 49150 H, J, K, L, Enter
; 57342 Y, U, I, O, P
; 61438 6, 7, 8, 9, 0
; 63486 5, 4, 3, 2, 1 <--- Current
; 64510 T, R, E, W, Q
; 65022 G, F, D, S, A
; 65278 V, C, X, Z, Caps Shift
; ------------------------------------------------------------------------------




org 32768                  ; why this number?

mloop:  ld bc,63486        ; keyboard row 1-5/joystick port 2.
       in a,(c)            ; see what keys are pressed.
       rra                 ; outermost bit = key 1.
       push af             ; remember the value.
       call nc, init_print_one         ; it's being pressed, move left.
       halt                ; delete
       pop af              ; restore accumulator.
       rra                 ; next bit along (value 2) = key 2.
       push af             ; remember the value.
       call nc, init_print_two        ; being pressed, so move right.
       halt                ; delete
       pop af              ; restore accumulator.
       rra                 ; next bit (value 4) = key 3.
       push af             ; remember the value.
       call nc, init_print_three         ; being pressed, so move down.
       halt                ; delete
       pop af              ; restore accumulator.
       rra                 ; next bit (value 8) reads key 4.
       call nc, init_print_four         ; it's being pressed, move up.
       halt


; Jump back to beginning of main loop.
       jp mloop
init_print_one:   
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, one      ; Get character to print
        call printline
        ret

init_print_two:       
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, two       ; Get character to print
        call printline
        ret

init_print_three:      
        ld a, 2         ; channel 2 = "S" for screen (Paul: Why so we need to do this?)
        call $1601      ; Select print channel using ROM
        ld hl, three       ; Get character to print
        call printline
        ret

init_print_four:  
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, four       ; Get character to print
        call printline
        ret


printline:              ; Routine to print out a line
        ld a, (hl)
        cp '$'          ; See if it '$' terminator
        jp z,printend   ; We're done if it is
        rst 16          ; Spectrum: Print the character in 'A'
        inc hl          ; Move onto the next character
        jp printline    ; Loop round 
printend:
        ret



line:   defb 'Hello, world!',13,'$'
one:   defb '1',13,'$'
two:   defb '2',13,'$'
three: defb '3',13,'$'
four:  defb '4',13,'$'
