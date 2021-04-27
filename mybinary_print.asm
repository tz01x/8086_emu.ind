mov bl,8

mov ah , 2 
mov cx,4
print:
test  bl,1000b  
mov dl,'0'
jz zerro
mov dl,'1'
zerro:
int 21h 
shl bl,1
loop print

