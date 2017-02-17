; Encoded data of the format x,y repeated, where x is the byte to write into
; VRAM and y is the number of times to write it
title_screen_data:
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,255
	defb 255,240
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,255
	defb 63,1
	defb 255,223
	defb 63,1
	defb 255,31
	defb 63,1
	defb 255,31
	defb 45,3
	defb 111,4
	defb 45,27
	defb 111,6
	defb 45,19
	defb 111,2
	defb 45,13
	defb 63,11
	defb 45,5
	defb 111,4
	defb 45,12
	defb 9,11
	defb 45,4
	defb 111,6
	defb 45,11
	defb 9,11
	defb 45,18
	defb 63,17
	defb 45,10
	defb 111,2
	defb 45,3
	defb 9,17
	defb 45,9
	defb 111,4
	defb 45,2
	defb 9,17
	defb 45,8
	defb 111,4
	defb 47,4
	defb 63,15
	defb 47,4
	defb 45,9
	defb 9,23
	defb 45,9
	defb 9,23
	defb 45,9
	defb 47,23
	defb 45,9
	defb 63,2
	defb 45,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 45,1
	defb 63,2
	defb 45,10
	defb 63,2
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,1
	defb 9,2
	defb 63,2
	defb 45,12
	defb 63,19
	defb 45,18
	defb 63,9
	defb 45,23
	defb 63,9
	defb 45,23
	defb 63,9
	defb 45,23
	defb 63,9
	defb 45,12
	defb 36,11
	defb 54,2
	defb 36,31
	defb 54,6
	defb 36,27
	defb 54,7
	defb 36,30
	defb 54,2
	defb 36,31
	defb 54,2
	defb 36,11







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
	defb 0,0



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



other_shoe_pixels:
		defb 0,9
	defb 7,1
	defb 0,2
	defb 2,1
	defb 136,1
	defb 16,1
	defb 255,2
	defb 128,1
	defb 6,1
	defb 127,1
	defb 0,1
	defb 3,1
	defb 1,1
	defb 128,1
	defb 0,1
	defb 3,1
	defb 255,3
	defb 0,1
	defb 2,1
	defb 0,3
	defb 1,1
	defb 0,10
	defb 12,1
	defb 0,2
	defb 2,1
	defb 176,1
	defb 12,1
	defb 255,2
	defb 128,1
	defb 4,1
	defb 255,1
	defb 0,2
	defb 159,1
	defb 128,1
	defb 0,3
	defb 128,1
	defb 4,1
	defb 0,1
	defb 2,1
	defb 0,1
	defb 64,1
	defb 0,1
	defb 1,1
	defb 0,10
	defb 56,1
	defb 0,2
	defb 2,1
	defb 192,1
	defb 31,1
	defb 255,2
	defb 128,1
	defb 4,1
	defb 255,1
	defb 0,2
	defb 255,1
	defb 128,1
	defb 0,2
	defb 1,1
	defb 0,1
	defb 2,1
	defb 0,1
	defb 2,1
	defb 0,1
	defb 128,1
	defb 0,10
	defb 192,1
	defb 0,1
	defb 224,1
	defb 0,2
	defb 2,1
	defb 192,1
	defb 255,3
	defb 128,1
	defb 4,1
	defb 255,4
	defb 128,1
	defb 0,2
	defb 2,1
	defb 0,1
	defb 1,1
	defb 0,1
	defb 3,1
	defb 57,1
	defb 0,10
	defb 24,1
	defb 188,1
	defb 3,1
	defb 0,3
	defb 3,1
	defb 131,1
	defb 255,3
	defb 128,1
	defb 4,1
	defb 127,1
	defb 255,3
	defb 128,1
	defb 0,2
	defb 4,1
	defb 0,1
	defb 1,1
	defb 0,13
	defb 12,1
	defb 131,1
	defb 62,1
	defb 0,3
	defb 1,1
	defb 15,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 8,1
	defb 127,1
	defb 255,3
	defb 128,1
	defb 2,1
	defb 0,1
	defb 12,1
	defb 0,1
	defb 1,1
	defb 0,11
	defb 127,1
	defb 240,1
	defb 4,1
	defb 129,1
	defb 192,1
	defb 0,1
	defb 6,1
	defb 0,1
	defb 2,1
	defb 31,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 63,1
	defb 255,3
	defb 128,1
	defb 2,1
	defb 0,1
	defb 8,1
	defb 0,1
	defb 1,1
	defb 0,11
	defb 192,1
	defb 0,1
	defb 6,1
	defb 134,1
	defb 96,1
	defb 31,1
	defb 4,1
	defb 0,1
	defb 2,1
	defb 63,1
	defb 255,2
	defb 0,1
	defb 128,1
	defb 0,1
	defb 31,1
	defb 255,3
	defb 128,1
	defb 2,1
	defb 0,1
	defb 16,1
	defb 0,1
	defb 1,1
	defb 0,7
	defb 0,0
other_shoe_name:
	defb 'Other Shoe'
