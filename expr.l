delim	[ \t]
ws	{delim}+
digito	[0-9]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?

%%
{ws}	{}
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

"("	{return TAPAR;}
")"	{return TFPAR;}
\n	{return TFIM;}

{num}	{yylval=atof(yytext); return TNUM;} 
