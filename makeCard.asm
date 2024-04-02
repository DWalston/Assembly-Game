include setup.inc
INCLUDE Irvine32.inc

.data
cardTop BYTE   "  __________",0
botCardSlide BYTE " /          \",0
topCardSlide BYTE " \__________/",0
cardBody BYTE  "|            |",0

bust1 BYTE "  ___           ____  _____ ",0
bust2 BYTE " |   \  |   |  /        |   ",0
bust3 BYTE " |___/  |   |  \___     |   ",0
bust4 BYTE " |   \  |   |      \    |   ",0
bust5 BYTE " |___/  \___/  ____/    |   ",0
bust6 BYTE "                            ",0

win1 BYTE "           ___         | ",0
win2 BYTE " \      /   |   |\  |  | ",0
win3 BYTE "  \    /    |   | \ |  | ",0
win4 BYTE "   \/\/    _|_  |  \|  . ",0
win5 BYTE "                         ",0

.code
makePlayerCard PROC USES eax ebx ecx edx
  call Gotoxy
  mov bh,dh
  mov bl,dl
  mov ecx,5

L1:
  mov edx,OFFSET cardBody
  call WriteString
  call moveUp
  loop L1
  
  mov WORD PTR cardBody[3],ax
  mov edx, OFFSET cardBody
  call WriteString
  call moveUp
  mov edx,OFFSET botCardSlide
  call WriteString
  call moveUp
  mov edx,OFFSET cardTop
  call WriteString
  
  mov al," "
  mov cardBody[3],al
  mov cardBody[4],al
  
  ret
makePlayerCard endp

makeDealerCard PROC USES eax ebx ecx edx
  call Gotoxy
  mov bh,dh
  mov bl,dl
  mov ecx,5

L1:
  mov edx,OFFSET cardBody
  call WriteString
  call moveDown
  loop L1
  
  mov WORD PTR cardBody[3],ax
  mov edx, OFFSET cardBody
  call WriteString
  call moveDown
  mov edx,OFFSET topCardSlide
  call WriteString
  
  mov al," "
  mov cardBody[3],al
  mov cardBody[4],al
  ret
makeDealerCard endp

blankDealerCard PROC USES eax ebx ecx edx
  call Gotoxy
  mov bl,dl
  mov bh,dh
  mov ecx,6

L1:
  mov edx,OFFSET cardBody
  call WriteString
  call moveDown
  loop L1
  
  mov edx,OFFSET topCardSlide
  call WriteString
  call moveDown
  
  ret
blankDealerCard endp

winMsg PROC USES ebx ecx edx
  mov bl,dl
  mov bh,dh

  mov edx, OFFSET win1
  call WriteString
  call moveDown
  mov edx, OFFSET win2
  call WriteString
  call moveDown
  mov edx, OFFSET win3
  call WriteString
  call moveDown
  mov edx, OFFSET win4
  call WriteString
  call moveDown
  mov edx, OFFSET win5
  call WriteString

  ret
winMsg endp

loseMsg PROC USES ebx ecx edx
  mov bl,dl
  mov bh,dh

  mov edx, OFFSET bust1
  call WriteString
  call moveDown
  mov edx, OFFSET bust2
  call WriteString
  call moveDown
  mov edx, OFFSET bust3
  call WriteString
  call moveDown
  mov edx, OFFSET bust4
  call WriteString
  call moveDown
  mov edx, OFFSET bust5
  call WriteString
  call moveDown
  mov edx, OFFSET bust6
  call WriteString

  ret
loseMsg endp

moveUp proc USES edx
  dec bh
  mov dh,bh
  mov dl,bl
  call Gotoxy
  ret
moveUp ENDP

moveDown proc USES edx
  inc bh
  mov dh,bh
  mov dl,bl
  call Gotoxy
  ret
moveDown ENDP

END