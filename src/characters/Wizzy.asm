wizzy_data:
wizzy_name:
  defb '  Wizzy   '
wizzy_init:
  ld bc,wizzy_name
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_idle_1
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_idle_2
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_walk_forward_1
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_walk_forward_2
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_block
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_hit
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld a,(wizzy_attack_1_starting_active_frame)
  ld (hl),a
  inc hl
  ld a,(wizzy_attack_1_ending_active_frame)
  ld (hl),a
  inc hl
  ld a,(wizzy_attack_1_total_frames)
  ld (hl),a
  inc hl
  ld bc,wizzy_sprite_attack_1_1
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_attack_1_2
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  inc hl
  ld bc,wizzy_attack_1_execute
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld a,(wizzy_attack_2_starting_active_frame)
  ld (hl),a
  inc hl
  ld a,(wizzy_attack_2_ending_active_frame)
  ld (hl),a
  inc hl
  ld a,(wizzy_attack_2_total_frames)
  ld (hl),a
  inc hl
  ld bc,wizzy_sprite_attack_2_1
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_attack_2_2
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  inc hl
  ld bc,wizzy_attack_2_execute
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld a,(wizzy_attack_3_starting_active_frame)
  ld (hl),a
  inc hl
  ld a,(wizzy_attack_3_ending_active_frame)
  ld (hl),a
  inc hl
  ld a,(wizzy_attack_3_total_frames)
  ld (hl),a
  inc hl
  ld bc,wizzy_sprite_attack_3_1
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ld bc,wizzy_sprite_attack_3_2
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  inc hl
  ld bc,wizzy_attack_3_execute
  ld (hl),c
  inc hl
  ld (hl),b
  inc hl
  ret
wizzy_flip:
  ld ix,wizzy_sprite_idle_1
  call flip_sprite_init
  ld ix,wizzy_sprite_idle_2
  call flip_sprite_init
  ld ix,wizzy_sprite_walk_forward_1
  call flip_sprite_init
  ld ix,wizzy_sprite_walk_forward_2
  call flip_sprite_init
  ld ix,wizzy_sprite_block
  call flip_sprite_init
  ld ix,wizzy_sprite_hit
  call flip_sprite_init
  ld ix,wizzy_sprite_attack_1_1
  call flip_sprite_init
  ld ix,wizzy_sprite_attack_1_2
  call flip_sprite_init
  ld ix,wizzy_sprite_attack_2_1
  call flip_sprite_init
  ld ix,wizzy_sprite_attack_2_2
  call flip_sprite_init
  ld ix,wizzy_sprite_attack_3_1
  call flip_sprite_init
  ld ix,wizzy_sprite_attack_3_2
  call flip_sprite_init
  ret
