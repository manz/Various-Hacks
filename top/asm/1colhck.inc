; restes du one col hack
;One col Hack ?

.patch ($C27EED)
 ADC.W #$0080
.endp (0)

.patch ($C27EFE)
 ADC.W #$0080 
.endp (0)

;F0C46B 
.patch ($F0C46B)
 LDA.W #$0015
.endp (0)

.patch ($C27FAF)
 ADC.W #$0024
.endp (0)

; décalage ":"
.patch ($C27FA9)
 STA $319E,X
.endp (0)