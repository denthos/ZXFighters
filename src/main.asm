        org 32768	; put code at first address in 3rd memory device (sorta)
start:
	;;; INITIALIZATION
  ld hl,select_next_character_p1 ;816d (or something)
  ld hl,interrupt_handler ;8e3a

  ; set up interrupt handler
  di
  ld hl,0xfdfd
  ld bc,interrupt_handler
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

  ;;; DRAW TITLE SCREEN AND START CHARACTER SELECT
main_start:
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

  ;;; INITIALIZE STARTING GAME DATA
  
  ; initialize player 1 data
  ld a,0
  ld (player_1_damage_taken),a
  ld a,3
  ld (player_1_last_location),a
  ld (player_1_current_location),a
  ld hl,(player_1_sprite_idle)
  ld (player_1_current_sprite),hl

  ; initialize player 2 data
  ld a,0
  ld (player_2_damage_taken),a
  ld a,22
  ld (player_2_last_location),a
  ld (player_2_last_location),a
  ld hl,(player_2_sprite_idle)
  ld (player_2_current_sprite),hl

  ; clear the screen
  ld d,0x47             ; 0x47 = 0b01000111 (paper = black, ink = white)
  call clear_screen
  ; call draw_background
  ;call init_status_bar

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
  include "src/InterruptHandler.asm"

