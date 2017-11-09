package rpn;

public enum Control implements Node {
	/* comparators */
	LTEQ,
	LT,
	GTEQ,
	GT,
	NEQ,
	EQEQ,
	
	/* control operations */
	JMP,
}
