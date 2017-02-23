play_loop: 
      ld bc,65022           ; read keys G,F,D,S,A
      in a,(c)
      ld (character_select_input_store),a ; store input for later
      and 0x1               ; check key A
      jp nz,__character_select_loop_a_release
      ld a,1
      ld hl,a_down
      ld (hl),a             ; a_down = 1
      jp __character_select_loop_a_done
      __character_select_loop_a_release:
      ld hl,a_down
      ld a,(hl)
      or a                  ; if a_down was 1 (key release), select prev character
      call nz, move_sprite_left
      ld hl,a_down
      ld a,0
      ld (hl),a             ; a_down = 0
      __character_select_loop_a_done:

      ld a,(character_select_input_store)
      and 0x4               ; check key D
      jp nz,__character_select_loop_d_release
      ld a,1
      ld hl,d_down
      ld (hl),a             ; d_down = 1
      jp __character_select_loop_d_done
      __character_select_loop_d_release:
      ld hl,d_down
      ld a,(hl)
      or a                  ; if d_down was 1 (key release), select next character
      call nz, move_sprite_right
      ld hl,d_down
      ld a,0
      ld (hl),a             ; d_down = 0
      __character_select_loop_d_done:


      ld a,(character_select_input_store)
      and 0x2               ; check key S
      jp nz,__character_select_loop_s_release
      ld a,1
      ld hl,s_down
      ld (hl),a             ; s_down = 1
      jp __character_select_loop_s_done
      __character_select_loop_s_release:
      ld hl,s_down
      ld a,(hl)
      or a                  ; if d_down was 1 (key release), select next character
      call nz, move_sprite_down
      ld hl,s_down
      ld a,0
      ld (hl),a             ; d_down = 0
      __character_select_loop_s_done:

      ld bc,64510           ; read keys T, R, E, W, Q
      in a,(c)
      ld (character_select_input_store),a ; save input for later
      ld a,(character_select_input_store)
      and 0x2               ; check key W?????
      jp nz,__character_select_loop_w_release
      ld a,1
      ld hl,w_down
      ld (hl),a             ; w_down = 1
      jp __character_select_loop_w_done
      __character_select_loop_w_release:
      ld hl,w_down
      ld a,(hl)
      or a                  ; if w_down was 1 (key release), select next character
      call nz, move_sprite_up
      ld hl,w_down
      ld a,0
      ld (hl),a             ; w_down = 0
      __character_select_loop_w_done:
      jp play_loop