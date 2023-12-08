%{
#include "y.tab.h"
%}

%option noyywrap

%%

[0-9]+                          { printf("%s", yytext); yylval = atoi(yytext); return NUMERO; }
[-+*/\|\%\(\)\n]                { printf("%s", yytext); return *yytext; }
[<]{2}                          { printf("%s", yytext); return STR_SHIFT_LEFT; }
"sqrt"                          { printf("%s", yytext); return SQRT; }
"**"                            { printf("%s", yytext); return STR_POW; }
[ \t]                           ;
=                               { printf("%s", yytext); return '='; }
.                               ;

%%