.386
.model flat,stdcall
.stack 4096
OPTION PROC:PRIVATE
ExitProcess PROTO, dwExitCode:DWORD

dealPlayer PROTO
dealDealer PROTO
storeDealer PROTO
shuffle PROTO

makePlayerCard PROTO
makeDealerCard PROTO
blankDealerCard PROTO
winMsg PROTO
loseMsg PROTO

EXTERNDEF playerLow:WORD
EXTERNDEF playerHigh:WORD
EXTERNDEF dealerLow:WORD
EXTERNDEF dealerHigh:WORD