start_character_select:
character_select_loop:
  ; player 1
  ld bc,65022           ; read keys G,F,D,S,A
  in a,(c)
  ld (character_select_input_store),a ; store input for later
  and 0x1               ; check key A
  jp nz,_character_select_loop_a_release
  ld a,1
  ld hl,a_down
  ld (hl),a             ; a_down = 1
  jp _character_select_loop_a_done
_character_select_loop_a_release:
  ld hl,a_down
  ld a,(hl)
  or a                  ; if a_down was 1 (key release), select prev character
  call nz,select_prev_character_p1
  ld hl,a_down
  ld a,0
  ld (hl),a             ; a_down = 0
_character_select_loop_a_done:

	ld a,(character_select_input_store)
  and 0x4               ; check key D
  jp nz,_character_select_loop_d_release
  ld a,1
  ld hl,d_down
  ld (hl),a             ; d_down = 1
  jp _character_select_loop_d_done
_character_select_loop_d_release:
  ld hl,d_down
  ld a,(hl)
  or a                  ; if d_down was 1 (key release), select next character
  call nz,select_next_character_p1
  ld hl,d_down
  ld a,0
  ld (hl),a             ; d_down = 0
_character_select_loop_d_done:



  ld a,(character_select_input_store)
  and 0x10               ; check key G
  jp nz, _character_select_loop_g_release 
  ld a, 1
  ld hl, g_down
  ld (hl), a 
  jp _character_select_loop_g_done
_character_select_loop_g_release:
  ld hl,g_down
  ld a,(hl)
  or a                  ; if d_down was 1 (key release), select next character
  call nz, decrease_number_of_rounds
  ld hl, g_down
  ld a,0 
  ld (hl), a 
_character_select_loop_g_done:





  ; player 2
  ld bc,49150           ; read keys H,J,K,L,Enter
  in a,(c)
	ld (character_select_input_store),a ; save input for later
  and 0x8               ; check key J
  jp nz,_character_select_loop_j_release
  ld a,1
  ld hl,j_down
  ld (hl),a             ; j_down = 1
  jp _character_select_loop_j_done
_character_select_loop_j_release:
  ld hl,j_down
  ld a,(hl)
  or a                  ; if j_down was 1 (key release), select prev character
  call nz,select_prev_character_p2
  ld hl,j_down
  ld a,0
  ld (hl),a             ; j_down = 0
_character_select_loop_j_done:

  ld a,(character_select_input_store)
  and 0x2               ; check key L
  jp nz,_character_select_loop_l_release
  ld a,1
  ld hl,l_down
  ld (hl),a             ; l_down = 1
  jp _character_select_loop_l_done
_character_select_loop_l_release:
  ld hl,l_down
  ld a,(hl)
  or a                  ; if l_down was 1 (key release), select next character
  call nz,select_next_character_p2
  ld hl,l_down
  ld a,0
  ld (hl),a             ; l_down = 0
_character_select_loop_l_done:

  ld a,(character_select_input_store)
  and 0x10               ; check key H
  jp nz, _character_select_loop_h_release 
  ld a, 1
  ld hl, h_down 
  ld (hl), a 
  jp _character_select_loop_h_done
_character_select_loop_h_release:
  ld hl,h_down
  ld a,(hl)
  or a                  ; if d_down was 1 (key release), select next character
  call nz, increase_number_of_rounds
  out (254), a
  ld hl, h_down
  ld a,0 
  ld (hl), a 
_character_select_loop_h_done:  

  ; check for Enter
	ld a,(character_select_input_store)
  and 0x1               ; check key Enter
  jp nz,character_select_loop
  
  ;;;;; characters have been locked in, initialize player data
  ; initialize player 1
  ld a,(selected_character_p1)
  ld hl,player_1_name
  call init_player

  ; TODO: reverse sprites of player 2's selected character
  ; initialize player 2
  ld a,(selected_character_p2)
  call flip_player
  ld a,(selected_character_p2)
  ld hl,player_2_name
  call init_player

  ret

select_next_character_p1:
	ld hl,selected_character_p1
	ld a,(selected_character_max)
	ld e,a
	ld a,(hl)
	cp e
	jp z,_select_next_character_p1_set_zero
  inc a
  jp _select_next_character_p1_end
