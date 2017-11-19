package asm;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.HashSet;

import compilador.SymbolTableEntry;

public class TasmDos16Writer implements Writer {
	protected HashMap<String, Integer> mapVariableToIndex = new HashMap<>();
	protected HashMap<Integer, Integer> mapIntegerToIndex = new HashMap<>();
	protected HashMap<Float, Integer> mapFloatToIndex = new HashMap<>();
	protected HashMap<String, Integer> mapStringToIndex = new HashMap<>();

	protected HashMap<String, SymbolTableEntry> symbolTable = new HashMap<>();
	protected HashSet<Integer> integerTable = new HashSet<>();
	protected HashSet<Float> floatTable = new HashSet<>();
	protected HashSet<String> stringTable = new HashSet<>();
	
	protected Path path;
	protected PrintWriter writer;
	
	protected final String VARIABLE_PREFIX = "VAR_";
	protected final String LABEL_PREFIX = "LABEL_";
	protected final String ILIT_PREFIX = "CTE_INT_";
	protected final String FLIT_PREFIX = "CTE_FLT_";
	protected final String SLIT_PREFIX = "CTE_STR_";
	protected final String CONVERSION_BUFFER_NAME = "BUFFER_CONVERSION";
	protected final int CONVERSION_BUFFER_SIZE = 15;
	
	public TasmDos16Writer(Path fpath) throws IOException {
		path = fpath;
		writer = new PrintWriter(Files.newOutputStream(fpath));
	}

	public void beginProgram() {
		writer.println(".MODEL LARGE");
		writer.println(".386");
		writer.println(".STACK 200h");
		writer.println("INCLUDE macros/tasm.asm");
		writer.println(".DATA");
	}

	@Override
	public void loadSymbols(HashMap<String, SymbolTableEntry> variables, HashSet<Integer> integers,
			HashSet<Float> floats, HashSet<String> strings) {
		symbolTable.putAll(variables);
		integerTable.addAll(integers);
		floatTable.addAll(floats);
		stringTable.addAll(strings);

		for (SymbolTableEntry entry : symbolTable.values())
			mapVariableToIndex.put(entry.getName(), mapVariableToIndex.size());
		for (Integer i : integerTable)
			mapIntegerToIndex.put(i, mapIntegerToIndex.size());
		for (Float f : floatTable)
			mapFloatToIndex.put(f, mapFloatToIndex.size());
		for (String st : stringTable)
			mapStringToIndex.put(st, mapStringToIndex.size());
	}

	@Override
	public void loadFloatLiteral(Float value) {
		writer.println("\tfld " + FLIT_PREFIX + mapFloatToIndex.get(value) + " ; value=" + value);
	}
	@Override
	public void loadIntegerLiteral(Integer value) {
		writer.println("\tfild " + ILIT_PREFIX + mapIntegerToIndex.get(value) + " ; value=" + value);
	}
	@Override
	public void loadStringLiteral(String value) {
		writer.println("\tlea dx, [" + SLIT_PREFIX + mapStringToIndex.get(value) + "] ; value=" + value);
	}
	@Override
	public void loadFloatVariable(String varName) {
		writer.println("\tfld " + VARIABLE_PREFIX + varName);
	}
	@Override
	public void loadIntegerVariable(String varName) {
		writer.println("\tfild " + VARIABLE_PREFIX + varName);
	}
	@Override
	public void doAdd() {
		writer.println("\tfaddp");
	}
	@Override
	public void doSub() {
		writer.println("\tfsubp");
	}
	@Override
	public void doMul() {
		writer.println("\tfmulp");
	}
	@Override
	public void doDiv() {
		writer.println("\tfdivp");
	}
	@Override
	public void doPrintString() {
		writer.println("\tmov ah, 09h");
		writer.println("\tint 21h");
	}
	@Override
	public void doPrintInteger() {
		writer.println("lea bx, [" + CONVERSION_BUFFER_NAME + "]");
		writer.println("push bx");
		writer.println("push " + (CONVERSION_BUFFER_SIZE-1));
		writer.println("call itoa");
		writer.println("lea bx, [" + CONVERSION_BUFFER_NAME + "]");
		writer.println("add bx, ax");
		writer.println("mov byte ptr [bx], '$'");
		writer.println("\tlea dx, [" + CONVERSION_BUFFER_NAME + "]");
		doPrintString();
	}
	@Override
	public void doPrintFloat() {
		writer.println("push 4");
		writer.println("push 10");
		writer.println("lea bx, [" + CONVERSION_BUFFER_NAME + "]");
		writer.println("push bx");
		writer.println("push " + (CONVERSION_BUFFER_SIZE-1));
		writer.println("call ftoa");
		writer.println("add bx, ax");
		writer.println("mov byte ptr [bx], '$'");
		writer.println("\tlea dx, [" + CONVERSION_BUFFER_NAME + "]");
		doPrintString();
	}
	@Override
	public void doPrintLF() {
		writer.print(
				"\tmov ah, 02h\n" +
				"\tmov dl, 10\n" +
				"\tint 21h\n" +
				"\tmov dl, 13\n" +
				"\tint 21h\n"
				);
	}
	@Override
	public void doCompare() {
		writer.println("\tfcompp");
		writer.println("\tfstsw ax");
	}
	@Override
	public void doJMP(String label) {
		writer.println("\tjmp " + LABEL_PREFIX + label);
	}
	@Override
	public void doJG(String label) {
		writer.println("\ttest ax, 0000000100000000b ; c0");
		writer.println("\tjnz " + LABEL_PREFIX + label);
	}
	@Override
	public void doJGE(String label) {
		doJG(label);
		doJE(label);
	}
	@Override
	public void doJL(String label) {
		writer.println("\ttest ax, 0000000100000000b ; c0");
		writer.println("\tjz " + LABEL_PREFIX + label);
	}
	@Override
	public void doJLE(String label) {
		doJL(label);
		doJE(label);
	}
	@Override
	public void doJE(String label) {
		writer.println("\ttest ax, 0100000000000000b ; c3");
		writer.println("\tjnz " + LABEL_PREFIX + label);
	}
	@Override
	public void doJNE(String label) {
		writer.println("\ttest ax, 0100000000000000b ; c3");
		writer.println("\tjz " + LABEL_PREFIX + label);
	}
	@Override
	public void declareLabel(String name) {
		writer.println("\t" + LABEL_PREFIX + name + ":");
	}

