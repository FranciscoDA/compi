package asm;

import java.io.IOException;
import java.nio.file.Path;

import compilador.SymbolTableEntry;

public class NasmLinux32Writer extends TasmDos16Writer {
	public NasmLinux32Writer(Path fpath) throws IOException
	{
		super(fpath);
	}
	
	@Override
	public Character[] getNewlineCharacters() {
		return new Character[] {'\n'};
	}
	
	@Override
	public void beginProgram() {
		String filename = this.path.getFileName().toString();
		if (filename.contains(".")) { // remove file extension
			filename = filename.substring(0, filename.lastIndexOf('.'));
		}
		
		writer.println("; compile with: nasm -felf32 " + filename  + ".asm && ld " + filename + ".o");
		writer.println("; 32-bit linux only");
		writer.println("global _start");
		writer.println("section .text");
	} 
	
	@Override
	public void beginCode() {
		writer.println("%include \"macros/nasm.asm\"");
		writer.println("_start:");
	}
	
	@Override
	public void loadStringLiteral(String value) {
		writer.println("\tmov ecx, " + SLIT_PREFIX + mapStringToIndex.get(value) + " ; value=" + value);
		writer.println("\tmov edx, " + value.length() + " ; msg length");
	}
	
	@Override
	public void doPrintString() {
		writer.println("\tmov eax, 0x4 ; sys_write");
		writer.println("\tmov ebx, 1 ; fd=stdout");
		writer.println("\tint 0x80");
	}
	@Override
	public void doPrintInteger() {
		writer.println("\titoa " + (CONVERSION_BUFFER_SIZE-1) + ", " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov ecx, " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov edx, edi");
		doPrintString();
	}
	@Override
	public void doPrintFloat() {
		writer.println("\tftoa " + (CONVERSION_BUFFER_SIZE-1) + ", " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov ecx, " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov edx, edi");
		doPrintString();
	}
	@Override
	public void doPrintLF() {
		writer.println("\tmov ecx, " + NEWLINE_NAME + " ; line break");
		writer.println("\tmov edx, " + getNewlineCharacters().length + " ; length");
		doPrintString();
	}

	@Override
	public void endCode() {
		// exit (0)
		writer.println("\tmov eax, 0x1 ; sys_exit");
		writer.println("\txor ebx, ebx ; code = 0");
		writer.println("\tint 0x80");
		
		for (Integer i : integerTable)
			writer.println(ILIT_PREFIX + mapIntegerToIndex.get(i) + ":\n\tdw " + i);
		for (Float f : floatTable)
			writer.println(FLIT_PREFIX + mapFloatToIndex.get(f) + ":\n\tdd " + f);
		for (String s : stringTable)
			writer.println(SLIT_PREFIX + mapStringToIndex.get(s) + ":\n\tdb \"" + s + "\"");

		writer.print(NEWLINE_NAME + ":\n\tdb ");
		for (int i = 0; i < getNewlineCharacters().length; i++) {
			writer.print((int)getNewlineCharacters()[i]);
			if (i < getNewlineCharacters().length - 1)
				writer.print(",");
			else
				writer.print("\n");
		}
		writer.println("section .bss");
		for (SymbolTableEntry entry : symbolTable.values()) {
			switch(entry.getType())	{
			case FLOAT:
				writer.println(VARIABLE_PREFIX + entry.getName() + ":\n\tresd 1");
				break;
			case INTEGER:
				writer.println(VARIABLE_PREFIX + entry.getName() + ":\n\tresw 1");
				break;
			}
		}
		writer.println(CONVERSION_BUFFER_NAME + ":\n\tresb " + CONVERSION_BUFFER_SIZE);
	}

	@Override
	public String getPlatformName() {
		return "Linux 32-bit (NASM syntax)";
	}
}
