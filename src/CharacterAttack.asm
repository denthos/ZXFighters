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
	ld (player_1_blocking), a
	ret

update_player_attack_end:
	ret 



; ------------------------------------------------------------------------------
; Subroutine for dealing damage to player 1
;
; Inputs:
;   H  = amount of damage to deal
;   L  = amount of hit stun
;   C  = 0 for blockable abilities, 1+ for block breakers
;   
; Outputs:
;
; ------------------------------------------------------------------------------
hit_player_1:
	ld a,c
	or a
	jp nz,_hit_player_1_no_block
	ld a,(player_1_blocking)
	or a
	jp z,_hit_player_1_no_block
	ld a,(player_1_blocking_health)
	sub h
	ld (player_1_blocking_health),a
	jp _hit_player_1_done
_hit_player_1_no_block:
	ld a,(player_1_damage_taken)
	add h
	ld (player_1_damage_taken),a
	ld a,l
	ld (player_1_hit_stun),a
_hit_player_1_done:
	ret

hit_player_2:
	ret ; remove this once we add player 2 in for real
	ld a,c
	or a
	jp nz,_hit_player_2_no_block
	ld a,(player_2_blocking)
	or a
	jp z,_hit_player_2_no_block
	ld a,(player_2_blocking_health)
	sub h
	ld (player_2_blocking_health),a
	jp _hit_player_2_done
_hit_player_2_no_block:
	ld a,(player_2_damage_taken)
	add h
	ld (player_2_damage_taken),a
	ld a,l
	ld (player_2_hit_stun),a
_hit_player_2_done:
	ret