wizzy_sprites:
wizzy_sprite_idle_1:
  defb 2
  defb 2
  defb 0,38
  defb 16,1
  defb 0,5
  defb 40,1
  defb 0,5
  defb 16,1
  defb 0,4
  defb 192,1
  defb 0,4
  defb 3,1
  defb 254,1
  defb 0,4
  defb 7,1
  defb 225,1
  defb 128,1
  defb 16,1
  defb 0,2
  defb 15,1
  defb 192,1
  defb 64,1
  defb 40,1
  defb 0,2
  defb 14,1
  defb 224,1
  defb 64,1
  defb 16,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 32,1
  defb 0,3
  defb 16,1
  defb 60,1
  defb 16,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 32,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 80,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 32,1
  defb 0,3
  defb 32,2
  defb 0,4
  defb 36,1
  defb 160,1
  defb 1,1
  defb 0,3
  defb 32,2
  defb 3,1
  defb 0,2
  defb 8,1
  defb 51,1
  defb 96,1
  defb 6,1
  defb 0,2
  defb 20,1
  defb 16,1
  defb 64,1
  defb 12,1
  defb 0,2
  defb 8,1
  defb 31,1
  defb 192,1
  defb 24,1
  defb 0,2
  defb 32,1
  defb 120,1
  defb 96,1
  defb 240,1
  defb 0,2
  defb 80,1
  defb 113,1
  defb 25,1
  defb 32,1
  defb 0,2
  defb 32,1
  defb 226,1
  defb 142,1
  defb 32,1
  defb 0,3
  defb 193,1
  defb 0,1
  defb 64,1
  defb 0,3
  defb 192,1
  defb 32,1
  defb 128,1
  defb 0,3
  defb 222,1
  defb 63,1
  defb 0,4
  defb 193,1
  defb 32,1
  defb 0,4
  defb 194,1
  defb 32,1
  defb 4,1
  defb 0,3
  defb 126,1
  defb 32,1
  defb 74,1
  defb 0,3
  defb 96,1
  defb 32,1
  defb 164,1
  defb 0,2
  defb 64,1
  defb 224,1
  defb 56,1
  defb 64,1
  defb 0,2
  defb 160,1
  defb 192,1
  defb 8,1
  defb 0,3
  defb 65,1
  defb 128,1
  defb 12,1
  defb 0,3
  defb 3,1
  defb 128,1
  defb 2,1
  defb 8,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 20,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 8,1
  defb 0,2
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 144,1
  defb 0,4
  defb 120,1
  defb 240,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 98,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_idle_1_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_idle_2:
  defb 2
  defb 1
  defb 0,31
  defb 8,1
  defb 0,4
  defb 8,1
  defb 20,1
  defb 0,4
  defb 20,1
  defb 8,1
  defb 0,4
  defb 8,1
  defb 0,1
  defb 4,1
  defb 0,5
  defb 10,1
  defb 0,4
  defb 192,1
  defb 4,1
  defb 0,3
  defb 3,1
  defb 254,1
  defb 0,4
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 16,1
  defb 0,2
  defb 14,1
  defb 224,1
  defb 64,1
  defb 40,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 32,1
  defb 16,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 16,1
  defb 0,1
  defb 64,1
  defb 0,2
  defb 127,1
  defb 248,1
  defb 0,1
  defb 160,1
  defb 0,2
  defb 127,1
  defb 248,1
  defb 0,1
  defb 64,1
  defb 0,2
  defb 127,1
  defb 248,1
  defb 32,1
  defb 0,3
  defb 32,2
  defb 82,1
  defb 0,3
  defb 36,1
  defb 160,1
  defb 38,1
  defb 0,3
  defb 32,2
  defb 12,1
  defb 0,3
  defb 51,1
  defb 96,1
  defb 24,1
  defb 0,3
  defb 16,1
  defb 64,1
  defb 48,1
  defb 0,3
  defb 31,1
  defb 192,1
  defb 224,1
  defb 0,3
  defb 120,1
  defb 97,1
  defb 96,1
  defb 0,3
  defb 113,1
  defb 26,1
  defb 64,1
  defb 0,3
  defb 226,1
  defb 140,1
  defb 64,1
  defb 0,3
  defb 193,1
  defb 0,1
  defb 128,1
  defb 0,2
  defb 2,1
  defb 192,1
  defb 33,1
  defb 0,3
  defb 5,1
  defb 222,1
  defb 62,1
  defb 0,3
  defb 34,1
  defb 193,1
  defb 32,1
  defb 8,1
  defb 0,2
  defb 80,1
  defb 194,1
  defb 32,1
  defb 20,1
  defb 0,2
  defb 32,1
  defb 126,1
  defb 32,1
  defb 8,1
  defb 0,3
  defb 64,1
  defb 48,1
  defb 64,1
  defb 0,3
  defb 192,1
  defb 8,1
  defb 160,1
  defb 0,2
  defb 1,1
  defb 128,1
  defb 12,1
  defb 64,1
  defb 0,2
  defb 3,1
  defb 128,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 144,1
  defb 0,4
  defb 120,1
  defb 240,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 98,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_idle_2_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_walk_forward_1:
  defb 2
  defb 2
  defb 0,45
  defb 16,1
  defb 0,4
  defb 2,1
  defb 40,1
  defb 0,3
  defb 192,1
  defb 5,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 254,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 64,1
  defb 32,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 32,1
  defb 80,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 16,1
  defb 32,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 32,2
  defb 0,4
  defb 36,1
  defb 161,1
  defb 1,1
  defb 0,2
  defb 16,1
  defb 32,1
  defb 34,1
  defb 131,1
  defb 0,2
  defb 40,1
  defb 51,1
  defb 97,1
  defb 6,1
  defb 0,2
  defb 16,2
  defb 64,1
  defb 12,1
  defb 0,3
  defb 31,1
  defb 192,1
  defb 24,1
  defb 0,3
  defb 120,1
  defb 96,1
  defb 240,1
  defb 0,3
  defb 113,1
  defb 25,1
  defb 32,1
  defb 0,3
  defb 226,1
  defb 142,1
  defb 32,1
  defb 0,2
  defb 32,1
  defb 193,1
  defb 0,1
  defb 64,1
  defb 0,2
  defb 80,1
  defb 192,1
  defb 32,1
  defb 128,1
  defb 0,2
  defb 32,1
  defb 222,1
  defb 63,1
  defb 0,4
  defb 193,1
  defb 32,1
  defb 0,4
  defb 194,1
  defb 32,1
  defb 0,4
  defb 126,1
  defb 32,1
  defb 0,3
  defb 16,1
  defb 96,1
  defb 32,1
  defb 0,3
  defb 40,1
  defb 224,1
  defb 56,1
  defb 0,3
  defb 16,1
  defb 192,1
  defb 8,1
  defb 0,3
  defb 1,1
  defb 128,1
  defb 12,1
  defb 0,3
  defb 3,1
  defb 128,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 240,1
  defb 0,4
  defb 120,1
  defb 98,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 0,4
  defb 0,0
