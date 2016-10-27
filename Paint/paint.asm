;Pinta pinta 1.0
org 100h
jmp eti0                  
;**************************************************************************************************************************
;Declaracion desplegar imagen
cad db 'Error, archivo no encontrado!...presione una tecla para terminar.$'
filename db "C:\imagen.bmp" ;Unidad Logica, Ruta, Nombre y Extension del archivo de imagen a utilizar
handle dw ? ;DW=Define Word, para almacenar valores entre 0 y 65535, o sea 16 bits
col dw 0 ;COL=0
ren dw 479 ;REN=479d  
col1 dw ?
ren1 dw ?
col2 dw ?
ren2 dw ?
buffer db ? ;DB=Define Byte, para almacenar valores entre 0 y 255, o sea 8 bits
colo db ? ; ? = Valor NO definido de inicio        
;declaracion desplegar coordenadas y boton salir
val db 0 
her db ?
color db 0 
bot dw ?
noc db 'Color:             $'
cb db 'Color: Blanco      $' 
cn db 'Color: Negro       $'
ca db 'Color: Azul Intenso$'
cr db 'Color: Rojo        $'
cv db 'Color: Verde       $'
caz db 'Color: Azul        $'
cm db 'Color: Magenta     $'
cam db 'Color: Amarillo    $'
cf db 'Color: Cafe        $'
noher db 'Herramienta:            $'
lap db 'Herramienta: Lapiz      $'
bru db 'Herramienta: Pincel     $'
spr db 'Herramienta: Spray      $'
cua db 'Herramienta: Cuadrados  $'
gom db 'Herramienta: Goma       $'    
ins db 'Instrucciones:$'
in1 db 'Elige un color para comenzar      $'
in2 db 'Puedes cambiar el color del lapiz $'
in3 db 'Puedes cambiar el color del pincel$'
in4 db 'Puedes cambiar el color del spray $'
in5 db 'Elige esq. sup. izq. (btn der)    $' 
in6 db 'Elige la esq. inf. der. (btn izq) $'  
in7 db 'Puedes borrar                     $'
;**************************************************************************************************************************
;Macros y procedimientos
pos macro c r
    mov ah,02h ;Para la funcion 02H de la INT 10H
    mov dl,c ;DL=Columna donde se desea ubicar el cursor (empieza desde 0)
    mov dh,r ;DH=Renglon donde se desea ubicar el cursor (empieza desde 0)
    mov bh,0h ;BH=Pagina de despliegue (la primera es la cero)
    int 10h ;INT 10H de la función 02H, ubicar el cursor en la posición indicada (solo coordenadas 80x25)
endm 

ponpix macro co re colox ;Macro que recibe dos parámetros, en C y en R
mov ah,0Ch ;Funcion 12d=0Ch para pintar o desplegar PIXEL
mov al,colox ;AL=Atributos de color, parte baja: 1010b=10d=Color Verde (vea Paleta de Color)
mov cx,co ;Cx=Columna donde se despliega PIXEL (empieza desde cero)
mov dx,re ;Dx=Renglon donde se despliega PIXEL (empieza desde cero)
int 10h ;INT 10H funcion 0CH, despliega PIXEL de color en posicion CX (Columna), DX (Renglon)
endm

numero macro num ;Declaracion de la macro NUMERO con un dato de parametro (NUM)
mov ax,num
mov bl,100d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8
mov bl,10d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8
mov dl,al
add dl,30h
mov ah,02h
int 21h
endm         

prende proc
    mov ax,1
    int 33h
ret
endp

apaga proc
    mov ax,2
    int 33h
ret
endp

