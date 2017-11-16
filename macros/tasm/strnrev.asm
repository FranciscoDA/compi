
section .text
;=====================================================
;Reverse string at memory address in place
;Signature: void strnreverse (int count, char* source)
strnrev:
	push bp
	mov bp, sp

	mov cx, [bp + __BITS__/8*3]
	mov si, [bp + __BITS__/8*2]

	.loop:
		cmp cx, 1
		jbe .return
		dec cx
		mov dl, [si+cx]
		xchg dl, [si]
		mov [si+cx], dl
		inc si
		dec cx
	jmp .loop

	.return:
	mov sp, bp
	pop bp
	ret __BITS__/8*2
