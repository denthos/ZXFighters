
; ------------------------------------------------------------------------------
; Currently characters move at 25 fps. We can make them move slower by keeping a 
; pointer to what movements are waiting to be processed and decrement those pointers
; until they reach 0. I don't know how this would play out or if it would be good though. 
; ------------------------------------------------------------------------------

play_loop: 
      ld bc,65022           ; read keys G,F,D,S,A
      in a,(c)
      ld (character_select_input_store),a ; store input for later
      and 0x1               ; check key A
      jp nz,__character_select_loop_a_done
      call halt_2             ; make sure movement is constant and ensure to flickering
      call move_sprite_left
;       halt
__character_select_loop_a_done:
      ld a,(character_select_input_store)
      and 0x4               ; check key D
      jp nz,__character_select_loop_d_done
      call halt_2             ; make sure movement is constant and ensure to flickering
      call move_sprite_right

__character_select_loop_d_done:


      ld a,(character_select_input_store)
      and 0x2               ; check key S
      jp nz,__character_select_loop_s_done
      call halt_2             ; make sure movement is constant and ensure to flickering
      call move_sprite_down

__character_select_loop_s_done:
      ld bc,64510           ; read keys T, R, E, W, Q
      in a,(c)
      ld (character_select_input_store),a ; save input for later
      ld a,(character_select_input_store)
      and 0x2               ; check key W?????
      jp nz,__character_select_loop_w_done
      call halt_2             ; make sure movement is constant and ensure to flickering
      call move_sprite_up
__character_select_loop_w_done:
      jp play_loop



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
      ld (hl), a    ;Set the last upate time 
      ret


; ------------------------------------------------------------------------------
; Stores the time of the last interrupt update by ROM
; ------------------------------------------------------------------------------
last_update: defb 0

;       ld a,1
;       ld hl,a_down
;       ld (hl),a             ; d_down = 1