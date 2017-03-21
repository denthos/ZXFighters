punchy_data:
punchy_name:
    defb '  Punchy  '
punchy_init:
        ld bc,punchy_name
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_idle_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_idle_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_walk_forward_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_walk_forward_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_block
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_hit
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld a,(punchy_attack_1_starting_active_frame)
        ld (hl),a
        inc hl
        ld a,(punchy_attack_1_ending_active_frame)
        ld (hl),a
        inc hl
        ld a,(punchy_attack_1_total_frames)
        ld (hl),a
        inc hl
        ld bc,punchy_sprite_attack_1_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_attack_1_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        inc hl
        ld bc,punchy_attack_1_execute
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld a,(punchy_attack_2_starting_active_frame)
        ld (hl),a
        inc hl
        ld a,(punchy_attack_2_ending_active_frame)
        ld (hl),a
        inc hl
        ld a,(punchy_attack_2_total_frames)
        ld (hl),a
        inc hl
        ld bc,punchy_sprite_attack_2_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_attack_2_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        inc hl
        ld bc,punchy_attack_2_execute
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld a,(punchy_attack_3_starting_active_frame)
        ld (hl),a
        inc hl
        ld a,(punchy_attack_3_ending_active_frame)
        ld (hl),a
        inc hl
        ld a,(punchy_attack_3_total_frames)
        ld (hl),a
        inc hl
        ld bc,punchy_sprite_attack_3_1
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ld bc,punchy_sprite_attack_3_2
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        inc hl
        ld bc,punchy_attack_3_execute
        ld (hl),c
        inc hl
        ld (hl),b
        inc hl
        ret

punchy_flip:
  ld ix,punchy_sprite_idle_1
  call flip_sprite_init
  ld ix,punchy_sprite_idle_2
  call flip_sprite_init
  ld ix,punchy_sprite_walk_forward_1
  call flip_sprite_init
  ld ix,punchy_sprite_walk_forward_2
  call flip_sprite_init
  ld ix,punchy_sprite_block
  call flip_sprite_init
  ld ix,punchy_sprite_hit
  call flip_sprite_init
  ld ix,punchy_sprite_attack_1_1
  call flip_sprite_init
  ld ix,punchy_sprite_attack_1_2
  call flip_sprite_init
  ld ix,punchy_sprite_attack_2_1
  call flip_sprite_init
  ld ix,punchy_sprite_attack_2_2
  call flip_sprite_init
  ld ix,punchy_sprite_attack_3_1
  call flip_sprite_init
  ld ix,punchy_sprite_attack_3_2
  call flip_sprite_init
  ret


punchy_sprites:
punchy_sprite_idle_1:
    defb 3
    defb 3
    defb 0,37
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 0,4
    defb 16,1
    defb 3,1
    defb 6,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 137,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 73,1
    defb 0,3
    defb 66,1
    defb 0,1
    defb 53,1
    defb 0,3
    defb 65,1
    defb 84,1
    defb 34,1
    defb 0,3
    defb 65,1
    defb 6,1
    defb 4,1
    defb 0,3
    defb 65,1
    defb 7,1
    defb 136,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 240,1
    defb 0,3
    defb 35,1
    defb 14,1
    defb 0,4
    defb 48,1
    defb 241,1
    defb 0,4
    defb 24,1
    defb 1,1
    defb 0,4
    defb 15,1
    defb 249,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 7,1
    defb 252,1
    defb 0,4
    defb 7,1
    defb 250,1
    defb 0,4
    defb 15,1
    defb 253,1
    defb 0,4
    defb 13,1
    defb 254,1
    defb 128,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 0,4
    defb 27,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 63,1
    defb 223,1
    defb 192,1
    defb 0,3
    defb 55,1
    defb 143,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 192,1
    defb 0,3
    defb 36,1
    defb 1,1
    defb 48,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 60,1
    defb 1,1
    defb 240,1
    defb 0,3
    defb 0,0
