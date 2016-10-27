;Programa 12.- Programa que carga o despliega una imagen BMP pixel por pixel en pantalla (640x480)
org 100h
jmp eti0 
;Zona de declaracion de Cadenas e Identificadores creados por el usuario (variables)
cad db 'Error, archivo no encontrado!...presione una tecla para terminar.$'
filename db "C:\imagen.bmp" ;Unidad Logica, Ruta, Nombre y Extension del archivo de imagen a utilizar
handle dw ? 	|			;DW=Define Word, para almacenar valores entre 0 y 65535, o sea 16 bits
col dw 0 					;COL=0
ren dw 479 					;REN=479d
buffer db ? 				;DB=Define Byte, para almacenar valores entre 0 y 255, o sea 8 bits
colo db ?					; ? = Valor NO definido de inicio
;**************************************************************************************************************************
eti0:
mov ah,3dh 					;Funcion 3DH, abre un archivo existente
mov al,0 					;AL=Modos de Acceso, 0=Solo Lectura, 1=Escritura, 2=Lectura/Escritura
mov dx,offset filename 		;DX=Direccion de la cadena de RUTA
int 21h 					;INT 21H función 3DH, abre un archivo. Esta funcion altera la bandera CF (Carry Flag), si el archivo se pudo abrir sin error CF=0, y en AX esta el Manejador de Archivo
;(Handle), caso contrario CF=1, y en AX esta el codigo de error
jc err 						;Si hay error, salta a la etiqueta ERR;Funcion 3DH, abre un archivo existente
;Handle es el permiso que el SO brinda para que el programa pueda manipular archivos
mov handle,ax 				;Caso contrario HANDLE=Manejador de Archivo
;*************************************************************************************************************************
;Los primeros 118 bytes de un archivo bmp contiene información de fechas, donde fue creado, etc.
mov cx,118d 				;Se prepara ciclo de 118 vueltas (Para leer archivo en formato BMP)
eti1:
push cx
mov ah,3fh 					;3FH=Leer del archivo
mov bx,handle
mov dx,offset buffer
mov cx,1 					;CX=Numero de Bytes a leer
int 21h 					;INT 21H funcion 3FH, leer del archivo
pop cx
loop eti1
;*************************************************************************************************************************
mov ah,00h 					;Funcion 00H para la INT 10H (Resolucion de Pantalla)
mov al,18d 					;AL=Modo de despliegue o resolución, 18 = 640x480 a 16 colores
int 10h 					;INT 10H funcion 00H, inicializar resolucion
;***********************************************************************************************************************
eti2:
mov ah,3fh 					;3FH=Leer del archivo
mov bx,handle
mov dx,offset buffer
mov cx,1
int 21h 					;INT 21H funcion 3FH, leer del archivo. En BUFFER se almacenaran los datos leidos
mov al,buffer
and al,11110000b
ror al,4
mov colo,al
mov ah,0ch
mov al,colo
mov cx,col
mov dx,ren
int 10h 					;AL=BUFFER, en los 4 bits superiores esta el color de un PRIMER Pixel
mov al,buffer
and al,00001111b
mov colo,al ;AL=BUFFER, en los 4 bits inferiores esta el color de un SEGUNDO Pixel
;COLO=Color de un PRIMER Pixel
;Funcion 0CH para despliegue de un solo PIXEL con atributos
;AL=Atributos del Pixel
;CX=Columna de despliegue del Pixel
;DX=Renglon de desplieguie del Pixel
;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
;COLO=Color de un SEGUNDO Pixelinc col
mov ah,0ch
mov al,colo
mov cx,col
mov dx,ren
int 10h
inc col
mov ah,0ch
mov al,colo
mov cx,col
mov dx,ren
int 10h ;Funcion 0CH para despliegue de un solo PIXEL con atributos
;AL=Atributos del Pixel
;CX=Columna de despliegue del Pixel
;DX=Renglon de desplieguie del Pixel
;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
;Se debe desplegar otro Pixel para dar FORMATO a la imagen
;Funcion 0CH para despliegue de un solo PIXEL con atributos
;AL=Atributos del Pixel
;CX=Columna de despliegue del Pixel
;DX=Renglon de desplieguie del Pixel
;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
cmp col,639d
jbe eti2 ;JBE=Jump if Below or Equal (salta si esta abajo o si es igual)
mov col,0
dec ren
cmp ren,-1
;Se compara con -1 para llegar hasta el ultimo renglon, que es el CERO
jne eti2
JNE=Jump if Not Equal (salta si no es igual)
;***********************************************************************************************************************
mov ah,07h
int 21h
;Espera que se oprima una tecla
mov ah,00h
mov al,3d
int 10h
;Funcion 00H para devolver al modo TEXTO
;AL=Modo de despliegue o resolución, 3 = 80x25 a 16 colores (Modo TEXTO)
;INT 10H funcion 00H, inicializar resolucion
int 20h
;Fin del Programa (Cuando se carga la imagen)
;***********************************************************************************************************************
err: 		;Se llega hasta aqui solo si hay error en la lectura del archivo
mov ah,09h
lea dx,cad
int 21h 	;Despliega cad
mov ah,07h
int 21h 	;Espera a que se oprima tecla
int 20h 	;Fin del Programa (Cuando NO se carga la imagen)