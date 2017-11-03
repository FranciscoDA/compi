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

import asm.NASMWriter;
import asm.TASMWriter;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	private final static Path TS_PATH = Paths.get("ts.txt");
	private final static Path INTERMEDIATE_PATH = Paths.get("intermedio.txt");
	private final static Path TASM_OUT_PATH = Paths.get("programa-tasm.asm");
	private final static Path NASM_OUT_PATH = Paths.get("programa-nasm.asm");

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

				asm.Writer writer = new NASMWriter(NASM_OUT_PATH);

				writer.loadSymbols(par.symbolTable, par.integerTable, par.floatTable, par.stringTable);

				writer.beginProgram();
				writer.beginCode();
				for (rpn.Node node : program)
				{
					if (node instanceof rpn.VariableExpression)
					{
						rpn.VariableExpression vex = (rpn.VariableExpression) node;
						writer.loadVariable(par.symbolTable.get(vex.getName()));
					}
					else if (node instanceof rpn.LiteralExpression)
					{
						rpn.LiteralExpression lex = (rpn.LiteralExpression) node;
						writer.loadLiteral(lex.getLiteral());
					}
					else if (node instanceof rpn.BinaryOperator)
					{
						rpn.BinaryOperator binop = (rpn.BinaryOperator) node;
						if (binop == rpn.BinaryOperator.CMP) writer.doCompare();
						else if (binop == rpn.BinaryOperator.PLUS) writer.doAdd();
						else if (binop == rpn.BinaryOperator.MINUS) writer.doSub();
						else if (binop == rpn.BinaryOperator.MULT) writer.doMul();
						else if (binop == rpn.BinaryOperator.DIV) writer.doDiv();
						else if (binop == rpn.BinaryOperator.ASSIGN) writer.doAssign();
					}
					else if (node instanceof rpn.UnaryOperator)
					{
						rpn.UnaryOperator unop = (rpn.UnaryOperator) node;
						if (unop == rpn.UnaryOperator.PRINT) writer.doPrint();
						else if (unop == rpn.UnaryOperator.TRUNC) writer.doTrunc();
					}
					else if (node instanceof rpn.ControlOperator)
					{
						rpn.ControlOperator cop = (rpn.ControlOperator) node;
						if (cop == rpn.ControlOperator.JMP)
							writer.doJmp();
					}
					else if (node instanceof rpn.Comparator)
					{
						rpn.Comparator cmp = (rpn.Comparator) node;
						if (cmp == rpn.Comparator.NEQ) writer.doJNE();
						else if (cmp == rpn.Comparator.LTEQ) writer.doJLE();
						else if (cmp == rpn.Comparator.LT) writer.doJE();
						else if (cmp == rpn.Comparator.GTEQ) writer.doJGE();
						else if (cmp == rpn.Comparator.GT) writer.doJG();
						else if (cmp == rpn.Comparator.EQEQ) writer.doJE();
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
