include console.inc

;ВАРИАНТ 5-5-3

.data
    text dB 201 DUP(?),0 ; 200 for 2rule 1 for size
    alphabet dB 28 DUP(0) ; for checkFunc
    
.code

    read proc
        push EBX
        push ECX
        push EDX
        
        mov ECX, 100d
        mov EDX, 1d
        mov EBX, 0d
        
        readIn:
            inchar BL
            cmp BL, "."
            JZ fin
            mov text[EDX], BL
            INC EDX
        loop readIn
        
        fin: 
        sub EDX, 1
        mov text[0], DL
        
        pop EDX
        pop ECX
        pop EBX
        RET
    read endp
    
    
    
    write proc
        push EBX
        push ECX
        push EDX
        
        mov EBX, 0d
        mov EDX, 1d
        mov ECX, 0d
        mov CL, text[0]
        
        WriteOut:
            mov BL, text[EDX]
            outchar BL
            inc EDX
        loop WriteOut
        
        pop EDX
        pop ECX
        pop EBX
  
        RET
    write endp
    
    RuleOne proc
        outstrln "Rule #1"
        push EBX
        push ECX
        push EDX
        
        mov EBX, 0d
        mov EDX, 1d
        mov ECX, 0
        mov CL, text[0]
        
        parsing:
            mov BL, text[EDX]
            cmp BL, 65
            JB conty
            cmp BL, 90
            JA conty
            ADD text[EDX], 32
            
            conty:
            inc EDX
        loop parsing
        
        pop EDX
        pop ECX
        pop EBX
        RET
    RuleOne endp
    
    RuleTwo proc
        outstrln "Rule #2"
        
        push EBX
        push ECX
        push EDX
        
        mov EBX, 0
        mov EDX, 0
        mov ECX, 0
        mov CL, text[0]
        mov DL, text[0]
        
       
        
        parsing:
            mov BL, text[ECX]
            cmp BL, 65
            JB NO
            cmp BL, 90
            JA MeyBE
            push EBX
            inc DL
            jmp NO
          MeyBE:
            cmp BL, 97
            JB NO
            cmp BL, 123
            JA NO
            push EBX
            inc DL
          NO:
          push EBX
          
        loop parsing
        
        mov ECX, EDX
        mov text[0], DL
        mov EDX, 1
       
        newmas:
            pop EBX
            mov text[edx], BL   
            inc edx     
        loop newmas
        
        
        pop EDX
        pop ECX
        pop EBX
        RET

    RuleTwo endp
    
    
    
    checkFunc proc
    
        
        push EBX
        push ECX
        push EDX
        
        mov EBX, 0d
        mov EDX, 1d
        mov ECX, 0
        mov CL, text[0]
        
        parsing:
            mov BL, text[EDX]
            cmp BL, 65
            JB NO
            cmp BL, 90
            JA MeyBE
            inc alphabet[EBX - "A" + 1 ]
            jmp NO
          MeyBE:
            cmp BL, 97
            JB NO
            cmp BL, 123
            JA NO
            dec alphabet[EBX - "A" - 31]
          NO:
            inc EDX
        loop parsing
        
        mov ECX, 26
        
        A:
            cmp alphabet[ECX], 0
            JZ R
            call RuleTwo
            jmp final
            R:
        loop A
        
        CALL RuleOne
        final:
        pop EDX
        pop ECX
        pop EBX
        RET
    checkFunc endp
    
    


START:
    
    call read
    call checkFunc
    call write
    
EXIT
end START