valida proc
cmp col,559d ;Area de SALIR
jbe eti12
cmp col,639d
jae eti12
cmp ren,0d
jbe eti12
cmp ren,23d
jae eti12
mov val,1   ;VAL=1=SALIR
eti12:
cmp col,579d ;Area de Blanco
jbe eti13
cmp col,639d
jae eti13
cmp ren,23d
jbe eti13
cmp ren,55d
jae eti13
mov val,2   ;VAL=2=BLANCO
eti13:
cmp col,579d ;Area de NEGRO
jbe eti14
cmp col,639d
jae eti14
cmp ren,55d
jbe eti14
cmp ren,90d
jae eti14
mov val,3   ;VAL=3=NEGRO
eti14:
cmp col,579d ;Area de azul intenso
jbe eti117
cmp col,639d
jae eti117
cmp ren,90d
jbe eti117
cmp ren,124d
jae eti117
mov val,4   ;VAL=4=AZUL INTENSO    
eti117:
cmp col,579d ;Area de rojo
jbe eti18
cmp col,639d
jae eti18
cmp ren,124d
jbe eti18
cmp ren,161d
jae eti18
mov val,5   ;VAL=5=ROJO     
eti18:
cmp col,579d ;Area de verde intenso
jbe eti19
cmp col,639d
jae eti19
cmp ren,161d
jbe eti19
cmp ren,195d
jae eti19
mov val,6   ;VAL=6=VERDE INTENSO    
eti19:
cmp col,579d ;Area de azul
jbe eti20
cmp col,639d
jae eti20
cmp ren,195d
jbe eti20
cmp ren,230d
jae eti20
mov val,7   ;VAL=7=AZUL
eti20:
cmp col,579d ;Area de morado
jbe eti21
cmp col,639d
jae eti21
cmp ren,230d
jbe eti21
cmp ren,265d
jae eti21
mov val,8   ;VAL=8=MORADO
eti21:
cmp col,579d ;Area de amarillo
jbe eti22
cmp col,639d
jae eti22
cmp ren,265d
jbe eti22
cmp ren,297d
jae eti22
mov val,9   ;VAL=9=AMARILLO
eti22:
cmp col,579d ;Area de cafe
jbe eti23
cmp col,639d
jae eti23
cmp ren,297d
jbe eti23
cmp ren,332d
jae eti23
mov val,10   ;VAL=10=CAFE
eti23:
cmp col,0d ;Area de lapiz
jbe eti24
cmp col,70d
jae eti24
cmp ren,23d
jbe eti24
cmp ren,95d
jae eti24
mov her,0   ;her=0=LAPIZ 
eti24:
cmp col,0d ;Area de pincel
jbe eti25
cmp col,70d
jae eti25
cmp ren,95d
jbe eti25
cmp ren,160d
jae eti25
mov her,1   ;her=1=PINCEL
eti25:
cmp col,0d ;Area de spray
jbe eti26
cmp col,70d
jae eti26
cmp ren,160d
jbe eti26
cmp ren,238d
jae eti26
mov her,2   ;her=2=spray 
eti26:
cmp col,0d ;Area de cuadrado
jbe eti27
cmp col,70d
jae eti27
cmp ren,238d
jbe eti27
cmp ren,302d
jae eti27
mov her,3   ;her=3=cuadrado
eti27:
cmp col,0d ;Area de goma
jbe salir
cmp col,70d
jae salir
cmp ren,302d
jbe salir
cmp ren,371d
jae salir
mov her,4   ;her=4=goma    
salir:
ret
endp  

herramienta proc
cmp her,0
je l
cmp her,1
je b
cmp her,2
je s
cmp her,3
je c
cmp her,4
je g
ret 
endp
;**************************************************************************************************************************
;HERRAMIENTAS
lapiz proc
    call apaga
    ponpix col ren color
    call prende    
ret
endp

pincel proc
    call apaga
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col  
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    ponpix col ren color
    inc col
    call prende
ret
endp 

spray proc
    call apaga  
    mov cx,col
    mov dx,ren
    add cx,2
    sub dx,2
    ponpix cx dx color  
    add cx,1
    add dx,2
    ponpix cx dx color  
    add cx,2
    ponpix cx dx color
    sub cx,4
    sub dx,6
    ponpix cx dx color 
    sub cx,1
    add dx,2
    ponpix cx dx color 
    sub cx,2
    add dx,1
    ponpix cx dx color 
    add cx,1
    add dx,2
    ponpix cx dx color
    sub cx,3
    add dx,1
    ponpix cx dx color
    add cx,3
    add dx,1
    ponpix cx dx color
    sub cx,4
    sub dx,8
    ponpix cx dx color
    add cx,2
    add dx,2
    ponpix cx dx color
    call prende
ret
endp

