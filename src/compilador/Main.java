package compilador;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;

import com.sun.org.apache.xerces.internal.util.SynchronizedSymbolTable;

import constructs.AssignStatement;
import constructs.BinaryExpression;
import constructs.BinaryOperator;
import constructs.Condition;
import constructs.Declaration;
import constructs.Expression;
import constructs.IfStatement;
import constructs.LiteralExpression;
import constructs.PlusTrunc;
import constructs.PrintStatement;
import constructs.Program;
import constructs.Statement;
import constructs.TypeName;
import constructs.VariableExpression;
import constructs.WhileStatement;
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
			for (SymbolTableEntry e : symbolTable.values()) {
				pw.printf("%s\t%s\t---\t---\n", e.getName(), e.getType().toString());
			}
			for (Integer i : integerTable) {
				pw.printf("---\tCteInt\t%d\t---\n", i);
			}
			for (Float f : floatTable) {
				pw.printf("---\tCteReal\t%f\t---\n", f);
			}
			for (String s : stringTable) {
				pw.printf("---\tCteString\t%s\t%d\n", s, s.length());
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
