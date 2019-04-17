include console.inc

.data
    N dD ?
.code

    sort proc
        
        push EBP
        mov EBP, ESP
        push EAX
        push EBX
        push ECX
        mov ECX, [EBP+8]    ;SIZE
        ;END of pushing registers and collecting data
        
        ;size in ecx
        A:
            push ECX
            mov ECX, [EBP+8]
            dec ECX
            B:
                
                mov EAX, [EBP+8+4*ECX+4]
                cmp EAX, [EBP+8+4*ECX]
                JA next
                xchg EAX, [EBP+8+4*ECX]
                
                next:
                mov [EBP+8+4*ECX+4], EAX
               
            loop B
            pop ECX
            
        loop A
        
        
        
        
        
        pop ECX
        pop EBX
        pop EAX
        pop EBP

    RET 4 ;delete size from stack
    
    sort endp



START:

    inint ECX
    mov N, ECX
    
    input:
        inint EAX
        push EAX
    loop input
    
    push N ; will be deleted in stack
    CALL sort
    
    mov ECX, N
    output:
        outint [ESP+4*ECX-4]
        outchar " "
    loop output


EXIT
end START




