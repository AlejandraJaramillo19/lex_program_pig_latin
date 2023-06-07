%{
#include <stdio.h>

%}

espacio 	[ \t]
espacios 	{espacio}+
palabraActual  [a-zA-Z]+
saltoLinea 	[ \n]
otros  [^ \t\na-zA-Z]

%%
{palabraActual} {
    // Obtener la primera letra de la palabra capturada
    char primerLetra = yytext[0];

    // Mover la primera letra al final de la palabra y agregar "ay"
    if (primerLetra == 'a' || primerLetra == 'e' || primerLetra == 'i' || primerLetra == 'o' || primerLetra == 'u' ||
        primerLetra == 'A' || primerLetra == 'E' || primerLetra == 'I' || primerLetra == 'O' || primerLetra == 'U') {
        printf("%say ", yytext);
        
    } else {
        int longitud = 0;
        for (int i = 0; yytext[i] != '\0'; i++) {
           longitud++;
        }
        char nuevaPalabra[longitud + 2];
        
        for (int i = 0; i < longitud - 1; i++) {
           nuevaPalabra[i] = yytext[i + 1];
        }
        nuevaPalabra[longitud - 1] = primerLetra;
        nuevaPalabra[longitud] = 'a';
        nuevaPalabra[longitud + 1] = 'y';
        nuevaPalabra[longitud + 2] = '\0';
        printf("%s ", nuevaPalabra);
    }
}


{espacios} { printf("%s", yytext); }
{saltoLinea}  { printf("%s", yytext); }
{otros} { printf("%s", yytext);}

%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Usage: %s filename\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        printf("Failed to open file: %s\n", argv[1]);
        return 1;
    }

    yyin = file;
    yylex();

    fclose(file);

    return 0;
}

int yywrap(){
    return 1;
}