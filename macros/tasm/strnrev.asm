
;=====================================================
;Reverse string at memory address in place
;Signature: void strnreverse (int count, char* source)
strnrev:
	push bp
	mov bp, sp

	mov di, [bp + WORD_SIZE*3]
	mov si, [bp + WORD_SIZE*2]
	add di, si
	dec di

	@@loop:
		cmp di, si
		jbe @@return
		mov dl, [di]
		xchg dl, [si]
		mov [di], dl
		inc si
		dec di
	jmp @@loop

	@@return:
	mov sp, bp
	pop bp
	ret WORD_SIZE*2
