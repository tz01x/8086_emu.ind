
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

ORG 100h  ; for COM file.

mov bx,10
mov cx,10

outer_loop:
; push bx value to stack , because bx current state value is need letter
push bx

inner_loop:
; move ascii code 42 to dl and call print procedure that print DL register value to console
mov dl,42
call print
; same as before call print procedure for print a space in the console
mov dl,32
call print

dec bx
; compare bx if it is greater then zero or not, if is equal to zero then exit this loop sequence
cmp bx,0
jg inner_loop
;call print_ln procedure that print a newline to console
call print_ln

pop bx; pop from stack which contain bx value, so  bx value get restore
loop outer_loop

RET         ; return to OS.


print proc
    ;print procedure, print DL value to console
    ; ah set to 2 because interrupts 21h will print a single character or 8bit data to console
    mov ah, 2
	int 21h
	ret
print endp

print_ln proc
    ;print_ln procedure, print newline value to console
    ; ah set to 2 because interrupts 21h will print a single character or 8bit data to console
    mov ah,2
    mov dl,10 ; newline ascii code
    int 21h
    mov dl,13
    int 21h
    ret
print_ln endp





