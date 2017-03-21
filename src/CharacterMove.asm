; Because the new changes when a sprite is set to idle I'll need to reset the bit offset counter 
; Also take care of setting the idle stuff in revert sprite 
; Fix check overlap
; Add extra walking step back to 2nd walking sprite from 3rd walking sprite 

; ------------------------------------------------------------
; Input: None
; Output: None
; Called after player key inputs are read in order to do the correct
; actions based on the keys that were pressed. 
; 
; 
; 
; -------------------------------------------------------------
update_player_1_movements:
      ; Check A (move left)
update_check_a:
      ;Check if a and d are pressed 
      ld a, (a_down)                            ; Load a (left p1) into a 
      cp 1                                      ; Check if pressed (1 = pressed)
      jp z, update_check_d_a_pressed            ; If a is pressed we need to check if d is pressed 
      ld a, (d_down)                            ; Else a is not pressed check d 
      cp 1                                      ; Compare d to 1 (check if pressed)
      jp nz, no_movement_player_1               ; If it is not pressed then p1 has not moved, jump to idle logic 
      ld a, (player_1_current_location)         ; Else player has moved right, so get the current location 
      ld a, 0     
      call move_sprite_right                    ; Move the player right (if possible)
;       call halt_8
;       Check result to know what the sprite is 
;       ld a , 2  

;       ld a, (player_1_current_location)       ; Load the player 1 current location again 
;       out (254), a                            ; 
      cp 0                                      ; Check if the sprite moved successfully 
      jp nz, update_movement_check_end          ; If sprite moved successfully then return 
      jp no_movement_player_1                   ; Else player didn't move, switch to idle logic 
      

update_check_d_a_pressed:
      ld a, (d_down)                            ; Check if d has been pressed 
      cp 1                                      ; Compare d to 1 (check if pressed)
      jp z, no_movement_player_1                ; If d_down is 0 then do idle logic
      ld a, 0                                   ; Let move_sprite_left know that it is sprite one (may change)
      call move_sprite_left                     ; Move the sprite left 
      cp 0                                      ; Check success or failure 
      jp nz, update_movement_check_end          ; Will end if success
      jp no_movement_player_1                   ; If not successful then idle logic 
      ret   

; Can be optimized to only use two numbers 
no_movement_player_1:
      ld a, (player_1_idle_counter)
      inc a 
      ld (player_1_idle_counter), a 
      cp 10 
      jp c, update_movement_check_end           ; If no movement for less than 25 frames then wait 
      ld a, 0                                   ; Reset the counter 
      ld (player_1_idle_counter), a             ; Reset the counter 
      ld a, (player_1_current_idle_sprite)      ; Load the number of the idle sprite being used (0 -> not idle, 1 -> idle1, 2 -> idle2)
      cp 0                                      ; Check if it's 0 (not idle)
      jp z, set_player_1_idle_sprite            ; If it's not the idle sprite then set to idle 1 
      cp 1                                      ; Check if it is currently idle sprite 1 
      jp z, set_player_1_idle_sprite_2          ; If so then move to idle sprite 2
      cp 2                                      ; Check if it's sprite 2 
      jp z, set_player_1_idle_sprite            ; If it is then reset to sprite 1 
      out (254), a                              ; Does this get called? Shouldn't be called 


update_player_2_movements:
update_check_j:
      ld a, (j_down)                            ; Check if j was pressed 
      cp 1                                      ; Compare 1 (pressed)
      jp z, update_check_j_l_pressed            ; If pressed check if j also pressed 
      ld a, (l_down)                            ; Else j was not pressed, check l 
      cp 1                                      ; Compare 1 (pressed)
      jp nz, no_movement_player_2               ; If not pressed then player has not moved 
      ld a, 1                                   ; Load 1 into a for sprite 2
      call move_sprite_right                    ; Move the sprite right (l)
      cp 0                                      ; Check result of the move (0 = unsuccessful)
      jp nz, update_movement_check_end          ; If not zero then return 
      jp no_movement_player_2                   ; Else idle logic 
      ret 

update_check_j_l_pressed:
      ld a, (l_down)                            ; Check i l was also pressed 
      cp 1                                      ; Compare 1 (pressed)
      jp z, no_movement_player_2                ; If l also pressed then no movement 
      ld a, 1                                   ; Load 1 into a 
      call move_sprite_left                     ; Move the sprite left for j 
      cp 0                                      ; Check result of move 
      jp nz, update_movement_check_end          ; If successful then return 
      jp no_movement_player_2                   ; Else idle logic 
      ret 

