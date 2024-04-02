include setup.inc
INCLUDE Irvine32.inc

.data
ALIGN 2
card1 WORD "H2","H3","H4","H5","H6","H7","H8","H9","HT","HJ","HQ","HK","HA",
		   "C2","C3","C4","C5","C6","C7","C8","C9","CT","CJ","CQ","CK","CA"
		   
card2 WORD "D2","D3","D4","D5","D6","D7","D8","D9","DT","DJ","DQ","DK","DA",
		   "S2","S3","S4","S5","S6","S7","S8","S9","ST","SJ","SQ","SK","SA",0

deckSize DWORD 0

playerLow WORD 0
playerHigh WORD 0
playerFinal WORD 0
dealerLow WORD 0
dealerHigh WORD 0
dealerHand WORD 2 DUP(?)
prompt BYTE "Your next move? -      ",0
clear BYTE "                        ",0
input BYTE 5 DUP(?)

scoreMessage BYTE "Your Score:       Dealer Score: ?",0
captionW		BYTE "Warning",0
warningMsg	BYTE "Invalid input: please type either "
				BYTE "'Hit' or 'Stay'",0

.code
main PROC PUBLIC
  add deckSize,LENGTHOF card1
  add deckSize,LENGTHOF card2
  dec deckSize
  call Randomize

  mov eax,(lightGray*16)+black
  call SetTextColor
  call Clrscr

  mov esi, OFFSET card1
  mov ecx,deckSize
  call shuffle

; Initial game setup
  mov dh, 18
  mov dl,3
  call dealPlayer
  mov dh, 0
  call storeDealer
  mov dealerHand, ax
  mov dh, 18
  add dl,7
  call dealPlayer
  mov dh, 0
  call storeDealer
  mov dealerHand[1], ax

  mov dh, 10
  mov dl, 5
  call Gotoxy
  mov edx, OFFSET scoreMessage
  call WriteString

  mov dh,18
  mov dl,10
  jmp P1
error: 
INVOKE MessageBox, NULL, ADDR warningMsg, 
		ADDR captionW, 
		MB_OK + MB_ICONEXCLAMATION
P1:  ; Player's turn
  push edx
  
  mov dh,10
  mov dl,17
  call Gotoxy
  mov eax,0
  mov ax, playerHigh
  cmp ax,21
  JLE P3
  mov ax, playerLow
  cmp eax,21
  jg fail

P3:
  call WriteDec

  mov eax,(blue*16)+white
  call SetTextColor
  mov dh, 20
  mov dl,0
  call Gotoxy
  mov edx, OFFSET prompt
  call WriteString
  mov dh,20
  mov dl,18
  call Gotoxy
  mov edx, OFFSET input
  mov ecx, 5
  call ReadString
  mov eax,(lightGray*16)+black
  call SetTextColor

  mov al,input[0]
  cmp al,"s"
  je D1
  cmp al,"S"
  je D1
  cmp al,"P"
  je D1
  cmp al,"p"
  je D1
  cmp al,"h"
  je P2
  cmp al,"H"
  je P2
  jmp error

P2:  ; Hit
  pop edx
  add dl, 7
  call dealPlayer
  jmp P1

; Dealer Turn
D1:
  mov ax, playerHigh
  cmp ax, 21
  jg D3
  jmp D4
D3:
  mov ax, playerLow

D4:
  mov playerFinal, ax
  mov dh,0
  mov dl,3
  mov ax, dealerHand[0]
  call makeDealerCard
  mov ax, dealerHand[1]
  add dl,7
  call makeDealerCard

D5:
  push edx
  mov dh,10
  mov dl,37
  call Gotoxy
  mov eax,0
  mov ax, dealerHigh
  cmp ax,21
  JLE D2
  mov ax, dealerLow
  cmp eax,21
  jg win

D2:
  call WriteDec
  
  call Gotoxy
  cmp ax, playerFinal
  jge fail
  
  pop edx
  add dl, 7
  call dealDealer

  jmp D5

fail:
  call WriteDec
  mov dh, 12
  mov dl, 8
  call Gotoxy
  mov eax,(red*16)+white
  call SetTextColor
  call loseMsg
  jmp quit

win:
  call WriteDec
  mov dh, 13
  mov dl, 8
  call Gotoxy
  mov eax,(green*16)+white
  call SetTextColor
  call winMsg
  
; End of game
quit:
  mov eax,(lightGray*16)+black
  call SetTextColor
  mov dh, 20
  mov dl,0
  call Gotoxy

  invoke ExitProcess,0
main ENDP
END main