; hack qui vire ces ombres dans l'inventaire du menu
; principal

;pas de "fog of war" :)
.patch ($C27AB6)
 LDA.W #$0140
.endp (0)