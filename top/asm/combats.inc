; hack pour gagner de la place dans la fenètre pour les monstres
; ajustement de la postion des sprites "aïelevilainmonstrem'atapé"
; abscisse en pixels
.patch ($C1C4F4)
 lda.w #$0010
.endp (0)


; Postition nom monstre
.patch ($C1D74E)
 ldx.w #$0524
.endp (0)

; postion nombre monstre
.patch ($C1D77D)
 adc.w #$0018
.endp (0)

;largeur premiere ligne fenetre 1
.patch ($C10AD8)
 ldy.w #$000F
.endp (0)

; largeur autres lignes fenetre 1
.patch ($C10AFE)
 ldy.w #$000F
.endp (0)

; largeur ligne finale fenetre 1
.patch ($C10B26)
 ldy.w #$000F
.endp (0)

; postion fenetre 2
.patch ($C1D609)
	ldx.w #$04A4
.endp (0)

; largeur fenetre 2
;$C1/D613 A0 0B 00    LDY #$000B              A:24F8 X:04A8 Y:0000 P:envmxdizc
.patch ($C1D613)
 ldy.w #$000D
.endp (0)

;$C1/D629 A2 E8 04    LDX #$04E8              A:24FA X:04BE Y:0000 P:envmxdizc
;$C1/D62C A9 08 00    LDA #$0008              A:24FA X:04E8 Y:0000 P:envmxdizc
.patch ($C1D629)
 ldx.w #$04E4
.endp (0)

; nombres de lignes fen2
;.patch ($C1D62C)
; lda.w #$000A
;.endp (0)

;largeur fen2
;$C1/D639 A0 0B 00    LDY #$000B              A:04FB X:04E8 Y:0000 P:envmxdizc
.patch ($C1D639)
	ldy.w #$000D
.endp (0)

;largeur ligne finale
;$C1/D661 A0 0B 00    LDY #$000B              A:04FE X:06E8 Y:0000 P:envmxdizc
.patch ($C1D661)
 ldy.w #$000D
.endp (0)

; a quelque chose avoir avec le degradé
;$C3/DF8B A2 80 61    LDX #$6180              A:FF7E X:6180 Y:0970 P:envmxdizc
;.patch ($C3DF8B)
; ldx.w #$617E
;.endp (0)


;perso 1
;decalage du nom

.patch ($C1D839)
 ldx.w #$0502
.endp (0)

; ptvie
;$C1/D8CB A2 12 05    LDX #$0512              A:0001 X:5A08 Y:8469 P:envmxdizc
.patch ($C1D8CB)
 ldx.w #$0510
.endp (0)

; pm
;$C1/D99E A2 1C 05    LDX #$051C              A:0001 X:5A08 Y:8469 P:envmxdizc
.patch ($C1D99E)
 ldx.w #$051A
.endp (0)

; ===============================================================================
; perso 2
;$C1/D85D A2 84 05    LDX #$0584              A:0004 X:050E Y:6B22 P:envmxdiZc
.patch ($C1D85D)
 ldx.w #$0582
.endp (0)

; ptvie
;$C1/D8FC A2 92 05    LDX #$0592              A:0004 X:051A Y:8469 P:envmxdizc
.patch ($C1D8FC)
 ldx.w #$0590
.endp (0)

;pm
.patch ($C1D9CF)
 ldx.w #$059A
.endp (0)

; ===============================================================================
; perso 3
; nom
.patch ($C1D881)
 ldx.w #$0602
.endp (0)

; pv
.patch ($C1D92D)
 ldx.w #$0610
.endp (0)

; pm
.patch ($C1DA00)
 ldx.w #$061A
.endp (0)

; ===============================================================================
;perso 4
; nom
.patch ($C1D8A5)
 ldx.w #$0682
.endp (0)

;pv
.patch ($C1D95E)
 ldx.w #$0690
.endp (0)

;pm
.patch ($C1DA31)
 ldx.w #$069A
.endp (0)

; effacement du nom monstre ?
; pos

;postion
;$C1/D6FE A2 EA 04    LDX #$04EA              A:FFFF X:8969 Y:0000 P:eNvmxdizC
.patch ($C1D6FE)
 ldx.w #$04E4
.endp (0)

;longeur
;$C1/D701 A9 09 00    LDA #$0009              A:FFFF X:04EA Y:0000 P:envmxdizC
.patch ($C1D701)
 lda.w #$000D
.endp (0)

;$C1/D708 A2 2A 05    LDX #$052A              A:0103 X:04FC Y:0000 P:envmxdizC
.patch ($C1D708)
 ldx.w #$0524
.endp (0)

;$C1/D70B A9 09 00    LDA #$0009              A:0103 X:052A Y:0000 P:envmxdizC
.patch ($C1D70B)
 lda.w #$000D
.endp (0)


;$C1/D712 A2 6A 05    LDX #$056A              A:0103 X:053C Y:0000 P:envmxdizC
.patch ($C1D712)
 ldx.w #$0564
.endp (0)

;$C1/D715 A9 09 00    LDA #$0009              A:0103 X:056A Y:0000 P:envmxdizC
.patch ($C1D715)
 lda.w #$000D
.endp (0)


;$C1/D726 A2 EA 05    LDX #$05EA              A:0103 X:05BC Y:0000 P:envmxdizC
.patch ($C1D726)
 ldx.w #$05E4
.endp (0)

;$C1/D729 A9 09 00    LDA #$0009              A:0103 X:05EA Y:0000 P:envmxdizC
.patch ($C1D729)
 lda.w #$000D
.endp (0)

;$C1/D71C A2 AA 05    LDX #$05AA              A:0103 X:057C Y:0000 P:envmxdizC
.patch ($C1D71C)
 ldx.w #$05A4
.endp (0)

;$C1/D71F A9 09 00    LDA #$0009              A:0103 X:05AA Y:0000 P:envmxdizC
.patch ($C1D71F)
 lda.w #$000D
.endp (0)


;$C1/D730 A2 2A 06    LDX #$062A              A:0103 X:05FC Y:0000 P:envmxdizC
.patch ($C1D730)
 ldx.w #$0624
.endp (0)

;$C1/D733 A9 09 00    LDA #$0009              A:0103 X:062A Y:0000 P:envmxdizC
.patch ($C1D733)
 lda.w #$000D
.endp (0)


;$C1/D73A A2 6A 06    LDX #$066A              A:0103 X:063C Y:0000 P:envmxdizC
.patch ($C1D73A)
 ldx.w #$0664
.endp (0)

;$C1/D73D A9 09 00    LDA #$0009              A:0103 X:066A Y:0000 P:envmxdizC
.patch ($C1D73D)
 lda.w #$000D
.endp (0)


;$C1/D744 A2 AA 06    LDX #$06AA              A:0103 X:067C Y:0000 P:envmxdizC
.patch ($C1D744)
 ldx.w #$06A4
.endp (0)

;$C1/D747 A9 09 00    LDA #$0009              A:0103 X:06AA Y:0000 P:envmxdizC
.patch ($C1D747)
 lda.w #$000D
.endp (0)

;debug effacement affiche un caractère a la place du blanc afin de s'assurer qu'on efface
; toute la zone
;$C9/D737 A9 03 01    LDA #$0103              A:0009 X:04EA Y:0000 P:envmxdizC
;.patch ($C9D737)
; lda.w #$0055
;.endp (0)