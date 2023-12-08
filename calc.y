%{
int yylex();
int yy_scan_string();
int yyerror(const char *message){return 0;};
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
%}

%token NUMERO
%token SQRT
%token STR_POW
%token STR_SHIFT_LEFT

%%

linea : expresion '=' { printf("%d\n", $1); }

expresion : expresion '+' termino               { $$ = $1 + $3; }
          | expresion '-' termino               { $$ = $1 - $3; }
          | termino
          ;

termino : termino '*' factor                  { $$ = $1 * $3; }
        | termino '/' factor                  { $$ = $1 / $3; }
        | termino '%' factor                  { $$ = $1 % $3; }
        | termino STR_SHIFT_LEFT factor       { $$ = $1 << $3; }
        | factor
        ;                                                               

factor : NUMERO
       | '-' factor                             { $$ = -$2; }
       | '(' expresion ')'                      { $$ = $2; }
       | '|' expresion '|'                      { $$ = abs($2); }
       | SQRT '(' expresion ')'                 { $$ = sqrt($3); }
       | NUMERO STR_POW factor                  { $$ = pow($1, $3); }
       ;

%%

int main(int argc, char* argv[]) {

    FILE* file = fopen(argv[1], "r");

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        yy_scan_string(line);
        yyparse();
    }

    fclose(file);

    return 0;
}