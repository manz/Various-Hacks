.incsrc "asm2ips.asm"

.startfile (HI,YES)
.detect on

.patch ($C0002C)
 	JSL $FA0000
 	NOP
.endp (0)

.patch ($FA0000)
	intro:
; initialise SNES
JSR.W init

; set register modes
	REP #$10        ; make X & Y 16-bits
	SEP #$20        ; make A 8-bits

; initialise graphics hardware
	LDA.B #$03        ; graphics mode 3
	STA.W $2105
	LDA.B #$01        ; enable plane 0
	STA.W $212c
	LDA.B #$00        ; set plane 0 memory to $0000, 32x32 chars
	STA.W $2107
	LDA.B #$01        ; set plane 0 character set to $1000
	STA.W $210b

; copy screen map data
	LDX.W #$0000    ; set VRAM pointer to plane 0 memory location
	STX.W $2116
	LDX.W #$1801    ; dma to $2118
	STX.W $4300
	LDX.W #!mapData ;&$FFFF ; source offset
	STX.W $4302
	LDA.B #^mapData ;/$10000 ; source bank
	STA.W $4304
	LDX.W #mapDataEnd-mapData     ; number of bytes
	STX.W $4305
	LDA.B #$01        ; do dma
	STA.W $420B

; set colour registers
	;LDA.B #$00        ; select colour register 0
	;STA.W $2121

	STZ.W $2121
	LDX.W #$2200    ; dma to $2122
	STX.W $4300
	LDX.W #!colData	;&$FFFF ; source offset
	STX.W $4302
	LDA.B #^colData	;/$10000 ; source bank
	STA.W $4304
	LDX.W #colDataEnd-colData      ; number of bytes
	STX.W $4305
	LDA.B #$01        ; do dma
	STA.W $420B

; set tile data
	LDX.W #$1000    ; set VRAM pointer to character set location
	STX.W $2116
	LDX.W #$1801    ; dma to $2118
	STX.W $4300
	LDX.W #!tileData	;&$FFFF ; source offset
	STX.W $4302
	LDA.B #^tileData	;/$10000 ; source bank
	STA.W $4304
	LDX.W #tileDataEnd-tileData    ; number of bytes
	STX.W $4305
	LDA.B #$01        ; do dma
	STA.W $420B

	LDA.B #$00        ; enable screen, full brightness
	STA.W $2100

	LDA #$00
	STA $2100
	STZ $00

LDA.B #$01	;Joypad enabled :D
STA.W $4200

_debut3:
	INC $00
	LDA $00
	STA $2100
	ASL
	ASL
	ASL
	ASL
	STA $01
	LDA #$F0
	SBC $01
	ADC #$01
	STA $2106

	JSR.W waitvb
	JSR.W waitvb


	LDA $00
	CMP #$0F
	BEQ _fin3
BRA _debut3

_fin3:

;Delay pas bo mais qui fonctionne
	LDA.B #$80
loop:
	JSR.W WaitVb
	JSR.W WaitVb
	JSR.W WaitVb
	
	LDX.W $4218	; lecture depuis joystick
	BNE _nxt	; si on appuye sur quelque chose on sort du delay

	DEC
	BNE loop
_nxt:
	STZ $00


;enable Joystick



STZ.W $4200

_debut:
	INC $00
	LDA #$0F
	SBC $00
	STA $2100
	LDA $00
	CMP #$0F
	BEQ _fin
	LDA $00
	ASL
	ASL
	ASL
	ASL
	INC
	STA $2106
	
	JSR.W waitvb
	JSR.W waitvb
	JSR.W waitvb
	BRA _debut
_fin:

	LDA #$01
	STA $420D

	RTL

;Wait for vblank routine
WaitVb:
	PHA
lop:
	CLC
	LDA $4210
	BPL lop
WaitVb2:
	CLC
	LDA $4210
	BMI WaitVb2
	PLA
	RTS

