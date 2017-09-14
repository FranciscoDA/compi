/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 1998-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* Java 1.2 language lexer specification */

/* Use together with unicode.flex for Unicode preprocesssing */
/* and java12.cup for a Java 1.2 parser                      */

/* Note that this lexer specification is not tuned for speed.
   It is in fact quite slow on integer and floating point literals, 
   because the input is read twice and the methods used to parse
   the numbers are not very fast. 
   For a production quality application (e.g. a Java compiler) 
   this could be optimized */

package compilador;
import java_cup.runtime.*;

%%

%public
%class Scanner
%implements sym

%unicode

%line
%column

%cup
%cupdebug

%{
  final int MAX_STRING = 30;
  final int MAX_INT = Short.MAX_VALUE;
  final float MAX_FLOAT = Float.MAX_VALUE;

  StringBuilder string = new StringBuilder();
  
  private Symbol symbol(int type) {
    return new JavaSymbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(int type, Object value) {
    return new JavaSymbol(type, yyline+1, yycolumn+1, value);
  }

  /** 
   * assumes correct representation of a long value for 
   * specified radix in scanner buffer from <code>start</code> 
   * to <code>end</code> 
   */
  private long parseLong(int start, int end, int radix) {
    long result = 0;
    long digit;

    for (int i = start; i < end; i++) {
      digit  = Character.digit(yycharat(i),radix);
      result*= radix;
      result+= digit;
    }

    return result;
  }

  private boolean verify_real(String x) {
      float f = Float.parseFloat(x);
      if (f < -MAX_FLOAT || f > MAX_FLOAT) {
          throw new NumberFormatException();
      }
      return true;
  }
  private boolean verify_int(String x) {
      int i = Integer.parseInt(x);
      if (i < -MAX_INT || i > MAX_INT) {
          throw new NumberFormatException();
      }
      return true;
  }
  private boolean verify_string(String x) {
      if (x.length() > MAX_STRING) {
          throw new NumberFormatException();
      }
      return true;
  }

%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = {LineTerminator} | [ \t\f]

/* comments */
Comment = "</" ~"/>"

/* identifiers */
Identifier = [a-zA-Z_][a-zA-Z_0-9]*

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*
    
/* floating point literals */        
DoubleLiteral = ({FLit1}|{FLit2}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]* 
FLit2    = \. [0-9]+  
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%

<YYINITIAL> {

  /* comments */
  {Comment}                      {/**/}

  /* keywords */
  "VAR"                          { return symbol(DECVAR); }
  "ENDVAR"                       { return symbol(ENDVAR); }
  "INTEGER"                      { return symbol(INTEGER); }
  "FLOAT"                        { return symbol(FLOAT); }
  
  "WHILE"                        { return symbol(WHILE); }
  "IF"                           { return symbol(IF); }
  "ELSE"                         { return symbol(ELSE); }
  "THEN"                         { return symbol(THEN); }
  "END"                          { return symbol(END); }
  "DO"                           { return symbol(DO); }
  "PRINT"                        { return symbol(PRINT); }
  //"PLUSTRUNC"                    { return symbol(PLUSTRUNC); }
  //"TRUNC"                        { return symbol(TRUNC); }
  "("                            { return symbol(LPAREN); }
  ")"                            { return symbol(RPAREN); }
  "{"                            { return symbol(LBRACE); }
  "}"                            { return symbol(RBRACE); }
  "["                            { return symbol(LBRACK); }
  "]"                            { return symbol(RBRACK); }
  ";"                            { return symbol(SEMICOLON); }
  ":"                            { return symbol(COLON); }
  ","                            { return symbol(COMMA); }
  
  /* operators */
  "="                            { return symbol(EQ); }
  ">"                            { return symbol(GT); }
  "<"                            { return symbol(LT); }
  "!"                            { return symbol(NOT); }
  "=="                           { return symbol(EQEQ); }
  "<="                           { return symbol(LTEQ); }
  ">="                           { return symbol(GTEQ); }
  "!="                           { return symbol(NOTEQ); }
  "&&"                           { return symbol(ANDAND); }
  "||"                           { return symbol(OROR); }
  "+"                            { return symbol(PLUS); }
  "-"                            { return symbol(MINUS); }
  "*"                            { return symbol(MULT); }
  "/"                            { return symbol(DIV); }
  "%"                            { return symbol(MOD); }
  
  /* string literal */
  \"                             { yybegin(STRING); string.setLength(0); }

  /* numeric literals */


  
  {DecIntegerLiteral}            {
                                    verify_int(yytext());
                                    return symbol(INTEGER_LITERAL, new Integer(yytext()));
                                 }

  {DoubleLiteral}                {
                                    verify_real(yytext());
                                    return symbol(FLOATING_POINT_LITERAL, new Double(yytext()));
                                 }
  
  {Identifier}                   { return symbol(IDENTIFIER, yytext()); }
  
  {LineTerminator}               { return symbol(LINE_TERMINATOR); }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
   
}

<STRING> {
  \"                             {
                                    yybegin(YYINITIAL);
                                    verify_string(string.toString());
                                    return symbol(STRING_LITERAL, string.toString());
                                 }
  
  {StringCharacter}+             { string.append( yytext() ); }
  
  /* escape sequences */
  "\\b"                          { string.append( '\b' ); }
  "\\t"                          { string.append( '\t' ); }
  "\\n"                          { string.append( '\n' ); }
  "\\f"                          { string.append( '\f' ); }
  "\\r"                          { string.append( '\r' ); }
  "\\\""                         { string.append( '\"' ); }
  "\\'"                          { string.append( '\'' ); }
  "\\\\"                         { string.append( '\\' ); }
  
  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated string at end of line"); }
}

/* error fallback */
[^]                              { throw new RuntimeException("Illegal character \""+yytext()+"\" at line "+yyline+", column "+yycolumn); }
<<EOF>>                          { return symbol(EOF); }