punchy_sprite_idle_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_idle_2:
    defb 3
    defb 3
    defb 0,49
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 12,1
    defb 0,3
    defb 16,1
    defb 3,1
    defb 18,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 146,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 106,1
    defb 0,3
    defb 66,1
    defb 0,1
    defb 68,1
    defb 0,3
    defb 65,1
    defb 84,1
    defb 8,1
    defb 0,3
    defb 65,1
    defb 6,1
    defb 16,1
    defb 0,3
    defb 65,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 0,4
    defb 35,1
    defb 14,1
    defb 0,4
    defb 48,1
    defb 241,1
    defb 0,4
    defb 24,1
    defb 1,1
    defb 0,4
    defb 15,1
    defb 249,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 15,1
    defb 253,1
    defb 0,4
    defb 13,1
    defb 254,1
    defb 128,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 0,4
    defb 27,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 63,1
    defb 223,1
    defb 192,1
    defb 0,3
    defb 55,1
    defb 143,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 192,1
    defb 0,3
    defb 36,1
    defb 1,1
    defb 48,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 60,1
    defb 1,1
    defb 240,1
    defb 0,3
    defb 0,0
punchy_sprite_idle_2_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_walk_forward_1:
    defb 3
    defb 3
    defb 0,37
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 0,4
    defb 16,1
    defb 3,1
    defb 6,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 137,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 73,1
    defb 0,3
    defb 66,1
    defb 0,1
    defb 53,1
    defb 0,3
    defb 65,1
    defb 84,1
    defb 34,1
    defb 0,3
    defb 65,1
    defb 6,1
    defb 4,1
    defb 0,3
    defb 65,1
    defb 7,1
    defb 136,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 240,1
    defb 0,3
    defb 35,1
    defb 14,1
    defb 0,4
    defb 48,1
    defb 241,1
    defb 0,4
    defb 24,1
    defb 1,1
    defb 0,4
    defb 15,1
    defb 249,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 252,1
    defb 0,4
    defb 3,1
    defb 252,1
    defb 0,4
    defb 7,1
    defb 252,1
    defb 0,4
    defb 7,1
    defb 246,1
    defb 0,4
    defb 7,1
    defb 250,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 254,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 254,1
    defb 0,4
    defb 7,1
    defb 252,1
    defb 0,4
    defb 15,1
    defb 252,1
    defb 0,4
    defb 63,1
    defb 252,1
    defb 0,4
    defb 79,1
    defb 252,1
    defb 0,4
    defb 71,1
    defb 248,1
    defb 0,4
    defb 35,1
    defb 38,1
    defb 0,4
    defb 17,1
    defb 65,1
    defb 0,4
    defb 9,1
    defb 65,1
    defb 0,4
    defb 6,1
    defb 62,1
    defb 0,4
    defb 0,0
punchy_sprite_walk_forward_1_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_walk_forward_2:
    defb 3
    defb 3
    defb 0,37
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 0,4
    defb 16,1
    defb 3,1
    defb 6,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 137,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 73,1
    defb 0,3
    defb 66,1
    defb 0,1
    defb 53,1
    defb 0,3
    defb 65,1
    defb 84,1
    defb 34,1
    defb 0,3
    defb 65,1
    defb 6,1
    defb 4,1
    defb 0,3
    defb 65,1
    defb 7,1
    defb 136,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 240,1
    defb 0,3
    defb 35,1
    defb 14,1
    defb 0,4
    defb 48,1
    defb 241,1
    defb 0,4
    defb 24,1
    defb 1,1
    defb 0,4
    defb 15,1
    defb 249,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 248,1
    defb 0,4
    defb 3,1
    defb 252,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 7,1
    defb 253,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 128,1
    defb 0,3
    defb 7,1
    defb 255,1
    defb 64,1
    defb 0,3
    defb 3,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 1,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 1,1
    defb 255,1
    defb 128,1
    defb 0,3
    defb 2,1
    defb 127,1
    defb 0,4
    defb 2,1
    defb 62,1
    defb 0,4
    defb 1,1
    defb 28,1
    defb 0,5
    defb 136,1
    defb 0,4
    defb 1,1
    defb 200,1
    defb 0,4
    defb 1,1
    defb 48,1
    defb 0,4
    defb 2,1
    defb 8,1
    defb 0,4
    defb 2,1
    defb 8,1
    defb 0,4
    defb 1,1
    defb 240,1
    defb 0,4
    defb 0,0
