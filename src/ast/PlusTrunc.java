package ast;

public class PlusTrunc extends Expression {
	public PlusTrunc(Expression trunc) {
		_trunc = trunc;
		_next = null;
	}
	public PlusTrunc(Expression trunc, PlusTrunc next) {
		_trunc = trunc;
		_next = next;
	}
	public Expression getTrunc() {
		return _trunc;
	}
	public void setTrunc(Expression trunc) {
		_trunc = trunc;
	}
	public PlusTrunc getNext() {
		return _next;		
	}
	public void setNext(PlusTrunc next) {
		_next = next;
	}
	Expression _trunc;
	PlusTrunc _next;
}
