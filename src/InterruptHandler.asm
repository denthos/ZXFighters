interrupt_handler:
	di
	; save registers
	push af
	push bc
	push hl
	push de
	push ix
	ld hl,23672            ; increment frame counter
	inc (hl)

	;;; INTERRUPT HANDLER CODE HERE


	; restore registers
	pop ix
	pop de
	pop hl
	pop bc
	pop af
	ei
	reti
	ret
	;jp 0x0038              ; uncomment this instruction to run the default
	                       ;   interrupt handler after ours
