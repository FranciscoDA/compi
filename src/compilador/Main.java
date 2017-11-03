package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.HashSet;

import java_cup.runtime.Symbol;
import java.util.LinkedList;

import asm.TASMWriter;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	private final static Path TS_PATH = Paths.get("ts.txt");
	private final static Path INTERMEDIATE_PATH = Paths.get("intermedio.txt");
	private final static Path ASSEMBLY_PATH = Paths.get("programa.asm");

	public static void outputSymbolTable(HashMap<String, SymbolTableEntry> symbolTable,
			HashSet<Integer> integerTable,
			HashSet<Float> floatTable,
			HashSet<String> stringTable,
			OutputStream output) {
		PrintWriter pw =  new PrintWriter(output);
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
	}

	public static void main(String[] argv) {
		try {
			BufferedReader br = Files.newBufferedReader(PRUEBA_PATH);
			Scanner sc = new Scanner(br);
			parser par = new parser(sc);
			try {
				Symbol s = par.debug_parse();
				
				LinkedList<rpn.Node> program = (LinkedList<rpn.Node>) s.value;
				
				System.out.println("Compilacion OK");
				
				outputSymbolTable(par.symbolTable, par.integerTable, par.floatTable, par.stringTable, Files.newOutputStream(TS_PATH));
				rpn.Serializer.serialize(program, Files.newOutputStream(INTERMEDIATE_PATH));

				asm.Writer writer = new TASMWriter(ASSEMBLY_PATH);
				writer.loadSymbols(par.symbolTable, par.integerTable, par.floatTable, par.stringTable);
				writer.beginCode();
				for (rpn.Node node : program)
				{
					if (node instanceof rpn.VariableExpression)
					{
						rpn.VariableExpression vex = (rpn.VariableExpression) node;
						switch (par.getVariableType(vex.getName()))
						{
						case FLOAT:
							writer.loadFloatVariable(vex.getName());
							break;
						case INTEGER:
							writer.loadIntegerVariable(vex.getName());
							break;
						}
					}
					else if (node instanceof rpn.LiteralExpression)
					{
						rpn.LiteralExpression lex = (rpn.LiteralExpression) node;
						if (lex.getLiteral() instanceof Integer)
							writer.loadIntegerLiteral((Integer)lex.getLiteral());
						else if (lex.getLiteral() instanceof String)
							writer.loadStringLiteral((String)lex.getLiteral());
						else if (lex.getLiteral() instanceof Float)
							writer.loadFloatLiteral((Float)lex.getLiteral());
					}
					else if (node instanceof rpn.BinaryOperator)
					{
						rpn.BinaryOperator binop = (rpn.BinaryOperator) node;
						switch(binop)
						{
						case CMP:
							writer.doCompare();
							break;
						case MINUS:
							writer.doSub();
							break;
						case DIV:
							writer.doDiv();
							break;
						case MULT:
							writer.doMul();
							break;
						case PLUS:
							writer.doAdd();
							break;
						case ASSIGN:
							//pw2.print("fstp ST(1)");
							break;
						}
					}
					else if (node instanceof rpn.UnaryOperator)
					{
						rpn.UnaryOperator unop = (rpn.UnaryOperator) node;
						switch (unop)
						{
						case PRINT:
							writer.doPrint();
							break;
						case TRUNC:
							writer.doTrunc();
							break;
						}
					}
					else if (node instanceof rpn.ControlOperator)
					{
						rpn.ControlOperator cop = (rpn.ControlOperator) node;
						switch(cop)
						{
						case JMP:
							writer.doJmp();
							break;
						}
					}
					else if (node instanceof rpn.Comparator)
					{
						rpn.Comparator cmp = (rpn.Comparator) node;
						switch (cmp)
						{
						case EQEQ:
							writer.doJNE();
							break;
						case GT:
							writer.doJLE();
							break;
						case GTEQ:
							writer.doJL();
							break;
						case LTEQ:
							writer.doJG();
							break;
						case LT:
							writer.doJGE();
							break;
						case NEQ:
							writer.doJE();
							break;
						}
					}
					else if (node instanceof rpn.JumpLabel)
					{
						rpn.JumpLabel lr = (rpn.JumpLabel) node;
						writer.referenceLabel(lr.getLabelIndex().toString());
					}
					else if (node instanceof rpn.LabelDeclaration)
					{
						rpn.LabelDeclaration ld = (rpn.LabelDeclaration) node;
						writer.declareLabel(ld.getLabelIndex().toString());
					}
				}
				writer.endCode();
				writer.endProgram();
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