;initialisation de la snes
init:
	sep #$30        ; make X, Y, A all 8-bits
	lda #$80        ; screen off, no brightness
	sta $2100       ; brightness & screen enable register
	lda #$00
	sta $2101       ; sprite register (size & address in VRAM)
	sta $2102       ; sprite registers (address of sprite memory [OAM])
	sta $2103       ; sprite registers (address of sprite memory [OAM])
	sta $2105       ; graphic mode register
	sta $2106       ; mosaic register
	sta $2107       ; plane 0 map VRAM location
	sta $2108       ; plane 1 map VRAM location
	sta $2109       ; plane 2 map VRAM location
	sta $210A       ; plane 3 map VRAM location
	sta $210B       ; plane 0 & 1 Tile data location
	sta $210C       ; plane 2 & 3 Tile data location
	sta $210D       ; plane 0 scroll x (first 8 bits)
	sta $210D       ; plane 0 scroll x (last 3 bits)
	sta $210E       ; plane 0 scroll y (first 8 bits)
	sta $210E       ; plane 0 scroll y (last 3 bits)
	sta $210F       ; plane 1 scroll x (first 8 bits)
	sta $210F       ; plane 1 scroll x (last 3 bits)
	sta $2110       ; plane 1 scroll y (first 8 bits)
	sta $2110       ; plane 1 scroll y (last 3 bits)
	sta $2111       ; plane 2 scroll x (first 8 bits)
	sta $2111       ; plane 2 scroll x (last 3 bits)
	sta $2112       ; plane 2 scroll y (first 8 bits)
	sta $2112       ; plane 2 scroll y (last 3 bits)
	sta $2113       ; plane 3 scroll x (first 8 bits)
	sta $2113       ; plane 3 scroll x (last 3 bits)
	sta $2114       ; plane 3 scroll y (first 8 bits)
	sta $2114       ; plane 3 scroll y (last 3 bits)
	lda #$80        ; increase VRAM address after writing to $2119
	sta $2115       ; VRAM address increment register
	lda #$00
	sta $2116       ; VRAM address low
	sta $2117       ; VRAM address high
	sta $211A       ; initial mode 7 setting register
	sta $211B       ; mode 7 matrix parameter A register (low)
	lda #$01
	sta $211B       ; mode 7 matrix parameter A register (high)
	lda #$00
	sta $211C       ; mode 7 matrix parameter B register (low)
	sta $211C       ; mode 7 matrix parameter B register (high)
	sta $211D       ; mode 7 matrix parameter C register (low)
	sta $211D       ; mode 7 matrix parameter C register (high)
	sta $211E       ; mode 7 matrix parameter D register (low)
	lda #$01
	sta $211E       ; mode 7 matrix parameter D register (high)
	lda #$00
	sta $211F       ; mode 7 center position X register (low)
	sta $211F       ; mode 7 center position X register (high)
	sta $2120       ; mode 7 center position Y register (low)
	sta $2120       ; mode 7 center position Y register (high)
	sta $2121       ; color number register ($00-$ff)
	sta $2123       ; bg1 & bg2 window mask setting register
	sta $2124       ; bg3 & bg4 window mask setting register
	sta $2125       ; obj & color window mask setting register
	sta $2126       ; window 1 left position register
	sta $2127       ; window 2 left position register
	sta $2128       ; window 3 left position register
	sta $2129       ; window 4 left position register
	sta $212A       ; bg1, bg2, bg3, bg4 window logic register
	sta $212B       ; obj, color window logic register (or, and, xor, xnor)
	lda #$01
	sta $212C       ; main screen designation (planes, sprites enable)
	lda #$00
	sta $212D       ; sub screen designation
	sta $212E       ; window mask for main screen
	sta $212F       ; window mask for sub screen
	lda #$30
	sta $2130       ; color addition & screen addition init setting
	lda #$00
	sta $2131       ; add/sub sub designation for screen, sprite, color
	lda #$E0
	sta $2132       ; color data for addition/subtraction
	;lda #$00
	stz $2133       ; screen setting (interlace x,y/enable SFX data)
	stz $4200       ; disable v-blank, interrupt, joypad register
	lda #$FF
	sta $4201       ; programmable I/O port
	lda #$00
	sta $4202       ; multiplicand A
	sta $4203       ; multiplier B
	sta $4204       ; multiplier C
	sta $4205       ; multiplicand C
	sta $4206       ; divisor B
	sta $4207       ; horizontal count timer
	sta $4208       ; horizontal count timer MSB
	sta $4209       ; vertical count timer
	sta $420A       ; vertical count timer MSB
	sta $420B       ; general DMA enable (bits 0-7)
	sta $420C       ; horizontal DMA (HDMA) enable (bits 0-7)
	sta $420D       ; access cycle designation (slow/fast rom)
RTS

;==========================================================================
;                         Wait For Vertical Blank
;==========================================================================

; screen map data
mapData:
	.incbin ".\files\ff4warn2.map"
;	.incbin ".\files\gix.map"
mapDataEnd:
; colour register data
colData:
	.incbin ".\files\ff4warn2.col"
;	.incbin ".\files\gix.col"
colDataEnd:
; tile set data
tileData:
	.incbin ".\files\ff4warn2.set"
;	.incbin ".\files\gix.set"
tileDataEnd:

.endp (0)