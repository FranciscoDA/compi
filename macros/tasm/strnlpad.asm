;========================================
;Left-pad a string with character in dl
;Signature: void strnleftpad(int count, char* src, int minWidth, char padChar)
strnlpad:
	push ebp
	mov ebp, esp

	mov ecx, [ebp + WORD_SIZE*4] ; ecx=minWidth
	sub ecx, [ebp + WORD_SIZE*2] ; ecx-=count

	pushad
	mov eax, [ebp + WORD_SIZE*2] ; ecx=count
	push eax
	mov ebx, [ebp + WORD_SIZE*3] ; ebx=src
	push ebx
	lea ebx, [ebx + ecx]
	push ebx
	call strncpy
	popad

	mov ebx, [ebp + WORD_SIZE*3]
	mov ecx, [ebp + WORD_SIZE*4] ; ecx=minWidth
	mov eax, [ebp + WORD_SIZE*2]
	sub ecx, eax ; ecx-=count
	mov edx, [ebp + WORD_SIZE*5] ; edx=padChar
	.padloop:
		cmp ecx, 0
		jle .breakpadloop
		mov [ebx+ecx], dl
		dec ecx
		jmp .padloop
	.breakpadloop:

	mov esp, ebp
	pop ebp
	ret WORD_SIZE*4

