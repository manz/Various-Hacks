; effacement des items+ décalage et augmentation

; pos effacement
.patch ($C14F90)
 ldx.w #$04C2
 lda.w #$001D
.endp (0)

;C14F9A LDX #$0504             A:0103 X:04FA Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14F9D LDA #$001B             A:0103 X:0504 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14F9A)
 ldx.w #$0502
 lda.w #$001D
.endp (0)

;C14FA4 LDX #$0544             A:0103 X:053A Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14FA7 LDA #$001B             A:0103 X:0544 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14FA4)
 ldx.w #$0542
 lda.w #$001D
.endp (0)

;C14FAE LDX #$0584             A:0103 X:057A Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14FB1 LDA #$001B             A:0103 X:0584 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14FAE)
 ldx.w #$0582
 lda.w #$001D
.endp (0)

;C14FB8 LDX #$05C4             A:0103 X:05BA Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14FBB LDA #$001B             A:0103 X:05C4 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14FB8)
 ldx.w #$05C2
 lda.w #$001D
.endp (0)

;C14FC2 LDX #$0604             A:0103 X:05FA Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14FC5 LDA #$001B             A:0103 X:0604 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14FC2)
 ldx.w #$0602
 lda.w #$001D
.endp (0)

;C14FCC LDX #$0644             A:0103 X:063A Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14FCF LDA #$001B             A:0103 X:0644 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14FCC)
 ldx.w #$0642
 lda.w #$001D
.endp (0)

;C14FD6 LDX #$0684             A:0103 X:067A Y:097A S:01D4 DB:7E D:0000 P:00 e
;C14FD9 LDA #$001B             A:0103 X:0684 Y:097A S:01D4 DB:7E D:0000 P:00 e
.patch ($C14FD6)
 ldx.w #$0682
 lda.w #$001D
.endp (0)


.patch ($C15313)
 lda.w #$00E8+8
.endp (0)

.patch ($C15360)
 lda.w #$00E8+8
.endp (0)

.patch ($C14FEA)
 LDX.W #$0502
.endp (0)

.patch ($C152B5)
 asl a
 sta.b $06
.endp (0)

; décalage des 2 pts
;ADC #$0012             A:0506 X:0506 Y:0020 S:01CD DB:7E D:0000 P:00 e
.patch ($C1504D)
 ADC.W #$0014
.endp (0)

; next pos
.patch ($C15076)
 ADC.W #$001C
.endp (0)

.patch ($F0C561)
 LDA.W #$0013
.endp (0)