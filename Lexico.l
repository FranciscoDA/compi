%{
#include <stdio.h>
#include <stdlib.h>
//#include <conio.h>
//#include "y.tab.h"
#include <math.h>
#include <string.h>

#define STRINGMAX 30
#define MAXFLOAT 3.4E+38
#define ENTRADAS_TDS 50

typedef struct _Entrada_TdS_t {
    // _{CONST_REAL}
    char *token;
    // Nada por el momento. Tipos de datos definidos por el usuario
    char *type;
    // Solo si es CONST_REAL
    float value;
    // Solo si es CONST_STRING
    int length;
} Entrada_TDS;

FILE  *yyin;
int yylval;

int verificar_real(char* yytext);
void insertarString(char* str);
void insertarReal(char* n);
void insertarID(char* id);
void inicializarTDS();

Entrada_TDS tabla_simbolos[ENTRADAS_TDS];
%}

/*DEFINICIONES*************************************************/
DIGITO                                                          [0-9]
LETRA                                                           [A-Za-z]
ID                                                              {LETRA}(_?({LETRA}|{DIGITO}))*
CONST_REAL                                                      ({DIGITO}+\.{DIGITO}*)|({DIGITO}*\.{DIGITO}+)|{DIGITO}+
CONST_STRING                                                    \"([^\"]|\.)*\"
COMA                                                            ","
FIN_INSTRUCCION                                                 ";"
OP_ASIGNACION                                                   "="
OP_SUMA                                                         "+"
OP_RESTA                                                        "\-"
OP_MULTIPLICACION                                               "*"
OP_DIVISION                                                     "/"
OP_IGUAL                                                        "=="
OP_DISTINTO                                                     "!="
OP_MAYOR                                                        ">"
OP_MENOR                                                        "<"
OP_MAYOR_IGUAL                                                  ">="|"=>"
OP_MENOR_IGUAL                                                  "<="|"=<"
BLOQUE_ABRE                                                     "{"
BLOQUE_CIERRA                                                   "}"
CORCHETE_ABRE                                                   "["
CORCHETE_CIERRA                                                 "]"
PARENTESIS_ABRE                                                 "("
PARENTESIS_CIERRA                                               ")"
COMENTARIO                                                      \-\/([^/]|[\r\n]|(\/+([^/-]|[\r\n])))*\/+\-
SALTO_LINEA                                                     \n|\r\n
DOS_PUNTOS							:
TIPO_STRING							[sS][tT][rR][iI][nN][gG]
TIPO_REAL							[rR][eE][aA][lL]


%%/*REGLAS*****************************************************/
{COMENTARIO}                                                    {
                                                                    // Debe ir primero por si se comenta una seccion de codigo
                                                                    //printf("Un comentario: %s\n", yytext);
                                                                    //;
                                                                }
long                                                            {printf("Una palabra reservada: %s\n", yytext);/*return(LONG);*/}
defvar                                                          {printf("Una palabra reservada: %s\n", yytext);/*return(DEFVAR);*/}
enddef                                                          {printf("Una palabra reservada: %s\n", yytext);/*return(ENDDEF);*/}
else                                                            {printf("Una palabra reservada: %s\n", yytext);/*return(ELSE);*/}
if                                                              {printf("Una palabra reservada: %s\n", yytext);/*return(IF);*/}
while                                                           {printf("Una palabra reservada: %s\n", yytext);/*return(WHILE);*/}
write                                                           {printf("Una palabra reservada: %s\n", yytext);/*return(WRITE);*/}
{TIPO_STRING}							{printf("Un tipo de dato: %s\n", yytext);/*return(TIPO_STRING);*/}
{TIPO_REAL}							{printf("Un tipo de dato: %s\n", yytext);/*return(TIPO_REAL);*/}
{FIN_INSTRUCCION}                                               {printf("Un fin de instruccion: %s\n", yytext);/*return(FIN_INSTRUCCION);*/}
{ID}                                                            {printf("Un identificador: %s\n", yytext); insertarID(yytext);/*return(ID);*/}
{CONST_REAL}                                                    {
                                                                    if(verificar_real(yytext) != 0) {
                                                                        printf("Un float: %s (%g)\n", yytext,atof(yytext));
                                                                        insertarReal(yytext);
                                                                        //return CONST_REAL;
                                                                    } else {
                                                                        exit (1);
                                                                    }
                                                                }
{CONST_STRING}                                                  {
                                                                    //Restamos las 2 comillas
                                                                    int stringLargo = strlen(yytext)-2;
                                                                    if (stringLargo > STRINGMAX) {
                                                                        printf("ERROR: La cadena es demasiado larga(%d)!\n", stringLargo);
                                                                        exit (1);
                                                                    } else {
                                                                        printf("Un string: %s\n", yytext);
                                                                        insertarString(yytext);
                                                                        //return CONST_STRING;
                                                                    }
                                                                }
{OP_ASIGNACION}                                                 {printf("Una asignacion: %s\n", yytext);/*return(OP_ASIGNACION);*/}
{OP_IGUAL}                                                      {printf("Un operador de comparacion: %s\n", yytext);/*return(OP_IGUAL);*/}
{OP_SUMA}                                                       {printf("Un operador de suma: %s\n", yytext);/*return(OP_SUMA);*/}
{OP_RESTA}                                                      {printf("Un operador de resta: %s\n", yytext);/*return(OP_RESTA);*/}
{OP_MULTIPLICACION}                                             {printf("Un operador de multiplicacion: %s\n", yytext);/*return(OP_MULTIPLICACION);*/}
{OP_DIVISION}                                                   {printf("Un operador de division: %s\n", yytext);/*return(OP_DIVISION);*/}
{OP_DISTINTO}                                                   {printf("Un operador de comparacion: %s\n", yytext);/*return(OP_DISTINTO);*/}
{OP_MAYOR_IGUAL}                                                {printf("Un operador de comparacion: %s\n", yytext);/*return(OP_MAYOR_IGUAL);*/}
{OP_MENOR_IGUAL}                                                {printf("Un operador de comparacion: %s\n", yytext);/*return(OP_MENOR_IGUAL);*/}
{OP_MAYOR}                                                      {printf("Un operador de comparacion: %s\n", yytext);/*return(OP_MAYOR);*/}
{OP_MENOR}                                                      {printf("Un operador de comparacion: %s\n", yytext);/*return(OP_MENOR);*/}
{BLOQUE_ABRE}                                                   {printf("Delimitador de comienzo de bloque: %s\n", yytext);/*return(BLOQUE_ABRE);*/}
{BLOQUE_CIERRA}                                                 {printf("Delimitador de final de bloque: %s\n", yytext);/*return(BLOQUE_CIERRA);*/}
{CORCHETE_ABRE}                                                 {printf("Delimitador de comienzo de arreglo: %s\n", yytext);/*return(CORCHETE_ABRE);*/}
{CORCHETE_CIERRA}                                               {printf("Delimitador de final de arreglo: %s\n", yytext);/*return(CORCHETE_CIERRA);*/}
{PARENTESIS_ABRE}                                               {printf("Delimitador de comienzo de llamanda a funcion: %s\n", yytext);/*return(PARENTESIS_ABRE);*/}
{PARENTESIS_CIERRA}                                             {printf("Delimitador de final de llamada a funcion: %s\n", yytext);/*return(PARENTESIS_CIERRA);*/}
{DOS_PUNTOS}							{printf("Un caracter: %s\n", yytext);/*return(DOS_PUNTOS);*/}
"\t"                                                            {
                                                                    //printf("Un tabulador: %s\n", yytext);
                                                                    ;
                                                                }
{SALTO_LINEA}                                                   {
                                                                    //printf("Un salto de linea: %s\n", yytext);
                                                                    ;
                                                                }
