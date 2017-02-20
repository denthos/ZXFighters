a_press:
	ld hl,a_down
	ld a,1
	ld (hl),a
	ret

select_next_character_p1:
ld hl,selected_character_p1
ld a,(selected_character_max)
ld e,a
ld a,(hl)
cp e
jp z,_select_next_character_p1_set_zero
inc (hl)
jp draw_title_character_p1
_select_next_character_p1_set_zero:
ld a,0
ld (hl),a
jp draw_title_character_p1

select_prev_character_p1:
ld hl,selected_character_p1
ld a,(hl)
cp 0
jp z,_select_prev_character_p1_set_max
dec (hl)
jp draw_title_character_p1
_select_prev_character_p1_set_max:
ld a,(selected_character_max)
ld (hl),a
jp draw_title_character_p1

select_next_character_p2:
ld hl,selected_character_p2
ld a,(selected_character_max)
ld e,a
ld a,(hl)
cp e
jp z,_select_next_character_p2_set_zero
inc (hl)
jp draw_title_character_p2
_select_next_character_p2_set_zero:
ld a,0
ld (hl),a
jp draw_title_character_p2

select_prev_character_p2:
ld hl,selected_character_p2
ld a,(hl)
cp 0
jp z,_select_prev_character_p2_set_max
dec (hl)
jp draw_title_character_p2
_select_prev_character_p2_set_max:
ld a,(selected_character_max)
ld (hl),a
jp draw_title_character_p2
