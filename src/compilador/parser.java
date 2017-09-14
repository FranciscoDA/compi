
//----------------------------------------------------
// The following code was generated by CUP v0.11a beta 20060608
// Thu Sep 14 12:12:40 ART 2017
//----------------------------------------------------

package compilador;

import java_cup.runtime.*;

/** CUP v0.11a beta 20060608 generated parser.
  * @version Thu Sep 14 12:12:40 ART 2017
  */
public class parser extends java_cup.runtime.lr_parser {

  /** Default constructor. */
  public parser() {super();}

  /** Constructor which sets the default scanner. */
  public parser(java_cup.runtime.Scanner s) {super(s);}

  /** Constructor which sets the default scanner. */
  public parser(java_cup.runtime.Scanner s, java_cup.runtime.SymbolFactory sf) {super(s,sf);}

  /** Production table. */
  protected static final short _production_table[][] = 
    unpackFromStrings(new String[] {
    "\000\050\000\002\002\004\000\002\002\004\000\002\002" +
    "\003\000\002\003\003\000\002\003\003\000\002\004\003" +
    "\000\002\004\003\000\002\004\003\000\002\005\006\000" +
    "\002\006\004\000\002\006\003\000\002\007\006\000\002" +
    "\010\007\000\002\010\007\000\002\011\005\000\002\011" +
    "\005\000\002\011\003\000\002\012\005\000\002\012\005" +
    "\000\002\012\003\000\002\013\003\000\002\013\003\000" +
    "\002\013\003\000\002\013\005\000\002\014\007\000\002" +
    "\014\004\000\002\014\005\000\002\014\005\000\002\014" +
    "\003\000\002\014\003\000\002\015\012\000\002\015\006" +
    "\000\002\016\012\000\002\016\006\000\002\017\004\000" +
    "\002\020\006\000\002\020\006\000\002\021\003\000\002" +
    "\021\005\000\002\022\005" });

  /** Access to production table. */
  public short[][] production_table() {return _production_table;}