punchy_sprite_walk_forward_2_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_block:
    defb 2
    defb 2
    defb 0,38
    defb 32,1
    defb 0,4
    defb 31,1
    defb 199,1
    defb 192,1
    defb 0,3
    defb 31,1
    defb 232,1
    defb 160,1
    defb 0,3
    defb 56,1
    defb 40,1
    defb 160,1
    defb 0,3
    defb 49,1
    defb 168,1
    defb 160,1
    defb 0,3
    defb 48,1
    defb 20,1
    defb 160,1
    defb 0,3
    defb 32,1
    defb 20,1
    defb 160,1
    defb 0,3
    defb 32,1
    defb 36,1
    defb 160,1
    defb 0,3
    defb 16,1
    defb 228,1
    defb 160,1
    defb 0,3
    defb 17,1
    defb 8,1
    defb 160,1
    defb 0,3
    defb 127,1
    defb 240,1
    defb 160,1
    defb 0,3
    defb 128,1
    defb 0,1
    defb 160,1
    defb 0,2
    defb 1,1
    defb 0,1
    defb 1,1
    defb 64,1
    defb 0,2
    defb 1,1
    defb 0,1
    defb 1,1
    defb 64,1
    defb 0,2
    defb 1,1
    defb 0,1
    defb 2,1
    defb 128,1
    defb 0,3
    defb 135,1
    defb 255,1
    defb 0,4
    defb 120,1
    defb 64,1
    defb 0,4
    defb 32,1
    defb 64,1
    defb 0,4
    defb 32,1
    defb 64,1
    defb 0,4
    defb 16,1
    defb 64,1
    defb 0,4
    defb 16,1
    defb 64,1
    defb 0,4
    defb 16,1
    defb 64,1
    defb 0,4
    defb 31,1
    defb 192,1
    defb 0,4
    defb 31,1
    defb 192,1
    defb 0,4
    defb 63,1
    defb 192,1
    defb 0,4
    defb 127,1
    defb 192,1
    defb 0,4
    defb 127,1
    defb 192,1
    defb 0,4
    defb 127,1
    defb 96,1
    defb 0,4
    defb 127,1
    defb 160,1
    defb 0,4
    defb 127,1
    defb 224,1
    defb 0,4
    defb 63,1
    defb 224,1
    defb 0,4
    defb 31,1
    defb 224,1
    defb 0,4
    defb 63,1
    defb 224,1
    defb 0,4
    defb 127,1
    defb 192,1
    defb 0,4
    defb 255,1
    defb 192,1
    defb 0,3
    defb 3,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 4,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 4,1
    defb 127,1
    defb 128,1
    defb 0,3
    defb 2,1
    defb 50,1
    defb 96,1
    defb 0,3
    defb 1,1
    defb 20,1
    defb 16,1
    defb 0,4
    defb 148,1
    defb 16,1
    defb 0,4
    defb 99,1
    defb 224,1
    defb 0,3
    defb 0,0
punchy_sprite_block_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_hit:
    defb 3
    defb 2
    defb 0,38
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 0,4
    defb 16,1
    defb 3,1
    defb 0,4
    defb 32,1
    defb 0,1
    defb 128,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 128,1
    defb 0,3
    defb 66,1
    defb 0,1
    defb 64,1
    defb 0,3
    defb 65,1
    defb 84,1
    defb 64,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 64,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 64,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 128,1
    defb 0,3
    defb 35,1
    defb 4,1
    defb 128,1
    defb 0,3
    defb 35,1
    defb 4,1
    defb 128,1
    defb 0,3
    defb 35,1
    defb 4,1
    defb 128,1
    defb 0,3
    defb 39,1
    defb 252,1
    defb 128,1
    defb 0,3
    defb 39,1
    defb 252,1
    defb 128,1
    defb 0,3
    defb 39,1
    defb 252,1
    defb 128,1
    defb 0,3
    defb 39,1
    defb 250,1
    defb 128,1
    defb 0,3
    defb 35,1
    defb 253,1
    defb 128,1
    defb 0,3
    defb 35,1
    defb 254,1
    defb 128,1
    defb 0,3
    defb 35,1
    defb 255,1
    defb 0,4
    defb 31,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 63,1
    defb 223,1
    defb 192,1
    defb 0,3
    defb 55,1
    defb 143,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 192,1
    defb 0,3
    defb 36,1
    defb 1,1
    defb 48,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 60,1
    defb 1,1
    defb 240,1
    defb 0,2
    defb 0,0
