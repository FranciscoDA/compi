package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.HashSet;

import ast.AssignStatement;
import ast.BinaryExpression;
import ast.Condition;
import ast.Declaration;
import ast.Expression;
import ast.IfStatement;
import ast.LiteralExpression;
import ast.PlusTrunc;
import ast.PrintStatement;
import ast.Program;
import ast.Statement;
import ast.VariableExpression;
import ast.WhileStatement;
import java_cup.runtime.Symbol;

public class Main {
	private final static Path PRUEBA_PATH = Paths.get("prueba.txt");
	private final static Path TS_PATH = Paths.get("ts.txt");

	private static HashMap<String, SymbolTableEntry> symbolTable = new HashMap<>();
	private static HashSet<Integer> integerTable = new HashSet<>();
	private static HashSet<Float> floatTable = new HashSet<>();
	private static HashSet<String> stringTable = new HashSet<>();
	
	public static void processCondition(Condition condition) throws Exception {
		processExpression(condition.getLeft());
		processExpression(condition.getRight());
	}
	public static void processExpression(Expression expression) throws Exception {
		if (expression instanceof BinaryExpression) {
			BinaryExpression binexp = (BinaryExpression)expression;
			processExpression(binexp.getLeft());
			processExpression(binexp.getRight());
		}
		else if (expression instanceof VariableExpression) {
			VariableExpression vexp = (VariableExpression)expression;
			if (!symbolTable.containsKey(vexp.getIdentifier())) {
				throw new Exception("Undeclared identifier: " + vexp.getIdentifier());
			}
		}
		else if (expression instanceof PlusTrunc) {
			PlusTrunc ptrunc = (PlusTrunc)expression;
			processExpression(ptrunc.getTrunc());
			if (ptrunc.getNext() != null) {
				processExpression(ptrunc.getNext());
			}
		}
		else if (expression instanceof LiteralExpression) {
			LiteralExpression lexp = (LiteralExpression)expression;
			Object literal = lexp.getLiteral();
			if (literal instanceof Integer) {
				integerTable.add((Integer)literal);
			}
			else if (literal instanceof Float) {
				floatTable.add((Float) literal);
			}
		}
	}
	public static void processStatement(Statement statement) throws Exception {
		if (statement == null) {
			return;
		}
		if(statement instanceof AssignStatement) {
			AssignStatement astatement = (AssignStatement)statement;
			if (!symbolTable.containsKey(astatement.getIdentifier())) {
				throw new Exception("Undeclared identifier: " + astatement.getIdentifier());
			}
			processExpression(astatement.getExpression());
		}
		else if (statement instanceof PrintStatement) {
			PrintStatement pstatement = (PrintStatement)statement;
			stringTable.add(pstatement.getText());
		}
		else if (statement instanceof IfStatement) {
			IfStatement istatement = (IfStatement)statement;
			processCondition(istatement.getCondition());
			processStatement(istatement.getBranch());
			if (istatement.getElse() != null) {
				processStatement(istatement.getElse());
			}
		}
		else if (statement instanceof WhileStatement) {
			WhileStatement wstatement = (WhileStatement)statement;
			processCondition(wstatement.getCondition());
			processStatement(wstatement.getBranch());
		}
		processStatement(statement.getNext());
	}
	public static void processDeclaration(Declaration declaration) throws Exception {
		if (declaration == null) {
			return;
		}
		if (symbolTable.containsKey(declaration.getIdentifier())) {
			throw new Exception("Multiple declaration of " + declaration.getIdentifier());
		}
		else {
			SymbolTableEntry newEntry = new SymbolTableEntry(declaration.getIdentifier(), declaration.getType());
			symbolTable.put(declaration.getIdentifier(), newEntry);						
		}
		processDeclaration(declaration.getNext());
	}
	public static void outputSymbolTable() {
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
				Program program = (Program)s.value;
				processDeclaration(program.getDeclarations());
				
				Statement statement = program.getStatements();
				processStatement(statement);
				
				outputSymbolTable();
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
