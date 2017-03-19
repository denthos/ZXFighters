
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

read_player_1_input: 
read_input_check_a:
      ld bc, 65022                        ; read keys G,F,D,S,A
      in a, (c) 
      ld (character_select_input_store),a ; store input for later
      and 0x1 
      jp nz, read_input_check_d
      ld a, 1 
      ld (a_down), a                      ; Note that a was pressed 

 read_input_check_d:
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_check_s 
      ld a, 1 
      ld (d_down), a
read_input_check_s:
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_check_q 
      ld a, 1 
      ld (s_down), a

read_input_check_q:
      ld bc, 64510                              ; T, R, E, W, Q
      in a, (c)
      ld (character_select_input_store), a 
      and 0x1 
      jp nz, read_input_check_w 
      ld a, 1 
      ld (q_down), a

read_input_check_w: 
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_check_e 
      ld a, 1 
      ld (w_down), a

read_input_check_e: 
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_end  
      ld a, 1 
      ld (e_down), a
      ret 

;Player two check 
read_player_2_input: 
read_input_check_j:
      ld bc, 49150                              ; H, J, K, L, Enter
      in a, (c)
      ld (character_select_input_store), a 
      and 0x8 
      jp nz, read_input_check_l
      ld a, 1 
      ld (j_down), a

read_input_check_l:
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_check_k 
      ld a, 1 
      ld (l_down), a

read_input_check_k:
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_check_u 
      ld a, 1 
      ld (k_down), a

read_input_check_u:
      ld bc, 57342                              ; Y, U, I, O, P
      in a, (c)
      ld (character_select_input_store), a 
      and 0x8 
      jp nz, read_input_check_i
      ld a, 1 
      ld (u_down), a

read_input_check_i:
      ld a, (character_select_input_store)
      and 0x4 
      jp nz, read_input_check_o 
      ld a, 1 
      ld (i_down), a

read_input_check_o:
      ld a, (character_select_input_store)
      and 0x2 
      jp nz, read_input_end 
      ld a, 1 
      ld (o_down), a
read_input_end:
      ret 


; A, S , D , Q , W, E
; J , K , L , U, I, O 
clear_input: 
      ld a, 0 
      ld (a_down), a
      ld (s_down), a
      ld (d_down), a 
      ld (j_down), a 
      ld (l_down), a
      ld (q_down), a
      ld (w_down), a
      ld (e_down), a 
      ld (k_down), a
      ld (u_down), a
      ld (i_down), a
      ld (o_down), a 
      ret 