punchy_sprite_hit_attr_bytes:
    defb 120,36
    defb 0,0

punchy_attack_1:
punchy_attack_1_starting_active_frame:
    defb 2
punchy_attack_1_ending_active_frame:
    defb 7
punchy_attack_1_total_frames:
    defb 10
punchy_sprite_attack_1_1:
    defb 3
    defb 2
    defb 0,37
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 0,4
    defb 16,1
    defb 3,1
    defb 1,1
    defb 192,1
    defb 0,2
    defb 32,1
    defb 0,1
    defb 206,1
    defb 32,1
    defb 0,2
    defb 32,1
    defb 0,1
    defb 49,1
    defb 32,1
    defb 0,2
    defb 66,1
    defb 0,2
    defb 160,1
    defb 0,2
    defb 65,1
    defb 86,1
    defb 3,1
    defb 192,1
    defb 0,2
    defb 65,1
    defb 5,1
    defb 140,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 112,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 0,4
    defb 35,1
    defb 14,1
    defb 0,4
    defb 48,1
    defb 241,1
    defb 0,4
    defb 24,1
    defb 1,1
    defb 0,4
    defb 15,1
    defb 249,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 7,1
    defb 252,1
    defb 0,4
    defb 7,1
    defb 250,1
    defb 0,4
    defb 15,1
    defb 253,1
    defb 0,4
    defb 13,1
    defb 254,1
    defb 128,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 0,4
    defb 27,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 63,1
    defb 223,1
    defb 192,1
    defb 0,3
    defb 55,1
    defb 143,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 192,1
    defb 0,3
    defb 36,1
    defb 1,1
    defb 48,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 60,1
    defb 1,1
    defb 240,1
    defb 0,3
    defb 0,0
punchy_sprite_attack_1_1_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_attack_1_2:
    defb 3
    defb 2
    defb 0,37
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 12,1
    defb 0,4
    defb 1,1
    defb 23,1
    defb 0,4
    defb 15,1
    defb 24,1
    defb 255,1
    defb 248,1
    defb 0,2
    defb 16,1
    defb 0,2
    defb 4,1
    defb 0,2
    defb 32,1
    defb 0,2
    defb 4,1
    defb 0,2
    defb 32,1
    defb 0,1
    defb 255,1
    defb 228,1
    defb 0,2
    defb 66,1
    defb 1,1
    defb 255,1
    defb 252,1
    defb 0,2
    defb 65,1
    defb 82,1
    defb 0,1
    defb 24,1
    defb 0,2
    defb 65,1
    defb 4,1
    defb 0,4
    defb 65,1
    defb 4,1
    defb 0,4
    defb 65,1
    defb 4,1
    defb 0,4
    defb 35,1
    defb 14,1
    defb 0,4
    defb 48,1
    defb 241,1
    defb 0,4
    defb 24,1
    defb 1,1
    defb 0,4
    defb 15,1
    defb 249,1
    defb 0,4
    defb 7,1
    defb 254,1
    defb 0,4
    defb 7,1
    defb 252,1
    defb 0,4
    defb 7,1
    defb 250,1
    defb 0,4
    defb 15,1
    defb 253,1
    defb 0,4
    defb 15,1
    defb 254,1
    defb 128,1
    defb 0,3
    defb 27,1
    defb 255,1
    defb 0,4
    defb 31,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 63,1
    defb 223,1
    defb 192,1
    defb 0,3
    defb 63,1
    defb 143,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 127,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 224,1
    defb 0,3
    defb 126,1
    defb 3,1
    defb 192,1
    defb 0,3
    defb 36,1
    defb 1,1
    defb 48,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 66,1
    defb 2,1
    defb 8,1
    defb 0,3
    defb 60,1
    defb 1,1
    defb 240,1
    defb 0,3
    defb 0,0
