include console.inc
 
.data
 
        err db 'err',0
        A db 3d
        B db 5d
 
.code
 
Start:  
 
       inint(ecx)
       mov eax, ecx
       mov ebx, ecx
       mov edx, 1
       
Again:
      mov eax, edx
      div A
      cmp AH, 0
      jz tri
     
      mov eax, edx
      div B
      cmp AH, 0
      jz five
     
      outint edx
     
  retur3:
 
      mov eax, edx
      div B
      cmp AH, 0
      jz five
     
  retur5:
 
      outstrln  ;перевод строки
 
      cmp edx, ecx
      jz finish
      inc edx
      jmp Again ;loop
       
  finish:
 
 exit
 
 tri:
     outstr 'Fizz'
     jmp retur3
   
 five:
   outstr 'Buzz'
     jmp retur5
