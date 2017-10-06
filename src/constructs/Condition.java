package constructs;

public class Condition {
	public Condition(Expression left, BinaryComparator comp, Expression right) {
		setLeft(left);
		setComparator(comp);
		setRight(right);
	}
	public void setComparator(BinaryComparator op) {
		_op = op;
	}
	public BinaryComparator getComparator() {
		return _op;
	}
	public void setLeft(Expression left) {
		_left = left;
	}
	public Expression getLeft() {
		return _left;
	}
	public void setRight(Expression right) {
		_right = right;
	}
	public Expression getRight() {
		return _right;
	}
	private BinaryComparator _op;
	private Expression _left;
	private Expression _right;
}
