.lowrom2

#define mz_stack 0x7EDE00
#define line_jump_count mz_stack+2

;$81/85F6 BF 00 D0 87 LDA $87D000,x[$87:D0BE] A:00BE X:00BE Y:009A P:envmxdIzc
;deroutage init

*=0x8185F6
jmp @mz_init
ret_mz_init

; deroutage
; lda $14
; sta $18
*=0x818654
jmp @correct_wram_pos
ret_correct_wram_pos

; nombre d'octets à copier
; ldy #$0010
; 16 octets = 8x8 pixels en 2bpp
; la routine effectue une boucle sur Y et copie 32 octets
; -- 16
; -- 16
; TODO: Gérer le cas dernier caractère impair (donc seul sur un tile)
; completer le tile 2 8x8 32 octets
*=0x818658
.xl
ldy #$0008


;@ret_correct_tilemap_index

;$81/8680 A6 06       LDX $06    [$00:0D06]   A:0000 X:02FE Y:0000 P:envMxdIZc
;$81/8682 A5 04       LDA $04    [$00:0D04]   A:0000 X:0013 Y:0000 P:envMxdIzc
;$81/8684 9F 80 27 7E STA $7E2780,x[$7E:2793] A:000F X:0013 Y:0000 P:envMxdIzc
;$81/8688 E6 04       INC $04    [$00:0D04]   A:000F X:0013 Y:0000 P:envMxdIzc
;$81/868A C2 20       REP #$20                A:000F X:0013 Y:0000 P:envMxdIzc
;$81/868C E6 06       INC $06    [$00:0D06]   A:000F X:0013 Y:0000 P:envmxdIzc
;$81/868E E6 08       INC $08    [$00:0D08]   A:000F X:0013 Y:0000 P:envmxdIzc



*=0x818680
jmp @correct_tilemap_index

*=0x88BE00
#include "build_wram_data.s"
#include "build_set_data.s"
#include "init.s"
;include(`build_wram_data.s')
;include(`build_set_data.s')
