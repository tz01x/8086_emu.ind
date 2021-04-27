
.model small
.stack 100h
.data
;define byte to veritable 'a' and the value is 'enter password'
a db 'Enter password$'
;define byte to veritable 'ok' and the value is 'Correct Password$'
ok db 'Correct Password$'

wrg_pass db 'Wrong password$'
pass db 'mypassword'
; getting the password string length
pass1 equ $-pass
.code

main proc
   ; getting data section address in ax
   mov ax,@data
   ; setting up data segment
   ; ax contain the data section address. so, data section address move to data segment

   mov ds,ax
    ; move the password length to cx
   mov cx,pass1

   ; load Effective address in BX or BX pointed to pass variable
   lea bx, pass


   ; this part print w value of variable 'a'
   ; ah is set to 9 because this interrupts, printing string that is terminated by $
   mov ah,9
   lea dx,a
   int 21h; interrupts call


   l1:

   ; read a character(8bit) from console, character should be store in AL register
   mov ah,8
   int 10h

    ;compare newly read character with BX first value which it was pointing to
   cmp al,[bx]
   ; if both AL and BX pointed value is not equal go to 'l2' label
   jne l2
   ; if its true then increment bx , which holds the next character of the password
   ; and do above oration again
   inc bx
   loop l1

    ; if successfully all the character match then print a success message
    ; after that jump to exit label

  mov ah,9
  lea dx,ok
  int 21h

  jmp exit




  l2:
  ; for any region any character dont match with password string then this label call
  ; in this label print a warring message
  mov ah,9
  lea dx,notok
  int 21h


   exit:
   ret

   main endp
end main