  /** Parse-action table. */
  protected static final short[][] _action_table = 
    unpackFromStrings(new String[] {
    "\000\132\000\004\004\005\001\002\000\014\002\uffff\023" +
    "\017\026\015\031\011\054\013\001\002\000\004\010\112" +
    "\001\002\000\004\002\110\001\002\000\002\001\002\000" +
    "\014\002\001\023\017\026\015\031\011\054\013\001\002" +
    "\000\006\053\105\054\104\001\002\000\016\002\uffe4\023" +
    "\uffe4\026\uffe4\030\uffe4\031\uffe4\054\uffe4\001\002\000\006" +
    "\020\046\022\100\001\002\000\016\002\uffdf\023\uffdf\026" +
    "\uffdf\030\uffdf\031\uffdf\054\uffdf\001\002\000\014\020\032" +
    "\051\033\052\024\053\023\054\030\001\002\000\016\002" +
    "\uffe5\023\uffe5\026\uffe5\030\uffe5\031\uffe5\054\uffe5\001\002" +
    "\000\014\020\032\051\033\052\024\053\023\054\030\001" +
    "\002\000\004\032\021\001\002\000\016\002\uffe8\023\uffe8" +
    "\026\uffe8\030\uffe8\031\uffe8\054\uffe8\001\002\000\026\011" +
    "\ufff1\013\041\014\ufff1\021\ufff1\025\ufff1\027\ufff1\032\ufff1" +
    "\033\ufff1\034\ufff1\037\042\001\002\000\026\011\ufffa\013" +
    "\ufffa\014\ufffa\021\ufffa\025\ufffa\027\ufffa\032\ufffa\033\ufffa" +
    "\034\ufffa\037\ufffa\001\002\000\026\011\ufffb\013\ufffb\014" +
    "\ufffb\021\ufffb\025\ufffb\027\ufffb\032\ufffb\033\ufffb\034\ufffb" +
    "\037\ufffb\001\002\000\026\011\uffeb\013\uffeb\014\uffeb\021" +
    "\uffeb\025\uffeb\027\uffeb\032\uffeb\033\uffeb\034\uffeb\037\uffeb" +
    "\001\002\000\010\025\061\033\036\034\037\001\002\000" +
    "\026\011\uffee\013\uffee\014\uffee\021\uffee\025\uffee\027\uffee" +
    "\032\uffee\033\uffee\034\uffee\037\uffee\001\002\000\030\011" +
    "\uffed\013\uffed\014\uffed\020\046\021\uffed\025\uffed\027\uffed" +
    "\032\uffed\033\uffed\034\uffed\037\uffed\001\002\000\026\011" +
    "\uffec\013\uffec\014\uffec\021\uffec\025\uffec\027\uffec\032\uffec" +
    "\033\uffec\034\uffec\037\uffec\001\002\000\014\020\032\051" +
    "\033\052\024\053\023\054\030\001\002\000\026\011\ufffc" +
    "\013\ufffc\014\ufffc\021\ufffc\025\ufffc\027\ufffc\032\ufffc\033" +
    "\ufffc\034\ufffc\037\ufffc\001\002\000\010\021\035\033\036" +
    "\034\037\001\002\000\026\011\uffea\013\uffea\014\uffea\021" +
    "\uffea\025\uffea\027\uffea\032\uffea\033\uffea\034\uffea\037\uffea" +
    "\001\002\000\014\020\032\051\033\052\024\053\023\054" +
    "\030\001\002\000\014\020\032\051\033\052\024\053\023" +
    "\054\030\001\002\000\026\011\ufff2\013\041\014\ufff2\021" +
    "\ufff2\025\ufff2\027\ufff2\032\ufff2\033\ufff2\034\ufff2\037\042" +
    "\001\002\000\014\020\032\051\033\052\024\053\023\054" +
    "\030\001\002\000\014\020\032\051\033\052\024\053\023" +
    "\054\030\001\002\000\026\011\uffef\013\uffef\014\uffef\021" +
    "\uffef\025\uffef\027\uffef\032\uffef\033\uffef\034\uffef\037\uffef" +
    "\001\002\000\026\011\ufff0\013\ufff0\014\ufff0\021\ufff0\025" +
    "\ufff0\027\ufff0\032\ufff0\033\ufff0\034\ufff0\037\ufff0\001\002" +
    "\000\026\011\ufff3\013\041\014\ufff3\021\ufff3\025\ufff3\027" +
    "\ufff3\032\ufff3\033\ufff3\034\ufff3\037\042\001\002\000\016" +
    "\010\052\020\032\051\033\052\024\053\023\054\030\001" +
    "\002\000\006\014\055\021\060\001\002\000\014\011\uffdc" +
    "\014\uffdc\021\uffdc\033\036\034\037\001\002\000\004\021" +
    "\057\001\002\000\014\020\032\051\033\052\024\053\023" +
    "\054\030\001\002\000\006\011\054\014\055\001\002\000" +
    "\004\021\uffda\001\002\000\014\020\032\051\033\052\024" +
    "\053\023\054\030\001\002\000\014\011\uffdb\014\uffdb\021" +
    "\uffdb\033\036\034\037\001\002\000\026\011\uffdd\013\uffdd" +
    "\014\uffdd\021\uffdd\025\uffdd\027\uffdd\032\uffdd\033\uffdd\034" +
    "\uffdd\037\uffdd\001\002\000\026\011\uffde\013\uffde\014\uffde" +
    "\021\uffde\025\uffde\027\uffde\032\uffde\033\uffde\034\uffde\037" +
    "\uffde\001\002\000\014\023\017\026\015\031\011\032\062" +
    "\054\013\001\002\000\002\001\002\000\016\002\uffe2\023" +
    "\uffe2\026\uffe2\030\uffe2\031\uffe2\054\uffe2\001\002\000\014" +
    "\023\017\026\015\030\065\031\011\054\013\001\002\000" +
    "\004\023\066\001\002\000\004\032\067\001\002\000\016" +
    "\002\uffe3\023\uffe3\026\uffe3\030\uffe3\031\uffe3\054\uffe3\001" +
    "\002\000\010\027\071\033\036\034\037\001\002\000\014" +
    "\023\017\026\015\031\011\032\072\054\013\001\002\000" +
    "\002\001\002\000\016\002\uffe0\023\uffe0\026\uffe0\030\uffe0" +
    "\031\uffe0\054\uffe0\001\002\000\014\023\017\026\015\030" +
    "\075\031\011\054\013\001\002\000\004\026\076\001\002" +
    "\000\004\032\077\001\002\000\016\002\uffe1\023\uffe1\026" +
    "\uffe1\030\uffe1\031\uffe1\054\uffe1\001\002\000\004\017\101" +
    "\001\002\000\014\020\032\051\033\052\024\053\023\054" +
    "\030\001\002\000\010\032\103\033\036\034\037\001\002" +
    "\000\016\002\uffe9\023\uffe9\026\uffe9\030\uffe9\031\uffe9\054" +
    "\uffe9\001\002\000\004\032\107\001\002\000\004\032\106" +
    "\001\002\000\016\002\uffe7\023\uffe7\026\uffe7\030\uffe7\031" +
    "\uffe7\054\uffe7\001\002\000\016\002\uffe6\023\uffe6\026\uffe6" +
    "\030\uffe6\031\uffe6\054\uffe6\001\002\000\004\002\000\001" +
    "\002\000\006\005\ufff7\010\ufff7\001\002\000\004\054\117" +
    "\001\002\000\006\005\115\010\112\001\002\000\006\005" +
    "\ufff8\010\ufff8\001\002\000\004\032\116\001\002\000\002" +
    "\001\002\000\006\011\123\014\124\001\002\000\004\011" +
    "\121\001\002\000\004\032\122\001\002\000\006\005\ufff6" +
    "\010\ufff6\001\002\000\004\017\132\001\002\000\004\054" +
    "\117\001\002\000\004\014\126\001\002\000\006\006\127" +
    "\007\131\001\002\000\006\011\ufffe\014\ufffe\001\002\000" +
    "\006\011\ufff4\014\ufff4\001\002\000\006\011\ufffd\014\ufffd" +
    "\001\002\000\004\010\133\001\002\000\006\006\127\007" +
    "\131\001\002\000\006\011\ufff5\014\ufff5\001\002" });