punchy_sprite_attack_1_2_attr_bytes:
    defb 120,36
    defb 0,0

punchy_attack_1_execute:
  or a
  jp nz,punchy_attack_2_execute_player_2

punchy_attack_1_execute_player_1:
  ld a,d
  add 2
  ld d,a
  ld a,e
  cp d
  jp c,punchy_attack_1_execute_hit
  jp punchy_attack_1_execute_miss
punchy_attack_1_execute_player_2:
  ld a,d
  sub 1
  ld d,a
  ld a,e
  cp d
  jp nc,punchy_attack_1_execute_hit
punchy_attack_1_execute_miss:
  ld a,0
  ret
punchy_attack_1_execute_hit:
  ld a,1
  ld b,0
  ld c,0
  ld d,2
  ld e,2
  ret

punchy_attack_2:
punchy_attack_2_starting_active_frame:
    defb 5
punchy_attack_2_ending_active_frame:
    defb 10
punchy_attack_2_total_frames:
    defb 15
punchy_sprite_attack_2_1:
    defb 3
    defb 2
    defb 0,25
    defb 2,1
    defb 0,4
    defb 1,1
    defb 252,1
    defb 0,4
    defb 1,1
    defb 254,1
    defb 0,4
    defb 3,1
    defb 130,1
    defb 0,4
    defb 3,1
    defb 26,1
    defb 0,4
    defb 3,1
    defb 1,1
    defb 0,4
    defb 2,1
    defb 1,1
    defb 0,4
    defb 2,2
    defb 0,4
    defb 1,1
    defb 14,1
    defb 0,4
    defb 1,1
    defb 16,1
    defb 0,4
    defb 15,1
    defb 28,1
    defb 12,1
    defb 0,3
    defb 16,1
    defb 3,1
    defb 18,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 146,1
    defb 0,3
    defb 32,1
    defb 0,1
    defb 106,1
    defb 0,3
    defb 66,1
    defb 0,1
    defb 68,1
    defb 0,3
    defb 65,1
    defb 84,1
    defb 8,1
    defb 0,3
    defb 65,1
    defb 6,1
    defb 16,1
    defb 0,3
    defb 65,1
    defb 7,1
    defb 224,1
    defb 0,3
    defb 65,1
    defb 4,1
    defb 0,4
    defb 35,1
    defb 4,1
    defb 0,4
    defb 34,1
    defb 4,1
    defb 0,4
    defb 34,1
    defb 4,1
    defb 0,4
    defb 38,1
    defb 4,1
    defb 0,4
    defb 38,1
    defb 7,1
    defb 254,1
    defb 0,3
    defb 38,1
    defb 63,1
    defb 253,1
    defb 0,3
    defb 39,1
    defb 255,1
    defb 254,1
    defb 128,1
    defb 0,2
    defb 35,1
    defb 255,2
    defb 128,1
    defb 0,2
    defb 35,1
    defb 255,2
    defb 128,1
    defb 0,2
    defb 35,1
    defb 255,2
    defb 128,1
    defb 0,2
    defb 31,1
    defb 252,1
    defb 31,1
    defb 128,1
    defb 0,2
    defb 2,1
    defb 248,1
    defb 15,1
    defb 128,1
    defb 0,2
    defb 3,1
    defb 248,1
    defb 15,1
    defb 0,3
    defb 3,1
    defb 248,1
    defb 4,1
    defb 192,1
    defb 0,2
    defb 3,1
    defb 248,1
    defb 8,1
    defb 32,1
    defb 0,2
    defb 3,1
    defb 240,1
    defb 8,1
    defb 32,1
    defb 0,2
    defb 3,1
    defb 240,1
    defb 7,1
    defb 192,1
    defb 0,2
    defb 3,1
    defb 240,1
    defb 0,4
    defb 3,1
    defb 240,1
    defb 0,4
    defb 3,1
    defb 240,1
    defb 0,4
    defb 3,1
    defb 240,1
    defb 0,4
    defb 1,1
    defb 32,1
    defb 0,4
    defb 2,1
    defb 16,1
    defb 0,4
    defb 2,1
    defb 16,1
    defb 0,4
    defb 1,1
    defb 224,1
    defb 0,4
    defb 0,0