no_movement_player_2:
      ld a, (player_2_idle_counter)
      inc a 
      ld (player_2_idle_counter), a 
      cp 10 
      jp c, update_movement_check_end           ; If no movement for less than 25 frames then wait 
      ld a, 0                                   ; Reset the counter 
      ld (player_2_idle_counter), a             ; Reset the counter 
      ld a, (player_2_current_idle_sprite)      ; Load the number of the current idle sprite (0 -> not idle, 1 -> idle1, 2 -> idle2)
      cp 0                                      ; Check if not idle already 
      jp z, set_player_2_idle_sprite            ; If it's not the idle sprite then set to idle 1 
      cp 1                                      ; Compare to 1 to check if it's first idle sprite currently 
      jp z, set_player_2_idle_sprite_2          ; Should return 
      cp 2                                      ; Compare 2 to check if second idle sprite 
      jp z, set_player_2_idle_sprite            ; Should return and will set to idle sprite 1 

update_movement_check_end:
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



; Movement stuff

; The return value of a matters because move sprite stuff calls this to end in all cases (for now)
set_player_1_idle_sprite:
      ld hl, (player_1_sprite_idle_1)
      ld (player_1_current_sprite), hl    
      ld a, 1                                   ; Also good for the return value 
      ld (player_1_current_idle_sprite), a
      ret


set_player_1_idle_sprite_2:
      ld hl, (player_1_sprite_idle_2)
      ld (player_1_current_sprite), hl
      ld a, 2 
      ld (player_1_current_idle_sprite), a
      ld a, 1                                   ; 1 to denote an idle sprite, although this shouldn't matter since move code doesn't return idle_2
      ret

set_player_1_first_walking_sprite:
      ld hl, (player_1_sprite_walk_forward_1) 
      ld (player_1_current_sprite), hl

      ret 

set_player_1_second_walking_sprite:
      ld hl, (player_1_sprite_walk_forward_2) 
      ld (player_1_current_sprite), hl
      ret 

set_player_2_idle_sprite:
      ld hl, (player_2_sprite_idle_1)
      ld (player_2_current_sprite), hl
      ld a, 1                                   ; Also good for the return value 
      ld (player_2_current_idle_sprite), a
      ret

set_player_2_idle_sprite_2:
      ld hl, (player_2_sprite_idle_2)
      ld (player_2_current_sprite), hl
      ld a, 2 
      ld (player_2_current_idle_sprite), a
      ld a, 1                                   ; 1 to denote an idle sprite, although this shouldn't matter since move code doesn't return idle_2
      ret

set_player_2_first_walking_sprite:
      ld hl, (player_2_sprite_walk_forward_1) 
      ld (player_2_current_sprite), hl
      ret 

set_player_2_second_walking_sprite:
      ld hl, (player_2_sprite_walk_forward_2) 
      ld (player_2_current_sprite), hl
      ret 


; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen one pixel* to the 
; right of it's current location 
;
; Inputs: 
;     IX - the input sprite data, to be passed into draw_sprite routine 
;     A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; Outputs: 
;     A - 0 if no movement was allowed 1 if movement was successful 
; ------------------------------------------------------------------------------
move_sprite_left:
      cp 0
      jp nz, _move_sprite_left_2                ; Check if the first or second sprite
      ld a,(player_1_current_location)          ; Load first sprite x location
      cp 0                                      ; Is sprite at left edge?
      jp z, _move_sprite_left_done_edge         ; If it is, then skip to the end 
      ;for smoother movement 
      ld a, (player_1_current_walking_sprite)   ; Load the bit offsett to check to see where we are in the character cell 
      cp 0; 6                                   ; Check if the bit offset is = 0 (after 0 moves to the left character cell)
      jp nz,move_left_bit_offset_normal         ; If equal to 7 then increment player_1_current_walking_sprite 
      xor a                                     ; Clear the a register 
      ld a, 6;4 
      ld (player_1_current_walking_sprite), a   ; Save 4 as the bit offset 
      jp resume_move_sprite_left                ; Absolute jump to skip normal case 
move_left_bit_offset_normal:
      dec a                                     ; CAn be 0, 2, 4
      dec a
      ld (player_1_current_walking_sprite), a   ; Save the new bit offset into memory 

