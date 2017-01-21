; ------------------------------------------------------------------------------
; Subroutine for drawing an S to the screen. It currently has a width of 3 and
; height of 5 blocks. 
;
; Default color blue for now 
;
; Inputs:
;		HL = address of the top left block of the letter
;		B  = the info to be loaded into the attr pixel at that section
; Outputs:
;		n/a
; ------------------------------------------------------------------------------
draw_s:
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld de, 30
	add hl, de
	ld (hl), a
	ld de, 32
	add hl, de
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld de, 32
	add hl, de
	ld (hl), a
	add hl, de
	ld (hl), a
	dec hl
	ld (hl), a
	dec hl
	ld (hl), a
	ld de, -128
	add hl, de ;restore hl
	ret