punchy_sprite_attack_2_1_attr_bytes:
    defb 120,36
    defb 0,0


punchy_sprite_attack_2_2:
    defb 2
    defb 0
    defb 0,33
    defb 224,1
    defb 0,3
    defb 16,1
    defb 1,1
    defb 24,1
    defb 0,3
    defb 16,1
    defb 1,1
    defb 44,1
    defb 0,3
    defb 56,1
    defb 0,1
    defb 196,1
    defb 0,3
    defb 116,1
    defb 0,1
    defb 36,1
    defb 0,3
    defb 227,1
    defb 0,1
    defb 36,1
    defb 0,2
    defb 1,1
    defb 193,1
    defb 0,1
    defb 36,1
    defb 0,2
    defb 3,1
    defb 136,1
    defb 129,1
    defb 228,1
    defb 0,2
    defb 3,1
    defb 1,1
    defb 6,1
    defb 36,1
    defb 0,2
    defb 1,1
    defb 130,1
    defb 24,1
    defb 8,1
    defb 0,3
    defb 196,1
    defb 96,1
    defb 16,1
    defb 3,1
    defb 0,2
    defb 194,1
    defb 192,1
    defb 32,1
    defb 4,1
    defb 128,1
    defb 0,1
    defb 113,1
    defb 128,1
    defb 64,1
    defb 4,1
    defb 64,1
    defb 0,1
    defb 40,1
    defb 1,1
    defb 128,1
    defb 6,1
    defb 32,1
    defb 0,1
    defb 4,1
    defb 3,1
    defb 0,1
    defb 15,1
    defb 16,1
    defb 0,1
    defb 12,1
    defb 1,1
    defb 0,1
    defb 31,1
    defb 144,1
    defb 0,1
    defb 24,1
    defb 8,1
    defb 128,1
    defb 63,1
    defb 224,1
    defb 0,1
    defb 16,1
    defb 0,1
    defb 64,1
    defb 127,1
    defb 128,1
    defb 0,1
    defb 48,1
    defb 32,2
    defb 255,1
    defb 0,2
    defb 32,1
    defb 0,1
    defb 17,1
    defb 254,1
    defb 0,2
    defb 33,1
    defb 0,1
    defb 11,1
    defb 252,1
    defb 0,2
    defb 65,1
    defb 128,1
    defb 15,1
    defb 248,1
    defb 0,2
    defb 65,1
    defb 64,1
    defb 15,1
    defb 240,1
    defb 0,2
    defb 65,1
    defb 32,1
    defb 31,1
    defb 224,1
    defb 0,2
    defb 65,1
    defb 16,1
    defb 127,1
    defb 192,1
    defb 0,2
    defb 34,1
    defb 9,1
    defb 255,1
    defb 128,1
    defb 0,2
    defb 34,1
    defb 7,1
    defb 255,1
    defb 0,3
    defb 34,1
    defb 3,1
    defb 255,1
    defb 0,3
    defb 38,1
    defb 3,1
    defb 254,1
    defb 0,3
    defb 36,1
    defb 3,1
    defb 252,1
    defb 0,3
    defb 36,1
    defb 3,1
    defb 248,1
    defb 0,3
    defb 38,1
    defb 3,1
    defb 248,1
    defb 0,3
    defb 34,1
    defb 3,1
    defb 248,1
    defb 0,3
    defb 34,1
    defb 3,1
    defb 240,1
    defb 0,3
    defb 34,1
    defb 3,1
    defb 240,1
    defb 0,3
    defb 30,1
    defb 3,1
    defb 240,1
    defb 0,4
    defb 3,1
    defb 240,1
    defb 0,4
    defb 3,1
    defb 240,1
    defb 0,4
    defb 3,1
    defb 240,1
    defb 0,4
    defb 1,1
    defb 32,1
    defb 0,4
    defb 2,1
    defb 16,1
    defb 0,4
    defb 2,1
    defb 16,1
    defb 0,4
    defb 1,1
    defb 224,1
    defb 0,2
    defb 0,0