wizzy_sprite_walk_forward_1_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_walk_forward_2:
  defb 2
  defb 2
  defb 0,33
  defb 16,1
  defb 0,5
  defb 40,1
  defb 0,5
  defb 16,1
  defb 0,4
  defb 8,1
  defb 0,4
  defb 192,1
  defb 20,1
  defb 0,3
  defb 3,1
  defb 254,1
  defb 8,1
  defb 0,3
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 64,1
  defb 0,3
  defb 40,1
  defb 240,1
  defb 32,1
  defb 0,3
  defb 16,1
  defb 60,1
  defb 16,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 8,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 20,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 8,1
  defb 0,3
  defb 32,2
  defb 0,4
  defb 36,1
  defb 160,1
  defb 1,1
  defb 0,3
  defb 32,2
  defb 3,1
  defb 0,2
  defb 4,1
  defb 51,1
  defb 96,1
  defb 6,1
  defb 0,2
  defb 10,1
  defb 16,1
  defb 64,1
  defb 12,1
  defb 0,2
  defb 4,1
  defb 31,1
  defb 192,1
  defb 24,1
  defb 0,3
  defb 120,1
  defb 96,1
  defb 240,1
  defb 0,3
  defb 113,1
  defb 25,1
  defb 32,1
  defb 0,3
  defb 226,1
  defb 142,1
  defb 32,1
  defb 0,3
  defb 193,1
  defb 0,1
  defb 64,1
  defb 0,3
  defb 192,1
  defb 32,1
  defb 128,1
  defb 0,3
  defb 222,1
  defb 63,1
  defb 0,3
  defb 16,1
  defb 193,1
  defb 32,1
  defb 0,3
  defb 40,1
  defb 194,1
  defb 32,1
  defb 64,1
  defb 0,2
  defb 16,1
  defb 126,1
  defb 32,1
  defb 160,1
  defb 0,3
  defb 96,1
  defb 32,1
  defb 64,1
  defb 0,3
  defb 224,1
  defb 56,1
  defb 0,4
  defb 192,1
  defb 8,1
  defb 0,3
  defb 1,1
  defb 128,1
  defb 12,1
  defb 0,3
  defb 3,1
  defb 128,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 133,1
  defb 8,1
  defb 0,4
  defb 120,1
  defb 144,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 240,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 98,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,5
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_walk_forward_2_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_block:
  defb 2
  defb 1
  defb 0,45
  defb 17,1
  defb 0,5
  defb 42,1
  defb 128,1
  defb 0,2
  defb 192,1
  defb 0,1
  defb 17,1
  defb 0,2
  defb 3,1
  defb 254,1
  defb 2,1
  defb 40,1
  defb 0,2
  defb 7,1
  defb 225,1
  defb 130,1
  defb 16,1
  defb 0,2
  defb 15,1
  defb 192,1
  defb 66,1
  defb 40,1
  defb 0,2
  defb 14,1
  defb 224,1
  defb 66,1
  defb 16,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 34,1
  defb 40,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 18,1
  defb 16,1
  defb 64,1
  defb 0,2
  defb 127,1
  defb 250,1
  defb 40,1
  defb 160,1
  defb 0,2
  defb 127,1
  defb 250,1
  defb 16,1
  defb 64,1
  defb 0,2
  defb 127,1
  defb 250,1
  defb 40,1
  defb 0,3
  defb 32,1
  defb 34,1
  defb 16,1
  defb 0,3
  defb 36,1
  defb 167,1
  defb 41,1
  defb 0,3
  defb 32,1
  defb 41,1
  defb 18,1
  defb 128,1
  defb 0,2
  defb 51,1
  defb 97,1
  defb 41,1
  defb 0,3
  defb 16,1
  defb 73,1
  defb 16,1
  defb 0,3
  defb 31,1
  defb 209,1
  defb 40,1
  defb 0,3
  defb 120,1
  defb 97,1
  defb 16,1
  defb 0,3
  defb 113,1
  defb 2,1
  defb 41,1
  defb 0,3
  defb 226,1
  defb 140,1
  defb 18,1
  defb 128,1
  defb 0,2
  defb 193,1
  defb 8,1
  defb 41,1
  defb 0,3
  defb 192,1
  defb 50,1
  defb 16,1
  defb 0,3
  defb 222,1
  defb 32,1
  defb 40,1
  defb 0,3
  defb 193,1
  defb 32,1
  defb 16,1
  defb 0,3
  defb 194,1
  defb 32,1
  defb 40,1
  defb 128,1
  defb 0,2
  defb 126,1
  defb 32,1
  defb 17,1
  defb 64,1
  defb 0,2
  defb 96,1
  defb 32,1
  defb 40,1
  defb 128,1
  defb 0,2
  defb 224,1
  defb 56,1
  defb 16,1
  defb 0,3
  defb 192,1
  defb 8,1
  defb 40,1
  defb 0,2
  defb 1,1
  defb 128,1
  defb 12,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 128,1
  defb 2,1
  defb 40,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 16,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 240,1
  defb 0,4
  defb 120,1
  defb 98,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 0,4
  defb 0,0
