;
; vwf des combats
;

LargeurMaximal 	= $E3
HauteurMaximal 	= $E1
Tampon		= $7FFFE0
LargeurCourante	= $E0
Title1 		= $7FFFE2
Title2 		= $7FFFE3
Title3 		= $7FFFE4

realpos		= $7FFFE2

charc 		= $DE
wrampos 	= $D6

.patch (freespace)
shiftbtl:
	LDA.B $E0
	AND #$01
	BEQ _no_DEC
	DEC $E1
	_no_DEC
	
	LDY.B wrampos
	SEP #$20
	
	;JSR.W clearw
			
	LDA.B #$0C
	STA.B $08
loop_copie:
	LDA.L bitsleft
	PHX
	TAX
	LDA.L shiftbl,X
	PLX
	
	STA.L $00211C
	STA.L $00211C
	
	LDA.L $D40000,X
;	STA.W $0005,Y
	STA.L $00211B
	LDA.L $D40001,X
;	STA.W $0015,Y
	STA.L $00211B
	
	
	LDA.L $002136
	ORA.W $0005,Y
	STA.W $0005,Y
	REP #$20
	LDA.L $002134
	SEP #$20
	STA.W $0025,Y
	XBA
	STA.W $0015,Y
	INY
	INY
	INX
	INX
	
	DEC.B $08

	BNE loop_copie
	
	LDA.B charc
	XBA
	LDA.B #$00
	XBA
	TAX
	LDA.L lentbl,X
	INC
	STA.L len
	PLX
	LDA.L bitsleft
	SEC
	SBC.L len
	STA.L bitsleft
	
	BMI inc_wpos
	BEQ inc_wpos
	BRA _fin2
	
inc_wpos:
	CLC
	ADC.B #$08
	STA.L bitsleft
	
	PHA
	REP #$20
	LDA.W #$0020
	CLC
	ADC.B $D6
	STA.B $D6
	SEP #$20
	INC $E0
	PLA
	
	CMP #$00
	BMI inc_wpos
	BEQ inc_wpos
_fin2:
	STA.L bitsleft

	;JMP.L _return
clearw:
	PHX
	PHA
	PHY
	LDY.B $D6
	LDA.B #$20
	STA.B $00
loop_clear:
	LDA.B #$00

	STA.W $0001,Y
	INY
	INY
	DEC $00
	BNE loop_clear
	

;	REP #$20
;	LDA.W #$0020
;	ADC.B $D6
;	STA.B $D6
;	SEP #$20
	
	PLY
	PLA
	PLX
	RTS
init:
	LDA.B #$08
	STA.L bitsleft
	LDA.B #$08	; surement a refaire
	STA.B $E1
	STA.B $E3
	JMP.L $C15032
;	LDX.W #$0000
;	STA.L realpos
newline:

init_E3:
	LDX.W #$0000
	STX.B $DC
	LDA.B $E3
	LSR
	ADC.B $E3
	STA.B $E3
	STA.B $E1
	JMP.L $C13ECD

derout_DEC:
	LDA.B $E0
	AND #$01
	BEQ no_DEC
	DEC $E1
	no_DEC:
	REP #$21
	LDA.B $D6
	JMP.L $C150E0

shiftbl:
	.db %00000000
	.db %00000001
	.db %00000010
	.db %00000100
	.db %00001000
	.db %00010000
	.db %00100000
	.db %01000000
	.db %10000000
	
	
.endp (0)

;.patch ($C15095)
; pointeur vers la wram
;	LDA.B $DE
;	STA.W $211B
;	LDA.B $DF
;	STA.W $211B
;	LDA #$18
;	STA.W $211C
;	STA.W $211C
;	REP #$21
;	LDA.W #$9200
;	ADC.W $2134
;	TAX
;	SEP #$20
;
;	PHB
;	LDA #$7E
;	PHA
;	PLB
;	JMP.L shiftbtl
;_return:
;	PLB
;	RTS	
;		
;.endp (0)

; chtit menu des commandes
;.patch ($C1502C)
;	LDA.B #12
;.endp (0)

;.patch ($C1502C)
;	JMP.L init
;	NOP
;	NOP
;.endp (0)


;C13EC8 LDX #$0000             A:1D00 X:0060 Y:1A00 S:1FE0 DB:00 D:0300 P:27 e
;C13ECB STX $DC       [0003DC] A:1D00 X:0000 Y:1A00 S:1FE0 DB:00 D:0300 P:27 e
;C13ECD STZ $DF       [0003DF] A:1D00 X:0000 Y:1A00 S:1FE0 DB:00 D:0300 P:27 e
;C13ECF STZ $A7       [0003A7] A:1D00 X:0000 Y:1A00 S:1FE0 DB:00 D:0300 P:27 e

.patch ($C13EC8)
	JMP.L init_E3
	NOP
.endp (0)

.patch ($C150B2)
	@brval	= $C150BB
	BRA @brval
.endp (0)

.patch ($C150DC)
	JMP.L derout_DEC
.endp (0)

.patch ($C13F28)
	NOP
	NOP
.endp (0)
