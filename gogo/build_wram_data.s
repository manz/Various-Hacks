; calcul de l'index au quel la routine ecrit les 16 octets
correct_wram_pos

/*
lda $04
and $01
beq finish
lda #$0020
clc
adc $14
sta $14

finish
*/


; on charge l'index "original"
lda $14

; on ne garde que les deux derniers octets 
; note à moi même : cela ne limite t'il pas la longueur de la ligne à 16 lettres ?
and #$00FF
; on divise par 2 (on copie 2 fois moins d'octets donc on décale de 2 fois moins)
lsr
sta $18

lda $cc
xba
lsr
pha
and #$00FF
asl
asl
asl
asl
asl
asl
asl

clc
adc $18
sta $18
pla
lsr
xba
; on additionne l'offset de la ligne 0 0x200 0x400 ...
clc
adc $18

; on le stocke et on retourne dans la routine originale
sta $18

;bra finale2


lda $18
clc
adc @line_jump_count
sta $18

jmp @ret_correct_wram_pos