wizzy_sprite_block_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_hit:
  defb 3
  defb 2
  defb 0,43
  defb 192,1
  defb 0,4
  defb 3,1
  defb 254,1
  defb 0,4
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 64,1
  defb 0,3
  defb 40,1
  defb 240,1
  defb 32,1
  defb 0,3
  defb 16,1
  defb 60,1
  defb 16,1
  defb 0,3
  defb 16,1
  defb 127,1
  defb 248,1
  defb 0,3
  defb 16,1
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,10
  defb 63,1
  defb 224,1
  defb 0,4
  defb 32,2
  defb 0,4
  defb 45,1
  defb 160,1
  defb 0,4
  defb 40,1
  defb 160,1
  defb 0,4
  defb 55,1
  defb 96,1
  defb 0,4
  defb 21,1
  defb 64,1
  defb 0,4
  defb 31,1
  defb 192,1
  defb 0,4
  defb 120,1
  defb 112,1
  defb 0,4
  defb 113,1
  defb 8,1
  defb 0,4
  defb 98,1
  defb 136,1
  defb 0,4
  defb 73,1
  defb 72,1
  defb 0,4
  defb 72,2
  defb 0,4
  defb 72,2
  defb 0,4
  defb 72,2
  defb 0,4
  defb 72,1
  defb 216,1
  defb 0,4
  defb 73,1
  defb 144,1
  defb 0,4
  defb 73,1
  defb 48,1
  defb 0,4
  defb 201,1
  defb 120,1
  defb 0,4
  defb 251,1
  defb 200,1
  defb 0,3
  defb 1,1
  defb 134,1
  defb 12,1
  defb 0,3
  defb 3,1
  defb 132,1
  defb 2,1
  defb 12,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 6,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 3,1
  defb 0,2
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 144,1
  defb 0,4
  defb 120,1
  defb 240,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 98,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_hit_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_attack_1:
wizzy_attack_1_starting_active_frame:
  defb 6
wizzy_attack_1_ending_active_frame:
  defb 12
wizzy_attack_1_total_frames:
  defb 13
wizzy_sprite_attack_1_1:
  defb 3
  defb 1
  defb 0,45
  defb 16,1
  defb 0,4
  defb 2,1
  defb 40,1
  defb 0,3
  defb 192,1
  defb 5,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 254,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 64,1
  defb 32,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 32,1
  defb 80,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 16,1
  defb 32,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 16,1
  defb 32,1
  defb 0,4
  defb 18,1
  defb 97,1
  defb 0,3
  defb 16,2
  defb 34,1
  defb 128,1
  defb 0,2
  defb 40,1
  defb 16,1
  defb 225,1
  defb 0,3
  defb 16,2
  defb 64,1
  defb 0,4
  defb 31,1
  defb 192,1
  defb 0,4
  defb 120,1
  defb 96,1
  defb 2,1
  defb 0,3
  defb 113,1
  defb 32,1
  defb 5,1
  defb 0,3
  defb 226,1
  defb 32,1
  defb 2,1
  defb 64,1
  defb 0,1
  defb 32,1
  defb 193,1
  defb 16,1
  defb 0,1
  defb 160,1
  defb 0,1
  defb 80,1
  defb 192,1
  defb 28,1
  defb 0,1
  defb 64,1
  defb 0,1
  defb 32,1
  defb 222,1
  defb 47,1
  defb 252,1
  defb 0,3
  defb 193,1
  defb 44,1
  defb 0,1
  defb 128,1
  defb 0,2
  defb 194,1
  defb 56,1
  defb 1,1
  defb 64,1
  defb 0,2
  defb 126,1
  defb 32,1
  defb 0,1
  defb 128,1
  defb 0,1
  defb 16,1
  defb 112,1
  defb 32,1
  defb 0,3
  defb 40,1
  defb 240,1
  defb 56,1
  defb 0,3
  defb 16,1
  defb 224,1
  defb 8,1
  defb 0,3
  defb 1,1
  defb 192,1
  defb 12,1
  defb 0,3
  defb 3,1
  defb 192,1
  defb 4,1
  defb 0,3
  defb 7,1
  defb 128,1
  defb 4,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 4,1
  defb 0,3
  defb 7,1
  defb 255,1
  defb 252,1
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 240,1
  defb 0,4
  defb 120,1
  defb 98,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 0,4
  defb 0,0
