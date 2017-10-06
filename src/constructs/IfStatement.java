package constructs;

public class IfStatement extends Statement {
	public IfStatement(Condition condition, Statement branch, Statement els) {
		setCondition(condition);
		setBranch(branch);
		setElse(els);
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
	public void setElse(Statement newElse) {
		_else = newElse;
	}
	public Statement getElse() {
		return _else;
	}
	private Condition _condition;
	private Statement _branch;
	private Statement _else;
}
