
; ------------------------------------------------------------------------------
; Currently characters move at 25 fps. We can make them move slower by keeping a 
; pointer to what movements are waiting to be processed and decrement those pointers
; until they reach 0. I don't know how this would play out or if it would be good though.
;
; Ports
; 32766 B, N, M, Symbol Shift, Space
; 49150 H, J, K, L, Enter
; 57342 Y, U, I, O, P
; 61438 6, 7, 8, 9, 0
; 63486 5, 4, 3, 2, 1 <--- Current
; 64510 T, R, E, W, Q
; 65022 G, F, D, S, A
; 65278 V, C, X, Z, Caps Shift 
; ------------------------------------------------------------------------------
; Character select should use this 

read_player_one_input: 
read_input_check_a:
      ld bc, 65022                        ; read keys G,F,D,S,A
      in a, (c) 
      ld (character_select_input_store),a ; store input for later
      and 0x1 
      jp nz, read_input_check_d
      ld (a_down), 1                      ; Note that a was pressed 

 read_input_check_d:
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_check_s 
      ld (d_down), 1
read_input_check_s:
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_check_q 
      ld (s_down), 1

read_input_check_q:
      ld bc, 64510                              ; T, R, E, W, Q
      in a, (c)
      ld (character_select_input_store), a 
      and 0x1 
      jp nz, read_input_check_w 
      ld (q_down), 1

read_input_check_w: 
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_check_e 
      ld (w_down), 1

read_input_check_e: 
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_end  
      ld (e_down), 1
      ret 

;Player two check 
read_player_two_input: 
read_input_check_j:
      ld bc, 49150                              ; H, J, K, L, Enter
      in a, (c)
      ld (character_select_input_store), a 
      and 0x8 
      jp nz, read_input_check_l
      ld (j_down), 1

read_input_check_l:
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_check_k 
      ld (l_down), 1

read_input_check_k:
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_check_u 
      ld (k_down), 1

read_input_check_u:
      ld bc, 57342                              ; Y, U, I, O, P
      in a, (c)
      ld (character_select_input_store), a 
      and 0x8 
      jp nz, read_input_check_i
      ld (u_down), 1

read_input_check_i:
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_check_o 
      ld (i_down), 1

read_input_check_o:
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_end 
      ld (o_down), 1
read_input_end:
      ret 