wizzy_sprite_attack_1_1_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_attack_1_2:
  defb 3
  defb 0
  defb 0,45
  defb 16,1
  defb 0,4
  defb 2,1
  defb 40,1
  defb 0,3
  defb 192,1
  defb 5,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 254,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 64,1
  defb 32,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 32,1
  defb 80,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 16,1
  defb 32,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 32,2
  defb 0,4
  defb 36,1
  defb 161,1
  defb 0,3
  defb 16,1
  defb 32,1
  defb 34,1
  defb 128,1
  defb 0,2
  defb 40,1
  defb 51,1
  defb 97,1
  defb 0,3
  defb 16,2
  defb 64,1
  defb 0,4
  defb 31,1
  defb 192,1
  defb 0,4
  defb 120,1
  defb 96,1
  defb 0,4
  defb 113,1
  defb 56,1
  defb 0,2
  defb 32,1
  defb 0,1
  defb 226,1
  defb 39,1
  defb 8,1
  defb 0,1
  defb 80,1
  defb 32,1
  defb 193,1
  defb 24,1
  defb 252,1
  defb 0,1
  defb 36,1
  defb 80,1
  defb 192,1
  defb 16,1
  defb 15,1
  defb 255,1
  defb 250,1
  defb 32,1
  defb 222,1
  defb 63,1
  defb 236,1
  defb 0,1
  defb 36,1
  defb 0,1
  defb 193,1
  defb 63,1
  defb 248,1
  defb 0,1
  defb 80,1
  defb 0,1
  defb 194,1
  defb 48,1
  defb 0,2
  defb 32,1
  defb 0,1
  defb 126,1
  defb 32,1
  defb 0,3
  defb 16,1
  defb 112,1
  defb 32,1
  defb 0,3
  defb 40,1
  defb 240,1
  defb 56,1
  defb 0,3
  defb 16,1
  defb 224,1
  defb 8,1
  defb 0,3
  defb 1,1
  defb 192,1
  defb 12,1
  defb 0,3
  defb 3,1
  defb 192,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 128,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 144,1
  defb 0,4
  defb 120,1
  defb 240,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 98,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_attack_1_2_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_attack_1_execute:
  or a
  jp nz,wizzy_attack_1_execute_player_2

wizzy_attack_1_execute_player_1:
  ld a,d
  add 3
  ld d,a
  ld a,e
  cp d
  jp nc,wizzy_attack_1_execute_hit
  jp wizzy_attack_1_execute_miss
wizzy_attack_1_execute_player_2:
  ld a,d
  sub 2
  ld d,a
  ld a,e
  cp d
  jp nc,wizzy_attack_1_execute_hit
wizzy_attack_1_execute_miss:
  ld a,0
  ret
wizzy_attack_1_execute_hit:
  call high_pitch_sound
  ld a,1
  ld b,0
  ld c,0
  ld d,1
  ld e,3
  ret
wizzy_attack_2:
wizzy_attack_2_starting_active_frame:
  defb 8
wizzy_attack_2_ending_active_frame:
  defb 18
wizzy_attack_2_total_frames:
  defb 20
