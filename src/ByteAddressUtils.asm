; Utility file for calculating useful memory addresses
;
; Pixel Byte Address Format:
; 0  1  0  y7 y6 y2 y1 y0 y5 y4 y3 x7 x6 x5 x4 x3
;
; Attribute Byte Address Format:
; 0  1  0  1  1  0  y7 y6 y5 y4 y3 x7 x6 x5 x4 x3
;
; ------------------------------------------------------------------------------
; Subroutine for calculating the memory address of the byte containing
; the bit for a pixel based on its x,y screen coordinates
;
; Inputs:
;		B = x   (ranges from 0-255)
;		C = y   (ranges from 0-191)
; Outputs:
;		HL = address of pixel byte containing pixel
; ------------------------------------------------------------------------------
calculate_pixel_byte_address:
		ld a, c     ; a is now: y7 y6 y5 y4 y3 y2 y1 y0
		and 0x40    ; set base bits
		ld h, a     ; h is now: 0  1  0  y4 y3 y2 y1 y0
		ld a, c     ; a is now: y7 y6 y5 y4 y3 y2 y1 y0
		srl a
		srl a
		srl a
		and 0x18    ; a is now: 0  0  0  y7 y6 0  0  0
		or h        ; a is now: 0  1  0  y7 y6 y2 y1 y0
		ld h, a     ; we are done with h now
		ld a, b     ; a is now: x7 x6 x5 x4 x3 x2 x1 x0
		srl a
		srl a
		srl a       ; a is now: 0  0  0  x7 x6 x5 x4 x3
		ld l, a     ; l is now: 0  0  0  x7 x6 x5 x4 x3
		ld a, c     ; a is now: y7 y6 y5 y4 y3 y2 y1 y0
		sla a
		sla a
		and 0xe0    ; a is now: y5 y4 y3 0  0  0  0  0
		or l        ; a is now: y5 y4 y3 x7 x6 x5 x4 x3
		ld l, a     ; we are done with l now
		ret


; ------------------------------------------------------------------------------
; Subroutine for calculating the memory address of the byte containing
; the attribute byte for a pixel based on its x,y screen coordinates
;
; Inputs:
;		B = x   (ranges from 0-255)
;		C = y   (ranges from 0-191)
; Outputs:
;		HL = address of attr byte that determines the color of the specified pixel
; ------------------------------------------------------------------------------
calculate_attr_byte_address:
		ld a, c     ; a is now: y7 y6 y5 y4 y3 y2 y1 y0
		srl a
		srl a
		srl a
		srl a
		srl a
		srl a
		and 0x5b    ; a is now: 0  1  0  1  1  0  y7 y6
		ld h, a     ; we are done with h now
		ld a, c     ; a is now: y7 y6 y5 y4 y3 y2 y1 y0
		sla a
		sla a
		and 0xe0    ; a is now: y5 y4 y3 0  0  0  0  0
		ld l, a     ; l is now: y5 y4 y3 0  0  0  0  0
		ld a, b     ; a is now: x7 x6 x5 x4 x3 x2 x1 x0
		srl a
		srl a
		srl a       ; a is now: 0  0  0  x7 x6 x5 x4 x3
		or l        ; a is now: y5 y4 y3 x7 x6 x5 x4 x3
		ld l, a     ; we are done with l now
		ret


; ------------------------------------------------------------------------------
; Subroutine for calculating the memory address of the first pixel byte
; in a color cell
;
; Inputs:
;		B = x   (ranges from 0-31)
;		C = y   (ranges from 0-23)
; Outputs:
;		HL = address of the first pixel byte in the specified color cell
; ------------------------------------------------------------------------------
calculate_color_cell_pixel_address:
		ld a, c     ; a is now: 0  0  0  y7 y6 y5 y4 y3
		and 0x58    ; a is now: 0  1  0  y7 y6 0  0  0
		ld h, a     ; we are done with h now
		ld a, c     ; a is now: 0  0  0  y7 y6 y5 y4 y3
		and 0x7     ; strip y7 and y6
		rrca
		rrca
		rrca        ; a is now: y5 y4 y3 0  0  0  0  0
		add a, b    ; a is now: y5 y4 y3 x7 x6 x5 x4 x3
		ld l, a     ; we are done with l now
		ret


; ------------------------------------------------------------------------------
; Subroutine for calculating the memory address of the attribute byte
; for a color cell
;
; Inputs:
;		B = x   (ranges from 0-31)
;		C = y   (ranges from 0-23)
; Outputs:
;		HL = address of the specified color cell's attribute byte
; ------------------------------------------------------------------------------
calculate_color_cell_attr_address:
		ld a, c     ; a is now: 0  0  0  y7 y6 y5 y4 y3
		srl a
		srl a
		srl a       ; a is now: 0  0  0  0  0  0  y7 y6
		and 0x5b    ; a is now: 0  1  0  1  1  0  y7 y6
		ld h, a     ; we are done with h now
		ld a, c     ; a is now: 0  0  0  y7 y6 y5 y4 y3
		and 0x7     ; strip y7 and y6
		rrca
		rrca
		rrca        ; a is now: y5 y4 y3 0  0  0  0  0
		add a, b    ; a is now: y5 y4 y3 x7 x6 x5 x4 x3
		ld l, a     ; we are done with l now
		ret
