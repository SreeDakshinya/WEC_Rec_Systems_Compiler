# WEC_Rec_Systems_Compiler

This repository contains all of the files used to solve a given compiler-based question for the Web Enthusiasts' Club Systems Recruitment.

## Lex File: 
The lex file contains the implementation code for the token identification, the symbol table and the error table.
* Token Identification: The tokens identified are (the tokens returned by the lex file are mentioned in brackets []): Whitespaces [WS], newline characters, FullStops [STOP], commas [COMMA], hyphens [HYPHEN], words (having all characters except digits, whitespace, full stops, commas and hyphens) beginning with a capital letter with at least 3 and at most 26 characters [STARTWORD], words with at least 3 and at most 26 characters [WORD]. All other characters are considered to be invalid.
* The symbols are added to the symbol table as soon as they have been identified by the lexer.

(Yacc details to be added)
