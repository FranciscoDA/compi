package asm;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.HashSet;

import compilador.SymbolTableEntry;

public class TASMWriter implements Writer {
	protected HashMap<String, Integer> mapVariableToIndex = new HashMap<>();
	protected HashMap<Integer, Integer> mapIntegerToIndex = new HashMap<>();
	protected HashMap<Float, Integer> mapFloatToIndex = new HashMap<>();
	protected HashMap<String, Integer> mapStringToIndex = new HashMap<>();

	protected HashMap<String, SymbolTableEntry> symbolTable;
	protected HashSet<Integer> integerTable;
	protected HashSet<Float> floatTable;
	protected HashSet<String> stringTable;
	
	protected PrintWriter writer;
	
	protected final String VARIABLE_PREFIX = "VAR_";
	protected final String LABEL_PREFIX = "LABEL_";
	protected final String ILIT_PREFIX = "CTE_INT_";
	protected final String FLIT_PREFIX = "CTE_FLT_";
	protected final String SLIT_PREFIX = "CTE_STR_";
	
	public TASMWriter(Path fpath) throws IOException {
		writer = new PrintWriter(Files.newOutputStream(fpath));
	}

	public void beginProgram() {
		writer.println(".MODEL LARGE");
		writer.println(".386");
		writer.println(".STACK 200h");
		writer.println(".DATA");
	}

	@Override
	public void loadSymbols(HashMap<String, SymbolTableEntry> variables, HashSet<Integer> integers,
			HashSet<Float> floats, HashSet<String> strings) {
		symbolTable = variables;
		integerTable = integers;
		floatTable = floats;
		stringTable = strings;

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
		writer.println("\tmov dx, " + SLIT_PREFIX + mapStringToIndex.get(value) + " ; value=" + value);
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
		writer.println("\tfadd");
	}
	@Override
	public void doSub() {
		writer.println("\tfsub");
	}
	@Override
	public void doMul() {
		writer.println("\tfmul");
	}
	@Override
	public void doDiv() {
		writer.println("\tfdiv");
	}
	@Override
	public void doPrint() {
		writer.println("\tmov ah, 09h");
		writer.println("\tint 21h");
	}
	@Override
	public void doCompare() {
		writer.println("\tcmp");
	}
	@Override
	public void doJmp() {
		writer.print("\tjmp ");
	}
	@Override
	public void doJG() {
		writer.print("\tjg ");
	}
	@Override
	public void doJGE() {
		writer.print("\tjge ");
	}
	@Override
	public void doJL() {
		writer.print("\tjgl ");
	}
	@Override
	public void doJLE() {
		writer.print("\tjle ");
	}
	@Override
	public void doJE() {
		writer.print("\tje ");
	}
	@Override
	public void doJNE() {
		writer.print("\tjne ");
	}
	@Override
	public void declareLabel(String name) {
		writer.println("\t" + LABEL_PREFIX + name + ":");
	}
	@Override
	public void referenceLabel(String name) {
		writer.print(LABEL_PREFIX + name + "\n");
	}

	@Override
	public void doTrunc() {
		// ????
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

		writer.println("\taux_int dw ?");
		writer.println("\taux_float dd ?");

		writer.println(".CODE");
	}
	@Override
	public void endCode() {
	}
	@Override
	public void endProgram() {
		writer.close();
	}

	@Override
	public void doAssign() {
		// ???
	}
}
