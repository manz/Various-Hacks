
mz_init
.al
.xl
lda $87D000,x
pha
phx

lda #$0000
sta @line_jump_count

plx
pla


jmp @ret_mz_init
