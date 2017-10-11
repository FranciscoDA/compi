package ast;

public class Statement {
	public Statement() {
		_next = null;
	}
	public Statement(Statement next) {
		setNext(next);
	}
	public void setNext(Statement next) {
		_next = next;
	}
	public boolean hasNext() {
		return _next != null;
	}
	public Statement getNext() {
		return _next;
	}
	public void concatenate(Statement other) {
		if (_next != null) {
			_next.concatenate(other);
		}
		else {
			_next = other;
		}
	}
	private Statement _next;
}
