;===================================================================
; Live A eviL (LAL)
; Variable width font Code
;===================================================================

.incsrc "asm2ips.asm"
.startfile (HI,YES)
.detect on

.asctable                       ;  set up ascii table map for 12*12 text
32 = $20 : "A".."Z" = $41 : "a".."z" = $61 : 33 = $21
.end

;.patch ($DCFB3F)
;	.asc "Ianzisageekorg uber uber koollll"
;	.db $00
;.endp (0)


;"patch de la font"
.patch ($D49200)
	.incbin "..\vwf\lalvwf8.dat"
.endp (0)

;deroutage pour faire marcher la vwf avec la dte
.patch ($DCFA38)
	JMP.L derout_dte1
.endp (0)

.patch ($DCFA58)
	JMP.L derout_dte2
.endp (0)


var_space = $7EBA80
char = var_space
bitsleft = char+2
cntr = bitsleft+2
cntr2 = cntr+2
len = cntr2+2
;===================================================================
; Déroutage, pour stocker le caractère courant
;===================================================================
.patch ($C09C4E)
	JMP.L store_char
.endp (0)

;===================================================================
; Deroutage pour shifter et stocker la lettre courrante
;===================================================================
.patch ($C0A6E7)
	JMP.L dlg.shift
.endp (0)

;C09BEA LDA $30       [000030] A:A50C X:0010 Y:99DE S:1FF7 DB:00 D:0000 P:26 e
;C09BEC STA $01C3     [0001C3] A:A5D1 X:0010 Y:99DE S:1FF7 DB:00 D:0000 P:A4 e
.patch ($C09BEA)
	JSR.L dlg.init
	NOP
.endp (0)

.patch ($C09D0E)
	JSR.L dlg.reinit
.endp (0)

; On se demande dans quel état faut être pour ecrire ce genre de choses :D
;.patch ($C0A652)
;	NOP
;	NOP
;.endp (0)

; tag 02=\n<NEW>\n
;C09D4B PLB                    A:0004 X:0004 Y:A50D S:1FF6 DB:D1 D:0000 P:24 e
;C09D4C LDA $01C0     [0001C0] A:0004 X:0004 Y:A50D S:1FF7 DB:00 D:0000 P:26 e

.patch ($C09D4B)
	JMP.L dlg.reinit02
dlg.reinit_ret02:
.endp (0)


;===================================================================
; /!\ Code logé dans la partie "Kanji" de la font /!\
; Attention a ne pas l'écraser en inserant la font
;===================================================================
.patch ($D4AA00)
dlg.reinit02:
	LDA.B #$08
	STA.L bitsleft	
	PLB
	LDA.W $01C0
	JMP.L dlg.reinit_ret02

derout_dte1:
	STA.L char
	STA.B $30
	SEP #$20
	JMP.L $DCFA3C
	
derout_dte2:
	STA.L char
	STA.B $30
	SEP #$20
	JMP.L $DCFA5C
	
store_char:
	STA.L char
	JMP.L $DCFA00
	
dlg.reinit:
	STA.L $0001D0	
dlg.init:
	LDA.B $30
	STA.W $01C3
	LDA.B #$08
	STA.L bitsleft	
	RTL

;
; X: src Y:dest
; A:16 X, Y:16
TEMP = $30
tilepos = $01D0
	
dlg.shift:
	SEP #$20
	LDX.W #$02C6
	LDA.B #$0C
	STA.L cntr
loop1:	
	LDA.L bitsleft
	STA.B TEMP

	REP #$20
	
loop2:	
	ROL.W $0000,X

	DEC TEMP
	BNE loop2

	INX
	INX
	SEP #$20
		
	LDA.L cntr
	DEC
	STA.L cntr
	BNE loop1
	
	PHX
        XBA
        LDA.B #$00
	XBA
	LDA.L char
	
	TAX
	LDA.L lentbl,X
	INC
	STA.L len
	PLX
	LDA.L bitsleft
	SEC
	SBC.L len
	
	BMI inc_tpos
	BEQ inc_tpos
	BRA _fin
inc_tpos:
	CLC
	ADC.B #$08
	INC tilepos
	CMP #$00	
	BMI inc_tpos
	BEQ inc_tpos
