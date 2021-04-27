

ORG 100h  ; for COM file.

; setting data segment value
mov ax,900h
mov ds,ax

; set  staring index register to 1

mov si,1h
; set ax to 10 , which indicated that it should print 10x10 square
mov ax,10 ; n=10

mov bx,ax
mov cx,ax
; storing ax register  value to memory
mov [si+10h],ax
; storing 1 to memory
mov [si+12h],1

outer_loop:
; bx push to stack
push bx
inner_loop:

;condition goes here


mov [si],cx

mov cx,3
;;run three time
run_three:
mov ax,[si+10h]
cmp [si],ax
jne moveon
mov dl,42; print *
call print
jmp print_space
moveon:
cmp bx,ax
jne check_last_index
mov dl,42; print *
call print
jmp print_space

check_last_index:
mov ax,[si+12h]
cmp [si],ax
jne moveon_
mov dl,42
call print
jmp print_space
moveon_:
cmp bx,ax
jne skip
mov dl,42
call print
jmp print_space

skip:


mov ax,[si+10h]
sub ax,2
mov [si+10h],ax
mov ax,[si+12h]
add ax,2
mov [si+12h],ax

loop  run_three
;end run for time

mov dl,32; print space
call print
print_space:
mov dl,32; print space
call print
mov cx,[si]

mov [si+10h],10
mov [si+12h],1

;inner loop part [dont touch]
dec bx
cmp bx,0
jg inner_loop ;end of inner loop

call print_ln

pop bx; restore bx

loop outer_loop

RET         ; return to OS.


print proc
    push ax
    ;write to console in dl
    mov ah, 2
	int 21h
	pop ax
	ret
print endp

print_ln proc
    push ax
    mov ah,2
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    pop ax
    ret
print_ln endp









