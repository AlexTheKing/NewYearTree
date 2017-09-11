%include "stud_io.inc"
GLOBAL _start


;.....^.....
;....^^^....
;...^^^^^...
;..^^^^^^^..
;.^^^^^^^^^.

section .data
const dw 23
  timeval:
    tv_sec  dd 0
    tv_usec dd 0

;esi 752

nullconst:
	mov dword [const], 23
	mov esi, [const]
	jmp main

section .text
_start: mov edi, 10
		xor esi, esi
		jmp nullconst
main:	call dopause
		PUTCHAR 0x1B
		PRINT "[2J"
		PRINT "HAPPY NEW YEAR!"
		PUTCHAR 10
		xor eax, eax
		xor ebx, ebx
		xor ecx, ecx
		xor edx, edx
		mov al, 20 ; spaces
		mov dl, 1 ; ^
					; bl - for @
		add dword [const], 2
		add esi, [const]

strings:
		mov cl, al
		call spaces
		mov cl, dl
		call tree
		mov cl, al
		call spaces
		PUTCHAR 10
		dec al
		add si, [const]
		add dl, 2
		cmp al, 0
		jnz strings
		dec edi
		cmp dword [const], 800
		jae nullconst
		cmp esi, 800
		jae nullconst
		cmp edi, 0
		jnz main
		FINISH

tree:	PUTCHAR 0x1B
		PRINT "[32;1m"
		PRINT "^"
		inc bl
		cmp bl, 7
		jz toys
backtree:
		loop tree
		ret



toys:	jmp changecolor
backtoys:
		PRINT "@"
		xor ebx, ebx
		jmp backtree



spaces:	PRINT " "
		loop spaces
		ret



changecolor:
		push eax
		push ebx
		mov ax, si ;delimoe
		mov bl, 7  ;delitel
		div bl
		pop ebx

		cmp ah, 0
		jz gray

		cmp ah, 1
		jz red

		cmp ah, 2
		jz yellow
		
		cmp ah, 3
		jz blue

		cmp ah, 4
		jz magenta

		cmp ah, 5
		jz cyan

		cmp ah, 6
		jz white

gray: PUTCHAR 0x1B
		PRINT "[30;1m"
		pop eax
		sub esi, 1
		jmp backtoys

red: PUTCHAR 0x1B
		PRINT "[31;1m"
		pop eax
		sub esi, 13
		jmp backtoys

white: PUTCHAR 0x1B
		PRINT "[37;1m"
		pop eax
		sub esi, 5
		jmp backtoys

yellow: PUTCHAR 0x1B
		PRINT "[33;1m"
		pop eax
		sub esi, 3
		jmp backtoys

blue: PUTCHAR 0x1B
		PRINT "[34;1m"
		pop eax
		sub esi, 8
		jmp backtoys

magenta: PUTCHAR 0x1B
		PRINT "[35;1m"
		pop eax
		sub esi, 19
		jmp backtoys

cyan: PUTCHAR 0x1B
		PRINT "[36;1m"
		pop eax
		sub esi, 9
		jmp backtoys

dopause:
		push eax
		push ebx
		push ecx
		mov dword [tv_sec], 0
  		mov dword [tv_usec], 300000000
  		mov eax, 162
  		mov ebx, timeval
  		mov ecx, 0
  		int 0x80
  		pop ecx
  		pop ebx
  		pop eax
  		ret
