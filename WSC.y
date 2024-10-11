%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int yyerror();
    int yylex();
    extern void printsymbol();
    extern void printerror();
    extern void adderror(char* err, int line);
    extern int sym_count;
    extern int err_count;
    extern int yylineno;

    char output[10000];

    void addtok(char* str)
    {
        if (strlen(output)==0)
        {
            strcpy(output, str);
            return;
        }
        strcat(output, " ");
        strcat(output, str);
    }

    void printlines()
    {
        printf("--------------------------\n");
        printf("--------------------------\n");
    }

%}

%token STARTWORD WORD STOP COMMA HYPHEN WS '\n'
%left COMMA HYPHEN
%%

begin_parse : STARTWORD {addtok("STARTWORD");} body STOP {addtok("STOP");} '\n' {printlines(); printf("The given string is VALID. \n"); return 0;}
            | {adderror("Invalid construct.", yylineno);}
            ;

body    : compound
        |
        ;

compound    : multiword HYPHEN {addtok("HYPHEN");} compound
            | multiword compound
            | multiword
            ;

multiword   : words COMMA {addtok("COMMA");} multiword
            | words
            ;

words   : WORD {addtok("WORD");}
        | STARTWORD {addtok("STARTWORD");}
        | WS    //{addtok("WS");}
        ;


%%

int main()
{
    yyparse();
    printsymbol();
    printerror();
    printf("Output string: %s \n", output);
}

int yyerror()
{   
    printlines();
    printf("The given string is INVALID. \n");
    return 1;
}