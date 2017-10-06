package constructs;

public class PrintStatement extends Statement {
	public PrintStatement(String text) {
		setText(text);
	}
	public void setText(String text) {
		_text = text;
	}
	public String getText() {
		return _text;
	}
	private String _text;
}
