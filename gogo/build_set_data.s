; handy macroes

;define(`SET_8_BIT_A', `sep #`'$20 : .as')

;define(`SET_16_BIT_A',  `rep #`'$20 : .al')
;define(`SET_8_BIT_X',   `sep #`'$10 : .xs')
;define(`SET_16_BIT_X',  `rep #`'$10 : .xl')

;define(`SET_8_BIT_AX',  `sep #$`'30 : .xs : .as')
;define(`SET_16_BIT_AX', `rep #$`'30 : .xl : .al')
#define SET_8_BIT_A()   sep #$20 : .as
#define SET_16_BIT_A()  rep #$20 : .al
#define SET_8_BIT_X()   sep #$10 : .xs
#define SET_16_BIT_X()  rep #$10 : .xl

#define SET_8_BIT_AX()  sep #$30 : .xs : .as
#define SET_16_BIT_AX() rep #$30 : .xl : .al

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
and #$00FF
cmp #$00FF
bne end
;inc $04

phx
phy
lda #$FF00
ldy #$0010
_begin_copy
ldx $18
sta $7EE020,x
sta $7EE120,x
inc $18
inc $18
dey
cpy #$0000
bne _begin_copy

ply
plx
inc $04

SET_8_BIT_AX()
bra end
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