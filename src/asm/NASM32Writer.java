package asm;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.HashSet;

import compilador.SymbolTableEntry;

public class NASM32Writer extends TASMWriter {

	public NASM32Writer(Path fpath) throws IOException
	{
		super(fpath);
	}

	@Override
	public void beginProgram() {
		writer.println("; compile with: nasm -felf32 filename.asm && ld filename.o");
		writer.println("; 32-bit linux only");
		writer.println("global _start");
		writer.println("section .text");
	} 
	
	@Override
	public void beginCode() {
		writer.println("_start:");
	}
	
	@Override
	public void loadStringLiteral(String value) {
		writer.println("\tmov eax, 1 ; sys_write");
		writer.println("\tmov ebx, 1 ; fd=stdout");
		writer.println("\tmov ecx, " + SLIT_PREFIX + mapStringToIndex.get(value) + " ; value=" + value);
		writer.println("\tmov edx, " + (value.length()+1) + " ; msg length + newline");
	}
	
	@Override
	public void doPrint() {
		writer.println("\tsyscall");
	}

	@Override
	public void endCode() {
		// exit (0)
		writer.println("\tmov eax, 60 ; sys_exit");
		writer.println("\txor rdi, rdi ; code = 0");
		writer.println("\tsyscall");
		
		for (Integer i : integerTable)
			writer.println(ILIT_PREFIX + mapIntegerToIndex.get(i) + ":\n\tdw " + i);
		for (Float f : floatTable)
			writer.println(FLIT_PREFIX + mapFloatToIndex.get(f) + ":\n\tdd " + f);
		for (String s : stringTable)
			writer.println(SLIT_PREFIX + mapStringToIndex.get(s) + ":\n\tdb \"" + s + "\", 10");
		writer.println("section .bss");
		for (SymbolTableEntry entry : symbolTable.values())
		{
			switch(entry.getType())
			{
			case FLOAT:
				writer.println(VARIABLE_PREFIX + entry.getName() + ":\n\tresb 4");
				break;
			case INTEGER:
				writer.println(VARIABLE_PREFIX + entry.getName() + ":\n\tresw 1");
				break;
			}
		}
	}

}