cuadrado proc   
    ciclo1: 
    mov ax,3d
    int 33h
    mov col,cx
    mov ren,dx
    mov bot,bx   
    pos 1 25
    numero col
    mov ah,02h
    mov dl,' '
    int 21h
    numero ren
    cmp bot,2d
    jne ciclo1
    mov cx,col
    mov dx,ren
    mov col1,cx
    mov ren1,dx
    ciclo2:  
    pos 26 29
    mov ah,09h
    lea dx,in6
    int 21h 
    mov ax,3d
    int 33h
    mov col,cx
    mov ren,dx
    mov bot,bx  
    pos 1 25
    numero col
    mov ah,02h
    mov dl,' '
    int 21h
    numero ren
    cmp bot,1d
    jne ciclo2
    mov cx,col
    mov dx,ren
    mov col2,cx
    mov ren2,dx
    call apaga
    mov cx,col1
    mov dx,ren1
    ciclo3:
    mov ah,0ch
    mov al,color
    int 10h
    inc cx
    cmp cx,col2
    jbe ciclo3
    mov cx,col1
    mov dx,ren2
    ciclo4:
    mov ah,0ch
    mov al,color
    int 10h
    inc cx 
    cmp cx,col2
    jbe ciclo4
    mov cx,col1
    mov dx,ren1
    ciclo5:
    mov ah,0ch
    mov al,color
    int 10h
    inc dx
    cmp dx,ren2
    jbe ciclo5
    mov cx,col2
    mov dx,ren1
    ciclo6:
    mov ah,0ch
    mov al,color
    int 10h
    inc dx
    cmp dx,ren2
    jbe ciclo6
    call prende
ret
endp

goma proc
    call apaga   
    mov cx,col
    sub cx,5
    mov dx,ren
    sub dx,5
    mov col1,cx
    mov ren1,dx  
    mov cx,col
    add cx,5
    mov dx,ren
    add dx,5
    mov col2,cx
    mov ren2,dx   
    mov cx,col1
    mov dx,ren1
    eti32:
    mov ah,0ch
    mov al,15d
    int 10h
    inc cx
    cmp cx,col2
    jbe eti32
    inc dx
    mov cx,col1
    cmp dx,ren2 
    jbe eti32
    call prende
ret
endp
;**************************************************************************************************************************
eti0:
mov ah,3dh ;Funcion 3DH, abre un archivo existente
mov al,0 ;AL=Modos de Acceso, 0=Solo Lectura, 1=Escritura, 2=Lectura/Escritura
mov dx,offset filename ;DX=Direccion de la cadena de RUTA
int 21h ;INT 21H función 3DH, abre un archivo. Esta funcion 
;altera la bandera CF (Carry ;Flag), 
;si el archivo se pudo abrir sin error CF=0, y en AX esta el Manejador de Archivo
;(Handle), caso contrario CF=1, y en AX esta el codigo de error
jc err ;Si hay error, salta a la etiqueta ERR
mov handle,ax ;Caso contrario HANDLE=Manejador de Archivo
;*************************************************************************************************************************
mov cx,118d ;Se prepara ciclo de 118 vueltas (Para leer archivo en formato BMP)
eti1:
push cx
mov ah,3fh ;3FH=Leer del archivo
mov bx,handle
mov dx,offset buffer
mov cx,1 ;CX=Numero de Bytes a leer
int 21h ;INT 21H funcion 3FH, leer del archivo
pop cx
loop eti1
;*************************************************************************************************************************
mov ah,00h ;Funcion 00H para la INT 10H (Resolucion de Pantalla)
mov al,18d ;AL=Modo de despliegue o resolución, 18 = 640x480 a 16 colores
int 10h ;INT 10H funcion 00H, inicializar resolucion
;***********************************************************************************************************************
eti2:
mov ah,3fh ;3FH=Leer del archivo
mov bx,handle
mov dx,offset buffer
mov cx,1
int 21h ;INT 21H funcion 3FH, leer del archivo. En BUFFER se almacenaran los datos leidos
mov al,buffer ;AL=BUFFER, en los 4 bits superiores esta el color de un PRIMER Pixel
and al,11110000b
ror al,4
mov colo,al ;COLO=Color de un PRIMER Pixel
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,colo ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
mov al,buffer ;AL=BUFFER, en los 4 bits inferiores esta el color de un SEGUNDO Pixel
and al,00001111b
mov colo,al ;COLO=Color de un SEGUNDO Pixel
inc col
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,colo ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
inc col ;Se debe desplegar otro Pixel para dar FORMATO a la imagen
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,colo ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
cmp col,639d
jbe eti2 ;JBE=Jump if Below or Equal (salta si esta abajo o si es igual)
mov col,0
dec ren
cmp ren,-1 ;Se compara con -1 para llegar hasta el ultimo renglon, que es el CERO
jne eti2
;***********************************************************************************************************************
eti10:  
pos 55 28
mov ah,09h
lea dx,noc
int 21h
pos 1 28
mov ah,09h
lea dx,noher
int 21h 
pos 26 28
mov ah,09h
lea dx,ins 
int 21h
pos 26 29
mov ah,09h
lea dx,in1
int 21h 
call prende