_select_next_character_p1_set_zero:
	ld a,0
_select_next_character_p1_end:
  ld (hl),a
  ld b,a
  ld a,(selected_character_p2)
  cp b
  jp z,select_next_character_p1
	jp draw_title_character_p1

select_prev_character_p1:
	ld hl,selected_character_p1
	ld a,(hl)
	cp 0
	jp z,_select_prev_character_p1_set_max
	dec a
	jp _select_prev_character_p1_end
_select_prev_character_p1_set_max:
	ld a,(selected_character_max)
_select_prev_character_p1_end:
	ld (hl),a
  ld b,a
  ld a,(selected_character_p2)
  cp b
  jp z,select_prev_character_p1
	jp draw_title_character_p1

select_next_character_p2:
	ld hl,selected_character_p2
	ld a,(selected_character_max)
	ld e,a
	ld a,(hl)
	cp e
	jp z,_select_next_character_p2_set_zero
	inc a
	jp _select_next_character_p2_end
_select_next_character_p2_set_zero:
	ld a,0
_select_next_character_p2_end:
	ld (hl),a
  ld b,a
  ld a,(selected_character_p1)
  cp b
  jp z,select_next_character_p2
	jp draw_title_character_p2

select_prev_character_p2:
  ld hl,selected_character_p2
  ld a,(hl)
  cp 0
  jp z,_select_prev_character_p2_set_max
  dec a
  jp _select_prev_character_p2_end
_select_prev_character_p2_set_max:
  ld a,(selected_character_max)
_select_prev_character_p2_end:
  ld (hl),a
  ld b,a
  ld a,(selected_character_p1)
  cp b
  jp z,select_prev_character_p2
  jp draw_title_character_p2


increase_number_of_rounds:
  ld a, (number_of_rounds)
  out (254), a
  cp 9 
  jp z, _increase_number_rounds_end
  inc a 
  ld (number_of_rounds), a
  call draw_number_of_rounds
_increase_number_rounds_end:
  ret

decrease_number_of_rounds:
  ld a, (number_of_rounds)
  cp 1 
  jp z, _decrease_number_rounds_end
  dec a 
  ld (number_of_rounds), a
  call draw_number_of_rounds
_decrease_number_rounds_end:
  ret 


init_player:
  cp 0
  jp z,punchy_init
  cp 1
  jp z,wizzy_init
  cp 2
  jp z,stabby_init

init_char_1:
  ret
init_char_2:
  ret
init_char_3:
  ret
init_char_4:
  ret
init_char_5:
  ret

flip_player:
  cp 0
  jp z,punchy_flip
  cp 1
  jp z,wizzy_flip
  cp 2
  jp z,stabby_flip
  cp 3
  jp z,init_char_3
  cp 4
  jp z,init_char_4
  cp 5
  jp z,init_char_5


; ------------------------------------------------------------------------------
; This routine is basically a switch statement for determining which character
; is selected based on the character index passed in through A, and loading
; the address of that character's data into IX. This can't be done by storing
; pointers to the data in memory, because IX can only be loaded with constants
;
; Inputs:
;   A  = Index of the character whose data address should be loaded
; Outputs:
;   IX = Address of the data of the character
; ------------------------------------------------------------------------------
ld_character_data_address:
  cp 0
  jp z,_ld_character_data_address_char_0
  cp 1
  jp z,_ld_character_data_address_char_1
  cp 2
  jp z,_ld_character_data_address_char_2
_ld_character_data_address_char_0:
  ld ix,punchy_data
  ret
_ld_character_data_address_char_1:
  ld ix,wizzy_data
  ret
_ld_character_data_address_char_2:
  ld ix,stabby_data
  ret

ld_character_sprite_address:
  cp 0
  jp z,_ld_character_sprite_address_char_0
  cp 1
  jp z,_ld_character_sprite_address_char_1
  cp 2
  jp z,_ld_character_sprite_address_char_2
_ld_character_sprite_address_char_0:
  ld ix,punchy_sprites
  ret
_ld_character_sprite_address_char_1:
  ld ix,wizzy_sprites
  ret
_ld_character_sprite_address_char_2:
  ld ix,stabby_sprites
  ret