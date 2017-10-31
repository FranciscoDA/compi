package rpn;

public class LabelDeclaration implements Node {
	int LabelIndex;
	
	public LabelDeclaration(int i) {
		this.LabelIndex=i;
	}

	public int getLabelIndex() {
		return LabelIndex;
	}

	public void setLabelIndex(int labelIndex) {
		LabelIndex = labelIndex;
	}
	
	@Override
	public String toString()
	{
		return "LABEL_" + LabelIndex + ":";
	}
}
