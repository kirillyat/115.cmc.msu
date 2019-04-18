include console.inc
 
.data

    ten dD 10
    prev dD '+'
    S dD ' '
    res dD 0
 
.code
Start:





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
