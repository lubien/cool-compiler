/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

%START string

/*
 * Define names for regular expressions here.
 */

CAPITAL_LETTER  [A-Z]
MINUSCLE_LETTER [a-z]
LETTER          ({CAPITAL_LETTER}|{MINUSCLE_LETTER})
DIGIT           [0-9]

DARROW          =>
TYPE            ({LETTER}{LETTER}*|SELF_TYPE)
ID              {MINUSCLE_LETTER}({LETTER}|{DIGIT}|_)*
CLASS           class
INHERITS        inherits

%%

 /*
  *  Nested comments
  */


 /*
  *  The multiple-character operators.
  */
<string>\\$               { strcat(string_buf, ""); curr_lineno++; }
<string>\\b               { strcat(string_buf, "\b"); }
<string>\\t               { strcat(string_buf, "\t"); }
<string>\\n               { strcat(string_buf, "\n"); }
<string>\\f               { strcat(string_buf, "\f"); }
<string>[^\\b\\t\\n\\f"]+ { strcat(string_buf, yytext); }
<string>\"                {
                            cool_yylval.symbol = stringtable.add_string(string_buf);
                            BEGIN 0;
                            string_buf[0] = '\0';
                            return (STR_CONST);
                          }
\"                        { BEGIN string; }

{DARROW}		{ return (DARROW); }
{CLASS}     { return (CLASS); }
{INHERITS}  { return (INHERITS); }
{ID}        {
              cool_yylval.symbol = idtable.add_string(yytext);
              return (OBJECTID);
            }
{TYPE}      {
              cool_yylval.symbol = idtable.add_string(yytext);
              return (TYPEID);
            }
":" |
";" |
"(" |
")" |
"{" |
"}"         {
              printf("#%i '%s'\n", curr_lineno, yytext);
            }
\n          { curr_lineno++; }
[ \t]       ;

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */


%%