_fin:
	STA.L bitsleft
	REP #$20
	STZ.W $02DE
	STZ.W $02C4
	JMP.W store
	
lentbl:
	.incbin "..\vwf\lentbl.dat"

store:
	SEP #$20
	STZ.B $34
	LDX.W #$02C6

	LDA.B $00,X
	ORA.W $0015,Y
	STA.W $0015,Y
	LDA.B $02,X
	ORA.W $0017,Y
	STA.W $0017,Y
	LDA.B $04,X
	ORA.W $0019,Y
	STA.W $0019,Y
	LDA.B $06,X
	ORA.W $001B,Y
	STA.W $001B,Y
	LDA.B $08,X
	ORA.W $001D,Y
	STA.W $001D,Y
	LDA.B $0A,X
	ORA.W $001F,Y
	STA.W $001F,Y

	LDA.B $01,X
	ORA.W $0005,Y
	STA.W $0005,Y
	LDA.B $03,X
	ORA.W $0007,Y
	STA.W $0007,Y
	LDA.B $05,X
	ORA.W $0009,Y
	STA.W $0009,Y
	LDA.B $07,X
	ORA.W $000B,Y
	STA.W $000B,Y
	LDA.B $09,X
	ORA.W $000D,Y
	STA.W $000D,Y
	LDA.B $0B,X
	ORA.W $000F,Y
	STA.W $000F,Y
	

	; 2eme partie
	PHY
	LDX.W #$02D2
	REP #$20
	PLA
	CLC
	ADC.B $36
	TAY
	SEP #$20

	LDA.B $00,X
	ORA.W $0011,Y
	STA.W $0011,Y
	LDA.B $02,X
	ORA.W $0013,Y
	STA.W $0013,Y
	LDA.B $04,X
	ORA.W $0015,Y
	STA.W $0015,Y
	LDA.B $06,X
	ORA.W $0017,Y
	STA.W $0017,Y
	LDA.B $08,X
	ORA.W $0019,Y
	STA.W $0019,Y
	LDA.B $0A,X
	ORA.W $001B,Y
	STA.W $001B,Y	
	LDA.B $0C,X
	ORA.W $001D,Y
	STA.W $001D,Y

	LDA.B $01,X
	ORA.W $0001,Y
	STA.W $0001,Y
	LDA.B $03,X
	ORA.W $0003,Y
	STA.W $0003,Y
	LDA.B $05,X
	ORA.W $0005,Y
	STA.W $0005,Y
	LDA.B $07,X
	ORA.W $0007,Y
	STA.W $0007,Y
	LDA.B $09,X
	ORA.W $0009,Y
	STA.W $0009,Y
	LDA.B $0B,X
	ORA.W $000B,Y
	STA.W $000B,Y
	LDA.B $0D,X
	ORA.W $000D,Y
	STA.W $000D,Y
	LDX #$0040
	
	JMP.L $C0A786
	
	freespace:
.endp (0)

; patch de l'incrémentation auto du tilepos
.patch ($C09C92)
 	; INC $01D0     [0001D0] A:C90E X:02D2 Y:C980 S:1FF7 DB:00 D:0000 P:26 e
 	NOP
 	NOP
	NOP
.endp (0)

; ==============================
; Deroutages des combats
; ==============================

;ptite windoze en haut
;.patch ($C13E18)
;	LDA #$14
;.endp (0)

; mutiplication par 1,5
.patch ($C13E61)
	phb
	pha
	plb
	;ldx.w #$0000
	;phy
	JMP.L mult15_E3
	
.endp (0)

.patch (freespace)
mult15_E3:
; *1.5

	lda.b $E3
	lsr
	clc
	adc.b $E3
;	cmp #$14
;	bmi pas_depass
;		lda #$14
	
pas_depass:
	sta $E3

pha	
	lda $E2
	sta $E1
pla

_more_loop:
	sta.l $004202		; MULTPILIER
	
	lda #$0C
	sta.l $004203		; MULTIPLICAND
	
	ldx.b $D6
	
	rep #$20
	lda.l $004216	; the result is stored in $4216-$4217
	sta.b $08
	lda #$00FF
	
_loop08:
	
	sta $7E0000,X
	inx
	inx
	dec $08
	bne _loop08
	sep #$20
	
	dec $E1
	bne _more_loop

