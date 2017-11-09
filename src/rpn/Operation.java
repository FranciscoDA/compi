package rpn;

public enum Operation implements Node {
	/* binary operations */
	PLUS,
	MINUS,
	DIV,
	MULT,
	ASSIGN,
	CMP,
	
	/* etc */
	PRINTSTR,
	PRINTINT,
	PRINTFLOAT,
	PRINTLF,
	TRUNC,
}
