mov ax,900h
mov ds,ax
mov si,1h;
mov [si],01100111b  ;67 lowr 8 of fist num 
mov [si+1h],10011001b;99 higher 8bit   

mov [si+2h],10010101b;95 lower 8 bit of second num  
mov [si+3h],10010100b;94 higher bit of secound number   

mov bp,0h    ;
mov cl,0b   ; inital CL 
mov ch,0b
doItfor_higher_bit:
mov al,ds:[si+bp];67
mov bl,ds:[si+2h+bp];95   
add al,bl;add al,bl 
lahf ; load current flags registers[SZ0A0P1C] value into AH register 
test ah,00000001b ;check if carry is there or not 
jz nocarryfound
add cl,1b          
nocarryfound:
;mov ah,SZ0A0P1C 
mov dl,al
test ah,10000b ;check if auxiliary flag is set to 1 
; then z flag will be zerro 
jnz add6  ;find a match
mov bl,al 
; compering lower 4 bit if it is greater then 9 or not 
shl al,4
shr al,4
cmp al,9
jg add6 
jmp skip
add6:
mov al,dl
add al,6
jnc skip
add cl,1b               
jmp skipAgain   ; after adding 6 to lower bit if there is an carry bit 
skip:
;check higher 4bit    if its greater then 9 or not 
mov dl,al
shr dl,4
cmp dl,9   
jng skipAgain
;add 6 to higher bit 
mov ch,1;mark as  6 is already added to higer 4bit of bcd code
add al,60h
jnc skipAgain
add cl,1b
skipAgain: 
cmp ch,1  
jge skipahead ; if 6 is not add to higher 4bit of 8bit bcd 
cmp cl,1
jnge skipahead: ; if there is no carry bit then skip ahead  
;so add 6 to higher bit 
add al,60h;   
skipahead:  
mov ah,0
mov ah,cl    ;adding carry to higher bit   
;cheking if base pointer is greater then 1 if it is then we alrady add higher 1bit 
mov ds:[si+8h+bp],al
cmp bp,0
jg end_this  
inc bp     ;increment base pointer 
  ;
mov al,ds:[si+3h] ; add carray to higher 8 bit of the bcd  
add al,cl ; if there is a carry bit form lower 8 bit then added to higher bit  
mov cx,0 
mov ds:[si+3h],al ;restore it 

jnc  doItfor_higher_bit 
add cl,1b
jmp doItfor_higher_bit
end_this: 
inc bp
mov ds:[si+8h+bp],ah; ah will contain the carry bit if it exits 
hlt




 



