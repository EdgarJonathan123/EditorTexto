include P3M.asm ; archivo con los macros a utilizar

;================= DECLARACION TIPO DE EJECUTABLE ================
    .model small , stdcall
    .286
    .stack 100h 
        ;ONE_VAR    EQU sub esp,2 
        ;TWO_VARS   EQU sub esp,4
        ;THREE_VARS EQU sub esp,6
        ;FOUR_varas EQU sub esp,8
        ;w_local    EQU BYTE PTR [ebp-2]
        ;x_local    EQU BYTE PTR [ebp-4]
        ;y_local    EQU BYTE PTR [ebp-6]  
        ;z_local    EQU BYTE PTR [ebp-8]
       
    .data 
;================= FIN TIPO DE EJECUTABLE ========================
;================ SECCION DE DATOS ================================
    msm0     db  '***UNIVERSIDAD DE SANCARLOS DE GUATEMALA***',0
    msm1     db  'FACULTAD DE INGENIRIA',0
    msm2     db  'CIENCIAS Y SISTEMAS',0
    msm3     db  'ARQUITECTURA DE COMPUTADORES  Y ENSAMBLADORES 1',0
    msm4     db  'SECCION B',0
    msm5     db  'NOMBRE: EDGAR JONATHAN ARRECIS MARTINEZ',0
    msm6     db  'CARNTE: 201602633',0
    msm7     db  'TAREA PRACTICA 3',0
    msm8     db  '****Menu Principal *****',0
    msm9     db  '1) Cargar Texto ',0
    msm10    db  '2) A Mayuscula',0
    msm11    db  '3) A Minuscula',0
    msm12    db  '4) A Capital',0
    msm13    db  '5) Buscar y Reemplazar',0
    msm14    db  '6) Invertir Palabras',0
    msm15    db  '7) Reporte Diptongos',0
    msm16    db  '8) Reporte Hiatos',0
    msm17    db  '9) Reporte Triptongos',0 
    msm18    db  '10) Reporte Final',0
    msm19    db  '11) Salir',0

    msm20    db  'selecciono -> carga Masiva',0
    msm21    db  'selecciono -> a mayuscula',0
    msm22    db  'selecciono -> a minuscula',0
    msm23    db  'selecciono -> a capital',0
    msm24    db  'selecciono -> buscar y reemplazar',0
    msm25    db  'selecciono -> invertir palabras',0
    msm26    db  'selecciono -> reporte diptongos',0
    msm27    db  'selecciono -> reporte hiatos',0
    msm28    db  'selecciono -> reporte triptongos',0
    msm29    db  'selecciono -> reporte reporte final',0
    msm30    db  'selecciono -> salir',0

    bucle    db 'estamos en el bucle alv ',0
    finfuncion db'estamos al final de la funcion antes del return alv',0
    txt     db ', es letra',0

    salto db 13,10,0
    tab   db 9,0

    corA db 91,0
    corC db 93,0


    ;---------------------Exito---------------------------
    msmsucces1 db  'Se Abrio el archivo exitosamente',0
    msmsucces2 db  'Se leyo el archivo con exito',0
    msmsucces3 db  'Se creo el archivo con exito',0
    msmsucces4 db  'Se Escribio el reporte con exito',0
    msmsucces5 db  'Se cerro el archivo con exito',0

    ;---------------------Errores---------------------------
    msmError1 db  'Error al abrir archivo',0
    msmError2 db  'Error al leer archivo',0
    msmError3 db  'Error al crear archivo',0
    msmError4 db  'Error al escribir reporte',0
    msmError5 db  'Error al Cerrar el archivo',0

    ;---------------------Arreglos---------------------------
    rutaArchivo db 100 dup(0)
    bufferLectura db 5000 dup(0)
    bufferAux     db 5000 dup(0)
    token         db 100  dup(0)
    bufferEscritura db 100 dup(0)
    ;---------------------Ficheros---------------------------
    handleFichero dw ?
    handle2 dw ?