  /** Access to parse-action table. */
  public short[][] action_table() {return _action_table;}

  /** <code>reduce_goto</code> table. */
  protected static final short[][] _reduce_table = 
    unpackFromStrings(new String[] {
    "\000\132\000\010\002\005\005\006\017\003\001\001\000" +
    "\012\014\013\015\015\016\011\020\017\001\001\000\006" +
    "\006\112\007\110\001\001\000\002\001\001\000\004\017" +
    "\007\001\001\000\012\014\013\015\015\016\011\020\017" +
    "\001\001\000\002\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001\000\014\004\030\011\067\012\021" +
    "\013\026\020\024\001\001\000\002\001\001\000\014\004" +
    "\030\011\025\012\021\013\026\020\024\001\001\000\002" +
    "\001\001\000\002\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001\000\002\001\001\000\002\001\001" +
    "\000\002\001\001\000\002\001\001\000\002\001\001\000" +
    "\014\004\030\011\033\012\021\013\026\020\024\001\001" +
    "\000\002\001\001\000\002\001\001\000\002\001\001\000" +
    "\012\004\030\012\044\013\026\020\024\001\001\000\012" +
    "\004\030\012\037\013\026\020\024\001\001\000\002\001" +
    "\001\000\010\004\030\013\043\020\024\001\001\000\010" +
    "\004\030\013\042\020\024\001\001\000\002\001\001\000" +
    "\002\001\001\000\002\001\001\000\020\004\030\011\047" +
    "\012\021\013\026\020\024\021\046\022\050\001\001\000" +
    "\002\001\001\000\002\001\001\000\002\001\001\000\016" +
    "\004\030\011\047\012\021\013\026\020\024\021\052\001" +
    "\001\000\002\001\001\000\002\001\001\000\014\004\030" +
    "\011\055\012\021\013\026\020\024\001\001\000\002\001" +
    "\001\000\002\001\001\000\002\001\001\000\012\014\062" +
    "\015\015\016\011\020\017\001\001\000\004\017\063\001" +
    "\001\000\002\001\001\000\012\014\013\015\015\016\011" +
    "\020\017\001\001\000\002\001\001\000\002\001\001\000" +
    "\002\001\001\000\002\001\001\000\012\014\072\015\015" +
    "\016\011\020\017\001\001\000\004\017\073\001\001\000" +
    "\002\001\001\000\012\014\013\015\015\016\011\020\017" +
    "\001\001\000\002\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001\000\014\004\030\011\101\012\021" +
    "\013\026\020\024\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001\000\002\001\001\000\002\001\001" +
    "\000\002\001\001\000\002\001\001\000\002\001\001\000" +
    "\004\010\117\001\001\000\004\007\113\001\001\000\002" +
    "\001\001\000\002\001\001\000\002\001\001\000\002\001" +
    "\001\000\002\001\001\000\002\001\001\000\002\001\001" +
    "\000\002\001\001\000\004\010\124\001\001\000\002\001" +
    "\001\000\004\003\127\001\001\000\002\001\001\000\002" +
    "\001\001\000\002\001\001\000\002\001\001\000\004\003" +
    "\133\001\001\000\002\001\001" });

