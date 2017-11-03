package asm;

import java.io.IOException;
import java.nio.file.Path;

public class NasmLinux64Writer extends NasmLinux32Writer {
	public NasmLinux64Writer(Path p) throws IOException {
		super(p);
	}

	@Override
	public void beginProgram() {
		writer.println("; compile with: nasm -felf64 filename.asm && ld filename.o");
		writer.println("; 64-bit linux only");
		writer.println("global _start");
		writer.println("section .text");
	}

	@Override
	public void loadStringLiteral(String value) {
		writer.println("\tmov rax, 1 ; sys_write");
		writer.println("\tmov rdi, 1 ; fd=stdout");
		writer.println("\tmov rsi, " + SLIT_PREFIX + mapStringToIndex.get(value) + " ; value=" + value);
		writer.println("\tmov rdx, " + (value.length()+1) + " ; msg length + newline");
	}
	
}
