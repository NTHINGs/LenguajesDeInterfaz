;Programa 7.- Dibuja una linea blanca horizontal de 100 pixeles
org 0100h
col dw 100d
ren dw 100d
numpix dw 200d

lh macro c r np
eti0:
mov ah,0Ch
mov al,00001111b 	;1111b=15d=Color Blanco
mov cx,c
mov dx,r
int 10h
inc c
dec np
cmp np,0d
jne eti0
endm

;Inicio del Programa Principal
mov ah,00h
mov al,18d
int 10h
lh col ren numpix
mov ah,07h
int 21h
mov ah,00h
mov al,3d
int 10h
int 20h