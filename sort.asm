include console.inc

.data
    N dD 0
    index dD ?

.code

    PROC fun:
        push EBP
        mov EBP, ESP



        RET
        fun ENDP



START:

    ;РАЗМЕР МАССИВА
        inint ECX
        mov N, ECX


        mov EBX, ESP
        add EBX, 4 ;ТК первый элемент будет располагаться по след. адресу


    ;ВВОДИМ МАССИВ
    inputArray:    
        inint EAX
        pop EAX
        loop inputArray
    

    CALL fun



EXIT

end START
