;================= Declaracion de Macros==========================

    iniciarDs macro 
        mov ax,@data
        mov ds,ax           ;Inicializa DS
    endm

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

;================= Fin Declaracion de Macros======================

;================= DECLARACION TIPO DE EJECUTABLE ================
    .model small , stdcall
    .286
    .stack 100h 
    .data 
;================= FIN TIPO DE EJECUTABLE ========================

;================ SECCION DE DATOS ================================

    ;ini variables globales
        salto   db  0ah,0dh,0
        num     db  030h,030h,0
    ;fin variables globales



    msm0    db '***UNIVERSIDAD DE SANCARLOS DE GUATEMALA***',0
    prueba  db 'esto es un prueba xd',0
    corA    db '[',0
    corC    db ']',0

    texto db 100 dup(?)

;===================== FIN  DE DATOS ==============================
.code
;================== SECCION DE CODIGO =============================
	main proc     
        
        iniciarDs

        println msm0
        read  texto
        println prueba
        println texto
       

        
	    call exit
	main endp

    exit proc 
        MOV ah,4ch 
	    int 21h
        ret
    exit endp

    ReadString proc
        ;---------------------------------------------------------------;
        ;   Recibe:     DS:DX apunta al bufer de entrada,              ;
        ;               CX= maximo de caracteres de entrada.            ;
        ;                                                               ;
        ;   Devuelve:   AX= tamana de la cadena de entrada.             ;
        ;                                                               ;       
        ;   Comentarios:Se detiene cuando se oprime Intro(0dh),         ;
        ;               o cuando se leen (CX-1) caracateres.            ; 
        ;---------------------------------------------------------------;

        push cx                     ;guarda los registros
        push si 
        push cx                     ;guarda la cuenta de digitos otra vez
        mov si,dx                   ;apunta al buffer de entrada
        dec cx                      ;guarda el spacio para el byte nulo

        L1:
            mov ah,1                ;funcionn de entrada del teclado
            int 21h                 ;DOS devuelve el caracter en AL
            cmp al,0dh              ;¿fin de linea? 
            je L2                   ;si: termina
            mov [si],al             ;no: guarda el caracter
            inc si                  ;incrementa el apuntador al bufer
            loop L1                 ;itera hasta CX = 0

        L2:
            mov byte ptr[si],0      ;termina con un byte nulo
            pop ax                  ;cuenta de digitos original
            sub ax,cx               ;AX= tamanio de la cadena de entrada 
            dec ax          
            pop si                  ;restaura los registros
            pop cx
        
        ret
    ReadString endp

    Str_length proc
        ;--------------------------------------------------------------------;
        ;   Recibe:     DS:[ebp+8] apunta al arreglo                         ;
        ;                                                                    ;
        ;   Devuelve:   AX= tamanio de la cadena de entrada.                 ;
        ;                                                                    ;       
        ;   Comentarios:Se detiene cuando se encuentra (0dh)en el arreglo.   ;
        ;--------------------------------------------------------------------;
        
        ;Subrutina proglogo
        push bp                    ;almacenamos el puntero base
        mov  bp,sp                 ;ebp contiene la direccion de esp
        push di                    ;guarda edi para no perder el valor al salir

        ;Ini Codigo--
            mov di,[bp+4]    ;guarda Parametro1 en edi
            xor ax,ax                 ;eax=0 

            L1:
                cmp byte PTR[di],0      ;¿final de cadena?
                je  L2                  ;si: termina
                inc di                  ;no: apunta al siguiente
                inc ax                  ;suma 1 a la cuenta 
                jmp L1

        ;Fin Codigo--
        
        L2: 
            ;Subrutina epilogo
            pop di                  ;obtenemos el valor devuelta
            mov sp,bp               ;esp vuelve apuntar al inicio y elimina las variables locales
            pop bp                  ;restaura el valor del puntro base listo para el ret
            ret 2
    Str_length endp
 
    WriteString proc
        ;--------------------------------------------------------------------;
        ;   Recibe:      DS:DX apunta a la cadena                            ;
        ;                                                                    ;
        ;   Devuelve:    Nada.                                               ;
        ;                                                                    ;       
        ;   Comentarios: Recibe una cadena con terminacion nula y            ;   
        ;                lo imprime en la salida estandar                    ;
        ;--------------------------------------------------------------------;

        ;Subrutina proglogo
        pusha

        push ds                         ;ES=DS
        pop  es

        ;Ini Codigo--
            push dx                         ;Enviamos parameter1
            call Str_length                 ;EAX = longitud de la cadena
            mov cx,ax                       ;ECX = numero de bytes
            mov ah,40h                      ;Escribe al archivo o dispositivo
            mov bx,1                        ;manejador de salida estandar
            int 21h                         ;llamada a ms-dos
        ;Fin Codigo--

        popa
        ret
    WriteString endp
   

;================ FIN DE SECCION DE CODIGO ========================
end

;===============Codigos Comentados alv =============================

    ;    Str_length PROC USES di,
    ;        Pstring:PTR byte            ;apuntador a la cadena
    ;        mov di,Pstring  
    ;        xor ax,ax                   ;cuenta de caracteres
    ;
    ;        L1:
    ;            cmp byte PTR[di],0      ;¿final de cadena?
    ;            je  L2                  ;si: termina
    ;            inc di                  ;no: apunta al siguiente
    ;            int ax                  ;suma 1 a la cuenta 
    ;            jmp L1
    ;
    ;        L2: ret
    ;    Str_length endp



    ;   WriteString proc
    ;       MOV ah,09h 
    ;	    int 21h
    ;        ret
    ;    WriteString endp

;===============fIN     Comentados alv =============================    