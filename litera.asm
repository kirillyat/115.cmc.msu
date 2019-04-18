include console.inc

.data

    text dB 101 DUP(?)
    a db 97
    
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
        
        mov ECX, 0
        mov cl, text[0]
        
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
        mov EDX, 1db
        mov ECX, 0
        mov cl, text[0]
        
        
        pop EDX
        pop ECX
        pop EBX
    RET
    RuleOne endp
    
    
    
    
    
    RuleTwo proc
        outstrln "Rule #2"
    
    RET
    RuleTwo endp


START:
    
    outchar a
    sub a, 32
    outchar a

EXIT
end START
