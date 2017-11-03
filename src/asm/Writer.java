package asm;

import java.util.HashMap;
import java.util.HashSet;

import compilador.SymbolTableEntry;

public interface Writer {
	void loadSymbols(
			HashMap<String, SymbolTableEntry> variables,
			HashSet<Integer> integers,
			HashSet<Float> floats,
			HashSet<String> strings
			);
	
	void loadFloatLiteral(Float value);
	void loadIntegerLiteral(Integer value);
	void loadStringLiteral(String value);
	
	void loadFloatVariable(String varName);
	void loadIntegerVariable(String varName);
	
	void doAdd();
	void doSub();
	void doMul();
	void doDiv();
	
	void doPrint();
	void doCompare();
	void doTrunc();
	
	void doJmp();
	void doJG();
	void doJGE();
	void doJL();
	void doJLE();
	void doJE();
	void doJNE();
	
	void declareLabel(String name);
	void referenceLabel(String name);
	
	void beginCode();
	void endCode();
	void endProgram();
}
