package rpn;

public class LiteralExpression implements Node{
	Object Literal;
	
	public LiteralExpression(Object l) {
		this.Literal=l;
	}

	public Object getLiteral() {
		return Literal;
	}

	public void setLiteral(Object literal) {
		Literal = literal;
	}
	
	
}
