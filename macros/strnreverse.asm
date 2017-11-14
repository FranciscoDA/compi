;===================================================
;Reverse string at memory address in range [esi;edi)
; char* source
; int count
strnreverse:
	push ebp
	mov ebp, esp

	mov esi, [ebp + __BITS__/8*2]
	mov ecx, [ebp + __BITS__/8*3]

	.loop:
	cmp ecx, 1
	jbe .finish
	dec ecx
	mov dl, [esi+ecx]
	xchg dl, [esi]
	mov [esi+ecx], dl
	inc esi
	dec ecx
	jmp .loop
	.finish:

	mov esp, ebp
	pop ebp
	ret __BITS__/8*2
