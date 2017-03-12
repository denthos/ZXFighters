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
	ld (player_1_current_attack), a
	ret 
update_player_check_e:
	ld a, (e_down)
	cp 1
	jp nz, update_player_attack_end
	ld (player_1_current_attack), a
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
	ld (player_2_current_attack), a
	ret 
update_player_check_o:
	ld a, (o_down)
	cp 1
	jp nz, update_player_attack_end
	ld (player_2_current_attack), a
	ret 

update_player_attack_end:
	ret 