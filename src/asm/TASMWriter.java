package asm;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.HashSet;

import compilador.SymbolTableEntry;

public class TASMWriter implements Writer {
	private HashMap<String, Integer> mapVariableToIndex = new HashMap<>();
	private HashMap<Integer, Integer> mapIntegerToIndex = new HashMap<>();
	private HashMap<Float, Integer> mapFloatToIndex = new HashMap<>();
	private HashMap<String, Integer> mapStringToIndex = new HashMap<>();
	
	private PrintWriter writer;
	
	private final String VARIABLE_PREFIX = "VAR_";
	private final String LABEL_PREFIX = "LABEL_";
	private final String ILIT_PREFIX = "CTE_INT_";
	private final String FLIT_PREFIX = "CTE_FLT_";
	private final String SLIT_PREFIX = "CTE_STR_";
	
	public TASMWriter(Path fpath) throws IOException
	{
		writer = new PrintWriter(Files.newOutputStream(fpath));
		writer.println(".MODEL LARGE");
		writer.println(".386");
		writer.println(".STACK 200h");
		writer.println(".DATA");
	}
	@Override
	public void loadSymbols(HashMap<String, SymbolTableEntry> variables, HashSet<Integer> integers,
			HashSet<Float> floats, HashSet<String> strings) {
		for (SymbolTableEntry entry : variables.values())
		{
			switch(entry.getType())
			{
			case FLOAT:
				writer.println("\tVAR_" + entry.getName() + " dd ?");
				break;
			case INTEGER:
				writer.println("\tVAR_" + entry.getName() + " dw ?");
				break;
			}
			mapVariableToIndex.put(entry.getName(), mapVariableToIndex.size());
		}
		for (Integer i : integers)
		{
			writer.println("\t" + ILIT_PREFIX + mapIntegerToIndex.size() + " dw " + i);
			mapIntegerToIndex.put(i, mapIntegerToIndex.size());
		}
		for (Float f : floats)
		{
			writer.println("\t" + FLIT_PREFIX + mapFloatToIndex.size() + " dd " + f);
			mapFloatToIndex.put(f, mapFloatToIndex.size());
		}
		for (String st : strings)
		{
			writer.println("\t" + SLIT_PREFIX + mapStringToIndex.size() + " db \"" + st + "\", '$'");
			mapStringToIndex.put(st, mapStringToIndex.size());
		}
		writer.println("\taux_int dw ?");
		writer.println("\taux_float dd ?");
	}
	@Override
	public void loadFloatLiteral(Float value) {
		writer.print("fld " + FLIT_PREFIX + mapFloatToIndex.get(value) + " ; value=" + value);
	}
	@Override
	public void loadIntegerLiteral(Integer value) {
		writer.println("flid " + ILIT_PREFIX + mapIntegerToIndex.get(value) + " ; value=" + value);
	}
	@Override
	public void loadStringLiteral(String value) {
		writer.println("mov dx, " + SLIT_PREFIX + mapStringToIndex.get(value) + " ; value=" + value);
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
		writer.println("fadd");
	}
	@Override
	public void doSub() {
		writer.println("fsub");
	}
	@Override
	public void doMul() {
		writer.println("fmul");
	}
	@Override
	public void doDiv() {
		writer.println("fdiv");
	}
	@Override
	public void doPrint() {
		writer.println("mov ah, 09h");
		writer.println("int 21h");
	}
	@Override
	public void doCompare() {
		writer.println("cmp");
	}
	@Override
	public void doJmp() {
		writer.print("jmp ");
	}
	@Override
	public void doJG() {
		writer.print("jg ");
	}
	@Override
	public void doJGE() {
		writer.print("jge ");
	}
	@Override
	public void doJL() {
		writer.print("jgl ");
	}
	@Override
	public void doJLE() {
		writer.print("jle ");
	}
	@Override
	public void doJE() {
		writer.print("je ");
	}
	@Override
	public void doJNE() {
		writer.print("jne ");
	}
	@Override
	public void declareLabel(String name) {
		writer.println(LABEL_PREFIX + name + ":");
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
		writer.println(".CODE");
	}
	@Override
	public void endCode() {
	}
	@Override
	public void endProgram() {
		writer.close();
	}
}