wizzy_sprite_attack_2_1:
  defb 3
  defb 2
  defb 0,45
  defb 16,1
  defb 0,4
  defb 2,1
  defb 40,1
  defb 0,3
  defb 192,1
  defb 5,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 254,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 64,1
  defb 32,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 32,1
  defb 80,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 16,1
  defb 32,1
  defb 0,3
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 127,1
  defb 248,1
  defb 0,4
  defb 32,2
  defb 0,4
  defb 36,1
  defb 161,1
  defb 0,3
  defb 16,1
  defb 32,1
  defb 34,1
  defb 128,1
  defb 0,2
  defb 40,1
  defb 51,1
  defb 97,1
  defb 0,3
  defb 16,2
  defb 64,1
  defb 0,4
  defb 31,1
  defb 192,1
  defb 0,4
  defb 120,1
  defb 96,1
  defb 0,4
  defb 113,1
  defb 28,1
  defb 0,4
  defb 226,1
  defb 132,1
  defb 0,3
  defb 32,1
  defb 193,1
  defb 6,1
  defb 0,3
  defb 80,1
  defb 192,1
  defb 35,1
  defb 128,1
  defb 0,2
  defb 32,1
  defb 222,1
  defb 56,1
  defb 192,1
  defb 0,3
  defb 193,1
  defb 38,1
  defb 96,1
  defb 0,3
  defb 194,1
  defb 35,1
  defb 32,1
  defb 0,3
  defb 126,1
  defb 32,1
  defb 240,1
  defb 0,2
  defb 16,1
  defb 96,1
  defb 32,1
  defb 48,1
  defb 0,2
  defb 40,1
  defb 224,1
  defb 56,1
  defb 24,1
  defb 0,2
  defb 16,1
  defb 192,1
  defb 8,1
  defb 12,1
  defb 0,2
  defb 1,1
  defb 128,1
  defb 12,1
  defb 6,1
  defb 0,2
  defb 3,1
  defb 128,1
  defb 2,1
  defb 3,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 144,1
  defb 0,4
  defb 120,1
  defb 240,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 98,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_attack_2_1_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_attack_2_2:
  defb 3
  defb 0
  defb 0,19
  defb 1,1
  defb 0,4
  defb 8,1
  defb 2,1
  defb 128,1
  defb 0,3
  defb 20,1
  defb 1,1
  defb 0,4
  defb 8,1
  defb 0,4
  defb 2,1
  defb 0,3
  defb 16,1
  defb 0,1
  defb 5,1
  defb 0,2
  defb 2,1
  defb 40,1
  defb 0,1
  defb 26,1
  defb 0,1
  defb 192,1
  defb 5,1
  defb 16,1
  defb 0,1
  defb 48,1
  defb 3,1
  defb 254,1
  defb 2,1
  defb 0,2
  defb 32,1
  defb 7,1
  defb 225,1
  defb 128,1
  defb 0,2
  defb 64,1
  defb 15,1
  defb 192,1
  defb 64,1
  defb 0,2
  defb 194,1
  defb 14,1
  defb 224,1
  defb 64,1
  defb 32,1
  defb 3,1
  defb 5,1
  defb 40,1
  defb 240,1
  defb 32,1
  defb 80,1
  defb 6,1
  defb 10,1
  defb 16,1
  defb 60,1
  defb 16,1
  defb 32,1
  defb 12,1
  defb 24,1
  defb 0,1
  defb 127,1
  defb 248,1
  defb 0,1
  defb 8,1
  defb 112,1
  defb 0,1
  defb 127,1
  defb 248,1
  defb 0,1
  defb 24,1
  defb 32,1
  defb 0,1
  defb 127,1
  defb 248,1
  defb 0,1
  defb 48,1
  defb 96,1
  defb 0,1
  defb 32,2
  defb 0,1
  defb 32,1
  defb 64,1
  defb 0,1
  defb 36,1
  defb 161,1
  defb 0,1
  defb 192,1
  defb 194,1
  defb 16,1
  defb 32,1
  defb 34,1
  defb 129,2
  defb 133,1
  defb 40,1
  defb 51,1
  defb 97,1
  defb 1,1
  defb 3,1
  defb 14,1
  defb 16,2
  defb 64,1
  defb 3,1
  defb 2,1
  defb 8,1
  defb 0,1
  defb 31,1
  defb 192,1
  defb 6,1
  defb 4,1
  defb 16,1
  defb 0,1
  defb 120,1
  defb 96,1
  defb 12,2
  defb 48,1
  defb 0,1
  defb 113,1
  defb 28,1
  defb 24,2
  defb 192,1
  defb 0,1
  defb 226,1
  defb 132,1
  defb 32,1
  defb 49,1
  defb 0,1
  defb 32,1
  defb 193,1
  defb 4,1
  defb 97,1
  defb 206,1
  defb 0,1
  defb 80,1
  defb 192,1
  defb 36,1
  defb 67,1
  defb 80,1
  defb 2,1
  defb 32,1
  defb 222,1
  defb 100,1
  defb 221,1
  defb 224,1
  defb 253,1
  defb 0,1
  defb 193,1
  defb 68,1
  defb 99,1
  defb 63,1
  defb 130,1
  defb 0,1
  defb 194,1
  defb 132,1
  defb 252,1
  defb 0,3
  defb 127,1
  defb 140,1
  defb 211,1
  defb 128,1
  defb 0,1
  defb 16,1
  defb 99,1
  defb 48,1
  defb 128,1
  defb 112,1
  defb 0,1
  defb 40,1
  defb 226,1
  defb 56,1
  defb 240,1
  defb 24,1
  defb 0,1
  defb 16,1
  defb 199,1
  defb 104,1
  defb 63,1
  defb 7,1
  defb 194,1
  defb 1,1
  defb 141,1
  defb 140,1
  defb 17,1
  defb 192,1
  defb 125,1
  defb 3,1
  defb 152,1
  defb 2,1
  defb 24,1
  defb 120,1
  defb 2,1
  defb 7,1
  defb 48,1
  defb 1,1
  defb 14,2
  defb 0,1
  defb 7,1
  defb 32,1
  defb 1,1
  defb 3,1
  defb 129,1
  defb 128,1
  defb 7,1
  defb 255,2
  defb 0,1
  defb 96,1
  defb 224,1
  defb 0,1
  defb 197,1
  defb 8,1
  defb 0,1
  defb 56,1
  defb 52,1
  defb 0,1
  defb 104,1
  defb 144,1
  defb 0,1
  defb 6,1
  defb 26,1
  defb 0,1
  defb 120,1
  defb 240,1
  defb 0,1
  defb 3,1
  defb 4,1
  defb 2,1
  defb 48,1
  defb 98,1
  defb 0,2
  defb 200,1
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,2
  defb 116,1
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,2
  defb 8,1
  defb 0,0
wizzy_sprite_attack_2_2_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_attack_2_execute:
  or a
  jp nz,wizzy_attack_2_execute_player_2

