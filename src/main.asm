        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION (TODO: set up interrupt handler and stuff)

	; disable interrupts
	di

; 	; set border color
; 	ld a,0                    ; blue
; 	out (0xfe),a              ; send to ula

; 	; draw base title screen
; ; 	call draw_title_screen

; ; 	; start title screen loop
;  	ld ix,shoe_name
; 	call print_p1_name_title_screen
; 	ld ix,lambtron_name
; 	call print_p2_name_title_screen
; 	ld hl,0x4800
; 	ld ix,shoe_sprite_pixels
; 	call draw_sprite


mloop:  

       di
       ld bc,63486        ; keyboard row 1-5/joystick port 2.
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


       ld bc,64510        ; keyboard row 1-5/joystick port 2.
       in a,(c)            ; see what keys are pressed.
       rra                 ; outermost bit = key 1.
       push af             ; remember the value.
       call nc, init_print_q         ; it's being pressed, move left.
       halt                ; delete
       pop af              ; restore accumulator.
       rra                 ; next bit along (value 2) = key 2.
       push af             ; remember the value.
       call nc, init_print_w        ; being pressed, so move right.
       halt                ; delete
       pop af              ; restore accumulator.
       rra                 ; next bit (value 4) = key 3.
       push af             ; remember the value.
       call nc, init_print_e         ; being pressed, so move down.
       halt                ; delete
       pop af              ; restore accumulator.
       rra                 ; next bit (value 8) reads key 4.
       call nc, init_print_r         ; it's being pressed, move up.
       halt

; Jump back to beginning of main loop.
       jp mloop
init_print_one:   
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, one      ; Get character to print
        call printline
        ld ix,shoe_name
        call print_p1_name_title_screen
        ld hl,0x4800
        ld ix,other_shoe_pixels
        call draw_sprite
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

init_print_q:   
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, q      ; Get character to print
        call printline
        ret

init_print_w:       
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, w       ; Get character to print
        call printline
        ret

init_print_e:      
        ld a, 2         ; channel 2 = "S" for screen (Paul: Why so we need to do this?)
        call $1601      ; Select print channel using ROM
        ld hl, _e       ; Get character to print
        call printline
        ret

init_print_r:  
        ld a, 2         ; channel 2 = "S" for screen
        call $1601      ; Select print channel using ROM
        ld hl, _r       ; Get character to print
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
q:     defb 'q',13,'$'
w:     defb 'w',13,'$'
_e:     defb 'e',13,'$'
_r:     defb 'r',13,'$'


	;		HL = Address of memory to write to
	;		C  = 0 if sprite should overwrite screen contents, 1 if it should blend
	;   DE = Address of sprite to draw

	; read keys in



  include "src/ByteAddressUtils.asm"
  include "src/DrawingUtils.asm"
  include "src/PrintingUtils.asm"
  include "src/GameData.asm"
  include "src/input_loop.asm"
