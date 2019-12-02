include console.inc

    n equ 9
.data
    a db 1
    w db 2
    r db 5
    
.code

writein macro A, B
    mov dword ptr A, B
endm

checkargs1 macro A, B, C
    ifidn <A>, <>
        echo <NO arg - 1!!!!!!!>
        .err
    endif
    ifidn <B>, <>
        echo <NO arg - 2!!!!!!!>
        .err
    endif
    ifidn <C>, <>
        echo <NO arg - 3!!!!!!!>
        .err
    endif 
endm 

ADDTHREE macro A, B, C
    checkargs1 A, B, C      
    
    push EAX
    XOR EAX, EAX
    ADD EAX, dword ptr A
    ADD EAX, dword ptr B
    ADD EAX, dword ptr C


    if type A NE 0
        writein A, EAX
    elseif type B NE 0
        writein B, EAX    
    elseif type C NE 0
        writein C, EAX
    else
        .err<CONSTANTS?!??!?!?>
    endif
    pop EAX
    
endm


START:
    
    inint edx

    ADDTHREE edx, 1 , a 
    
    outint edx
    
    
exit
end START

