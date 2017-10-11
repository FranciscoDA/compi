package ast;

public class Program {
	public Program(Statement statement, Declaration declaration) {
		setStatements(statement);
		setDeclarations(declaration);
	}
	public Program(Statement statement) {
		setStatements(statement);
	}
	public Statement getStatements() {
		return _statement;
	}
	public void setStatements(Statement statements) {
		_statement = statements;
	}
	public Declaration getDeclarations() {
		return _declaration;
	}
	public void setDeclarations(Declaration declarations) {
		_declaration = declarations;
	}
	private Statement _statement;
	private Declaration _declaration;
}
