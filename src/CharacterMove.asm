
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

play_loop: 
      ld bc,65022                         ; read keys G,F,D,S,A
      in a,(c)
      ld (character_select_input_store),a ; store input for later
      and 0x1                             ; check key A
      jp nz,__character_select_loop_a_done
      ld ix, shoe_sprite_data
      call halt_2                         ; make sure movement is constant and ensure no flickering
      ld a, 0
      call move_sprite_left
      cp 0                                ; Check if movement is allowed 
      jp z, __character_select_loop_a_done
      call _finish_move_sprite_left       ; Actually draw the sprite to the udpated location
      call _erase_old_sprite_left
__character_select_loop_a_done:
      ld a,(character_select_input_store)
      and 0x4                             ; check key D
      jp nz,__character_select_loop_d_done
      ld ix, shoe_sprite_data
      call halt_2                         ; make sure movement is constant and ensure no flickering
      ld a,0
      call move_sprite_right
      cp 0                                ; Check if movement is allowed 
      jp z, __character_select_loop_d_done
      cp 1
      jp z, _draw_first_walking_sprite_right
      ld ix, shoe_sprite_data;_2          ; Load second walking one 
      call _finish_move_sprite_right
      jp __character_select_loop_d_done
_draw_first_walking_sprite_right:
      call _finish_move_sprite_right
      call _erase_old_sprite_right

__character_select_loop_d_done:
;       ld a,(character_select_input_store)
;       and 0x2               ; check key S
;       jp nz,__character_select_loop_s_done
;       ld ix, shoe_sprite_data
;       call halt_2             ; make sure movement is constant and ensure no flickering
;       ld a, 0
;       call move_sprite_down

__character_select_loop_s_done:
;       ld bc,64510           ; read keys T, R, E, W, Q
;       in a,(c)
;       ld (character_select_input_store),a ; save input for later
;       ld a,(character_select_input_store)
;       and 0x2               ; check key W?????
;       jp nz,__character_select_loop_w_done
;       ld ix, shoe_sprite_data
;       call halt_2             ; make sure movement is constant and ensure no flickering
;       ld a, 0
;       call move_sprite_jump
       
__character_select_loop_w_done:

; player 2 movement
      ld bc,49150           ; H, J, K, L, Enter
      in a,(c)
      ld (character_select_input_store),a ; store input for later
      and 0x8               ; check key J
      jp nz,__character_select_loop_j_done
      ld ix, sprite_sprite_data
      call halt_2                         ; make sure movement is constant and ensure to flickering
      ld a, 1                             ; Let method know that sprite is sprite 2 
      call move_sprite_left               ; 
      cp 0                                ; Check if movement is allowed 
      jp z, __character_select_loop_j_done
      call _finish_move_sprite_left       ; Actually draw the sprite to the updated location
      call _erase_old_sprite_left_2       ; 
__character_select_loop_j_done:
      ld a,(character_select_input_store)
      and 0x2               ; check key L
      jp nz,__character_select_loop_l_done
      ld ix, sprite_sprite_data
      call halt_2             ; make sure movement is constant and ensure to flickering
      ld a, 1
      call move_sprite_right
      cp 0                                ; Check if movement is allowed 
      jp z, __character_select_loop_l_done
      call _finish_move_sprite_right
      call _erase_old_sprite_right_2
__character_select_loop_l_done:
;       ld a,(character_select_input_store)
;       and 0x4               ; check key K
;       jp nz,__character_select_loop_k_done
;       ld ix, sprite_sprite_data
;       call halt_2             ; make sure movement is constant and ensure to flickering
;       ld a, 1
;       call move_sprite_down
__character_select_loop_k_done:
;       ld bc,57342           ; read keys Y, U, I, O, P
;       in a,(c)
;       ld (character_select_input_store),a ; save input for later
;       ld a,(character_select_input_store)
;       and 0x4               ; check key I
;       jp nz,__character_select_loop_i_done
;       ld ix, sprite_sprite_data
;       call halt_2             ; make sure movement is constant and ensure to flickering
;       ld a, 1
;       call move_sprite_jump
__character_select_loop_i_done:
;       call halt_2
;       call halt_2
;       halt
      jp play_loop



;Commented out code for a basic running jump 
; play_loop:

;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_up
;       cp 0                                ; Check if movement is allowed 
;       jp z, end 
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_up

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, end 
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right

;       call halt_8

;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_up
;       cp 0                                ; Check if movement is allowed 
;       jp z, end 
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_up

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, end 
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right

;       call halt_8

;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_up
;       cp 0                                ; Check if movement is allowed 
;       jp z, end 
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_up

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, end 
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right

;       call halt_8


; ; - --- - -- - - - - - - - - - -  -- - - - -- - - -

;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_down
;       cp 0                                ; Check if movement is allowed 
;       jp z, end 
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_down

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, end 
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right


;       call halt_8


;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_down
;       cp 0                                ; Check if movement is allowed 
;       jp z, end 
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_down

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, end 
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right


;       call halt_8


;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_down
;       cp 0                                ; Check if movement is allowed 
;       jp z, end 
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_down

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, end 
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_jump




;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_down
;       cp 0                                ; Check if movement is allowed 
;       jp z, play_loop
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_down

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, play_loop
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right

;       ld ix, shoe_sprite_data 
;       call halt_2 
;       ld a, 0 
;       call move_sprite_down
;       cp 0                                ; Check if movement is allowed 
;       jp z, play_loop
; ;       call _finish_move_sprite_up
;       call _erase_old_sprite_down

;       ld a, 0 
;       ld ix, shoe_sprite_data 
;       call move_sprite_right
;       cp 0 
;       jp z, play_loop
;       call _finish_move_sprite_right
;       call _erase_old_sprite_right


end: 
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