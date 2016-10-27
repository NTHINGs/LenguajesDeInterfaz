org 0100h

mov ah,00h      ;Inicializar los gráficos. Función 0 de la interrupción 10
mov al,18d		;Es el número de resolución básico
int 10h			;18d Inicializa graficos 640x480, 16 colores. La interrupción 10 se encarga de controlar la tarjeta gráfica de la computadora

mov ax,1d       
int 33h			;Esta interrupción controla el ratón, Prende puntero de raton (flecha)

eti0:
	mov ax,3d	;Detecta un click y el resultado lo almacena en bx
	int 33h
	cmp bx,0
	je eti0

mov ax,2d
int 33h			;Apaga puntero de raton
 
mov ah,00h
mov al,3d
int 10h			;3d=80x25 16 colores

int 20h			;Fin del programa