;===================== FIN  DE DATOS ==============================
;----------------------Segmento de codigo---------------------------
.code
;================== SECCION DE CODIGO =============================
    main proc
        IniciarDs


        menuprincipal: ; etiqueta de prueba
            println msm0
            println msm1
            println msm2
            println msm3
            println msm4
            println msm5
            println msm6
            println msm7
            println salto
            println msm8
            println msm9
            println msm10
            println msm11
            println msm12
            println msm13
            println msm14
            println msm15
            println msm16
            println msm17
            println msm18
            println msm19
            print   tab
            getchar

            cmp al,31h  ;1
                je DESICION
            cmp al,32h  ;2
                je MAYUSCULA
            cmp al,33h  ;3
                je MINUS
            cmp al,34h  ;4
                je CAPITAL
            cmp al,35h  ;5
                je BUSCARYREEMPLAZAR
            cmp al,36h  ;6
                je INVERTIRPALABRA
            cmp al,37h  ;7
                je REPORTEDIPTONGO
            cmp al,38h  ;8
                je REPORTEHIATO
            cmp al,39h  ;9
                je REPORTETRIPTONGO
        jmp menuprincipal

        DESICION:
            getchar
            cmp al,30h  ;11
                je REPORTEFINAL
            cmp al,31h  ;12
                je SALIR
        jmp CARGA

        CARGA:
            print msm20
            print  tab
            read rutaArchivo
	    	abrirF rutaArchivo, handleFichero
            print msmsucces1
            getchar
        jmp menuprincipal
    
        MAYUSCULA:
            println msm21
		    leerF handleFichero, SIZEOF bufferLectura, bufferLectura

            print corA
            print bufferLectura
            print corC

            AMayuscula bufferLectura

            print corA
            print bufferLectura
            print corC
            getchar
        jmp menuprincipal

        MINUS:
            println msm22
		    leerF handleFichero, SIZEOF bufferLectura, bufferLectura

            print corA
            print bufferLectura
            print corC

            AMinuscula bufferLectura

            print corA
            print bufferLectura
            print corC
            getchar

        jmp menuprincipal
        
        CAPITAL:
            println msm23
            leerF handleFichero, SIZEOF bufferLectura, bufferLectura

            print corA
            print bufferLectura
            print corC

            toCapital bufferLectura

            print corA
            print bufferLectura
            print corC
            getchar

        jmp menuprincipal

        BUSCARYREEMPLAZAR:
            println msm24
            getchar
        jmp menuprincipal

        INVERTIRPALABRA:
            println msm25
            getchar
        jmp menuprincipal

        REPORTEDIPTONGO:
            println msm26
            getchar
        jmp menuprincipal

        REPORTEHIATO:
            println msm27
            getchar
        jmp menuprincipal

        REPORTETRIPTONGO:
            println msm28
            getchar
        jmp menuprincipal 

        REPORTEFINAL:
            println msm29
            getchar
        jmp menuprincipal
   
 
    ;==============================Errores======================================

        ErrorAbrir:
	        println msmError1
	        getChar
	        jmp menuprincipal
	
        ErrorLeer:
	        println msmError2
	        getChar
	        jmp menuprincipal
	
        ErrorCrear:
	        println msmError3
	        getChar
	        jmp menuprincipal
			
	    ErrorEscribir:
	        println msmError4
	        getChar
	        jmp menuprincipal

        ErrorCerrar:
	        println msmError5
	        getChar
	        jmp menuprincipal

    salir:
        mov ah,4ch ; numero de funcion para finalizar el programa
        xor al,al
        int 21h

    main endp
