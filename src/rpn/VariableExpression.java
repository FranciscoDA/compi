package rpn;

public class VariableExpression implements Node {
	String name;
	
	public VariableExpression(String name) {
		this.name=name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString()
	{
		return name;
	}
}
