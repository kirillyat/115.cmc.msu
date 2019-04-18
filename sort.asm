include console.inc

.data

.code

    sort proc
        push EAX
        push EBX
        push ECX
        push EDX
    
        ;END of pushing registers
        
        ;size in ecx and edx
        
         inint EDX
         mov ECX, EDX
    
        input:
            inint EAX
            push EAX
        loop input
    
        mov ECX, EDX
        
        A:
            push ECX
            mov ECX, EDX
            dec ECX
            B:
                
                mov EAX, [ESP+4*ECX+4]
                cmp EAX, [ESP+4*ECX]
                JA next
                xchg EAX, [ESP+4*ECX]
                
                
                mov [ESP+4*ECX+4], EAX
               next:
            loop B
            pop ECX
            
        loop A
        
        
         mov ECX, EDX
         mov EBX, 0
         output:
            pop EBX
            outint EBX
            outchar " "
         loop output
        
        
        
        
        pop EDX
        pop ECX
        pop EBX
        pop EAX

    RET
    
    sort endp



START:
    CALL sort
EXIT
end START
