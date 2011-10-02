;temp_area = (byte*)(malloc(sizeof(byte)*n))
temp_area 		= $7FFFE0
tampon1   		= $09
tampon2   		= temp_area+2
tampon3   		= temp_area+3
btl.len				= temp_area+4
btl.bitsleft 	= temp_area+5

btl.cntr			= $08
cchar					= $DE
wpos					= $D6
;C150BB PHB                    A:9A00 X:9A58 Y:0300 S:1FE2 DB:00 D:0300 P:26 e
;C150BC LDA #$7E               A:9A00 X:9A58 Y:0300 S:1FE1 DB:00 D:0300 P:26 e
;C150BE PHA                    A:9A7E X:9A58 Y:0300 S:1FE1 DB:00 D:0300 P:24 e
;C150BF PLB                    A:9A7E X:9A58 Y:0300 S:1FE0 DB:00 D:0300 P:24 e
;C150C0 LDY $D6       [0003D6] A:9A7E X:9A58 Y:0300 S:1FE1 DB:7E D:0300 P:24 e
;C150C2 LDA #$0C               A:9A7E X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:A4 e
;C150C4 STA $08       [000308] A:9A0C X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:24 e
;C150C6 LDA $D40000,X [D49A58] A:9A0C X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:24 e
;C150CA STA $0005,Y   [7EB005] A:9A00 X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:26 e
;C150CD LDA $D40001,X [D49A59] A:9A00 X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:26 e
;C150D1 STA $0025,Y   [7EB025] A:9A00 X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:26 e
;C150D4 INX                    A:9A00 X:9A58 Y:B000 S:1FE1 DB:7E D:0300 P:26 e
;C150D5 INX                    A:9A00 X:9A59 Y:B000 S:1FE1 DB:7E D:0300 P:A4 e
;C150D6 INY                    A:9A00 X:9A5A Y:B000 S:1FE1 DB:7E D:0300 P:A4 e
;C150D7 INY                    A:9A00 X:9A5A Y:B001 S:1FE1 DB:7E D:0300 P:A4 e
;C150D8 DEC $08       [000308] A:9A00 X:9A5A Y:B002 S:1FE1 DB:7E D:0300 P:A4 e
;C150DA BNE $50C6     [C150C6] A:9A00 X:9A5A Y:B002 S:1FE1 DB:7E D:0300 P:24 e
;C150DC REP #$21               A:9A00 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:26 e
;C150DE LDA $D6       [0003D6] A:9A00 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:06 e
;C150E0 ADC #$0020             A:B000 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:84 e
;C150E3 STA $D6       [0003D6] A:B020 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:84 e
;C150E5 SEP #$20               A:B020 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:84 e
;C150E7 INC $E0       [0003E0] A:B020 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:A4 e
;C150E9 PLB                    A:B020 X:9A70 Y:B018 S:1FE1 DB:7E D:0300 P:24 e
;C150EA RTS                    A:B020 X:9A70 Y:B018 S:1FE2 DB:00 D:0300 P:26 e

;vwf initialisation
btl.init:
	lda #$08
	sta btl.bitsleft
	ldx #$0000
	stx $dc
	jmp.l $C13ECD

; padding routine	
btl.pad:

	lda btl.bitsleft

	cmp #$08
	bpl _lastempty
	
	rep #$20
	lda $D6
	clc
	adc #$0020
	sta $D6
	sep #$20
	lda #$08
	sta btl.bitsleft
_lastempty:


btl.pad2:
	PHB
	LDA #$7E
	PHA
	PLB
	;LDX #$9200
	LDY $D6
	LDA #$0C
	STA $08
	
;clear routine
btl.clr:

	lda #$FF
	STA $0000,Y
	lda #$00
	sta $0001,Y

	INY
	INY
	DEC $08
	BNE btl.clr
	
	REP #$21
	LDA $D6
	ADC #$0020
	STA $D6
	SEP #$20
	INC $E0
	PLB
	
	dec $E1
	bne btl.pad2
	
	jmp.l btl.clr_ret
;C150EA RTS

; shift routine
btl.shift:
	phb
	lda #$7E
	pha
	plb
	ldy $D6

	lda.b #$0C
	sta.b btl.cntr

btl.loop1:

	lda.l btl.bitsleft
	sta.b tampon1
	
; loading some font :)	
	lda $D40000,X
	
; clear high byte :)
	xba
	lda #$00
	xba

; shift (width max = 8 pixels)
btl.loop2:
	rep #$20
	rol
	sep #$20
	dec tampon1
	bne btl.loop2
	
;wram transfer:)
	sta.w $0025,y
	xba
	ora.w $0005,y
	sta.w $0005,y
	
	iny
	iny
	inx
	inx
	
	dec btl.cntr
	bne btl.loop1
	xba
	lda #$00
	xba
	lda cchar
	phx
	rep #$20
	and #$00FF
	tax
	sep #$20
	lda lentbl,x
	inc
	sta btl.len
	plx
	
	lda btl.bitsleft
	sec
	sbc btl.len
	
	bmi btl.inc_tpos
	beq btl.inc_tpos
	bra btl._fin

btl.inc_tpos:
	CLC
	ADC.B #$08
	
	rep #$20
	pha
	lda wpos
	clc
	adc.w #$0020
	sta wpos
	pla
	sep #$20

	cmp #$00	
	bmi btl.inc_tpos
	beq btl.inc_tpos
btl._fin:
	STA.L btl.bitsleft
	inc $E0
	plb
	
	; return to the main code !
	jmp.l $C150EA