noeff:	
	lda $E3
	sta $E1
	ldx.w #$0000
	phy

	jmp.l $C13E68
	
	.incsrc "battle.asm"
.endp (0)

; call for the shift
.patch ($C150BB)
	jmp.l btl.shift
.endp (0)

; Initialization
;C13EC8 LDX #$0000             A:C300 X:0060 Y:0300 S:1FE4 DB:00 D:0300 P:27 e
;C13ECB STX $DC       [0003DC] A:C300 X:0000 Y:0300 S:1FE4 DB:00 D:0300 P:27 e
.patch ($C13EC8)
	jmp.l btl.init
	nop
.endp (0)

; some padding ...
;C13F72 STZ $DF       [0003DF] A:B100 X:0008 Y:B138 S:1FE2 DB:00 D:0300 P:27 e
;C13F74 STZ $DE       [0003DE] A:B100 X:0008 Y:B138 S:1FE2 DB:00 D:0300 P:27 e
;C13F76 JSR $5095     [C15095] A:B100 X:0008 Y:B138 S:1FE2 DB:00 D:0300 P:27 e
.patch ($C13F72)
	jmp.l btl.pad
btl.clr_ret:
	rts
.endp (0)

; calcul de la taille du transfer
;C15083 LDA #$30               A:B200 X:0012 Y:B218 S:1FE0 DB:00 D:0300 P:26 e
;C15085 STA $211C     [00211C] A:B230 X:0012 Y:B218 S:1FE0 DB:00 D:0300 P:24 e
.patch ($C15083)
	LDA.B #$20
.endp (0)

;C13E64 PHB                    A:C3D6 X:0000 Y:0300 S:1FE2 DB:00 D:0300 P:26 e
;C13E65 PHA                    A:C3D6 X:0000 Y:0300 S:1FE1 DB:00 D:0300 P:26 e
;C13E66 PLB                    A:C3D6 X:0000 Y:0300 S:1FE0 DB:00 D:0300 P:26 e

; LDX.W #$0000

;C13E67 PHY                    A:C3D6 X:0000 Y:0300 S:1FE1 DB:D6 D:0300 P:A4 e
;C13E68 LDY $DC       [0003DC] A:C3D6 X:0000 Y:0300 S:1FDF DB:D6 D:0300 P:A4 e

;fenètre commandes
;.patch ($C1502C)
;	LDA #$0C
;.endp (0)

.base $c150BB
branch:
.patch ($C150B6)
	BRA branch
.endp (0)

;.patch ($C150E0)
;	ADC #$20
;.endp (0)

;.patch ($C13E61)
;	JMP.L derout_mul
;	retmul:
;.endp (0)

; Déroutage affichage combats.

;.patch ($C150B2)
;	JMP.L btl.shift
;.endp (0)

char_c		= $DE
wram_ptr	= $D6
counter		= $08
Tampon		= $7FFFE0

;.patch (freespace)
;btl.init:
;	
;btl.shift:
;	PHB
;	LDA #$7E
;	PHA
;	PLB
;	LDY $D6
;	LDA #$0C
;	STA $08
;@boucle:
;	LDA $D40001,X
;	STA $00211B
;	LDA $D40000,X
;	STA $00211B
;	
;	PHX
;	;LDX $D6
;	LDA bitsleft ;lentbl,X
;	;LDA #$10
;	PLX
;	
;	STA $00211C
;	STA $00211C
;	LDA $002136
;	;AND #$0F
;	ORA $0005,Y
;	STA $0005,Y
;	LDA $002135
;	STA $0025,Y
;;
;	LDA $D40000,X
;	STA $0005,Y
;	LDA $D40001,X
;	STA $0025,Y
;	INX
;	INX
;	INY
;	INY
;	DEC $08
;	BNE @boucle
;	REP #$21
	
;	PHX
;	LDX.W #$0000
;	LDA char_c
;	TAX
;	LDA lentbl,X
;	STA Tampon
;	LDA bitsleft
;	SEC
;	SBC Tampon
	
;	LDA $D6
;	ADC #$0020
;	STA $D6
;	SEP #$20
;	INC $E0
;	PLB
;	RTS

;.endp (0)


.endfile (0)