	@Override
	public void doTrunc() {
		writer.println("\tfSetRC RC_ZERO");
		writer.println("\tfrndint");
		writer.println("\tfSetRC RC_NEAREST");
	}
	@Override
	public void doSine() {
		writer.println("\tfsin");
	}
	@Override
	public void doCosine() {
		writer.println("\tfcos");
	}
	@Override
	public void doSqrt() {
		writer.println("\tfsqrt");
	}
	@Override
	public void doModulo() {
		writer.println("\tfxch");
		writer.println("\tfprem");
		writer.println("\tfxch");
		writer.println("\tfstp st(0)");
	}
	@Override
	public void doPower() {
		writer.println("\tfpow");
	}
	@Override
	public void beginCode() {
		for (SymbolTableEntry entry : symbolTable.values())
		{
			switch(entry.getType())
			{
			case FLOAT:
				writer.println("\t" + VARIABLE_PREFIX + entry.getName() + " dd ?");
				break;
			case INTEGER:
				writer.println("\t" + VARIABLE_PREFIX + entry.getName() + " dw ?");
				break;
			}
		}
		for (Integer i : integerTable)
			writer.println("\t" + ILIT_PREFIX + mapIntegerToIndex.get(i) + " dw " + i);
		for (Float f : floatTable)
			writer.println("\t" + FLIT_PREFIX + mapFloatToIndex.get(f) + " dd " + f);
		for (String s : stringTable)
			writer.println("\t" + SLIT_PREFIX + mapStringToIndex.get(s) + " db \"" + s + "\", '$'");
	
		writer.println("\t" + CONVERSION_BUFFER_NAME + " db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0");

		writer.println("\taux_int dw ?");
		writer.println("\taux_float dd ?");

		writer.println(".CODE");
		writer.println("MAIN:");
		writer.println("\tmov ax, SEG " + CONVERSION_BUFFER_NAME);
		writer.println("\tmov ds, ax");
		writer.println("\tmov es, ax");
		writer.println("\tfinit");
	}
	@Override
	public void endCode() {
		writer.println("\tmov ax, 4C00h ; sys_exit");
		writer.println("\tint 21h");
		writer.println("END MAIN");
	}
	@Override
	public void endProgram() {
		writer.close();
	}

	@Override
	public void doAssign(String varName) {
		SymbolTableEntry entry = symbolTable.get(varName);
		switch (entry.getType()) {
		case FLOAT:
			writer.println("\tfstp " + VARIABLE_PREFIX + varName);
			break;
		case INTEGER:
			writer.println("\tfistp " + VARIABLE_PREFIX + varName);
			break;
		}
	}

	@Override
	public Path getOutputPath() {
		return path;
	}

	@Override
	public String getPlatformName() {
		return "DOS 16-bit (TASM syntax)";
	}
}
