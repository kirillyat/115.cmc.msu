include console.inc

.data

	ten dW 10d
	zero dB '0'
   	prev dB '+'
   	rez dD 0

.code

priority PROC 
        
        MOV EAX, 0
        MOV EBX, 0
        MOV ECX, 0
        inchar BL

    again::      

        cmp prev, '('
            jz open
        cmp prev, ')'
            jz close
        cmp prev, '+'
            jz plus
        cmp prev, '-'
            jz minus
        cmp prev, '/'
            jz devid
        cmp prev, '*'
            jz multy
        cmp prev, '='
            jz crash

    conty::                                       
        cmp BL, '0'
            jz num
        cmp BL, '1'
            jz num
        cmp BL, '2'
            jz num
        cmp BL, '3'
            jz num
        cmp BL, '4'
            jz num
        cmp BL, '5'
            jz num
        cmp BL, '6'
            jz num
        cmp BL, '7'
            jz num
        cmp BL, '8'
            jz num
        cmp BL, '9'
            jz num  
    contyn::
        MOV prev, BL
        inchar BL
    jmp again

    close:
        RET
    priority ENDP




START:
 	   CALL priority
	crash:
   		outintln ECX
exit

plus:
        ADD ECX, EAX
        jmp conty

minus:
        sub ECX, EAX
        jmp conty

devid:
        mov edx, 0
        xchg EAX, ECX
        DIV ECX
        xchg EAX, ECX
        jmp conty

multy:
        mov edx, 0
        xchg EAX, ECX
        MUL ECX
        xchg EAX, ECX
        jmp conty

step:
        MUL ten
        SUB BL, '0'
        ADD EAX, EBX
        MOV EBX, 0
        inchar BL
        jmp retur                


innum:  
        MOV EAX, 0
    onemore:
        cmp BL, '0'
            jz step
        cmp BL, '1'
            jz step
        cmp BL, '2'
            jz step
        cmp BL, '3'
            jz step
        cmp BL, '4'
            jz step
        cmp BL, '5'
            jz step
        cmp BL, '6'
            jz step
        cmp BL, '7'
            jz step
        cmp BL, '8'
            jz step
        cmp BL, '9'
            jz step
        jmp final
    retur:
        inchar BL
        jmp onemore
    final:  
        RET
num:
        CALL innum
        jmp contyn

open: 
        push ECX
        push EBX
        CALL priority
        pop EBX
        MOV prev, BL
        pop EAX
        jmp again



end START
