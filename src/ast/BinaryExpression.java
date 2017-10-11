package ast;

public class BinaryExpression extends Expression {
	public BinaryExpression(Expression left, BinaryOperator op, Expression right) {
		setLeft(left);
		setOperation(op);
		setRight(right);
	}
	public void setOperation(BinaryOperator op)	{
		_op = op;
	}
	public BinaryOperator getOperation() {
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
	private BinaryOperator _op;
	private Expression _left;
	private Expression _right;
}
