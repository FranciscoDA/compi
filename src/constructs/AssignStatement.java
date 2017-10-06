package constructs;

public class AssignStatement extends Statement {
	public AssignStatement(String identifier, Expression expression) {
		_identifier = identifier;
		_expression = expression;
	}
	public String getIdentifier() {
		return _identifier;
	}
	public void setIdentifier(String identifier) {
		_identifier = identifier;
	}
	public Expression getExpression() {
		return _expression;
	}
	public void setExpression(Expression expression) {
		_expression = expression;
	}
	private String _identifier;
	private Expression _expression;
}