  /** Access to <code>reduce_goto</code> table. */
  public short[][] reduce_table() {return _reduce_table;}

  /** Instance of action encapsulation class. */
  protected CUP$parser$actions action_obj;

  /** Action encapsulation object initializer. */
  protected void init_actions()
    {
      action_obj = new CUP$parser$actions(this);
    }

  /** Invoke a user supplied parse action. */
  public java_cup.runtime.Symbol do_action(
    int                        act_num,
    java_cup.runtime.lr_parser parser,
    java.util.Stack            stack,
    int                        top)
    throws java.lang.Exception
  {
    /* call code in generated class */
    return action_obj.CUP$parser$do_action(act_num, parser, stack, top);
  }

  /** Indicates start state. */
  public int start_state() {return 0;}
  /** Indicates start production. */
  public int start_production() {return 1;}

  /** <code>EOF</code> Symbol index. */
  public int EOF_sym() {return 0;}

  /** <code>error</code> Symbol index. */
  public int error_sym() {return 1;}


 
  public void report_error(String message, Object info) {
    StringBuilder m = new StringBuilder("Error ");

    if (info instanceof java_cup.runtime.Symbol) 
      m.append( "("+info.toString()+")" );
     
    m.append(" : "+message);
   
    System.out.println(m);
  }
   
  public void report_fatal_error(String message, Object info) {
    report_error(message, info);
    throw new RuntimeException("Fatal Syntax Error");
  }

}

/** Cup generated class to encapsulate user supplied action code.*/
class CUP$parser$actions {
  private final parser parser;

  /** Constructor */
  CUP$parser$actions(parser parser) {
    this.parser = parser;
  }