wizzy_attack_2_execute_player_1:
  ld a,d
  add 3
  ld d,a
  ld a,e
  cp d
  jp nc,wizzy_attack_2_execute_hit
  jp wizzy_attack_2_execute_miss
wizzy_attack_2_execute_player_2:
  ld a,d
  sub 2
  ld d,a
  ld a,e
  cp d
  jp nc,wizzy_attack_2_execute_hit
wizzy_attack_2_execute_miss:
  ld a,0
  ret
wizzy_attack_2_execute_hit:
  call taser_sound
  ld a,1
  ld b,0
  ld c,1
  ld d,2
  ld e,5
  ret
wizzy_attack_3:
wizzy_attack_3_starting_active_frame:
  defb 3
wizzy_attack_3_ending_active_frame:
  defb 8
wizzy_attack_3_total_frames:
  defb 20
wizzy_sprite_attack_3_1:
  defb 3
  defb 2
  defb 0,30
  defb 16,1
  defb 0,1
  defb 16,1
  defb 0,3
  defb 40,1
  defb 0,1
  defb 40,1
  defb 0,3
  defb 16,1
  defb 0,1
  defb 16,2
  defb 0,5
  defb 40,1
  defb 0,3
  defb 192,1
  defb 0,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 254,1
  defb 2,1
  defb 0,3
  defb 7,1
  defb 225,1
  defb 130,1
  defb 0,3
  defb 15,1
  defb 192,1
  defb 66,1
  defb 0,3
  defb 14,1
  defb 224,1
  defb 66,1
  defb 32,1
  defb 0,2
  defb 40,1
  defb 240,1
  defb 34,1
  defb 80,1
  defb 0,2
  defb 16,1
  defb 60,1
  defb 18,1
  defb 32,1
  defb 0,3
  defb 127,1
  defb 250,1
  defb 0,4
  defb 127,1
  defb 250,1
  defb 0,4
  defb 127,1
  defb 250,1
  defb 0,4
  defb 32,1
  defb 34,1
  defb 0,4
  defb 36,1
  defb 167,1
  defb 0,3
  defb 16,1
  defb 32,1
  defb 41,1
  defb 16,1
  defb 0,2
  defb 40,1
  defb 51,1
  defb 97,1
  defb 40,1
  defb 0,2
  defb 16,2
  defb 73,1
  defb 16,1
  defb 0,3
  defb 31,1
  defb 209,1
  defb 0,4
  defb 120,1
  defb 97,1
  defb 0,4
  defb 113,1
  defb 2,1
  defb 0,4
  defb 226,1
  defb 140,1
  defb 0,3
  defb 32,1
  defb 193,1
  defb 8,1
  defb 0,3
  defb 80,1
  defb 192,1
  defb 48,1
  defb 0,3
  defb 32,1
  defb 222,1
  defb 32,1
  defb 64,1
  defb 0,3
  defb 193,1
  defb 32,1
  defb 160,1
  defb 0,3
  defb 194,1
  defb 32,1
  defb 64,1
  defb 0,3
  defb 126,1
  defb 32,1
  defb 0,3
  defb 16,1
  defb 96,1
  defb 32,1
  defb 0,3
  defb 40,1
  defb 224,1
  defb 56,1
  defb 0,3
  defb 16,1
  defb 192,1
  defb 8,1
  defb 0,3
  defb 1,1
  defb 128,1
  defb 12,1
  defb 16,1
  defb 0,2
  defb 3,1
  defb 128,1
  defb 2,1
  defb 40,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 16,1
  defb 0,2
  defb 7,1
  defb 0,1
  defb 1,1
  defb 0,3
  defb 7,1
  defb 255,2
  defb 0,4
  defb 197,1
  defb 8,1
  defb 0,4
  defb 104,1
  defb 240,1
  defb 0,4
  defb 120,1
  defb 98,1
  defb 0,3
  defb 2,1
  defb 48,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 0,4
  defb 0,0