.





%%/*CODIGO DE USUARIO******************************************/
int verificar_real(char* yytext) {
    double valor;
    valor = strtod(yytext, NULL);

    if(valor > MAXFLOAT) {////compara con el maximo de los reales
        printf ("No es un real admitido. n");
        return 0;
    }
    return 1;
}

int buscarSimbolo(char *simbolo) {
    int i;
    for(i=0;i<ENTRADAS_TDS;i++) {
        if(tabla_simbolos[i].token == '\0') {
            break;
        } else if(strcmp(tabla_simbolos[i].token, simbolo) == 0) {
            return i;
        }
    }
    return ~i;
}

void inicializarTDS() {
    memset(tabla_simbolos, 0, sizeof(tabla_simbolos));
}

void insertarReal(char *n) {
    char *token = calloc(strlen(n) + 2, sizeof(char));
    token[0]='_';
    strcpy(&token[1], n);

    int i = buscarSimbolo(token);

    if(i < 0) {
        i=~i;
        tabla_simbolos[i].token = token;
        tabla_simbolos[i].value = atof(n);
    }
}

void insertarString(char *str) {
    char *token = calloc(strlen(str), sizeof(char));
    token[0]='_';
    strncpy(&token[1], &str[1], strlen(str)-2);

    int i = buscarSimbolo(token);

    if(i < 0) {
        i=~i;
        tabla_simbolos[i].token = token;
        tabla_simbolos[i].length = strlen(token)-1;
    }
}

void insertarID(char *id) {
    char *token = calloc(strlen(id) + 1, sizeof(char));
    strcpy(token, id);

    int i = buscarSimbolo(token);

    if(i < 0) {
        i=~i;
        tabla_simbolos[i].token = token;
    }
}

void mostrarTDS() {
    int i;
    for(i=0; i < ENTRADAS_TDS; i++)
        if(tabla_simbolos[i].token == '\0')
            break;
        else
            printf("Token:%s      Valor: %f          Length:%d\n", tabla_simbolos[i].token, tabla_simbolos[i].value, tabla_simbolos[i].length);
}

void escribirTDS() {
    FILE *out;

    out = fopen("ts.txt", "w");

    fprintf(out, "%-34s\t\t%s\t\t%s\t\t%s\n", "NOMBRE", "TIPO", "VALOR", "LONGITUD");

    int i;
    for(i=0; i < ENTRADAS_TDS; i++)
        if(tabla_simbolos[i].token == '\0')
            break;
        else
            fprintf(out, "%-34s\t\t%s\t\t%f\t\t%d\n", tabla_simbolos[i].token, tabla_simbolos[i].type, tabla_simbolos[i].value, tabla_simbolos[i].length);

    fclose(out);
}

int main(int argc, char **argv) {
    ++argv, --argc;  /* skip over program name */
    if (argc > 0) {
        yyin = fopen(argv[0], "r" );
    } else {
        yyin = stdin;
    }

    inicializarTDS();
    yylex();
    escribirTDS();
}
