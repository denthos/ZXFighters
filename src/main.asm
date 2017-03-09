        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION (TODO: set up interrupt handler and stuff)

	; disable interrupts
	di

	; set border color
	ld a,1                    ; blue
	out (0xfe),a              ; send to ula

	; fill screen with black
  ld hl,0x5800          ; address of first attribute byte
  ld bc,768             ; number of attribute bytes
  ld d,0x47             ; 0b00000111  (paper = black, ink = white)
  call fill_byte

  call draw_title_screen
  call draw_title_character_p1
  call draw_title_character_p2

  call start_main_game



  include "src/ByteAddressUtils.asm"
  include "src/CharacterSelect.asm"
  include "src/DrawingUtils.asm"
  include "src/GameData.asm"
  include "src/MainGame.asm"
  include "src/PrintingUtils.asm"
  include "src/CharacterMove.asm"
  include "src/InterruptHandler.asm"

  include "src/ByteAddressUtils.asm"
  include "src/DrawingUtils.asm"
  include "src/PrintingUtils.asm"
  include "src/GameData.asm"
