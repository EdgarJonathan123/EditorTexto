;=====================================================================================
;=========================== Principales para obtner texto ===========================
;=====================================================================================

;====================================
 	print macro cadena 
	    mov dx, offset cadena 
        call WriteString
    endm

    println macro cadena
        print cadena
        print salto
    endm

    read macro cadena
        mov dx,offset   cadena
        mov cx,lengthof cadena
        call ReadString
    endm
	imprimir macro
		call PrintAl
	endm
;===================================
   iniciarDs macro 
        mov ax,@data        ;pasamos la direccion de data a ax
        mov ds,ax           ;Inicializa DS
    endm
;====================================

getChar macro
mov ah,0dh
int 21h
mov ah,01h
int 21h
endm
;====================================

;===============================================================================
;=========================== FICHEROS ==========================================
;===============================================================================

;====================================
abrirF macro ruta, handle
	mov ah,3dh
	mov al,010b
	lea dx, ruta
	int 21h
	jc ErrorAbrir
	mov handle,ax
endm
;====================================

leerF macro handle, numBytes, bufferOut
	mov ah,3fh
	mov bx,handle
	mov cx,numBytes
	lea dx, bufferOut
	int 21h
	jc ErrorLeer
	
endm
;====================================
crearF macro ruta, handle
	mov ah, 3ch
	mov cx, 00h
	lea dx, ruta
	int 21h
	jc ErrorCrear
	mov handle, ax
endm

crearReporteFinal macro
	mov ah, 3ch
	mov cx, 00h
	lea dx, rutaRFinal
	int 21h
	jc ErrorCrear
	mov ptrRFinal, ax
endm

;====================================
escribirF macro handle, numBytes, buffer
	mov ah, 40h
	mov bx, handle
	mov cx, numBytes
	lea dx, buffer
	int 21h
	jc ErrorEscribir
endm

escribirRFinal macro numBytes, buffer
	mov ah, 40h
	mov bx, ptrRFinal
	mov cx, numBytes
	lea dx, buffer
	int 21h
	jc ErrorEscribir
endm
;====================================

cerrarRFinal macro
    mov ah,3eh
    mov bx,ptrRFinal
    int 21h
    jc ErrorCerrar
endm


cerrarF macro Handle
    mov ah,3eh
    mov bx,handle
    int 21h
    jc ErrorCerrar
endm
;===========================================================================================
;=========================== Tratamiento de texto ==========================================
;===========================================================================================



 	toCapital macro cadena
        mov dx,offset cadena
		push dx
        call LetraCapital
	endm

	InvertirP macro cadena
		mov dx,offset cadena
		push dx
        call Recorrer
	endm

;====================================
AMinuscula macro arreglo

LOCAL continuar, finalizar, MAYUSCULA, MAYOR,MENOR ,AUMENTAR

	xor di,di 

    continuar:

        cmp arreglo[di],24h
            je finalizar
        jmp MAYOR


    MAYOR: 
    ; ARREGLRO[DI] >= A
        cmp arreglo[di],41h
            jae MENOR 
        jmp AUMENTAR    
    
    MENOR:
     ; ARREGLRO[DI] =< Z
        cmp arreglo[di],5ch
			jbe MAYUSCULA
        jmp AUMENTAR        

	MAYUSCULA:
		mov al,arreglo[di]
		mov ah,20h

		add ah, al

		mov arreglo[di],ah
    
        
    AUMENTAR:
        inc di
        jmp continuar
       
    finalizar: 
    
endm
;====================================

AMayuscula macro arreglo

	LOCAL continuar, finalizar, MAYUSCULA, MAYOR,MENOR ,AUMENTAR

	xor di,di 

    	continuar:

        	cmp arreglo[di],24h
            	je finalizar
        	jmp MAYOR


    	MAYOR: 
    	; ARREGLRO[DI]>=a
        	cmp arreglo[di],61H
            	jae MENOR 
        	jmp AUMENTAR    
    
    	MENOR:
     	; ARREGLRO[DI]=<z
        	cmp arreglo[di],7AH
			jbe MINUSCULA
        jmp AUMENTAR        

		MINUSCULA:
			mov al,arreglo[di]
			mov ah,20h

			sub al,ah

			mov arreglo[di],al
    
        
    	AUMENTAR:
        	inc di
        	jmp continuar
       

    	finalizar: 
    


endm
;====================================

;===========================================================================================
;=========================== Manejo Arreglos ===============================================
;===========================================================================================

contarElementos macro arreglo   ;en di te devuelve el numero de elementos del arreglo en di
    LOCAL continuar, finalizar
    xor di,di
    continuar:
        cmp arreglo[di],0
        je finalizar
        inc di
        jmp continuar
    finalizar: 
endm


sizeCadena macro cadena
        push offset cadena              ;Enviamos parameter1
    	call Str_length                 ;EAX = longitud de la cadena
endm