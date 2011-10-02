
; déplacement des items du menu principal

.patch ($C27AB1)
 LDA.W #$000F
.endp (0)

;$C2/7AB9 99 80 41    STA $4180,y[$7E:42A4]   A:2DF8 X:0002 Y:0124 P:envmxdizc
.patch ($C27AB9)
 STA.W $417E,y
.endp (0)


.patch ($C2803E)
 STA $3196,X
 STA $3198,X
 STA $3140,X
 STA $3142,X
 STA $3144,X
 STA $3146,X
 STA $3148,X
 STA $314A,X
.endp (0)

.patch ($C27EBD)
 ADC.W #$0044
.endp (0)

.patch ($C28001)
 ADC.W #$0044
.endp (0)

.patch ($F0C46B)
 LDA.W #$0013
.endp (0)

;9D9031
; décalage ":"
.patch ($C27FA9)
 STA $3194,X
.endp (0)

.patch ($C27FAF)
 ADC.W #$0016
.endp (0)