package asm;

import java.io.IOException;
import java.nio.file.Path;

public class NasmLinux64Writer extends NasmLinux32Writer {
	public NasmLinux64Writer(Path p) throws IOException {
		super(p);
	}

	@Override
	public void beginProgram() {
		String filename = this.path.getFileName().toString();
		if (filename.contains(".")) { // remove file extension
			filename = filename.substring(0, filename.lastIndexOf('.'));
		}
		
		writer.println("; compile with: nasm -felf64 " + filename + ".asm && ld " + filename + ".o");
		writer.println("; 64-bit linux only");
		writer.println("global _start");
		writer.println("section .text");
	}
	
	@Override
	public String getPlatformName() {
		return "Linux 64-bit (NASM syntax)";
	}
}
