org 100h  
.data
top db 201,205,205,205,205,205,187
row1 db 186,?,?,?,?,?,186 
row2 db 186,?,?,?,?,?,186
row3 db 186,?,?,?,?,?,186
row4 db 186,?,?,?,?,?,186
row5 db 186,?,?,?,?,?,186    
bottom db 200,205,205,205,205,205,188
x db 37
y db 10 
t db 0
msgerror db "error"
msgnowin db "no winner"
input db ?
moves db 0 
col dw ? 
curr db ? 
first db ?
p1win db "Player 1 Wins"
p2win db "Player 2 Wins"
.code
mov ax,@data
mov ds,ax

call drawbox
mov x,38
mov y,11
call moveto



inputl:
mov al,0
mov ah,0h
int 16h 
mov input,al
cmp input,0dh
je printchar
cmp input,0
je movement
jmp error
jmp inputl
 jmp done
 
 
check proc
    mov dl,curr
    jmp checkrow
    
   
    
checkcol proc
   cc1:cmp row2[si],dl
   jne inputl
   cmp row3[si],dl
   pushf
   mov first,11
   mov t,2
   popf
   je pwin
   jmp inputl
   
   cc2:cmp row3[si],dl
   jne inputl
   cmp row1[si],dl
   pushf
   mov first,11
   mov t,2
   popf
   je pwin
   cmp row4[si],dl
   pushf
   mov first,12
   mov t,2
   je pwin
   jmp inputl
   
   cc3:cmp row5[si],dl
   pushf
   mov first,13 
   mov t,2
   popf
   je crow4
   cmp row1[si],dl
   pushf
   mov first,11
   mov t,2
   popf
   je crow2
   cmp row2[si],dl
   pushf
   mov first,12
   mov t,2
   popf
   je crow4
   jmp inputl
    crow2:cmp row2[si],dl
    je pwin
    jmp inputl 
    crow4:cmp row4[si],dl
    je pwin
    jmp inputl
   cc4:cmp row3[si],dl
   jne inputl
   cmp row5[si],dl
   pushf
   mov first,13 
   mov t,2
   popf
   je pwin
  cmp row2[si],dl
  pushf
  mov first,12 
  mov t,2
  popf
   je pwin
   jmp inputl
   
   cc5:cmp row4[si],dl
   jne inputl
   cmp row3[si],dl
   pushf
   mov first,13
   mov t,2
   popf
   je pwin
   jmp inputl

       
checkrow proc
    mov bl,x
    mov bh,0
    mov si,bx
    sub si,37
    cmp y,11
    je rw1
    cmp y,12
    je rw2
    cmp y,13
    je rw3
    cmp y,14
    je rw4
    cmp y,15
    je rw5
    rw1:
     cmp row1[si-1],dl
     je bar1
     jne c2rr1
     bar1:cmp row1[si+1],dl
     call bar
     je pwin 
     jne c2lr1
     c2lr1:cmp row1[si-2],dl
     call c2lr
     je pwin
     c2rr1:
     cmp row1[si+1],dl
     jne cc1
     cmp row1[si+2],dl
     call c2rr
     je pwin
   
    rw2:cmp row2[si-1],dl
     je bar2
     jne c2rr2
     bar2:cmp row2[si+1],dl
     call bar
     je pwin 
     jne c2lr2
     c2lr2:cmp row2[si-2],dl
     call c2lr
     je pwin
     c2rr2:
     cmp row2[si+1],dl
     jne cc2
     cmp row2[si+2],dl
     call c2rr
     je pwin
     
     rw3:cmp row3[si-1],dl
     je bar3
     jne c2rr3
     bar3:cmp row3[si+1],dl
     call bar
     je pwin 
     jne c2lr3
     c2lr3:cmp row3[si-2],dl
     call c2lr
     je pwin
     c2rr3:
     cmp row3[si+1],dl
     jne cc3
     cmp row3[si+2],dl
     call c2rr
     je pwin
    
    rw4:cmp row4[si-1],dl
     je bar4
     jne c2rr4
     bar4:cmp row4[si+1],dl
     call bar
     je pwin 
     jne c2lr4
     c2lr4:cmp row4[si-2],dl
     call c2lr
     je pwin
     c2rr4:
     cmp row4[si+1],dl
     jne cc4
     cmp row4[si+2],dl
     call c2rr
     je pwin
    
    rw5:cmp row5[si-1],dl
     je bar5
     jne c2rr5
     bar5:cmp row5[si+1],dl
     call bar
     je pwin 
     jne c2lr5
     c2lr5:cmp row5[si-2],dl
     call c2lr
     je pwin
     c2rr5:
     cmp row5[si+1],dl
     jne cc5
     cmp row5[si+2],dl
     call c2rr
     je pwin
      ret 

