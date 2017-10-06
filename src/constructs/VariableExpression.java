package constructs;

public class VariableExpression extends Expression {
	public VariableExpression(String identifier) {
		setIdentifier(identifier);
	}
	public void setIdentifier(String identifier) {
		_identifier = identifier;
	}
	public String getIdentifier() {
		return _identifier;
	}
	private String _identifier;
}