  /** Method with the actual generated action code. */
  public final java_cup.runtime.Symbol CUP$parser$do_action(
    int                        CUP$parser$act_num,
    java_cup.runtime.lr_parser CUP$parser$parser,
    java.util.Stack            CUP$parser$stack,
    int                        CUP$parser$top)
    throws java.lang.Exception
    {
      /* Symbol object for return from actions */
      java_cup.runtime.Symbol CUP$parser$result;

      /* select the action based on the action number */
      switch (CUP$parser$act_num)
        {
          /*. . . . . . . . . . . . . . . . . . . .*/
          case 39: // bracketed_argument_list ::= LBRACK argument_list RBRACK 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("bracketed_argument_list",16, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 38: // argument_list ::= argument_list COMMA expression 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("argument_list",15, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 37: // argument_list ::= expression 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("argument_list",15, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 36: // function_call ::= IDENTIFIER LPAREN bracketed_argument_list RPAREN 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("function_call",14, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-3)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 35: // function_call ::= IDENTIFIER LPAREN argument_list RPAREN 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("function_call",14, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-3)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 34: // statement_list ::= statement_list statement 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement_list",13, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 33: // while_statement ::= WHILE expression DO statement 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("while_statement",12, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-3)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 32: // while_statement ::= WHILE expression DO LINE_TERMINATOR statement_list END WHILE LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("while_statement",12, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-7)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 31: // if_statement ::= IF expression THEN statement 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("if_statement",11, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-3)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 30: // if_statement ::= IF expression THEN LINE_TERMINATOR statement_list END IF LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("if_statement",11, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-7)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 29: // statement ::= while_statement 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement",10, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 28: // statement ::= if_statement 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement",10, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 27: // statement ::= PRINT IDENTIFIER LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement",10, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 26: // statement ::= PRINT STRING_LITERAL LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement",10, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 25: // statement ::= function_call LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement",10, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 24: // statement ::= IDENTIFIER COLON EQ expression LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("statement",10, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-4)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 23: // factor ::= LPAREN expression RPAREN 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("factor",9, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 22: // factor ::= function_call 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("factor",9, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 21: // factor ::= literal 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("factor",9, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 20: // factor ::= IDENTIFIER 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("factor",9, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 19: // term ::= factor 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("term",8, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 18: // term ::= term DIV factor 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("term",8, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 17: // term ::= term MULT factor 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("term",8, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 16: // expression ::= term 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("expression",7, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 15: // expression ::= expression MINUS term 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("expression",7, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 14: // expression ::= expression PLUS term 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("expression",7, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-2)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 13: // type_declaration_inner ::= IDENTIFIER COMMA type_declaration_inner COMMA type_name 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("type_declaration_inner",6, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-4)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 12: // type_declaration_inner ::= IDENTIFIER RBRACK EQ LBRACK type_name 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("type_declaration_inner",6, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-4)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 11: // type_declaration_outer ::= LBRACK type_declaration_inner RBRACK LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("type_declaration_outer",5, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-3)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 10: // declaration_list ::= type_declaration_outer 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("declaration_list",4, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 9: // declaration_list ::= declaration_list type_declaration_outer 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("declaration_list",4, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 8: // declaration_block ::= DECVAR declaration_list ENDVAR LINE_TERMINATOR 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("declaration_block",3, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-3)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 7: // literal ::= STRING_LITERAL 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("literal",2, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 6: // literal ::= FLOATING_POINT_LITERAL 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("literal",2, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 5: // literal ::= INTEGER_LITERAL 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("literal",2, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 4: // type_name ::= FLOAT 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("type_name",1, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 3: // type_name ::= INTEGER 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("type_name",1, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 2: // goal ::= statement_list 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("goal",0, ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 1: // $START ::= goal EOF 
            {
              Object RESULT =null;
		int start_valleft = ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)).left;
		int start_valright = ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)).right;
		Object start_val = (Object)((java_cup.runtime.Symbol) CUP$parser$stack.elementAt(CUP$parser$top-1)).value;
		RESULT = start_val;
              CUP$parser$result = parser.getSymbolFactory().newSymbol("$START",0, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          /* ACCEPT */
          CUP$parser$parser.done_parsing();
          return CUP$parser$result;

          /*. . . . . . . . . . . . . . . . . . . .*/
          case 0: // goal ::= declaration_block statement_list 
            {
              Object RESULT =null;

              CUP$parser$result = parser.getSymbolFactory().newSymbol("goal",0, ((java_cup.runtime.Symbol)CUP$parser$stack.elementAt(CUP$parser$top-1)), ((java_cup.runtime.Symbol)CUP$parser$stack.peek()), RESULT);
            }
          return CUP$parser$result;

          /* . . . . . .*/
          default:
            throw new Exception(
               "Invalid action number found in internal parse table");

        }
    }
}

