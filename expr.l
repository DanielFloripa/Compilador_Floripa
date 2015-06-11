delim   [ \t\n\v\f]
ws      {delim}+
digito  [0-9]
num     {digito}+
alpha   [a-zA-Z]
literal \".*\"
id      ({alpha}|\_)({alpha}|{num}|\_)*

%%
{ws} {}
"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}

"read" {return READ;}
"print" {return PRINT;}
"return" {return RETURN;}

"int" {return INT;}
"void" {return VOID;}
"String" {return STRING;}

"+"	{return TADD;}
"-"	{return TSUB;}
"*"	{return TMUL;}
"/"	{return TDIV;}

"<" {return RMEN;}
">" {return RMAI;}
"<=" {return RMENEQ;}
">=" {return RMAIEQ;}
"==" {return REQU;}
"!=" {return RDIF;}

"&&" {return LAND;}
"||" {return LOR;}
"!" {return LNOT;}

"=" {return TATRIB;}
";" {return TPTOVRGL;}
"," {return TVIRGULA;}

"(" {return TAPAR;}
")" {return TFPAR;}
"{" {return TACHAVE;}
"}" {return TFCHAVE;}

<<EOF>> {return TFIM;}
{id} {strcpy(yylval.id, yytext); return ID;}
{literal} {return LITERAL;}
{num}	{return TNUM;} 
