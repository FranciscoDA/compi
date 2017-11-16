;========================================
;Copy string from source to dest variable
;Source and destination may overlap
; char* destination
; char* source
; int count
strncpy:
	push ebp
	mov ebp, esp

	mov edi, [ebp + __BITS__/8*2]
	mov esi, [ebp + __BITS__/8*3]
	mov ecx, [ebp + __BITS__/8*4]

	cmp edi, esi
	jg .r2lstart

	; copy left-to-right
	.l2rloop:
	cmp ecx, 0
	jbe .done
	mov dl, [esi]
	mov [edi], dl
	dec ecx
	inc esi
	inc edi
	jmp .l2rloop

	.r2lstart:
	add edi, ecx
	dec edi
	add esi, ecx
	dec esi
	; copy right-to left
	.r2lloop:
	cmp ecx, 0
	jbe .done
	mov dl, [esi]
	mov [edi], dl
	dec ecx
	dec edi
	dec esi
	jmp .r2lloop
	.done:
	mov esp, ebp
	pop ebp
	ret __BITS__/8*3