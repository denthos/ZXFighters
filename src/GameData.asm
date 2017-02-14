; Encoded data of the format x,y repeated, where x is the byte to write into
; VRAM and y is the number of times to write it
title_screen_data:
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,255
; 	defb 255,24
; 	defb 18,1
; 	defb 9,5
; 	defb 56,26
; 	defb 18,2
; 	defb 9,4
; 	defb 56,26
; 	defb 9,1
; 	defb 18,2
; 	defb 9,3
; 	defb 56,26
; 	defb 9,2
; 	defb 18,2
; 	defb 9,2
; 	defb 56,26
; 	defb 9,3
; 	defb 18,2
; 	defb 9,1
; 	defb 56,26
; 	defb 9,4
; 	defb 18,2
; 	defb 56,255
; 	defb 56,255
; 	defb 56,92






; Character data looks like:
; struct character {
;   name - 10 bytes
;   TODO
; }
shoe_data:
shoe_name:
	defb '   Shoe   '
shoe_icon_pixels:

shoe_icon_attributes:

shoe_sprite_pixels:
	defb 0,15
	defb 255,2
	defb 128,1
	defb 0,1
	defb 127,1
	defb 0,2
	defb 1,1
	defb 128,1
	defb 0,1
	defb 3,1
	defb 255,3
	defb 0,22
	defb 255,2
	defb 128,1
	defb 0,1
	defb 255,1
	defb 0,2
	defb 31,1
	defb 128,1
	defb 0,26
	defb 31,1
	defb 255,2
	defb 128,1
	defb 0,1
	defb 255,1
	defb 0,2
	defb 255,1
	defb 128,1
	defb 0,26
	defb 255,3
	defb 128,1
	defb 0,1
	defb 255,4
	defb 128,1
	defb 0,25
	defb 3,1
	defb 255,3
	defb 128,1
	defb 0,1
	defb 127,1
	defb 255,3
	defb 128,1
	defb 0,25
	defb 15,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 127,1
	defb 255,3
	defb 128,1
	defb 0,25
	defb 31,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 63,1
	defb 255,3
	defb 128,1
	defb 0,21
	defb 31,1
	defb 0,3
	defb 63,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 31,1
	defb 255,3
	defb 128,1
	defb 0,12


shoe_sprite_attributes:
; 	defb 71,6
; 	defb 63,6
; 	defb 71,2
; 	defb 63,7
; 	defb 63,7
; 	defb 63,7
; 	defb 63,1
;----------------
	defb 71,6
	defb 71,3
	defb 4,1
	defb 71,1
	defb 4,1
	defb 71,1
	defb 4,3
	defb 39,1
	defb 4,1
	defb 71,1
	defb 2,1
	defb 34,3
	defb 2,1
	defb 71,1
	defb 2,4
	defb 71,1
	defb 71,6

lambtron_data:
lambtron_name:
	defb ' Lambtron '