;================== Procedimientos =================================
    Exit proc 
        MOV ah,4ch 
	    int 21h
        ret
    Exit endp

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
        ;   Recibe:     DS:[bp+4] apunta al arreglo                         ;
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

        ;Subrutina epilogo
        popa
        ret
    WriteString endp
   
    LetraCapital proc
        ;--------------------------------------------------------------------;
        ;   Recibe:      DS:[bp+4] apunta a la cadena                        ;
        ;                                                                    ;
        ;   Devuelve:    Nada,pero afecta la cadena enviada                  ;
        ;                                                                    ;       
        ;   Comentarios: Recibe una cadena con terminacion nula y pone       ;   
        ;                mayuscula a la letra inicial de cualquier           ;  
        ;                expresion (LETRA)+                                  ; 
        ;--------------------------------------------------------------------;   

        ;Subrutina proglogo
        push bp                    ;almacenamos el puntero base
        mov  bp,sp                 ;ebp contiene la direccion de esp
        sub  sp,4                  ;se guarda espacio para dos variables
        pusha                      ;guarda los registros multiproposito
        mov di,[bp+4]              ;guarda el puntero a la cadena en di
        mov word ptr[bp-2],0       ;var local anterior =0
        mov word ptr[bp-4],0       ;var local size     =0
        mov  si,di                 ;si=di
        jmp GETSIG
        
        ;Ini Codigo--
            GETSIG:
                push di                     ;enviamos como parametro el caracter
                call EsLetra       

                cmp ax,0                    ;¿No es letra?
                je NOESLETRA                ;si: operamos el caracter
                cmp ax,1                    ;¿Es Letra
                je LETRA                    ;si: operamos el caracter
                cmp ax,2                    ;¿Es Espacio?
                je ESPACIO                  ;si: operamos el caracter
                cmp ax,3                    ;¿Es fin de cadena?
                je FINCADENA                ;si: salgamos de la funcion
            ;fin etiqueta    

            FINCADENA:
                mov bx,2                    ;bx=0 -> letra
                cmp [bp-2],bx               ;¿Ant == letra?
                je LETRA_FINCADENA
                jmp FIN
            ;fin etiqueta

            LETRA:
                mov bx,0                    ;bx=0 -> no es letra
                cmp [bp-2],bx               ;¿Ant == NOesLetra?
                je NOESLETRA_LETRA

                mov bx,1                    ;bx=0 -> espacio
                cmp [bp-2],bx               ;¿Ant == espacio?
                je ESPACIO_LETRA

                mov bx,2                    ;bx=0 -> letra
                cmp [bp-2],bx               ;¿Ant == letra?
                je LETRA_LETRA
            ;fin etiqueta  

            ESPACIO:
                mov bx,2                    ;bx=0 -> letra
                cmp [bp-2],bx               ;¿Ant == letra?
                je LETRA_ESPACIO

                mov word ptr[bp-2],1        ;anterior = espacio
                mov word ptr[bp-4],0h       ;size =0   
                jmp AUMENTAR      
            ;fin etiqueta       

            NOESLETRA:
                xor si,si                   ;para validar
                mov word ptr[bp-2],0        ;anterior = no es letra
                mov word ptr[bp-4],0        ;size =0 
                jmp AUMENTAR
            ;fin etiqueta        
          
            ;----notacion: ant_actual----------

            LETRA_FINCADENA:
                mov ax,[bp-4]               ;ax = size
                cmp ax,1                    ;¿ax > 1?
                ja APLICARCAPITALFIN        ;si: aplicar letra capital al token
                jmp FIN
            ;fin etiqueta
          
            ESPACIO_LETRA:
                mov ax,1                    ;ax = 1
                mov word ptr[bp-4],ax       ;size=ax     
                mov si,di                   ;inicio=puntero
                mov word ptr[bp-2],2        ;anterior=letra
                jmp AUMENTAR
            ;fin etiqueta  

            NOESLETRA_LETRA:
                mov word ptr[bp-4],0        ;size =0   
                mov word ptr[bp-2],2        ;anterior = letra
                jmp AUMENTAR
            ;fin etiqueta  

            LETRA_LETRA:     
                mov ax,[bp-4]               ;ax = size
                inc ax                      ;ax++
                mov word ptr[bp-4],ax       ;size=ax , size++    
                mov word ptr[bp-2],2        ;anterior = letra
                jmp AUMENTAR
            ;fin etiqueta  


            LETRA_ESPACIO:
                mov ax,[bp-4]               ;ax = size

                cmp si,0                    ;si tiene alguna direccion
                je  PASAR                   ;no hacer transformacon
                cmp ax,1                    ;¿ax > 1?
                ja APLICARCAPITAL           ;si: aplicar letra capital al token

                mov word ptr[bp-2],1        ;anterior = espacio
                mov word ptr[bp-4],0h       ;size =0   
                jmp AUMENTAR
            ;fin etiqueta

            APLICARCAPITAL:
            	mov al,[si]                 ;al=inicio token

                cmp al,61h                  ;¿es menor que 'a'?
                jb PASAR                    ;si: Continua sin hacer cambios
                cmp al,7ah                  ;¿es mayor que 'z'?
                ja PASAR                     ;si: Continua sin hacer cambios


		        sub al,20h                  ;inicio= inicio+20
		        mov [si],al                 ;se convierte a mayuscula

                mov word ptr[bp-2],1        ;anterior = espacio
                mov word ptr[bp-4],0h       ;size =0   
                jmp AUMENTAR
            ;fin etiqueta   

            PASAR:
                mov word ptr[bp-2],1        ;anterior = espacio
                mov word ptr[bp-4],0h       ;size =0   
                jmp AUMENTAR
            ;fin etiqueta

            APLICARCAPITALFIN:
                mov al,[si]                 ;al=inicio token

                cmp al,61h                  ;¿es menor que 'a'?
                jb FIN                      ;si: FIN
                cmp al,7ah                  ;¿es mayor que 'z'?
                ja FIN                      ;si: FIN

		        sub al,20h                  ;inicio= inicio+20
		        mov [si],al                 ;se convierte a mayuscula
                jmp FIN
            ;fin etiqueta

            AUMENTAR:
                inc di
                jmp GETSIG  
            ;fin cadena 

        ;Fin Codigo--

        ;Subrutina epilogo
        FIN:
            popa                    ;obtenemos el valor devuelta
            mov sp,bp               ;esp vuelve apuntar al inicio y elimina las variables locales
            pop bp                  ;restaura el valor del puntro base listo para el ret
            ret 2 
        ;fin etiqueta    
    LetraCapital endp

    EsLetra proc
        ;--------------------------------------------------------------------;
        ;   Recibe:      DS:[bp+4] apunta al caracter                        ;
        ;                                                                    ;
        ;   Devuelve:    AX = 0  no es letra                                 ;
        ;                Ax = 1  es letra                                    ;
        ;                Ax = 2  es un espacio                               ;
        ;                Ax = 3  fin de cadena                               ;
        ;                                                                    ;        
        ;   Comentarios: Recibe un caracter y verifica si es letra o algun   ;
        ;                caracter especial, espacio o fin de cadena.         ;
        ;--------------------------------------------------------------------;

        ;Subrutina proglogo
        push bp                    ;almacenamos el puntero base
        mov  bp,sp                 ;ebp contiene la direccion de esp
        push di
        mov di,[bp+4]              ;di = direccion del caracter
        mov al,byte ptr[di]        ;al = caracter
        jmp VerificaMinuscula


        ;Ini Codigo--
            VerificaMinuscula:
                cmp al,61h                  ;¿es menor que 'a'?
                jb VerificaMayuscula        ;si: Verifica Mayuscula
                cmp al,7ah                  ;¿es mayor que 'z'?
                ja VerificaMayuscula        ;si: Verifica Mayuscula
                jmp Letra                   ;no: entonces es una letra
            ;fin etiqueta  

            VerificaMayuscula:  
                cmp al,41h                  ;¿es menor que 'A'?
                jb VerificaCaracter         ;si: Verifica Caracter
                cmp al,5ah                  ;¿es mayor que 'Z'?
                ja VerificaCaracter         ;si: Verifica Caracter
                jmp Letra                   ;no: entonces es una letra  
            ;fin etiqueta

            VerificaCaracter:
                ;aqui va el codigo para verificar 
                ;si es un caracter especial alv
                jmp VerficaEspacio
            ;fin etiqueta

            VerficaEspacio:
                cmp al,20h                  ;¿es un espacio?
                je Espacio                  ;si: Espacio
                cmp al,10                   ;¿es retorno de carro?
                je Espacio                  ;si: tratarlo como espacio
                cmp al,13                   ;¿es salto de linea?
                je Espacio                  ;si: tratarlo como espacio
                jmp VerificaFinCadena       ;no: verificaFinCadena
            ;fin etiqueta

            VerificaFinCadena: 
                cmp al,0                    ;¿es fin cadena?
                je FinCadena                ;si: Fin Cadena
                jmp NoEsLetra               ;no: no es ninguna de la anteriores
            ;fin etiqueta

            ;--Retornos
            
            Letra:
                mov ax,1                    ;devuelve 1
                jmp FIN
            ;fin etiqueta

            Espacio:
                mov ax,2                    ;devuelve 2
                jmp FIN  
            ;fin etiqueta

            FinCadena:       
                mov ax,3                    ;devuelve 3
                jmp FIN  
            ;fin etiqueta       

            NoEsLetra:
                mov ax,0                    ;devuelve 0
                jmp FIN
            ;fin etiqueta

        ;Fin Codigo--

        ;Subrutina epilogo
        FIN:
            pop di
            mov sp,bp               ;esp vuelve apuntar al inicio y elimina las variables locales
            pop bp                  ;restaura el valor del puntro base listo para el ret
            ret 2 
        ;fin etiqueta    
    EsLetra endp

    Invertir proc
    Invertir endp

    GetToken proc
    GetToken endp


;====================Fin de Procedimientos =========================

;================ FIN DE SECCION DE CODIGO ========================
end main 