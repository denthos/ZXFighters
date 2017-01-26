; ------------------------------------------------------------------------------
; Subroutine for singing part of the song of our generation
; Frequencies
; C# 277.18
; D 293.66
; D# 311.13
; E 329.63
; F 349.23
; F# 369.99
; G 392.00
; G# 415.30
; A 440.00
; A# 466.16
; B 493.88
; Pitch = 437500 / Frequency - 30.125 (277.18 freq) [arbitrary ++]
; Duration = Frequency * Seconds
; As I go I'll make a chart for easy reference of these numbers so
; we don't have to keep calculating them. 
; ------------------------------------------------------------------------------	


	; :) 

	ld hl, 1548	; pitch = 437500 / Frequency - 30.125 (277.18 freq)
	ld de, 139	; duration = Frequency * Seconds
	call 949	; ROM beeper routine
	ld hl, 1548	; C# mid
	ld de, 139	; 0.5 seconds
	call 949	; beeper routine
	ld hl, 1959	; freq = 220, A mid
	ld de, 110	; .5 seconds
	call 949
	ld hl, 1959	; A (964 for high A pitch )
	ld de, 110	; 220 for high A duration
	call 949
	ld hl, 2624	; E mid, 329.63 freq
	ld de, 83	; .5 seconds
	call 949
	ld hl, 2624	; E (1297 for high E pitch )
	ld de, 83	; 165 for high E duration
	call 949
	ld hl, 3012	; D, 293.66 freq
	ld de, 74	; .5 seconds
	call 949
	ld hl, 3127	; C# lower 138.59 freq
	ld de, 69	; heyo
	call 949
	ld hl, 3012	; D (for High 1460)
	ld de, 74	; for high duration 147
	call 949
	ld hl, 1548	; C# mid 277.18 freq
	ld de, 139
	call 949
	ld hl, 1742	; B, 493.88 freq (856 for high pitch)
	ld de, 124	; 247 for high duration
	call 949	