punchy_sprite_attack_2_2_attr_bytes:
    defb 120,36
    defb 0,0

punchy_attack_2_execute:
  or a
  jp nz,punchy_attack_2_execute_player_2

punchy_attack_2_execute_player_1:
  ld a,d
  add 2
  ld d,a
  ld a,e
  cp d
  jp c,punchy_attack_2_execute_hit
  jp punchy_attack_2_execute_miss
punchy_attack_2_execute_player_2:
  ld a,d
  sub 1
  ld d,a
  ld a,e
  cp d
  jp nc,punchy_attack_2_execute_hit
punchy_attack_2_execute_miss:
  ld a,0
  ret
punchy_attack_2_execute_hit:
  ld a,1
  ld b,1
  ld c,0
  ld d,3
  ld e,6
  ret

punchy_attack_3:
punchy_attack_3_starting_active_frame:
    defb 3
punchy_attack_3_ending_active_frame:
    defb 10
punchy_attack_3_total_frames:
    defb 13
punchy_sprite_attack_3_1:
    defb 3
    defb 2
    defb 0,38
    defb 8,1
    defb 0,4
    defb 7,1
    defb 240,1
    defb 0,4
    defb 7,1
    defb 248,1
    defb 0,4
    defb 14,1
    defb 8,1
    defb 0,4
    defb 12,1
    defb 104,1
    defb 0,4
    defb 12,1
    defb 4,1
    defb 0,4
    defb 8,1
    defb 4,1
    defb 0,4
    defb 8,2
    defb 0,4
    defb 4,1
    defb 56,1
    defb 0,4
    defb 4,1
    defb 64,1
    defb 0,3
    defb 48,1
    defb 124,2
    defb 0,3
    defb 72,1
    defb 128,1
    defb 7,1
    defb 0,3
    defb 73,1
    defb 0,1
    defb 8,1
    defb 128,1
    defb 0,2
    defb 86,1
    defb 0,1
    defb 9,1
    defb 128,1
    defb 0,2
    defb 34,1
    defb 16,1
    defb 14,1
    defb 128,1
    defb 0,2
    defb 16,1
    defb 50,1
    defb 72,1
    defb 128,1
    defb 0,2
    defb 8,1
    defb 112,1
    defb 8,1
    defb 128,1
    defb 0,2
    defb 7,1
    defb 208,1
    defb 8,1
    defb 128,1
    defb 0,3
    defb 16,1
    defb 13,1
    defb 0,4
    defb 16,1
    defb 10,1
    defb 0,4
    defb 16,1
    defb 8,1
    defb 0,4
    defb 16,1
    defb 120,1
    defb 0,4
    defb 31,1
    defb 248,1
    defb 0,4
    defb 31,1
    defb 255,1
    defb 128,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 31,1
    defb 255,1
    defb 224,1
    defb 0,3
    defb 23,1
    defb 255,1
    defb 224,1
    defb 0,3
    defb 31,1
    defb 243,1
    defb 224,1
    defb 0,3
    defb 31,1
    defb 193,1
    defb 240,1
    defb 0,3
    defb 31,1
    defb 129,1
    defb 200,1
    defb 0,3
    defb 31,1
    defb 129,1
    defb 8,1
    defb 0,3
    defb 31,1
    defb 129,1
    defb 48,1
    defb 0,3
    defb 31,1
    defb 128,1
    defb 192,1
    defb 0,3
    defb 31,1
    defb 128,1
    defb 0,4
    defb 31,1
    defb 128,1
    defb 0,4
    defb 31,1
    defb 128,1
    defb 0,4
    defb 9,1
    defb 0,5
    defb 16,1
    defb 128,1
    defb 0,4
    defb 16,1
    defb 128,1
    defb 0,4
    defb 15,1
    defb 0,4
    defb 0,0
