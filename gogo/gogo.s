.lowrom2

; handy macroes
#define SET_8_BIT_A()   sep #$20 : .as
#define SET_16_BIT_A()  rep #$20 : .al
#define SET_8_BIT_X()   sep #$10 : .xs
#define SET_16_BIT_X()  rep #$10 : .xl

#define SET_8_BIT_AX()  sep #$30 : .xs : .as
#define SET_16_BIT_AX() rep #$30 : .xl : .al

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
*=0x818658
.xl
ldy #$0008

; calcul de l'index au quel la routine ecrit les 16 octets
*=0x88BE00
correct_wram_pos

; on charge l'index "original"
lda $14

; on ne garde que les deux derniers octets 
; note à moi même : cela ne limite t'il pas la longueur de la ligne à 16 lettres ?
and #$00FF
; on divise par 2 (on copie 2 fois moins d'octets donc on décale de 2 fois moins)
lsr
sta $18

lda $cc
xba
lsr
pha
and #$00FF
asl
asl
asl
asl
asl
asl
asl

clc
adc $18
sta $18
pla
lsr
xba
; on additionne l'offset de la ligne 0 0x200 0x400 ...
clc
adc $18
; on le stocke et on retourne dans la routine originale
sta $18
jmp @ret_correct_wram_pos

correct_tilemap_index

;$81/8619 C2 30       REP #$30                A:0001 X:000E Y:0000 P:envmxdIzC
;$81/861B A4 08       LDY $08    [$00:0D08]   A:0001 X:000E Y:0000 P:envmxdIzC
;$81/861D B7 00       LDA [$00],y[$87:BB29]   A:0001 X:000E Y:0004 P:envmxdIzC
;$81/861F 29 FF 00    AND #$00FF              A:7164 X:000E Y:0004 P:envmxdIzC
;$81/8622 85 0C       STA $0C    [$00:0D0C]   A:0064 X:000E Y:0004 P:envmxdIzC
;$81/8624 C9 FF 00    CMP #$00FF              A:0064 X:000E Y:0004 P:envmxdIzC
SET_8_BIT_AX()

lda $04
and #$01
beq put_tile_into_pre_tileset

SET_16_BIT_AX()
phy
ldy $08
iny
lda [$00],y
ply
cmp #$01FF
bne end
inc $04

SET_8_BIT_AX()

put_tile_into_pre_tileset
lda $04
lsr
ldx $06
sta $7E2780, x
inc $06

end
inc $04
inc $08

jmp $818690 
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

