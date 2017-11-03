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
	
	default void loadLiteral(Object literal) {
		if (literal instanceof Integer)
			loadIntegerLiteral((Integer)literal);
		else if (literal instanceof String)
			loadStringLiteral((String)literal);
		else if (literal instanceof Float)
			loadFloatLiteral((Float)literal);
	}
	void loadFloatLiteral(Float value);
	void loadIntegerLiteral(Integer value);
	void loadStringLiteral(String value);
	
	default void loadVariable(SymbolTableEntry entry) {
		if (entry.getType() == SymbolTableEntry.TypeName.INTEGER)
			loadIntegerVariable(entry.getName());
		else if (entry.getType() == SymbolTableEntry.TypeName.FLOAT)
			loadFloatVariable(entry.getName());
	}
	void loadFloatVariable(String varName);
	void loadIntegerVariable(String varName);
	
	void doAdd();
	void doSub();
	void doMul();
	void doDiv();
	
	void doAssign();
	
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
	void beginProgram();
	void endProgram();
}