eti11: ;CICLO PRINCIPAL
    mov ax,3d
    int 33h
    mov col,cx
    mov ren,dx
    mov bot,bx 
    
    pos 1 25
    
    numero col
    mov ah,02h
    mov dl,' '
    int 21h
    numero ren
    cmp bot,1
    jne eti11
    call valida
    cmp val,0
    je eti11
    cmp val,1
    je eti15
    cmp val,2
    je  eti16
    cmp val,3
    je eti17  
    cmp val,4
    je azulint
    cmp val,5
    je rojo
    cmp val,6
    je verde
    cmp val,7
    je azul
    cmp val,8
    je mag
    cmp val,9
    je ama
    cmp val,10
    je cafe 
    cmp her,0
    je l
    cmp her,1
    je b
    cmp her,2
    je s
    cmp her,3
    je c
    cmp her,4
    je g    
                 
;val=15=goma
g:      
pos 26 29
mov ah,09h
lea dx,in7
int 21h   
pos 55 28  
mov ah,09h
lea dx,noc
int 21h
pos 1 28 
mov ah,09h
lea dx,gom
int 21h 
call goma    
jmp eti11 
;val=14=cuadrado
c:     
pos 26 29
mov ah,09h
lea dx,in5
int 21h 
pos 1 28 
mov ah,09h
lea dx,cua
int 21h
call cuadrado    
jmp eti11
;val=13=spray
s:   
pos 26 29
mov ah,09h
lea dx,in4
int 21h 
pos 1 28 
mov ah,09h
lea dx,spr
int 21h  
call spray    
jmp eti11
;val=12=brush
b: 
pos 26 29
mov ah,09h
lea dx,in3
int 21h 
pos 1 28 
mov ah,09h
lea dx,bru
int 21h  
call pincel   
jmp eti11
;val=11=lapiz
l:     
pos 26 29
mov ah,09h
lea dx,in2
int 21h 
pos 1 28 
mov ah,09h
lea dx,lap
int 21h 
call lapiz    
jmp eti11
;val=10=cafe
cafe:
pos 55 28  
mov ah,09h
lea dx,cf
int 21h 
mov color,6d
call herramienta
jmp eti11  
;val=9=amarillo
ama:
pos 55 28  
mov ah,09h
lea dx,cam
int 21h 
mov color,14d
call herramienta
jmp eti11
;val=8=magenta
mag:
pos 55 28  
mov ah,09h
lea dx,cm
int 21h 
mov color,5d 
call herramienta
jmp eti11 
;val=7=AZUL
azul:
pos 55 28  
mov ah,09h
lea dx,caz
int 21h 
mov color,1d  
call herramienta
jmp eti11
;val=6=verde
verde:
pos 55 28  
mov ah,09h
lea dx,cv
int 21h 
mov color,2d   
call herramienta
jmp eti11
;val=5=rojo
rojo:
pos 55 28  
mov ah,09h
lea dx,cr
int 21h 
mov color,4d
call herramienta
jmp eti11    
;val=4=AZUL INTENSO 
azulint:
pos 55 28
mov ah,09h
lea dx,ca
int 21h 
mov color,9d  
call herramienta
jmp eti11
eti17:   
;val=3=NEGRO  
pos 55 28
mov ah,09h
lea dx,cn
int 21h 
mov color,0d
call herramienta
jmp eti11
eti16:   ;val=2=BLANCO
pos 55 28
mov ah,09h
lea dx,cb
int 21h 
mov color,15d  
call herramienta
jmp eti11

eti15:   ;val=1    
mov ax,2
int 33h

mov ah,00h
mov al,3d
int 10h

int 20h

;***********************************************************************************************************************
err: ;Se llega hasta aqui solo si hay error en la lectura del archivo
mov ah,09h
lea dx,cad
int 21h ;Despliega cad
mov ah,07h
int 21h ;Espera a que se oprima tecla
int 20h ;Fin del Programa (Cuando NO se carga la imagen)