wizzy_sprite_attack_3_1_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_sprite_attack_3_2:
  defb 3
  defb 0
  defb 0,14
  defb 8,1
  defb 0,3
  defb 16,1
  defb 192,1
  defb 21,1
  defb 240,1
  defb 0,2
  defb 47,1
  defb 251,1
  defb 248,1
  defb 15,1
  defb 0,2
  defb 16,1
  defb 14,1
  defb 24,1
  defb 225,1
  defb 192,1
  defb 0,1
  defb 3,1
  defb 140,1
  defb 15,1
  defb 48,1
  defb 96,1
  defb 0,2
  defb 124,1
  defb 4,1
  defb 28,1
  defb 48,1
  defb 0,2
  defb 7,1
  defb 130,1
  defb 46,1
  defb 8,1
  defb 0,2
  defb 192,1
  defb 101,1
  defb 23,1
  defb 204,1
  defb 0,1
  defb 3,1
  defb 254,1
  defb 26,1
  defb 193,1
  defb 254,1
  defb 0,1
  defb 4,1
  defb 127,1
  defb 128,1
  defb 112,1
  defb 111,1
  defb 0,1
  defb 11,1
  defb 143,1
  defb 192,1
  defb 28,1
  defb 27,1
  defb 128,1
  defb 14,1
  defb 129,1
  defb 192,1
  defb 35,1
  defb 15,1
  defb 192,1
  defb 8,1
  defb 225,1
  defb 224,1
  defb 81,1
  defb 194,1
  defb 96,1
  defb 16,1
  defb 32,1
  defb 240,1
  defb 32,1
  defb 61,1
  defb 176,1
  defb 0,1
  defb 127,1
  defb 248,1
  defb 31,1
  defb 135,1
  defb 156,1
  defb 0,1
  defb 127,1
  defb 248,1
  defb 3,1
  defb 240,1
  defb 15,1
  defb 0,1
  defb 127,1
  defb 248,1
  defb 159,1
  defb 253,1
  defb 241,1
  defb 0,1
  defb 32,1
  defb 96,1
  defb 252,1
  defb 3,1
  defb 234,1
  defb 0,1
  defb 36,1
  defb 225,1
  defb 0,1
  defb 65,1
  defb 1,1
  defb 16,1
  defb 32,1
  defb 98,1
  defb 128,1
  defb 195,1
  defb 231,1
  defb 40,1
  defb 51,1
  defb 97,1
  defb 1,1
  defb 158,1
  defb 108,1
  defb 16,2
  defb 195,1
  defb 131,1
  defb 56,1
  defb 76,1
  defb 0,1
  defb 31,1
  defb 255,1
  defb 230,1
  defb 72,2
  defb 0,1
  defb 120,1
  defb 96,1
  defb 28,1
  defb 136,2
  defb 1,1
  defb 145,1
  defb 7,1
  defb 249,1
  defb 16,1
  defb 144,1
  defb 2,2
  defb 131,1
  defb 242,1
  defb 17,1
  defb 48,1
  defb 12,1
  defb 1,1
  defb 124,1
  defb 6,1
  defb 33,1
  defb 96,1
  defb 24,1
  defb 0,1
  defb 96,1
  defb 4,1
  defb 34,1
  defb 96,1
  defb 48,1
  defb 128,1
  defb 96,1
  defb 4,1
  defb 70,1
  defb 64,1
  defb 35,1
  defb 192,1
  defb 96,1
  defb 8,1
  defb 68,1
  defb 128,1
  defb 38,1
  defb 64,1
  defb 96,1
  defb 8,1
  defb 133,1
  defb 128,1
  defb 54,1
  defb 64,1
  defb 96,1
  defb 17,1
  defb 73,1
  defb 0,1
  defb 12,1
  defb 64,1
  defb 96,1
  defb 0,1
  defb 155,1
  defb 0,2
  defb 64,1
  defb 120,1
  defb 8,1
  defb 39,1
  defb 0,2
  defb 128,1
  defb 120,1
  defb 20,1
  defb 36,1
  defb 0,1
  defb 1,1
  defb 128,1
  defb 28,1
  defb 9,1
  defb 40,1
  defb 0,1
  defb 3,1
  defb 0,1
  defb 14,1
  defb 2,1
  defb 144,1
  defb 0,1
  defb 6,1
  defb 0,1
  defb 7,1
  defb 1,1
  defb 16,1
  defb 0,1
  defb 4,1
  defb 0,1
  defb 7,1
  defb 0,1
  defb 32,1
  defb 0,1
  defb 7,1
  defb 255,2
  defb 0,1
  defb 32,1
  defb 0,2
  defb 197,1
  defb 8,1
  defb 0,1
  defb 32,1
  defb 0,2
  defb 104,1
  defb 144,1
  defb 0,1
  defb 128,1
  defb 0,2
  defb 120,1
  defb 240,1
  defb 1,1
  defb 64,1
  defb 0,1
  defb 2,1
  defb 48,1
  defb 100,1
  defb 0,1
  defb 128,1
  defb 0,1
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 1,1
  defb 240,1
  defb 124,1
  defb 0,3
  defb 0,0
wizzy_sprite_attack_3_2_attr_bytes:
  defb 120,36
  defb 0,0
wizzy_attack_3_execute:
  or a
  jp nz,wizzy_attack_3_execute_player_2

wizzy_attack_3_execute_player_1:
  ld a,d
  add 3
  ld d,a
  ld a,e
  cp d
  jp nc,wizzy_attack_3_execute_hit
  jp wizzy_attack_3_execute_miss
wizzy_attack_3_execute_player_2:
  ld a,d
  sub 2
  ld d,a
  ld a,e
  cp d
  jp nc,wizzy_attack_3_execute_hit
wizzy_attack_3_execute_miss:
  ld a,0
  ret
wizzy_attack_3_execute_hit:
  call five_hit_bang
  ld a,1
  ld b,3
  ld c,0
  ld d,6
  ld e,10
  ret