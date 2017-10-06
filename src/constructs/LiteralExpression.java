package constructs;

public class LiteralExpression extends Expression {
	public LiteralExpression() {
	}
	public LiteralExpression(Object literal) {
		setLiteral(literal);
	}
	public void setLiteral(Object literal) {
		_literal = literal;
	}
	public Object getLiteral() {
		return _literal;
	}
	private Object _literal;
}
