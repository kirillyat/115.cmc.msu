include console.inc

.data

      ten dW 10d
     zero dB '0'
     prev dB '+'
      rez dD 0

.code

;eСx - результат



			plus:
			    ADD ECX, EAX
			jmp conty

			minus:
			   sub ECX, EAX
			jmp conty


			devid:
			mov edx, 0
			   xchg EAX, ECX
			   DIV ECX
			   xchg EAX, ECX
			jmp conty

			mylty:
			mov edx, 0
			   xchg EAX, ECX
			   MUL ECX
			   xchg EAX, ECX
			jmp conty



		 
			step:
				    MUL ten
				    SUB BL, '0'
				    ADD EAX, EBX
				    MOV EBX, 0
				    inchar BL
			jmp retur			     


			innum:  

			        MOV EAX, 0

			    onemore:

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
			        jmp final

			    retur:

			    	inchar BL
			    	jmp onemore

			    final:

			RET        
			   


	priority PROC 
		
				MOV ECX, 0
				MOV EBX, 0
				MOV EAX, 0
				MOV prev,'+'
				inchar BL


			fromSAFE:		
		   		cmp prev, '('
		            jz saveANDnext
		        cmp prev, ')'
		            jz close ; TODO
		        cmp prev, '+'
		            jz plus
		       
		        cmp prev, '-'
		            jz minus
		        
		        cmp prev, '/'
		            jz devid
		        
		        cmp prev, '*'
		            jz multy

		          		conty::

		            					; в  eax  запишем новую цифру
		    				cmp BL, '0'
					            jz num
					        cmp BL, '1'
					            jz num
					        cmp BL, '2'
					           	jz num
					        cmp BL, '3'
					         	jz num
					        cmp BL, '4'
					 		 	jz num
					        cmp BL, '5'
								jz num
					        cmp BL, '6'
								jz num
					        cmp BL, '7'
						       	jz num
					        cmp BL, '8'
					            jz num
					        cmp BL, '9'
					            jz num  


		     
			contyn:

				MOV prev, BL




		    back:

	RAT

			num:
				CALL innum
			jmp contyn

			saveANDnext: 
				push ECX
				push dword ptr prev
				CALL priority
				pop EBX
				MOV prev, BL
				pop EAX
		        

			jmp fromSAFE

			close:
				
		    jmp back

	priority ENDP





Start
	CALL priority
Exit
end Start
