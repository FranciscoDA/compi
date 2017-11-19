package asm;

import java.io.IOException;
import java.nio.file.Path;

import compilador.SymbolTableEntry;

public class NasmLinux32Writer extends TasmDos16Writer {
	private final String NEWLINE_NAME = "CTE_ESPECIAL_LF";
	
	public NasmLinux32Writer(Path fpath) throws IOException
	{
		super(fpath);
	}
	
	@Override
	public void beginProgram() {
		String filename = this.path.getFileName().toString();
		if (filename.contains(".")) { // remove file extension
			filename = filename.substring(0, filename.lastIndexOf('.'));
		}
		writer.println("; 32-bit linux only:");
		writer.println("; compile with: nasm -felf32 " + filename  + ".asm && ld " + filename + ".o");
		writer.println("; 64-bit linux only:");
		writer.println("; compile with: nasm -felf32 " + filename  + ".asm && ld -melf_i386 " + filename + ".o");
		writer.println("global _start");
		writer.println("section .text");
	} 
	
	@Override
	public void beginCode() {
		writer.println("%include \"macros/nasm.asm\"");
		writer.println("_start:");
	}

	@Override
	public void loadFloatLiteral(Float value) {
		writer.println("\tfld dword [" + FLIT_PREFIX + mapFloatToIndex.get(value) + "] ; value=" + value);
	}
	@Override
	public void loadIntegerLiteral(Integer value) {
		writer.println("\tfild word [" + ILIT_PREFIX + mapIntegerToIndex.get(value) + "] ; value=" + value);
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
		writer.println("lea ebx, [" + CONVERSION_BUFFER_NAME + "]");
		writer.println("push ebx");
		writer.println("push " + (CONVERSION_BUFFER_SIZE-1));
		writer.println("call itoa");
		writer.println("\tmov ecx, " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov edx, eax");
		doPrintString();
	}
	@Override
	public void doModulo() {
		writer.println("\tfxch");
		writer.println("\tfprem");
		writer.println("\tfxch");
		writer.println("\tfstp st0");
	}
	@Override
	public void doPrintFloat() {
		writer.println("push 4");
		writer.println("push 10");
		writer.println("lea ebx, [" + CONVERSION_BUFFER_NAME + "]");
		writer.println("push ebx");
		writer.println("push " + (CONVERSION_BUFFER_SIZE-1));
		writer.println("call ftoa");
		writer.println("\tmov ecx, " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov edx, eax");
		doPrintString();
	}
	@Override
	public void doPrintLF() {
		writer.println("\tmov ecx, " + NEWLINE_NAME + " ; line break");
		writer.println("\tmov edx, 1 ; length");
		doPrintString();
	}
	@Override
	public void loadFloatVariable(String varName) {
		writer.println("\tfld dword [" + VARIABLE_PREFIX + varName + "]");
	}
	@Override
	public void loadIntegerVariable(String varName) {
		writer.println("\tfild word [" + VARIABLE_PREFIX + varName + "]");
	}
	@Override
	public void doAssign(String varName) {
		SymbolTableEntry entry = symbolTable.get(varName);
		switch (entry.getType()) {
		case FLOAT:
			writer.println("\tfstp dword [" + VARIABLE_PREFIX + varName + "]");
			break;
		case INTEGER:
			writer.println("\tfistp word [" + VARIABLE_PREFIX + varName + "]");
			break;
		}
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

		writer.println(NEWLINE_NAME + ":\n\tdb 10");
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
