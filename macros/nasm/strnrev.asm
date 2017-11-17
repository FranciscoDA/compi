
section .text
;=====================================================
;Reverse string at memory address in place
;Signature: void strnreverse (int count, char* source)
strnrev:
	push ebp
	mov ebp, esp

	mov edi, [ebp + WORD_SIZE*3]
	mov esi, [ebp + WORD_SIZE*2]
	add edi, esi
	dec edi

	.loop:
		cmp edi, esi
		jbe .return
		mov dl, [edi]
		xchg dl, [esi]
		mov [edi], dl
		inc esi
		dec edi
	jmp .loop

	.return:
	mov esp, ebp
	pop ebp
	ret WORD_SIZE*2
