.lowrom2

; deroutage
; lda $14
; sta $18
*=0x818654
jmp @correct_wram_pos
ret_correct_wram_pos

; nombre d'octets à copier
; ldy #$0010
; 16 octets = 8x8 pixels en 2bpp
; la routine effectue une boucle sur Y et copie 32 octets
; -- 16
; -- 16
*=0x818658
.xl
ldy #$0008

; calcul de l'index au quel la routine ecrit les 16 octets
*=0x88BE00
correct_wram_pos

; on charge l'index "original"
lda $14

; on ne garde que les deux derniers octets 
; note à moi même : cela ne limite t'il pas la longueur de la ligne à 16 lettres ?
and #$00FF
; on divise par 2 (on copie 2 fois moins d'octets donc on décale de 2 fois moins)
lsr
clc
; on additionne l'offset de la ligne 0 0x200 0x400 ...
adc $cc
; on le stocke et on retourne dans la routine originale
sta $18
jmp @ret_correct_wram_pos
