include setup.inc
include Irvine32.inc

.code
dealPlayer PROC
  mov ax,[esi]
  call makePlayerCard
  mov ah,0

  mov bx,playerLow
  mov cx,1
  call addToTotal
  mov playerLow,bx

  mov bx,playerHigh
  mov cx,11
  call addToTotal
  mov playerHigh,bx

  add esi,2
  ret
dealPlayer ENDP

dealDealer PROC
  mov ax,[esi]
  call makeDealerCard
  mov ah,0

  mov bx,dealerLow
  mov cx,1
  call addToTotal
  mov dealerLow,bx

  mov bx,dealerHigh
  mov cx,11
  call addToTotal
  mov dealerHigh,bx

  add esi,2
  ret
dealDealer ENDP

storeDealer PROC uses EDX
  mov ax,[esi]
  call blankDealerCard
  push eax
  mov ah,0

  mov bx,dealerLow
  mov cx,1
  call addToTotal
  mov dealerLow,bx

  mov bx,dealerHigh
  mov cx,11
  call addToTotal
  mov dealerHigh,bx

  pop eax
  add esi,2
  ret
storeDealer ENDP

addToTotal PROC USES eax
  call IsDigit
  jz L1
  cmp al,"T"
  je L2
  cmp al,"J"
  je L2
  cmp al,"Q"
  je L2
  cmp al,"K"
  je L2
  cmp AL,"A"
  je L3
  jmp quit

L1:
  sub al,"0"
  add bx,ax
  jmp quit
L2:
  add bx,10
  jmp quit
L3:
  add bx,cx
  jmp quit

quit:
  ret
addToTotal ENDP

shuffle proc USES esi ebx ecx eax
L1:
  mov eax,ecx
  call RandomRange
  
  mov ebx,eax
  dec ebx
  add ebx,ebx

  mov ax, WORD PTR [esi]
  xchg ax, WORD PTR [esi+ebx]
  mov WORD PTR [esi], ax
  add esi,2
  loop L1

  ret
shuffle ENDP
END