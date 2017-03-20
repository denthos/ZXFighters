; ------------------------------------------------------------------------------
; Draws the health bars and sets the attribute bytes for them
; ------------------------------------------------------------------------------
init_health_bars:

        ; set attribute bytes for player 1 health bar
        ld b, 1
        ld c, 21
        call calculate_color_cell_attr_address
        ld a, 0x54
        ld b, 10
_init_health_bars_1: 
        ld (hl), a
        inc hl
        djnz _init_health_bars_1

        ; set attribute bytes for player 2 health bar
        ld b, 21
        ld c, 21
        call calculate_color_cell_attr_address
        ld a, 0x54
        ld b, 10
_init_health_bars_2:
        ld (hl), a
        inc hl
        djnz _init_health_bars_2

        ; draw full health bar for player 1
        ld b, 1
        ld c, 21
        call calculate_color_cell_pixel_address
        ex de, hl
        ld b, 10
        ld h, 8
        call draw_bar_init
        
        ; draw full health bar for player 2
        ld b, 21
        ld c, 21
        call calculate_color_cell_pixel_address
        ex de, hl
        ld b, 10
        ld h, 8
        call draw_bar_init

        ; init address variable for player 1
        ld b,11
        ld c,21
        call calculate_color_cell_pixel_address
        ld (player_1_health_bar_address),hl

        ; init address variable for player 2
        ld b,21
        ld c,21
        call calculate_color_cell_pixel_address
        ld (player_2_health_bar_address),hl

        ret 


; ------------------------------------------------------------------------------
; Subroutine for updating each player's health bar incrementally.
;
; Inputs: N/A
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
update_health_bars:
        ld a,(player_1_damage_taken)
        ld c,a
        ld e,0                                  ; flag for player one
        ld hl,(player_1_health_bar_address)
        call individual_health

        ld a,(player_2_damage_taken)
        ld c,a
        ld e,1                                  ; flag for player two
        ld hl,(player_2_health_bar_address)
        call individual_health
        ret

; ------------------------------------------------------------------------------
; Helper subroutine for updating health bar, handles preprocessing for loading in
; player info.
;
; Inputs:
;       C = damage taken
;       E = player select 0=p1 1=p2
;       HL = address to start
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
individual_health:
        push hl                                 ; save address on stack
        ld d,8                                  ; dividing by 8 to find # of color cells
        call cdivd                              ; a holds remainder, c holds result of C/D
        ld d,a                                  ; clear d now, in case no remainder
        ld b,c                                  ; ld b for call to draw_bar, in case no remainder
        or a                                    ; check if there was a remainder (if Z flag is set for reg A after call to cdivd then no need for these two lines)
        jp z,_health_no_remainder

        ld d,c                                  ; store result
        dec a                                   ; lookup table (LT) starts at 0         (4)

        ld c,a                                  ; ld remainder into c                   (4)
        xor a                                   ; clear a                               (4)
        ld b,a                                  ; ld 0's into b, BC = remainder         (4)

        cp e                                    ; check which player we are updating
        jp nz,_health_player_two_remainder

        ld hl,rtl_remainders        ; updating player one
        jp _health_remainder_stuff_loaded

_health_player_two_remainder:
        ld hl,ltr_remainders        ; ld address of remainder lookup table  (20)

_health_remainder_stuff_loaded:
        add hl,bc                               ; add offset (remainder) into LT address(11)
        ld b,d                                  ; ld bar length into b
        ld d,(hl)                               ; ld remainder value into d             (7)

_health_no_remainder:
        ld a,e                                  ; set player flag
        ld e,8                                  ; height of bar in pixel lines
        pop hl
        call draw_bar
;         ld (player_2_damage_taken), a       ; TODO: reset damage taken value in memory
        ret


; ------------------------------------------------------------------------------------
; Sets the attribute bytes for the energy bars 
; ------------------------------------------------------------------------------------
init_energy_bars:
        ld b, 1
        ld c, 22
        call calculate_color_cell_attr_address
        ld a, 0x68
        ld b, 10
_init_energy_bars_1: 
        ld (hl), a
        inc hl
        djnz _init_energy_bars_1
        ld b, 21
        ld c, 22
        call calculate_color_cell_attr_address
        ld a, 0x68
        ld b, 10
_init_energy_bars_2:
        ld (hl), a
        inc hl
        djnz _init_energy_bars_2


        ; draw empty energy bar for player 1
        ld b,8
        ld c,176
        call calculate_pixel_byte_address
        ex de, hl
        ld b, 10
        ld h, 8
        call draw_bar_init
        
        ; draw empty bar for player 2
        ld b,172
        ld c,176
        call calculate_pixel_byte_address
        ex de, hl
        ld b, 10
        ld h, 8
        call draw_bar_init

        ; init address variable for player 1
        ld b,8
        ld c,178
        call calculate_pixel_byte_address
        ld (player_1_energy_bar_address),hl

        ; init address variable for player 2
        ld b,248
        ld c,178
        call calculate_pixel_byte_address
        ld (player_2_energy_bar_address),hl

        ret



; ------------------------------------------------------------------------------
; Subroutine for updating each player's energy bar incrementally.
;
; Inputs: N/A
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
update_energy_bars:
        ld a,(player_1_energy)
        ld c,a
        ld e,1                                  ; flag for player one
        ld hl,(player_1_energy_bar_address)
        call individual_energy

        ld a,(player_2_energy)
        ld c,a
        ld e,0                                  ; flag for player two
        ld hl,(player_2_energy_bar_address)
        call individual_energy
        ret

; ------------------------------------------------------------------------------
; Helper subroutine for updating health bar, handles preprocessing for loading in
; player info.
;
; Inputs:
;       C = damage taken
;       E = player select 0=p1 1=p2
;       HL = address to start
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
individual_energy:
        push hl                                 ; save address on stack
        ld d,8                                  ; dividing by 8 to find # of color cells
        call cdivd                              ; a holds remainder, c holds result of C/D
        ld d,a                                  ; clear d now, in case no remainder
        ld b,c                                  ; ld b for call to draw_bar, in case no remainder
        or a                                    ; check if there was a remainder (if Z flag is set for reg A after call to cdivd then no need for these two lines)
        jp z,_energy_no_remainder

        ld d,c                                  ; store result
        dec a                                   ; lookup table (LT) starts at 0         (4)

        ld c,a                                  ; ld remainder into c                   (4)
        xor a                                   ; clear a                               (4)
        ld b,a                                  ; ld 0's into b, BC = remainder         (4)

        cp e                                    ; check which player we are updating
        jp nz,_energy_player_two_remainder

        ld hl,rtl_remainders
        jp _energy_remainder_stuff_loaded

_energy_player_two_remainder:
        ld hl,ltr_remainders        ; ld address of remainder lookup table  (20)

_energy_remainder_stuff_loaded:
        add hl,bc                               ; add offset (remainder) into LT address(11)
        ld b,d                                  ; ld bar length into b
        ld d,(hl)                               ; ld remainder value into d             (7)

_energy_no_remainder:
        ld a,e                                  ; set player flag
        ld e,4                                  ; height of bar in pixel lines
        pop hl
        call draw_bar
;         ld (player_2_damage_taken), a       ; TODO: reset damage taken value in memory
        ret








