punchy_sprite_attack_3_1_attr_bytes:
    defb 120,36
    defb 0,0

punchy_sprite_attack_3_2:
    defb 3
    defb 0
    defb 0,38
    defb 32,1
    defb 0,4
    defb 31,1
    defb 192,1
    defb 0,4
    defb 31,1
    defb 224,1
    defb 0,4
    defb 56,1
    defb 32,1
    defb 0,4
    defb 49,1
    defb 160,1
    defb 0,4
    defb 48,1
    defb 16,1
    defb 0,4
    defb 32,1
    defb 16,1
    defb 0,4
    defb 32,2
    defb 0,4
    defb 16,1
    defb 236,1
    defb 0,4
    defb 17,1
    defb 18,1
    defb 0,4
    defb 127,1
    defb 255,3
    defb 128,1
    defb 0,1
    defb 128,1
    defb 0,3
    defb 64,1
    defb 1,1
    defb 0,4
    defb 32,1
    defb 1,1
    defb 0,2
    defb 255,1
    defb 0,1
    defb 32,1
    defb 1,1
    defb 0,1
    defb 63,1
    defb 1,1
    defb 224,1
    defb 32,1
    defb 0,1
    defb 135,1
    defb 200,1
    defb 0,1
    defb 252,1
    defb 32,1
    defb 0,1
    defb 120,1
    defb 80,1
    defb 0,1
    defb 63,1
    defb 32,1
    defb 0,1
    defb 32,1
    defb 96,1
    defb 0,1
    defb 15,1
    defb 192,1
    defb 0,1
    defb 32,1
    defb 64,1
    defb 0,1
    defb 6,1
    defb 0,2
    defb 16,1
    defb 64,1
    defb 0,4
    defb 16,1
    defb 64,1
    defb 0,4
    defb 16,1
    defb 64,1
    defb 0,4
    defb 31,1
    defb 192,1
    defb 0,4
    defb 31,1
    defb 192,1
    defb 0,4
    defb 63,1
    defb 192,1
    defb 0,4
    defb 127,1
    defb 192,1
    defb 0,4
    defb 127,1
    defb 192,1
    defb 0,4
    defb 127,1
    defb 96,1
    defb 0,4
    defb 127,1
    defb 160,1
    defb 0,4
    defb 63,1
    defb 224,1
    defb 0,4
    defb 31,1
    defb 224,1
    defb 0,4
    defb 31,1
    defb 224,1
    defb 0,4
    defb 63,1
    defb 224,1
    defb 0,4
    defb 127,1
    defb 192,1
    defb 0,4
    defb 255,1
    defb 192,1
    defb 0,3
    defb 3,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 4,1
    defb 255,1
    defb 192,1
    defb 0,3
    defb 4,1
    defb 127,1
    defb 128,1
    defb 0,3
    defb 2,1
    defb 50,1
    defb 96,1
    defb 0,3
    defb 1,1
    defb 20,1
    defb 16,1
    defb 0,4
    defb 148,1
    defb 16,1
    defb 0,4
    defb 99,1
    defb 224,1
    defb 0,3
    defb 0,0
punchy_sprite_attack_3_2_attr_bytes:
    defb 120,36
    defb 0,0

punchy_attack_3_execute:
  or a
  jp nz,punchy_attack_3_execute_player_2

punchy_attack_3_execute_player_1:
  ld a,d
  add 2
  ld d,a
  ld a,e
  cp d
  jp c,punchy_attack_3_execute_hit
  jp punchy_attack_3_execute_miss
punchy_attack_3_execute_player_2:
  ld a,d
  sub 2
  ld d,a
  ld a,e
  cp d
  jp nc,punchy_attack_3_execute_hit
punchy_attack_3_execute_miss:
  ld a,0
  ret
punchy_attack_3_execute_hit:
  ld a,1
  ld b,4
  ld c,1
  ld d,4
  ld e,15
  ret