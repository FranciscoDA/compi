package rpn;

public enum Operation implements Node {
	/* binary operations */
	PLUS,
	MINUS,
	DIV,
	MULT,
	MOD,
	ASSIGN,
	CMP,
	POW,
	
	COS,
	SIN,
	SQRT,
	
	/* etc */
	PRINTSTR,
	PRINTINT,
	PRINTFLOAT,
	PRINTLF,
	TRUNC,
}
