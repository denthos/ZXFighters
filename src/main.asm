        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION (TODO: set up interrupt handler and stuff)
	
	; disable interrupts
	di
	
	; set border color
	ld a,1                    ; blue
	out (0xfe),a              ; send to ula

	; draw base title screen
	call draw_title_screen

	; start title screen loop
	
	; read keys in

	

        include "src/ByteAddressUtils.asm"
        include "src/DrawingUtils.asm"
        include "src/PrintingUtils.asm"
	include "src/GameData.asm"
