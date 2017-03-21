taser_sound:
	ld b, 200
	ld hl,0             
_taser_sound_loop:
	ld a,(hl)
	inc hl 	
	and 248             
	out (254), a 
	djnz _taser_sound_loop
	ret 

retro_sound: 
	ld hl, 2000
	ld de, 4
	call 949 
	ret

chirpy_sound: 
	ld hl, 234
	ld de, 4
	call 949 
	ret

coin_sound: 
	ld hl, 670
	ld de, 12
	call 949 
	ret

high_pitch_sound: 
	ld hl, 39
	ld de, 627
	call 949
	ret

; a is the total counter
; b is the delay counter 
; d is the number of times to loop 

custom_bang:
	ld e, 50
	ld d, 0
_custom_bang_loop:
	ld b, 32
_custom_bang_loop_play:
	ld a,r
	ld l,a
	and 0x3f
	ld h,a
	ld a,(hl)	
	and 248             ; Make sure to not change the border color by anding away color bits
        out (254),a         ; Output to the speaker 
        inc d   	    ; increment the total counter 
_custom_bang_loop_delay:
	djnz _custom_bang_loop_delay
	ld a, d 
	cp 50 
	jp nz, _custom_bang_loop
	ret 


custom_bang_2:
	ld e, 50
	ld d, 0
	ld hl, 0 
_custom_bang_loop_2:
	ld b, 32
_custom_bang_loop_play_2:
	ld a,(hl)
	inc hl 	
	and 248             ; Make sure to not change the border color by anding away color bits
        out (254),a         ; Output to the speaker 
        inc d   	    ; increment the total counter 
_custom_bang_loop_delay_2:
	djnz _custom_bang_loop_delay_2
	ld a, d 
	cp 50 
	jp nz, _custom_bang_loop_2
	ret 




; Copied from https://chuntey.wordpress.com/category/z80-assembly/page/3/
five_hit_bang:  
 	ld e,25             ; repeat 250 times.
        ld hl,0             ; start pointer in ROM.
five_hit_bang2: push de
        ld b,32             ; length of step.
five_hit_bang0: push bc
        ld a,r
	ld l,a
	and 0x3f
	ld h,a
	ld a,(hl)	
	and 248             ; we want a black border.
        out (254),a         ; write to speaker.
        ld a,e              ; as e gets smaller...
        cpl                 ; ...we increase the delay.
	add a, 1
five_hit_bang1: dec a               ; decrement loop counter.
        jr nz,five_hit_bang1        ; delay loop.
        pop bc
        djnz five_hit_bang0         ; next step.
        pop de
        ld a,e
        sub 24              ; size of step.
        cp 30               ; end of range.
        ret z
        ret c
        ld e,a
        cpl
five_hit_bang3: ld b,20             ; silent period.
five_hit_bang4: djnz five_hit_bang4
        dec a
        jr nz,five_hit_bang3
        jr five_hit_bang2


