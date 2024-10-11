%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "WSC.tab.h"

    int sym_count=0;
    int err_count=0;

    struct symbol{
        char lexeme[20];
        char toktype[20];;
        int lineno;
    } ST[100];

    struct error{
        char error[50];
        int lineno;
    } ET[100];

    void addsymbol(char* lexe, char* tokt, int line)
    {
        strcpy(ST[sym_count].lexeme, lexe);
        strcpy(ST[sym_count].toktype, tokt);
        ST[sym_count].lineno=line;
        sym_count++;
    }

    void adderror(char* err, int line)
    {
        strcpy(ET[err_count].error, err);
        ET[err_count].lineno=line;
        err_count++;
    }

    void printsymbol()
    {
        int i;
        printf("--------------------------\n");
        printf("ID Lexeme TokenType LineNo \n");
        printf("--------------------------\n");
        for (i=0;i<sym_count;i++)
        {
            printf("%d   %s  %s    %d \n", i+1, ST[i].lexeme, ST[i].toktype, ST[i].lineno);
        }
        printf("--------------------------\n");
    }

    void printerror()
    {
        int i;
        printf("--------------------------\n");
        if (err_count==0)
        {
            printf("Error Table is empty. \n");
            printf("--------------------------\n");
            return;
        }
        printf("     Error         LineNo \n");
        printf("--------------------------\n");
        for (i=0;i<err_count;i++)
        {
            printf("%d %s %d \n", i+1, ET[i].error, ET[i].lineno);
        }
        printf("--------------------------\n");
    }

%}

%option yylineno

%%

[ \t] {return WS;}
"\n"    {return '\n';}
"." {addsymbol(yytext, "Full-Stop", yylineno); return STOP;}
"," {addsymbol(yytext, "Comma", yylineno); return COMMA;}
"-" {addsymbol(yytext, "Hyphen", yylineno); return HYPHEN;}
[A-Z]([^0-9 \n\t\.\,\-]{2,25}) {addsymbol(yytext, "Startword", yylineno); return STARTWORD;}
[^0-9 \n\t\.\,\-]{3,26}  {addsymbol(yytext, "Word", yylineno); return WORD;}
.   {adderror("Invalid Character. ", yylineno); }

%%

int yywrap()
{
    return 1;
}