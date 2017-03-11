; ------------------------------------------------------------------------------
; Subroutine for doing division. source: z80-heaven
;
; Inputs:
;     C is the numerator
;     D is the denominator
;
; Outputs:
;     A is the remainder
;     B is 0
;     C is the result of C/D
;
; Uses:
;     A, B, C, D
;     D,E,H,L are not changed
; ------------------------------------------------------------------------------
cdivd:
   ld b,8
   xor a
   sla c
   rla
   cp d
   jr c,$+4
   inc c
   sub d
   djnz $-8
   ret
