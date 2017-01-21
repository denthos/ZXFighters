; This is a basic hello world style example that
; simply colors the color cell in the top left of
; the screen a dark blue color by loading the
; byte 0b00001001 into the first attribute byte
; in VRAM.

start:	ld	a, 9
loop:	ld	(0x5800), a
	jr	loop
