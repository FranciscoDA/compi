package rpn;

public class LabelReference implements Node {
	int LabelIndex;
	
	public LabelReference(int i) {
		this.LabelIndex=i;
	}

	public Integer getLabelIndex() {
		return LabelIndex;
	}

	public void setLabelIndex(int labelIndex) {
		LabelIndex = labelIndex;
	}
	
	@Override
	public String toString()
	{
		return "(LABEL_" + LabelIndex + ")";
	}
}
