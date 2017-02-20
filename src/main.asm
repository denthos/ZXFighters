        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION (TODO: set up interrupt handler and stuff)

	; disable interrupts
	;di

  ;;; DRAW TITLE SCREEN AND START CHARACTER SELECT

	; set border color
	ld a,1                    ; blue
	out (0xfe),a              ; send to ula

	; fill screen with black
  ld hl,0x5800          ; address of first attribute byte
  ld bc,768             ; number of attribute bytes
  ld d,0x47             ; 0b00000111  (paper = black, ink = white)
  call fill_byte

  ; draw title screen elements (arrows, instructions, options, characters, etc.)
  call draw_title_screen
  call draw_title_character_p1
  call draw_title_character_p2

  ; start character select loop
character_select_loop:
  ; player 1
  ld bc,65022           ; read keys G,F,D,S,A
  in a,(c)
  ld d,a
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

  ld a,d
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
  ld d,a
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

  ld a,d
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
  ld a,d
  and 0x1
  call z,start_game

  halt
  jp character_select_loop

start_game:
  ret


  include "src/ByteAddressUtils.asm"
  include "src/CharacterSelectUtils.asm"
  include "src/DrawingUtils.asm"
  include "src/PrintingUtils.asm"
  include "src/GameData.asm"
