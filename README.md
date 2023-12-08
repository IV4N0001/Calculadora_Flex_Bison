//Compilar
flex calc.l
bison -yd calc.y
gcc lex.yy.c y.tab.c -o calc -lm

//Ejecutar
./calc test