tabul	[ \t]
ws	{tabul}+
digito	[0-9]
alpha   [A-Za-z]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?
id ({alpha}|\_)({alpha}|{num}|\_)*
literal [\".*\"]

%%

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

"\n"	{}
<<EOF>> {return TFIM;}

{ws} {}
{id} {strcpy(yylval.id, yytext); return ID;}
{literal} {return LITERAL;}
{num}	{return TNUM;} 