bar proc
    pushf
     mov bl,x
     dec bl
     mov first,bl
     mov t,1
     popf
    ret
    
c2lr proc
    pushf
     mov bl,x
     sub bl,2
     mov first,bl
     mov t,1
     popf
     ret
     
c2rr proc
    pushf
     mov bl,x
     add bl,2
     mov first,bl
     mov t,1
     popf
     ret
    
pwin proc 
    call clr
    mov ah,2
    mov cx,13 
    mov si,0
    mov x,34
    mov y,9
    call moveto
    cmp curr,10h
    je print1
    cmp curr,11h
    je print2
              
clr proc
    cmp t,1
    je clrr
    cmp t,2
    je clrc
    ret              
              
              
clrr:
mov bl,first 
mov x,bl
call moveto
mov al,curr 
mov bx,0004
mov cx,3
mov ah,09h
int 10h
ret 

clrc:
mov bl,first
mov cx,3
lo:push cx
mov y,bl
push bx
call moveto
mov al,curr
mov bx,0004
mov cx,1
mov ah,09h
int 10h
pop bx
inc bl
pop cx
loop lo
ret   
     
print1 proc
 lw1:
 mov dl,p1win[si]
 int 21h
 inc si
 loop lw1 
 jmp done

print2 proc
lw2: 
mov dl,p2win[si]
int 21h
inc si
loop lw2
jmp done   
 
printchar proc
    test moves,1
    jz a
    jnz b
    l:
    mov ah,2
    mov dl,curr
    call setval
    int 21h
    call moveto
    inc moves 
    cmp moves,25
    je nowin 
    cmp moves,5
    jae check
    jmp inputl
    ret 
    a:mov curr,10h
    jmp l
    b:mov curr,11h
    jmp l
 
movement proc
cmp ah,4bh
je left
cmp ah,4dh
je right
cmp ah,48h
je up
cmp ah,50h
je down
jmp error
ret    
    
     
printa proc
mov dl,10h
call setval
mov ah,2
int 21h 
jmp l
ret
 
printb proc
mov dl,11h
call setval
mov ah,2
int 21h
jmp l
ret 
left proc
dec x
cmp x,37
jbe error
call moveto
jmp inputl
 ret

right proc
inc x
cmp x,43
jae error
call moveto
jmp inputl
ret

up proc
    dec y
    cmp y,10
    jbe error
    call moveto
    jmp inputl
    ret
    
down proc
    inc y
    cmp y,16
    jae error
    call moveto
    jmp inputl
    ret
       
    
setval proc
    mov cl,x
    sub cl,37
    mov ch,0
    mov col,cx
    mov si,col
   cmp y,11
   je r1
   cmp y,12
   je r2
   cmp y,13
   je r3
   cmp y,14
   je r4
   cmp y,15
   je r5 
   
   r1: 
   mov row1[si],dl
   ret
   r2:
   mov row2[si],dl
   ret
   r3:
   mov row3[si],dl
   ret
   r4:
   mov row4[si],dl
   ret
   r5:
   mov row5[si],dl
   ret
   endp  

error proc
mov x,38
mov y,9
call moveto
mov cx,5
mov si,0
ll1:
 mov ah,2
 mov dl,msgerror[si]
 int 21h 
 inc si
 loop ll1
 jmp done
 endp
nowin proc
    mov x,36
    mov y,9
    call moveto
    mov cx,9
    mov si,0
    ll2:
    mov ah,2
    mov dl,msgnowin[si]
    int 21h
    inc si
    loop ll2
    jmp done
    endp 
drawbox proc 
      call moveto     
     mov ah,2 
     mov cx,7
    mov si,0 
    
    l1:
    mov dl,top[si]
    int 21h
    inc si
    loop l1
    
    
     
    mov cx,5
    l2: 
    mov bx,cx
    mov cx,7 
    mov si,0 
     inc y
    call moveto
    l3:
    
    mov dl,row1[si]
    int 21h
    inc si
    loop l3
    mov cx,bx
    
    loop l2 
    inc y
    call moveto
    mov cx,7
    mov si,0
    l4:
    mov dl,bottom[si]
    int 21h
    inc si
    loop l4
   
    ret 
endp
moveto proc
    mov dl,x
    mov dh,y
    mov ah,2
    mov bh,0
    int 10h
    ret
done:
