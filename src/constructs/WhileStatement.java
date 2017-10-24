package constructs;

public class WhileStatement extends Statement {
	public void setCondition(Expression condition) {
		_condition = condition;
	}
	public Expression getCondition() {
		return _condition;
	}
	public void setBranch(Statement branch) {
		_branch = branch;
	}
	public Statement getBranch() {
		return _branch;
	}
	private Expression _condition;
	private Statement _branch;
}
