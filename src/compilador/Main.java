package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

import java_cup.runtime.Symbol;
import java.util.LinkedList;

import asm.*;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	private final static Path TS_PATH = Paths.get("gen/ts.txt");
	private final static Path INTERMEDIATE_PATH = Paths.get("gen/intermedio.txt");
	private final static Path TASM_OUT_PATH = Paths.get("gen/tasm-programa.asm");
	private final static Path TASM_OBJ_PATH = Paths.get("gen/tasm-programa.obj");
	private final static Path TASM_EXE_PATH = Paths.get("gen/tasm-exe.exe");
	
	private final static Path NASM_OUT_PATH = Paths.get("gen/nasm-programa.asm");
	private final static Path NASM_OBJ_PATH = Paths.get("gen/nasm-programa.o");
	private final static Path NASM_EXE_PATH = Paths.get("gen/nasm-exe");
	private final static Path BASH_OUT_PATH = Paths.get("nasm-compile.sh");
	private final static Path BATCH_OUT_PATH = Paths.get("tasm-compile.bat");

	public static void outputSymbolTable(HashMap<String, SymbolTableEntry> symbolTable,
			HashSet<Integer> integerTable,
			HashSet<Float> floatTable,
			HashSet<String> stringTable,
			OutputStream output) {
		PrintWriter pw = new PrintWriter(output);
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
	public static void outputBashFile() {
		PrintWriter pw;
		try {
			pw = new PrintWriter(Files.newOutputStream(BASH_OUT_PATH));
			pw.println("nasm -felf32 -o " + NASM_OBJ_PATH + " " + NASM_OUT_PATH);
			pw.println("ld -melf_i386 -o " + NASM_EXE_PATH + " " + NASM_OBJ_PATH);
			pw.println("chmod ug+rwx " + NASM_EXE_PATH);
			pw.close();
			HashSet<PosixFilePermission> permissions = new HashSet<>();
			permissions.add(PosixFilePermission.GROUP_EXECUTE);
			permissions.add(PosixFilePermission.GROUP_READ);
			permissions.add(PosixFilePermission.GROUP_WRITE);
			permissions.add(PosixFilePermission.OWNER_EXECUTE);
			permissions.add(PosixFilePermission.OWNER_READ);
			permissions.add(PosixFilePermission.OWNER_WRITE);
			Files.setAttribute(BASH_OUT_PATH, "posix:permissions", permissions);
			System.out.println("Bash file: " + BASH_OUT_PATH);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static void outputBatchFile() {
		PrintWriter pw;
		try {
			pw = new PrintWriter(Files.newOutputStream(BATCH_OUT_PATH));
			pw.println("tasm\\tasm.exe " + TASM_OUT_PATH + " " + TASM_OBJ_PATH);
			pw.println("tasm\\tlink.exe " + TASM_OBJ_PATH + " , " + TASM_EXE_PATH);
			pw.close();
			System.out.println("Batch file: " + BATCH_OUT_PATH);
		}
		catch (IOException e) {
			
		}
	}
	
	public static void writeAssemblyCode(parser par, LinkedList<rpn.Node> program, asm.Writer writer) throws Exception {
		writer.loadSymbols(par.symbolTable, par.integerTable, par.floatTable, par.stringTable);
		writer.beginProgram();
		writer.beginCode();
		for (Iterator<rpn.Node> it = program.iterator(); it.hasNext(); )
		{
			rpn.Node node = it.next();
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
			else if (node instanceof rpn.Operation)
			{
				rpn.Operation op = (rpn.Operation) node;
				switch (op)	{
				case PLUS:
					writer.doAdd();
					break;
				case MINUS:
					writer.doSub();
					break;
				case MULT:
					writer.doMul();
					break;
				case DIV:
					writer.doDiv();
					break;
				case ASSIGN: {
					rpn.VariableExpression vex = (rpn.VariableExpression) it.next();
					writer.doAssign(vex.getName());
					break;
				}
				case CMP:
					writer.doCompare();
					break;
				case PRINTSTR:
					writer.doPrintString();
					break;
				case PRINTINT:
					writer.doPrintInteger();
					break;
				case PRINTFLOAT:
					writer.doPrintFloat();
					break;
				case PRINTLF:
					writer.doPrintLF();
					break;
				case TRUNC:
					writer.doTrunc();
					break;
				case SIN:
					writer.doSine();
					break;
				case COS:
					writer.doCosine();
					break;
				case SQRT:
					writer.doSqrt();
					break;
				case MOD:
					writer.doModulo();
					break;
				case POW:
					writer.doPower();
					break;
				}
			}
			else if (node instanceof rpn.Control) {
				rpn.Control co = (rpn.Control) node;
				rpn.LabelReference lr = (rpn.LabelReference)it.next();
				String i = lr.getLabelIndex().toString();
				switch (co) {
				case JMP:
					writer.doJMP(i);
					break;
				case LTEQ:
					writer.doJLE(i);
					break;
				case LT:
					writer.doJL(i);
					break;
				case GTEQ:
					writer.doJGE(i);
					break;
				case GT:
					writer.doJG(i);
					break;
				case EQEQ:
					writer.doJE(i);
					break;
				case NEQ:
					writer.doJNE(i);
					break;
				}
			}
			else if (node instanceof rpn.LabelReference) {
				rpn.LabelReference lr = (rpn.LabelReference) node;
				throw new Exception("loose label (" + lr.getLabelIndex() + ") reference");
			}
			else if (node instanceof rpn.LabelDeclaration) {
				rpn.LabelDeclaration ld = (rpn.LabelDeclaration) node;
				writer.declareLabel(ld.getLabelIndex().toString());
			}
		}
		writer.endCode();
		writer.endProgram();
		System.out.println(writer.getPlatformName() + ": " + writer.getOutputPath());
	}

	public static void main(String[] argv) {
		try {
			BufferedReader br = Files.newBufferedReader(PRUEBA_PATH);
			Scanner sc = new Scanner(br);
			parser par = new parser(sc);
			try {
				Symbol s = par.parse();
				
				@SuppressWarnings("unchecked")
				LinkedList<rpn.Node> program = (LinkedList<rpn.Node>) s.value;
				outputSymbolTable(par.symbolTable, par.integerTable, par.floatTable, par.stringTable, Files.newOutputStream(TS_PATH));
				rpn.Serializer.serialize(program, Files.newOutputStream(INTERMEDIATE_PATH));

				System.out.println("Parsing OK");
				writeAssemblyCode(par, program, new TasmDos16Writer(TASM_OUT_PATH));
				writeAssemblyCode(par, program, new NasmLinux32Writer(NASM_OUT_PATH));
				outputBashFile();
				outputBatchFile();
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
