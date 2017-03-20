update_player_1_attacks:
update_player_check_q:
	ld a, (q_down)
	cp 1
	jp nz, update_player_check_w	; If not q pressed then check w 
	ld (player_1_current_attack), a
	ret 
update_player_check_w:
	ld a, (w_down)
	cp 1
	jp nz, update_player_check_e
	ld a, 2
	ld (player_1_current_attack), a
	ret 
update_player_check_e:
	ld a, (e_down)
	cp 1
	jp nz, update_player_check_s
	ld a, 3
	ld (player_1_current_attack), a
	ret 
update_player_check_s:
	ld a, (s_down)
	cp 1
	jp nz, update_player_attack_end
	ld (player_1_blocking), a
	ld (player_1_blocking_active),a
	ret



update_player_2_attacks:
update_player_check_u:
	ld a, (u_down)
	cp 1
	jp nz, update_player_check_i	; If not q pressed then check w 
	ld (player_2_current_attack), a
	ret 
update_player_check_i:
	ld a, (i_down)
	cp 1
	jp nz, update_player_check_o
	ld a, 2
	ld (player_2_current_attack), a
	ret 
update_player_check_o:
	ld a, (o_down)
	cp 1
	jp nz, update_player_check_k
	ld a, 3
	ld (player_2_current_attack), a
	ret 
update_player_check_k:
	ld a, (k_down)
	cp 1
	jp nz, update_player_attack_end
	ld (player_2_blocking), a
	ld (player_2_blocking_active),a
	ret

update_player_attack_end:
	ret 



; ------------------------------------------------------------------------------
; Subroutine for dealing damage to player 1
;
; Inputs:
;   A  = 0 if attack missed, 1 otherwise
;   B  = amount of knockback
;   C  = 0 for blockable abilities, 1+ for block breakers
;   D  = amount of damage to deal
;   E  = amount of hit stun
;   
; Outputs:
;
; ------------------------------------------------------------------------------
hit_player_1:
	or a
	jp z,_hit_player_1_done
	ld a,c
	or a
	jp nz,_hit_player_1_no_block
	ld a,(player_1_blocking_active)
	or a
	jp z,_hit_player_1_no_block
	ld a,(player_1_blocking_damage_taken)
	add d
	ld (player_1_blocking_damage_taken),a
	jp _hit_player_1_done
_hit_player_1_no_block:
	ld a,(player_1_damage_taken)
	add d
	ld (player_1_damage_taken),a
	ld a,e
	ld (player_1_hit_stun),a
_hit_player_1_done:
	ret

	
hit_player_2:
	or a
	jp z,_hit_player_2_done
	ld a,c
	or a
	jp nz,_hit_player_2_no_block
	ld a,(player_2_blocking_active)
	or a
	jp z,_hit_player_2_no_block
	ld a,(player_2_blocking_damage_taken)
	add d
	ld (player_2_blocking_damage_taken),a
	jp _hit_player_2_done
_hit_player_2_no_block:
	ld a,(player_2_damage_taken)
	add d
	ld (player_2_damage_taken),a
	ld a,e
	ld (player_2_hit_stun),a
_hit_player_2_done:
	ret


player_1_attack:
	ld a,(player_2_current_location)
	ld e,a
	ld hl,(player_2_current_sprite)
	ld a,(hl)
	add e
	ld e,a

	ld a,(player_1_current_location)
	ld d,a
	ld hl,(player_1_current_sprite)
	ld a,(hl)
	ld c,a
	ld a,6
	sub c
	add d
	ld d,a

	ld c,0

	ld a,(player_1_current_attack)
	cp 1
	jp z,_player_1_attack_1_execute
	cp 2
	jp z,_player_1_attack_2_execute
	cp 3
	jp z,_player_1_attack_3_execute
	ret
_player_1_attack_1_execute:
	ld a,0
	call player_1_attack_1_execute
	jp hit_player_2
_player_1_attack_2_execute:
	ld a,0
	call player_1_attack_2_execute
	jp hit_player_2
_player_1_attack_3_execute:
	ld a,0
	call player_1_attack_3_execute
	jp hit_player_2


player_2_attack:
	ld a,(player_1_current_location)
	ld e,a
	ld hl,(player_1_current_sprite)
	ld a,(hl)
	ld d,a
	ld a,6
	sub d
	add e
	ld e,a

	ld a,(player_2_current_location)
	ld d,a
	ld hl,(player_2_current_sprite)
	ld a,(hl)
	add d
	ld d,a

	ld c,1

	ld a,(player_2_current_attack)
	cp 1
	jp z,_player_2_attack_1_execute
	cp 2
	jp z,_player_2_attack_2_execute
	cp 3
	jp z,_player_2_attack_3_execute
	ret
_player_2_attack_1_execute:
	ld a,1
	call player_2_attack_1_execute
	jp hit_player_1
_player_2_attack_2_execute:
	ld a,1
	call player_2_attack_2_execute
	jp hit_player_1
_player_2_attack_3_execute:
	ld a,1
	call player_2_attack_3_execute
	jp hit_player_1
