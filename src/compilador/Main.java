package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.HashSet;

import java_cup.runtime.Symbol;
import java.util.LinkedList;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	private final static Path TS_PATH = Paths.get("ts.txt");

	public static void outputSymbolTable(HashMap<String, SymbolTableEntry> symbolTable,
			HashSet<Integer> integerTable,
			HashSet<Float> floatTable,
			HashSet<String> stringTable) {
		try {
			PrintWriter pw =  new PrintWriter(Files.newOutputStream(TS_PATH));
			String fmt = "%20s%20s%20s%20s\n";
			for (SymbolTableEntry e : symbolTable.values()) {
				pw.printf(fmt, e.getName(), e.getType().toString(), "---", "---");
			}
			for (Integer i : integerTable) {
				pw.printf(fmt, "---", "CteInt", i.toString(), "---");
			}
			for (Float f : floatTable) {
				pw.printf(fmt, "---", "CteReal", f.toString(), "---");
			}
			for (String s : stringTable) {
				pw.printf(fmt, "---", "CteString", s, Integer.toString(s.length()));
			}
			pw.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public static void main(String[] argv) {
		try {
			BufferedReader br = Files.newBufferedReader(PRUEBA_PATH);
			Scanner sc = new Scanner(br);
			parser par = new parser(sc);
			try {
				Symbol s = par.debug_parse();
				
				outputSymbolTable(par.symbolTable, par.integerTable, par.floatTable, par.stringTable);
				LinkedList<rpn.Node> program = (LinkedList<rpn.Node>) s.value;
				PrintWriter pw =  new PrintWriter(Files.newOutputStream(Paths.get("intermedio.txt")));
				for (rpn.Node node : program)
				{
					pw.println(node.toString());
				}
				pw.close();
				
				PrintWriter pw2 =  new PrintWriter(Files.newOutputStream(Paths.get("programa.asm")));
				pw2.println(".MODEL LARGE");
				pw2.println(".386");
				pw2.println(".STACK 200h");
				pw2.println(".DATA");
				HashMap<String, Integer> mapVariableToIndex = new HashMap<>();
				HashMap<Integer, Integer> mapIntegerToIndex = new HashMap<>();
				HashMap<Float, Integer> mapFloatToIndex = new HashMap<>();
				HashMap<String, Integer> mapStringToIndex = new HashMap<>();
				for (SymbolTableEntry entry : par.symbolTable.values())
				{
					switch(entry.getType())
					{
					case FLOAT:
						pw2.println("\tVAR_" + entry.getName() + " dd ?");
						break;
					case INTEGER:
						pw2.println("\tVAR_" + entry.getName() + " dw ?");
						break;
					}
					mapVariableToIndex.put(entry.getName(), mapVariableToIndex.size());
				}
				for (Integer i : par.integerTable)
				{
					pw2.println("\tCTE_INT_" + mapIntegerToIndex.size() + " dw " + i);
					mapIntegerToIndex.put(i, mapIntegerToIndex.size());
				}
				for (Float f : par.floatTable)
				{
					pw2.println("\tCTE_FLOAT_" + mapFloatToIndex.size() + " dd " + f);
					mapFloatToIndex.put(f, mapFloatToIndex.size());
				}
				for (String st : par.stringTable)
				{
					pw2.println("\tCTE_STR_" + mapStringToIndex.size() + " db \"" + st + "\", '$'");
					mapStringToIndex.put(st, mapStringToIndex.size());
				}
				pw2.println("\taux_int dw ?");
				pw2.println("\taux_float dd ?");
				
				pw2.println(".CODE");
				for (rpn.Node node : program)
				{
					if (node instanceof rpn.VariableExpression)
					{
						rpn.VariableExpression vex = (rpn.VariableExpression) node;
						pw2.print("\t");
						switch (par.getVariableType(vex.getName()))
						{
						case FLOAT:
							pw2.print("fld " + "VAR_" + vex.getName());
							break;
						case INTEGER:
							pw2.print("flid " + "VAR_" + vex.getName());
							break;
						}
						pw2.print("\n");
					}
					else if (node instanceof rpn.LiteralExpression)
					{
						pw2.print("\t");
						rpn.LiteralExpression lex = (rpn.LiteralExpression) node;
						if (lex.getLiteral() instanceof Integer)
						{
							pw2.print("flid " + "CTE_INT_" + mapIntegerToIndex.get(lex.getLiteral()));
						}
						else if (lex.getLiteral() instanceof Float)
						{
							pw2.print("fld " + "CTE_FLOAT_" + mapFloatToIndex.get(lex.getLiteral()));
						}
						else if (lex.getLiteral() instanceof String)
						{
							pw2.print("mov dx, CTE_STR_" + mapStringToIndex.get(lex.getLiteral()));
						}
						pw2.print(" ; value = " + lex.toString() + "\n");
					}
					else if (node instanceof rpn.BinaryOperator)
					{
						pw2.print("\t");
						rpn.BinaryOperator binop = (rpn.BinaryOperator) node;
						switch(binop)
						{
						case CMP:
							pw2.print("fcom");
							break;
						case MINUS:
							pw2.print("fsubp");
							break;
						case DIV:
							pw2.print("fdivp");
							break;
						case MULT:
							pw2.print("fmulp");
							break;
						case PLUS:
							pw2.print("faddp");
							break;
						case ASSIGN:
							pw2.print("fstp ST(1)");
							break;
						}
						pw2.print("\n");
					}
					else if (node instanceof rpn.UnaryOperator)
					{
						rpn.UnaryOperator unop = (rpn.UnaryOperator) node;
						switch (unop)
						{
						case PRINT:
							pw2.print("\tmov ah, 09h\n");
							pw2.print("\tint 21h\n");
							break;
						case TRUNC:
							pw2.print("\tfisttp aux_int\n"); // pop truncated into aux variable
							pw2.print("\tfild aux_int\n"); // push aux content
							break;
						}
					}
					else if (node instanceof rpn.ControlOperator)
					{
						rpn.ControlOperator cop = (rpn.ControlOperator) node;
						switch(cop)
						{
						case JMP:
							pw2.print("\tjmp ");
							break;
						}
					}
					else if (node instanceof rpn.JumpLabel)
					{
						rpn.JumpLabel lr = (rpn.JumpLabel) node;
						pw2.print(lr.toString() + "\n");
					}
					else if (node instanceof rpn.LabelDeclaration)
					{
						rpn.LabelDeclaration ld = (rpn.LabelDeclaration) node;
						pw2.print("\t" + ld.toString() + "\n");
					}
					else if (node instanceof rpn.Comparator)
					{
						rpn.Comparator cmp = (rpn.Comparator) node;
						pw2.print("\t" + cmp.toString() + " ");
					}
					else if (node instanceof rpn.VariableExpression)
					{
						
					}
				}
				pw2.close();
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		catch (IOException ex) {
			System.err.println("No se pudo abrir el archivo de prueba " + PRUEBA_PATH.toString());
		}
		
	}
}
