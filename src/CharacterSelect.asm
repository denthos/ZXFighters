start_character_select:
character_select_loop:
  ; player 1
  ld bc,65022           ; read keys G,F,D,S,A
  in a,(c)
  ld (character_select_input_store),a
  and 0x1
  jp nz,_character_select_loop_a_release
  ld a,1
  ld hl,a_down
  ld (hl),a             ; a_down = 1
  jp _character_select_loop_a_done
_character_select_loop_a_release:
  ld hl,a_down
  ld a,(hl)
  or a                  ; if a_down was 1, select prev character
  call nz,select_prev_character_p1
  ld hl,a_down
  ld a,0
  ld (hl),a             ; a_down = 0
_character_select_loop_a_done:

	ld a,(character_select_input_store)
  and 0x4
  jp nz,_character_select_loop_d_release
  ld a,1
  ld hl,d_down
  ld (hl),a             ; d_down = 1
  jp _character_select_loop_d_done
_character_select_loop_d_release:
  ld hl,d_down
  ld a,(hl)
  or a                  ; if d_down was 1, select next character
  call nz,select_next_character_p1
  ld hl,d_down
  ld a,0
  ld (hl),a             ; d_down = 0
_character_select_loop_d_done:

  ; player 2
  ld bc,49150           ; read keys H,J,K,L,Enter
  in a,(c)
	ld (character_select_input_store),a
  and 0x8
  jp nz,_character_select_loop_j_release
  ld a,1
  ld hl,j_down
  ld (hl),a             ; j_down = 1
  jp _character_select_loop_j_done
_character_select_loop_j_release:
  ld hl,j_down
  ld a,(hl)
  or a                  ; if j_down was 1, select prev character
  call nz,select_prev_character_p2
  ld hl,j_down
  ld a,0
  ld (hl),a             ; j_down = 0
_character_select_loop_j_done:

  ld a,(character_select_input_store)
  and 0x2
  jp nz,_character_select_loop_l_release
  ld a,1
  ld hl,l_down
  ld (hl),a             ; l_down = 1
  jp _character_select_loop_l_done
_character_select_loop_l_release:
  ld hl,l_down
  ld a,(hl)
  or a                  ; if l_down was 1, select next character
  call nz,select_next_character_p2
  ld hl,l_down
  ld a,0
  ld (hl),a             ; l_down = 0
_character_select_loop_l_done:

  ; check for Enter
	ld a,(character_select_input_store)
  and 0x1
  jp nz,character_select_loop
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
