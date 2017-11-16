;========================================
;Copy string from source to dest variable
;Source and destination may overlap
; char* destination
; char* source
; int count
strncpy:
	push bp
	mov bp, sp

	mov di, [bp + __BITS__/8*2]
	mov si, [bp + __BITS__/8*3]
	mov cx, [bp + __BITS__/8*4]

	cmp di, si
	jg .r2lstart

	; copy left-to-right
	.l2rloop:
	cmp cx, 0
	jbe .done
	mov dl, [si]
	mov [di], dl
	dec cx
	inc si
	inc di
	jmp .l2rloop

	.r2lstart:
	add di, cx
	dec di
	add si, cx
	dec si
	; copy right-to left
	.r2lloop:
	cmp cx, 0
	jbe .done
	mov dl, [si]
	mov [di], dl
	dec cx
	dec di
	dec si
	jmp .r2lloop
	.done:
	mov sp, bp
	pop bp
	ret __BITS__/8*3