resume_move_sprite_left:
      ld a, (player_1_current_location)         ; For now always increment since we're doing single pixel movement
      dec a                                     ; Else increment a to move to the right of the screen
      ld (player_1_current_location), a         ; Save the updated x position in memory
      ld b, a
      ld a, 0 ;(8); 10                             ; Load sprite one y location into a, in order to load c
      ld c,a                                    ; Load c with the y location of sprite 1 from a 
      
      ld a, 0 
      ld (player_1_current_idle_sprite), a      ; Not idle

      ld a, (player_1_current_walking_sprite)   ; Load that into a 
      inc a                                     ; To differentiate from failure 
      cp 1
      jp z, set_player_1_idle_sprite            ; First walking sprite is the 1st idle sprite 
      cp 3                                      ; Check for second walking sprite and if so then update state of current sprite 
      jp z, set_player_1_first_walking_sprite   ; Update state to be the second walking sprite
      cp 5
      jp z, set_player_1_second_walking_sprite  ; Back to the first walking sprite for smoothness
      jp set_player_1_first_walking_sprite      ; Must be 5, jp automatically , should return 

_move_sprite_left_2: 
      ld a,(player_2_current_location)          ; Load second sprite x location 
      cp 0                                      ; Is sprite at left edge?
      jp z, _move_sprite_left_done_edge         ; If so, then skip to end and return 
      ;for smoother movement 
      ld a, (player_2_current_walking_sprite)   ; Load the bit offsett to check to see where we are in the character cell 
      cp 0; 6                                   ; Check if the bit offset is = 0 (after 0 moves to the left character cell)
      jp nz, move_left_current_walking_sprite2      ; If equal to 7 then increment player_1_current_walking_sprite 
      xor a                                     ; Clear the a register 
      ld a, 6 
      ld (player_2_current_walking_sprite), a   ; Save 4 as the bit offset 
      jp resume_move_sprite_left_2              ; Absolute jump to skip normal case 
move_left_current_walking_sprite2:
      dec a                                     ; CAn be 0, 2, 4
      dec a
      ld (player_2_current_walking_sprite), a   ; Save the new bit offset into memory 

resume_move_sprite_left_2:
      ld a, (player_2_current_location)         ; For now always increment since we're doing single pixel movement
      dec a                                     ; Else increment a to move to the right of the screen
      ld (player_2_current_location),a          ; Save the updated x position in memory
      ld b,a
      ld a, 0;(8)                                  ; Load sprite one y location into a, in order to load c
      ld c,a                                    ; Load c with the y location of sprite 1 from a 

      call check_sprite_overlap
      cp 1                                      ; Will set the Z flag if A == 1
      jp z, _revert_move_left_2                 ; a = 1 means overlapping now

      ld a, 0 
      ld (player_2_current_idle_sprite), a      ; Not idle 

      ld a, (player_2_current_walking_sprite)   ; a will be 1, 3, 5 ---- 0 is for failure 
      inc a 
      cp 1
      jp z, set_player_2_idle_sprite
      cp 3
      jp z, set_player_2_first_walking_sprite
      cp 5
      jp z, set_player_2_second_walking_sprite
      jp set_player_2_first_walking_sprite     ; Must be 5, jp automatically , should return 



; _finish_move_sprite_left:
;       push af 
;       call calculate_color_cell_pixel_address   ; Will set up HL  
;       ld c,0                                    ; Set to not overwrite
;       ; Check player one or player two because of the offset and touching 
;       pop af
;     cp 1                                      ; Check if sprite 1 or 2
;     jp z, _continue_finish_move_sprite_left ; Set d to 6 for sprite 2 
;     ld a, (pre_calculate_offset_middle_for_e)
;     dec a 
;     ld e, 0
; _continue_finish_move_sprite_left:
;       call draw_sprite                          ; Actually draw the sprite in the new location 
;       ret                                       ; return to original call 

; May never need this 
; _revert_move_left:
;     ld a, (player_1_current_walking_sprite)   ; Load the new faulty x position into the register a 
;     inc a                                     ; Revert the change by decrementing the x position 
;     ld (player_1_current_walking_sprite), a   ; Save the position in memory
;     ld a, 0
;     jp _move_sprite_left_done                 ; Finish 

_revert_move_left_2:
      ld a, (player_2_current_walking_sprite)    
      cp 6 ;4                           
      jp nz, _revert_move_left_sub_offset_2     ; 
      xor a                                     ; Now onto the next thing  
      jp _resume_revert_move_left_2
_revert_move_left_sub_offset_2: 
      add a, 2
