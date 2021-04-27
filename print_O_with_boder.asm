; **************
; **************
; **************
; ***        ***
; ***        ***
; ***        ***
; **************
; **************
; **************

org 100h

mov ax,900h
mov ds,ax
mov ax,10 ; total length of square

; store ax value to memory location
mov [00h],ax ; (n)
mov [02h],3 ; (k) store 3 to to memory , for
; 3x3 halo space inside the square


sub ax,[02h] ; (n-k)
mov [06h],ax ; store to 06 location
;shl ax,4
;add ax,10h;
;mov di,ax
;mov [di],1;
mov cx,1;
loop_i:
push cx
mov ax,cx ; store i  start from 1
; loop j start
mov cx,0; store j value
loop_j:
mov dx,ax
cmp ax,[02h]    ;!n<=k
jnle check_last_row
;calculate row offset
; ax contain row address value in hexadecimal  ,
; we need to multiply 10 to it
shl ax,4
; add column offset
add ax,cx
mov bx,ax
;mark calculate address, and store 10 to that address
mov [si+bx],10
jmp skip
check_last_row:

cmp ax,[06h]    ;  !n>=(n-k) jump to ckeck_first_colum label
jng ckeck_first_colum
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
jmp skip
ckeck_first_colum:
; j counter start form 0 to n-1 so
; j loop counter value store in 02h  location
; move the value to bx then decrementing
mov bx,[02h]
dec bx
cmp cx,bx;
jnle check_last_column
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
jmp skip
check_last_column:
; j loop start from 0 to n-1

mov bx,[06h]
dec bx
cmp cx,bx
jng skip:
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
skip:
mov ax,dx
; increment cx value and store to memory location
inc cx
; jump if cx is less then to total length then jump to loop_j

cmp cx,[00h]
jl loop_j
;loop j end
pop cx
inc cx
cmp cx,[0h]; <n
jle loop_i



; printing process
;2dloop start
mov cx,1
loop_i1:
push cx
mov ax,cx

mov cx,0
loop_j1:
push ax
; ax->i
; cx->j
; code block start

; calculating row and column offset
shl ax,4
add ax,cx
mov bx,ax
mov ax,[si+bx]
; adding bx, with 32 its make if current cell has a value of  10 it will became 42 decimal value which ascii value is *
; other wise is add 0 with 32 which is ascii value of white space
mov bx,32
add ax,bx
mov dl,al
call print
mov dl,32
call print

; code block end
pop ax
inc cx
cmp cx,[0h]
jl loop_j1
; j loop end here
call print_nl

pop cx
inc cx
; comparing with n s
cmp cx,[0h]
jle loop_i1
;2dloop end

ret


print proc
    push ax
    ;print procedure, print DL value to console
    ; ah set to 2 because interrupts 21h will print a single character or 8bit data to console
    mov ah, 2
	int 21h
	pop ax
	ret
print endp

print_nl proc
    ;print_ln procedure, print newline value to console
    ; ah set to 2 because interrupts 21h will print a single character or 8bit data to console

    push ax
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    pop ax
    ret
print_nl endp










