; **************
; *            *
; *            *
; .            .
; .            .
; *            *
; *            *
; **************
org 100h
; setting data segment value
mov ax,900h
mov ds,ax

mov ax,10 ; total length of square

; store ax value to memory location
mov [00h],ax
;left shift ax to 4
;shl ax,4
;add ax,10h;
;mov di,ax
; move cx value to 1
mov cx,1
loop_i:
push cx
mov ax,cx ; store i
; loop j start
mov cx,0; store j value
loop_j:
; store ax value to dx to use it latter
mov dx,ax
; if ax is not equal one then jump to check_last_row label
cmp ax,1
jne check_last_row
;calculate row offset
; ax contain row address value in hexadecimal  ,
; we need to multiply 10 to it
shl ax,4
; add column offset
add ax,cx
mov bx,ax
;store current cell [row+column] number address to 10
mov [si+bx],10
; and jump to skip label
jmp skip
check_last_row:
; ax contain to last index value or row number
cmp ax,[00];
; if current index which is AX dont match with last column number then jump to ckeck_first_colum
jne ckeck_first_colum
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
jmp skip
ckeck_first_colum:
; cx hold column index.
cmp cx,0
jne check_last_column
; if cx not equal to 0 jump to check_last_column label
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
jmp skip
check_last_column:
; if cx not equal to last index jump to skip label
; j loop start from 0 to n-1
mov bx,[00h]
dec bx
cmp cx,bx
jne skip
shl ax,4
add ax,cx
mov bx,ax
mov [si+bx],10
skip:
mov ax,dx
; increment cx value and store to memory location
inc cx
; jump if cx is less then to total length then jump to loop_j
cmp cx,[00h];
jl loop_j
;loop j end
pop cx
; restore cx value , as pop for stack
inc cx
cmp cx,[0h]
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
; calculate row and column offset
shl ax,4
add ax,cx
mov bx,ax
; store  value in ax form memory location
mov ax,[si+bx]

mov bx,32
; add 32 to ax because ax contain 10 adding 32 to it result will be 42 so it will print *
add ax,bx
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