_resume_revert_move_left_2:
      ld (player_2_current_walking_sprite), a   ; Save the old offset back to memory 
      ld a, (player_2_current_location)         ; Load the new faulty x position into the register a 
      inc a                                     ; Revert the change by decrementing the x position 
      ld (player_2_current_location), a         ; Save the position in memory
      ; Load the idle sprite 
      ; sjp set_player_2_idle_sprite               ; Finish 
      ld a, 0 
      ret 
_move_sprite_left_done_edge:                    ; Finish
      ld a, 0                                   ; Output a = 0 so no need to draw anything 
      ret

_move_sprite_left_done:                         ; Finish
      ret                                       ; Return and assume output a was set before this 


; ------------------------------------------------------------------------------
; Subroutine for drawing a sprite onto the screen 1 pixel to the right 
; of it's current location 
;
; Inputs: 
;     IX - the input sprite to be input to draw_sprite routine 
;     A  - the sprite number ( 0 = sprite #1, 1 = sprite #2)
; Outputs:
;     A - (0 = Character overlap no drawing)
;         (1 = Draw the first walking sprite)
;         (5 = Draw the second walking sprite)
; ------------------------------------------------------------------------------
move_sprite_right:
      cp 0                                      ; Check if sprite 1 or 2 move
      jp nz, _move_sprite_right_2               ; If 1 then absolute jump to sprite 2 movement right code
      ld a, (player_1_current_location)          ; Else load sprite 1 x position into a register
      cp 26                                     ; Check if the sprite is already as far right as possible 
      jp z, _move_sprite_right_done_edge         ; If so then skip to the end and return 
      ;for smoother movement 
      ld a, (player_1_current_walking_sprite)   ; Load the bit offsett to check to see where we are in the character cell 
      cp 6; 6                                   ; Check if the bit offset is = 4 (after 4 moves to next character cell)
      jp nz, move_right_current_walking_sprite  ; If equal to 7 then increment player_1_current_walking_sprite 
      xor a                                     ; Clear the a register 
      ld (player_1_current_walking_sprite), a   ; Save 0 as the bit offset 
      jp resume_move_sprite_right
move_right_current_walking_sprite:
      add a, 2                                  ; CAn be 0, 2, 4
      ld (player_1_current_walking_sprite), a   ; Save the new bit offset into memory 

resume_move_sprite_right:
      ld a, (player_1_current_location)         ; For now always increment since we're doing single pixel movement
      inc a                                     ; Else increment a to move to the right of the screen
      ld (player_1_current_location),a          ; Save the updated x position in memory
      ld b,a
      ld a,0;(8)                                  ; Load the sprite 1 y location into the a register to be loaded into the c register
      ld c,a                                    ; Load the y position into the c register for calculate_color_cell_pixel_address
      call check_sprite_overlap
      ;out (254), a  
      cp 1                                     ; Will set the Z flag if A == 1, A == 1 if there was overlap 
      jp z, _revert_move_right                 ; a = 1 means overlapping now, will auto end and fail the method
      ld a, (player_1_current_walking_sprite)    ; 
      inc a                                     ; 

      cp 1
      jp z, set_player_1_idle_sprite              
      cp 3
      jp z, set_player_1_first_walking_sprite
      cp 5
      jp z, set_player_1_second_walking_sprite    
      jp set_player_1_first_walking_sprite     ; Must be 5, jp automatically , should return 
      
_move_sprite_right_2:
      ld a,(player_2_current_location)          ; Load the old x position of sprite 2
      cp 26                                     ; Check if already to the farthest right of the screen 
      jp z,_move_sprite_right_done_edge         ; If so then skip to the end and return 
      ld a, (player_2_current_walking_sprite)       ; Load the bit offsett to check to see where we are in the character cell 
      cp 6 ;4; 6                                   ; Check if the bit offset is = 4 (after 4 moves to next character cell)
      jp nz, move_right_current_player_sprite_2     ; If equal to 7 then increment player_1_current_walking_sprite 
      xor a                                     ; Clear the a register 
      ld (player_2_current_walking_sprite), a       ; Save 0 as the bit offset 
      jp resume_move_sprite_right_2
move_right_current_player_sprite_2:
      add a, 2                                  ; CAn be 0, 2, 4
      ld (player_2_current_walking_sprite), a       ; Save the new bit offset into memory 
resume_move_sprite_right_2:
      ld a, (player_2_current_location)         ; For now always increment since we're doing single pixel movement
      inc a                                     ; Else increment a to move to the right of the screen
      ld (player_2_current_location),a          ; Save the updated x position in memory
      ld b,a
      ld a,0; (8)                                  ; Load the sprite 1 y location into the a register to be loaded into the c register
      ld c,a                                    ; Load the y position into the c register for calculate_color_cell_pixel_address
      ; we may never need this because second sprite moving right should never be reverted 
;     call check_sprite_overlap
;     cp 1                                      ; Will set the Z flag if A == 1
;     jp z, _revert_move_right_2                ; a = 1 means overlapping now, will auto end and fail the method 
      ld a, (player_2_current_walking_sprite)       ; a will be 1, 3, 5, 7---- 0 is for failure 
      inc a 
      cp 1
      jp z, set_player_2_idle_sprite
      cp 3
      jp z, set_player_2_first_walking_sprite
      cp 5
      jp z, set_player_2_second_walking_sprite
      jp set_player_2_first_walking_sprite     ; Must be 5, jp automatically , should return 

; Input: A - Which sprite , IX, 
; _finish_move_sprite_right:
;       push af 
;       call calculate_color_cell_pixel_address   ; Will set up HL 

;       ld c, 0 ; Blend always 
;       ; Check player one or player two 
;       pop af
; _continue_finish_move_sprite_right:
;       call draw_sprite                          ; Actually draw the sprite in the new location 
;       ret                                       ; return to original call 

_revert_move_right:
      ld a, (player_1_current_walking_sprite)       ; 
      cp 0                          ; 
      jp nz, _revert_move_right_sub_offset      ; 
      xor a 
      ld a, 6;4                             ; 
      jp _resume_revert_move_right
_revert_move_right_sub_offset: 
      dec a 
      dec a 
_resume_revert_move_right:
      ld (player_1_current_walking_sprite), a   ; Save the old offset back to memory 
      ld a, (player_1_current_location)         ; Load the new faulty x position into the register a 
      dec a                                     ; Revert the change by decrementing the x position 
      ld (player_1_current_location), a         ; Save the position in memory
      ;jp set_player_1_idle_sprite 
      ld a, 0 
      ret 
; May never need this again 
; _revert_move_right_2:
;     ld a, (player_2_current_walking_sprite)       ; 
;     cp 0                          ; 
;     jp nz, _revert_move_right_sub_offset_2    ; 
;     xor a 
;     ld a, 4                             ; 
;     jp _resume_revert_move_right_2
; _revert_move_right_sub_offset_2: 
;     dec a 
;     dec a 
; _resume_revert_move_right_2:
;     ld (player_2_current_walking_sprite), a       ; Save the old offset back to memory 
;     ld a, (player_2_current_location)         ; Load the new faulty x position into the register a 
;     dec a                                     ; Revert the change by decrementing the x position 
;     ld (player_2_current_location), a         ; Save the position in memory
;     ld a, 0                                   ; Failure 
;     jp _move_sprite_right_done                ; Finish 

_move_sprite_right_done_edge:
      ld a, 0                                   ; Output that no drawing is necessary

_move_sprite_right_done:
      ret
      
      
; ------------------------------------------------------------------------------
; Subroutine for checking if the two sprites are now overlapping
; Outputs:
;     A - 1 for overlapping 0 for not overlapping
; ------------------------------------------------------------------------------
check_sprite_overlap:
      ld a, (player_1_current_location)
;     call absA
      ld d, a
      ld a, (player_2_current_location)

;     call absA
      sub d 
      add a, 6
      push af                             ; Save a (difference)(how close they are) on stack 
      ld hl, (player_1_current_sprite)    ; Load pre_calculate_offset_middle into a to load to d  
      ld a, (hl)                          ; Offset for the first one 
      ld b, a 
      ld hl, (player_2_current_sprite)
      ld a, (hl)

;       ld a, 0

      add a, b 
      ld b, a 
      ld a, 6
      sub b 
      add a ,6
      ld d, a                             ; Load the pre_calculate_offset_middle into d for compare with a
      pop af                              ; Get back the difference into a 
      cp d ;6                             ; Compare d with a 
      jp nc, return_sprite_overlap_false  ; If difference is greater than or equal to d(4) then return false
      jp return_sprite_overlap_true

return_sprite_overlap_false:
      ld a, 0
      jp check_sprite_overlap_done

return_sprite_overlap_true:
      ld a, 1

check_sprite_overlap_done:
      ret