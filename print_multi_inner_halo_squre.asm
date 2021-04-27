; **************
; *            *
; *   ******   *
; .   *    *   .
; .   ******   .
; *            *
; **************
org 100h
; setting data segment value
mov ax,900h
mov ds,ax
mov ax,8 ;length of NxN matrix and max length is 15x15

mov [00h],ax
mov [02h],1; i loop start value
mov [04h],ax; i loop end value
mov [06h],0; j loop start value
mov [08h],ax; j loop end value
; calculate destination index
shl ax,4
add ax,10h;
mov di,ax

do_it_agin:
; i loop start
mov cx,[02h];
loop_i:
push cx
mov ax,cx ; store i value to ax register
; loop j start
mov cx,[06h]; store j value  to cx value
loop_j:
mov dx,ax
cmp ax,[02h] ; if i != 1 then jump to check_last_row; 1 is store 02h address
jne check_last_row
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

cmp ax,[04h]; i!=n then jump to ckeck_first_colum
jne ckeck_first_colum
;calculate row offset
; ax contain row address value in hexadecimal  ,
; we need to multiply 10 to it
shl ax,4
add ax,cx
mov bx,ax
;store current cell [row+column] number address to 10
mov [si+bx],10
jmp skip
ckeck_first_colum:
cmp cx,[06h] ; j!= memory location [06h] value then check_last_column
jne check_last_column
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
jmp skip
check_last_column:

mov bx,[08h] ; j loop end value store in 08h location
; j loop  from 0 to n-1 , so decrement by 1
dec bx
cmp cx,bx
jne skip:
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
skip:
mov ax,dx
inc cx
cmp cx,[08h];  if cx < [08h] then go to loop_j; [08h] contain j loop end value when the loop should end
jl loop_j
;loop j end  here
pop cx
inc cx
cmp cx,[04h]; if cx <= i loop end value then jump to loop_i label
jle loop_i
; i loop end
; adding two to i loop  start value  and store it in same address
mov ax,[02h]
add ax,2
mov [02h],ax
; subtracting two to i loop  end value and store it in same address
mov ax,[04h]
sub ax,2
mov [04h],ax
; adding two to j loop  start value  and store it in same address
mov ax,[06h]
add ax,2
mov [06h],ax
; subtracting two to j loop  end value and store it in same address
mov ax,[08h]
sub ax, 2
mov [08h],ax
; if i loop start value < i loop end value then do this whole process again
mov ax,[02h]
cmp ax,[04h]
jl do_it_agin


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

; calculate row and column offset of the memory
shl ax,4
add ax,cx
mov bx,ax
; move calculate address value to ax register
mov ax,[si+bx]

mov bx,32
; add 32 to ax because ax contain 10 adding 32 to it result will be 42 so it will print *
add ax,bx
; move al register value to dl
mov dl,al
;call print procedure that print DL register value to console
call print
mov dl,32
; same as before call print procedure for print a space in the console
call print

; code block end
pop ax
inc cx
cmp cx,[0h]
jl loop_j1
; j loop end here
;call print_ln procedure that print a newline to console
call print_nl

pop cx
inc cx
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




