include console.inc

.data
    N dD 0
    index dD ?

.code

    PROC fun:

        ;СОГЛАШЕИЕ О СВЯЗЯХ
        ; EBX - Начало Массива
        ; N - размер массича


        ;АЛОГОРИТМ ПУЗЫРЬКА НА НОРМАЛЬНОМ ЯЗЫКЕ(ПИТОН)
        ;for i in range(len(massive)-1):
        ;   for j in range(len(massive)-1-i):
        ;       if massive[j] > massive[j+1]:
        ;           massive[j], massive[j+1] = massive[j+1], massive[j]


        mov ECX, N

        sotri:
            push ECX
            mov ECX, N
            sortj:
                cmp[EBX-4*ECX], [EBX-4*(ECX-1)]
                JG swap
                next:
                loop sortj
            pop ECX
            loop sorti

        RET

        swap:
            xchg ECX, [EBX-4*ECX]
            xcng ECX, [EBX-4*(ECX-1)]
            xchg ECX, [EBX-4*ECX]
            JMP next

    fun ENDP



START:

    ;РАЗМЕР МАССИВА
        inint ECX
        mov N, ECX


        mov EBX, ESP
        sub EBX, 4 ; ТК первый элемент будет располагаться по след. адресу


    ;ВВОДИМ МАССИВ
    inputArray:    
        inint EAX
        pop EAX
        loop inputArray
    

    CALL fun



EXIT

end START
