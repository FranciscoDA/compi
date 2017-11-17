
;========================================
;Left-pad a string with character in dl
;Signature: void strnleftpad(int count, char* src, int minWidth, char padChar)
strnlpad:
	push bp
	mov bp, sp

	mov cx, [bp + WORD_SIZE*4] ; cx=minWidth
	sub cx, [bp + WORD_SIZE*2] ; cx-=count

	pushad
	mov ax, [bp + WORD_SIZE*2] ; cx=count
	push ax
	mov bx, [bp + WORD_SIZE*3] ; bx=src
	push bx
	lea bx, [bx + cx]
	push bx
	call strncpy
	popad

	mov bx, [bp + WORD_SIZE*3]
	mov cx, [bp + WORD_SIZE*4] ; cx=minWidth
	mov ax, [bp + WORD_SIZE*2]
	sub cx, ax ; cx-=count
	mov edx, [bp + WORD_SIZE*5] ; edx=padChar
	padloop:
		cmp cx, 0
		jle breakpadloop
		mov [bx+cx], dl
		dec cx
		jmp padloop
	breakpadloop:

	mov sp, bp
	pop bp
	ret WORD_SIZE*4

