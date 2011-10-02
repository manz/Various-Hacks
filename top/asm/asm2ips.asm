;====================================================================
; IPS Macros by F.H, DF
;====================================================================

YES = 1                         ; boolean values
NO  = 0
LOW = 20                        ; memory maps
HI  = 21
MEMMAPSET .MACRO (memap,smchdr)
	memmap = memap
	smcheader = smchdr
.ENDM

; *** MACRO DATA ***
STARTFILE .MACRO (memap,smchdr)
        .ORG $0000                      ; start address for IPS
        .dcb "PATCH"                    ; IPS header signature
        memmap = memap                  ; low = lorom upto 16mb, hi = hirom upto 32mb
        smcheader = smchdr              ; either "yes" or "no".
.ENDM
ENDFILE .MACRO (nothing)
        .db "EOF"
.ENDM

PATCH .MACRO (ADDR)
.MODULE _+ADDR                  ; append '_' to address for module name 

@STEP1 = ADDR && $3FFFFF        ; convert rom address to absolute...

;.IF MEMMAP = LOW                ; lorom address
;	@TB = ^ADDR && $01
;	@STEP2 = ((@STEP1 /2) && $FF0000) || !ADDR
;	.IF @TB = 0
;		@STEP3 = @STEP2 && $FF7FFF
;	.ELSE
;		@STEP3 = @STEP2
;	.ENDIF
;	
;	.HIROM OFF
;.ENDIF

.IF MEMMAP = HI                 ; hirom address
        @STEP3 = @STEP1
        .HIROM ON
.ENDIF

.IF SMCHEADER = YES
        @ND = @STEP3 + $200 ; account for smc header
.ELSE
        @ND = @STEP3
.ENDIF


.DCB ^@ND                       ; write destination file offset
.DCB >@ND
.DCB <@ND

;DATA LENGTH SECTION.
@DATA_LENGTH = @END - @BEGIN    ; write patch length
.DCB >@DATA_LENGTH
.DCB <@DATA_LENGTH
.BASE ADDR                      ; set address to assemble code at
@BEGIN                          ; start of code
.ENDM

ENDP  .MACRO (nothing)
@END                            ; end of code
.END                            ; end base directive
.END                            ; end module directive
.ENDM
