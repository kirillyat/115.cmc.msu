include console.inc
 
.data

    ten dD 10
    prev dD '+'
    S dD ' '
    res dD 0
 
.code
Start:





START:

  mov EAX, 0
    Again:  
        cmp prev,'='
            jz finish
           
        mov EBX, 0
        inchar BL
        mov S, EBX
        sub EBX, '0'
        cmp EBX, 0 ; IF not a num
            jl sign;
        cmp EBX, 9 ;
            jg sign;
        mul ten
        add EAX,EBX
    jmp Again
 

sign:
        cmp S,'('
        jz open      
 
        cmp prev,'+'
        jz plus
   
        cmp prev,'-'
        jz minus
   
        cmp prev,'*'
        jz mult
   
        cmp prev,'/'
        jz divis  
 
        jmp finish


plus:
        add res, EAX
        mov EAX, 0  
        mov EBX, S
        mov prev, EBX
        cmp S, ')'
        jz close
        jmp Again 

minus:  
        sub res, EAX
        mov EAX, 0
        mov EBX, S
        mov prev, EBX
        cmp S, ')'
        jz close
        jmp Again

mult:
        xchg res, EAX
        imul res
        xchg res, EAX
        mov EAX, 0
        mov EBX, S
        mov prev, EBX
        cmp S, ')'
            jz close
            jmp Again
       
divis:  
        xchg res, EAX
        cdq
        idiv res
        xchg res, EAX
        mov EAX, 0
 
        mov EBX, S
        mov prev, EBX
        cmp S, ')'
        jz close
        jmp Again
open:
        push res
        mov res,0
        push prev
        mov prev,'+'
        jmp Again
close:  
        pop prev
        pop EAX
        xchg res, EAX
        mov S,'+'
        jmp sign
	
finish:        
        outint res
exit
end Start
