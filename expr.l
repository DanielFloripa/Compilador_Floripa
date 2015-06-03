delim	[ \t]
ws	{delim}+
digito	[0-9]
alpha   [A-Za-z]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?
id ({alpha}|\_)({alpha}|{num}|\_)*
literal \".*\"

%%
"void" {return VOID;}
"int" {return INT;}
"String" {return STRING;}

"if" {return IF;}
"else" {return ELSE;}
"while" {return WHILE;}

"read" {return READ;}
"print" {return PRINT;}
"return" {return RETURN;}

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

"("	{return TAPAR;}
")"	{return TFPAR;}
"{" {return TACHAVE;}
"}" {return TFCHAVE;}

\n	{return TFIM;}
<<EOF>> {return TFIM;}

{ws} {}
{id} {return ID;}
{literal} {return LITERAL;}
{num}	{yylval=atof(yytext); return TNUM;} 
