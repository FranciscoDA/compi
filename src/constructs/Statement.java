package constructs;

public class Statement {
	public Statement() {
		_next = null;
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
	private Statement _next;
}
