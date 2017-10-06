package constructs;

public class WhileStatement extends Statement {
	public WhileStatement(Condition condition, Statement branch) {
		setCondition(condition);
		setBranch(branch);
	}
	public void setCondition(Condition condition) {
		_condition = condition;
	}
	public Condition getCondition() {
		return _condition;
	}
	public void setBranch(Statement branch) {
		_branch = branch;
	}
	public Statement getBranch() {
		return _branch;
	}
	private Condition _condition;
	private Statement _branch;
}
