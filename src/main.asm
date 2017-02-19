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
  ld d,7                ; 0b00000111  (paper = black, ink = white)
  call fill_byte

	; start title screen loop
  ld b,2
  ld c,9
  call calculate_color_cell_pixel_address

  ld d,6
  ld c,0
  ld ix,shoe_sprite_pixels
  call draw_sprite

  ld b,0
  ld c,15
  call calculate_color_cell_pixel_address
  ld d,h
  ld e,l

  ld ix,shoe_name
  call print_name_title_screen

  ld b,24
  ld c,9
  call calculate_color_cell_pixel_address

  ld d,4
  ld c,0
  ld ix,sprite_sprite_pixels
  call draw_sprite

  ld b,22
  ld c,15
  call calculate_color_cell_pixel_address
  ld d,h
  ld e,l

  ld ix,sprite_name
  call print_name_title_screen


  include "src/ByteAddressUtils.asm"
  include "src/DrawingUtils.asm"
  include "src/PrintingUtils.asm"
  include "src/GameData.asm"
