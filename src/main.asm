        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION

  ; set up interrupt handler to be main game loop
  di
  ld hl,0xfdfd
  ld bc,main_game_loop
  ld (hl),0xc3          ; 0xc3 corresponds to the opcode of the jp instruction
  inc hl
  ld (hl),c             ; write lower byte of interrupt_handler address
  inc hl
  ld (hl),b             ; write upper byte of interrupt_handler address
  ld a,0xfe
  ld i,a
  ld bc,0x100           ; 256
  ld h,a                ; a = 0xfe
  ld l,c                ; c = 0
  ld (hl),0xfd; fd cuz you want stuff 
  ld d,a                ; a = 0xfe
  ld e,b                ; b = 1
  ldir                  ; do the 256 byte copy
  im 2                  ; set interrupt mode to 2

main_start:
  ;;; DRAW TITLE SCREEN AND START CHARACTER SELECT

	; set border color
	ld a,0                    ; black
	out (0xfe),a              ; send to ula

	; clear the screen
  ld d,0x47             ; 0x47 = 0b01000111 (paper = black, ink = white)
  call clear_screen

  ; draw title screen elements (arrows, instructions, options, characters, etc.)
  call draw_title_screen
  call draw_title_character_p1
  call draw_title_character_p2

  ; start character select loop
  ;   this will return once the player(s) push Enter to start the game
  call start_character_select
  ;call start_stage_select   ; if we intend to have standalone stage selection, will go here

main_game_init:
  ;;; INITIALIZE STARTING GAME DATA

  ; initialize player data
  call set_up_characters

  ; clear the screen
  ;ld d,0x47             ; 0x47 = 0b01000111 (paper = black, ink = white)
  ld d,0x6f
  call clear_screen
  ; call draw_background
  ;call init_status_bar

  ; Load interface both full health 
  ; Draw the box for the thing to go into 

  call draw_status_panel
  call init_health_bars
  call init_energy_bars




main_loop_start:
  ei
main_loop:
  halt
  jp main_loop


  include "src/ByteAddressUtils.asm"
  include "src/CharacterSelect.asm"
  include "src/DrawingUtils.asm"
  include "src/GameData.asm"
  include "src/MainGame.asm"
  include "src/PrintingUtils.asm"
  include "src/MathUtils.asm"
  include "src/CharacterMove.asm"
  include "src/CharacterAttack.asm"
  include "src/InputUtils.asm"
  include "src/InterfaceUtils.asm"

  include "src/characters/Punchy.asm"
  include "src/characters/Punchy2.asm"
  include "src/characters/Wizzy.asm"
