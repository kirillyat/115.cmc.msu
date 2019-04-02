
include console.inc

.data

      ten dW 10d
     zero dB '0'
     prev dB '+'
      rez dD 0

.code

innum:  
        MOV EAX, 0
    retur:
        MOV EBX, 0
        inchar BL
      
     
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
RET        
   
Start:
    onemore:

        CALL innum ;çàïèñûâàåò íîâîå ÷èñëî â edx

        cmp prev, '+'
            jz plus
       
        cmp prev, '-'
            jz minus
        
        cmp prev, '/'
            jz devid
        
        cmp prev, '*'
            jz mylty
        
    conty:

        cmp BL, '='
           jz final
    
        mov prev, BL

    jmp onemore
        
    
    final:
        outintln rez

exit 


step:
    MUL ten
    SUB BL, '0'
    ADD EAX, EBX
jmp retur
     

plus:
    ADD rez, EAX
jmp conty

minus:
   sub rez, EAX
jmp conty


devid:
mov edx, 0
   xchg EAX, rez
   Div rez
   xchg EAX, rez
jmp conty

mylty:
mov edx, 0
   xchg EAX, rez
   MUL rez
   xchg EAX, rez
jmp conty


end Start
