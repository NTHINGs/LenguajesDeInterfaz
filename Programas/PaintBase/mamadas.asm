org 0100h
jmp eti0

cad db 'salir$'
c db ?
r db ?
val db 0
color db 0
col dw ?
ren dw ?
bot dw ?

ponpix macro co re colo 
mov ah, 0Ch
mov al, colo
mov cx, co
mov dx, re
int 10h
endm

numero macro num
mov ax, num
mov bl, 100d
div bl
mov dl, al
add dl,30h
push ax
mov ah
endm    

eti0:
mov ah,00h
mov al,18d
int 10h

mov c,5d
mov r,28d
call pos
mov ah, 02h
mov dl,'B'
int 21h
mov c,75d
mov r,1d
call pos
mov ah,02h
mov dl,'V'
int 21h

call prende

eti1:
mov ax,3d
int 33h
mov col,cx
mov ren, dx
mov bor,bx
mov c,2d
mov r,1
call pos
numero col
mov ah,02h
mov dl,' '
int 21h
numero ren
cmp bot,1
jne eti1
call valida
cmp val,0
je eti1
cmp val,1
je eti5
cmp val,2
je eti6
mov color,10d
call apaga
ponpix col ren color
call prende
jmp eti1
eti6:;val=2
mov color, 15d
call apaga
ponpix col ren color
call prende
jmp eti1

eti5:;val=1
mov ax,2
int 33h
mov ah,00h
mov al,3d
int 10h
int 20h

;Area de procedimientos
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

pos proc 
    mov ah,02h
    mov dl,c
    mov dh,r
    mov bh,0h
    int 10h
ret
endp

valida proc
    cmp col,39d
    jbe eti2
    cmp col,78d
    jne eti2
    cmp ren,449d
    jbe eti2
    cmp ren,462d
    jne eti2
    mov val,1
    eti2:
    cmp col,560d
    jbe eti3
    cmp col,568d
    jne eti3
    cmp ren,17d
    jbe eti3
    cmp ren,30d
    jne eti3
    mov val,2
    eti3:
    cmp col,599d
    jbe eti4
    cmp col,606d
    jne eti4
    cmp ren,17d
    jbe eti4
    cmp ren,
    jne eti4
    mov val,3
ret 
endp    