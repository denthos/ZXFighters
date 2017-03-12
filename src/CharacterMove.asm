
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


read_input: 
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
      jp nz, read_input_check_j 
      ld (e_down), 1

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


; ------------------------------------------------------------------------------
; Routine that will check the last time an interrupt was handled by the ROM. 
; If the last update (interrupt) was not 2 or more cycles ago then this method waits
; until then. This is to guarentee 25 cycles per second of processing (assuming that no
; processing takes more than 2 cycles in which case we need to re-evaluate). 
; Inputs:
;   A  = Index of the character whose data address should be loaded
; Outputs:
;   IX = Address of the data of the character
; ------------------------------------------------------------------------------
halt_2:
      ld hl, last_update
      ld a, (23672)       ; current timer updated by ROM interrupt routine
      sub (hl)
      cp 2
      jr nc, continue
      jp halt_2
continue: 
      ld a, (23672)
      ld (hl), a             ; Set the last upate time 
      ret


; ------------------------------------------------------------------------------
; Stores the time of the last interrupt update by ROM
; ------------------------------------------------------------------------------
last_update: defb 0

;       ld a,1
;       ld hl,a_down
;       ld (hl),a             ; d_down = 1



; A, S , D , Q , W, E
; J , K , L , U, I, O 
clear_input: 
      ld (a_down), 0 
      ld (d_down), 0 
      ld (j_down), 0 
      ld (l_down), 0
      ld (w_down), 0
      ld (e_down), 0 
      ld (k_down), 0
      ld (u_down), 0
      ld (i_down), 0
      ld (o_down), 0 
      ret 
