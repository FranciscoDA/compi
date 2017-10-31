package ast;

import compilador.SymbolTableEntry;

public class TreeInterpreter {
	/*public static void processCondition(Condition condition) throws Exception {
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
	}*/
}
