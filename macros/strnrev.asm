
section .text
;=====================================================
;Reverse string at memory address in place
;Signature: void strnreverse (int count, char* source)
strnrev:
	push ebp
	mov ebp, esp

	mov ecx, [ebp + __BITS__/8*3]
	mov esi, [ebp + __BITS__/8*2]

	.loop:
		cmp ecx, 1
		jbe .return
		dec ecx
		mov dl, [esi+ecx]
		xchg dl, [esi]
		mov [esi+ecx], dl
		inc esi
		dec ecx
	jmp .loop

	.return:
	mov esp, ebp
	pop ebp
	ret __BITS__/8*2
