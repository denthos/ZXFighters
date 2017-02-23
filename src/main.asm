        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION (TODO: set up interrupt handler and stuff)

	; disable interrupts
  ;di

  ;;; DRAW TITLE SCREEN AND START CHARACTER SELECT

	; set border color
	ld a,1                    ; black
	out (0xfe),a              ; send to ula

	; fill screen with black
  ld hl,0x5800          ; address of first attribute byte
  ld bc,768             ; number of attribute bytes
  ld d,0x47             ; 0b00000111  (paper = black, ink = white)
  call fill_byte

  ; draw title screen elements (arrows, instructions, options, characters, etc.)
  ;call draw_title_background
  call draw_title_screen
  call draw_title_character_p1
  call draw_title_character_p2
 call draw_title_screen


  ; start character select loop
  ;   this will return once the player(s) push Enter to start the game
  call start_character_select
  ;call start_stage_select   ; if we intend to have standalone stage selection, will go here
  call start_main_game



  include "src/ByteAddressUtils.asm"
  include "src/CharacterSelect.asm"
  include "src/DrawingUtils.asm"
  include "src/GameData.asm"
  include "src/MainGame.asm"
  include "src/PrintingUtils.asm"
