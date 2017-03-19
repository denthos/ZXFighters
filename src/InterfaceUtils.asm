; ------------------------------------------------------------------------------
; Subroutine for updating health bar for both players. TODO: could be optimized
; by only updating the pixels that have changed. Currently updates entire health
; bar.
;
; Inputs: N/A
;
; Outputs: N/A
;
; Uses: A, B, C, D, E, H, L
; ------------------------------------------------------------------------------
update_health:
        ld a,(player_1_damage_taken)
        ld c,a
        ld e,0                                  ; flag for player one
        ld h,01010000B                          ; upper byte of start address
        ld a,(player_1_last_health)   ; lower byte of start address
        ld l,a
        call individual_health

        ld a,(player_2_damage_taken)
        ld c,a
        ld e,1                                  ; flag for player two
        ld h,01010000B                          ; upper byte of start address
        ld a,(player_2_last_health)   ; lower byte of start address
        ld l,a
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
        jp z,_no_remainder

        ld d,c                                  ; store result
        dec a                                   ; lookup table (LT) starts at 0         (4)

        ld c,a                                  ; ld remainder into c                   (4)
        xor a                                   ; clear a                               (4)
        ld b,a                                  ; ld 0's into b, BC = remainder         (4)

        cp e                                    ; check which player we are updating
        jp nz,_player_two_remainder

        ld hl,player_one_remainder_stuff        ; updating player one
        jp _remainder_stuff_loaded

_player_two_remainder:
        ld hl,player_two_remainder_stuff        ; ld address of remainder lookup table  (20)

_remainder_stuff_loaded:
        add hl,bc                               ; add offset (remainder) into LT address(11)
        ld b,d                                  ; ld bar length into b
        ld d,(hl)                               ; ld remainder value into d             (7)

_no_remainder:
        ld a,e                                  ; set player flag
        ld e,8                                  ; height of bar in pixel lines
        pop hl
        call draw_bar
;         ld (player_2_damage_taken), a       ; TODO: reset damage taken value in memory
        ret
