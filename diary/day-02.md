# Day 02

Still on lexing.

## Multi line strings

Started by accepting multi line strings. My first logic was to match everything besides escape sequences.
Once one escape sequence was found I'd handle it.

Strings like:

```
"foo
bar"
```

Are invalid while:


```
"foo\
bar"
```

Is valid. 

So my hack was `<string>\\$`.

## Comments

Pretty much what I did in strings, I've matched everything besides what could be a comment end then
handled cases where it wasn't the end. 

## Lexer order

I was following my own order of things then I realized cs143 had comments on where to put
stuff like comments and strings so I just rearranged them.

## Case insensitive

Keywords are case insensitive and booleans have the first letter lowercase but the tail is
insensitive so I had to make my life easier:

![](http://i.imgur.com/dib7kSg.png)

![](http://i.imgur.com/02q5gQP.png)

![](http://i.imgur.com/8RUEltL.png)

## String parsing once again

I knew I've missed string error handling but I also found errors on my string
lexer so I had to come back here and I spent quite some time at it.

I've found somewhere about a pattern where you parse a string upto to a "worry"
character that may or may not finish or error the string so I've adopted this.

![](http://i.imgur.com/xZ5Bjdf.png)

So I basically consume the string as long as I don't find a _worry_ character. If I do
I start the worry state.

![](http://i.imgur.com/5rQkfeC.png)

I consume up to a "\" which could be a new line, string line break escape, tab...

![](http://i.imgur.com/KATagnP.png)

### Unterminated string constant

For this error case I consume upto to a non-escaped new line (if it was, the worry 
case would be triggered).

![](http://i.imgur.com/r98EHHD.png)

### String constant too long"

For this error my solution was simple.

Before that I was using strcat to append strings but if the string was greater than
`MAX_STR_CONST` we would get a segment fault. So I created a helper function.

![](http://i.imgur.com/YcxZ5on.png)

And that's `strncat` (notice the N) which specifies how many chars you want to append.
So I can prevent trespassing `MAX_STR_CONST` and to catch the error:

![](http://i.imgur.com/OYvClWC.png)

Why equals tho? `MAX_STR_CONST` is 1025 but cool manual specifies the limit as 1024 chars.

![](https://media.giphy.com/media/d3mlE7uhX8KFgEmY/source.gif)

## "I know it's not ready but I'll try grading it anyways"

```
Grading .....
make: Entering directory '/home/lubien/dev/cool/assignments/PA2'
make: 'lexer' is up to date.
make: Leaving directory '/home/lubien/dev/cool/assignments/PA2'
=====================================================================
submission: ..

	-1 (backslash)	 various backslashes in strings
	-1 (backslash2)	 more backslashes in strings
	-1 (badidentifiers)	 bad identifiers
	-1 (bothcomments)	 mixing the two types of comments
	-1 (endcomment)	 the end comment token by itself
	-1 (eofstring)	  eof in a string
	-1 (escapedeof)	 escaped eof in a string
	-1 (escapednull)	 escaped null char in a string
	-1 (escapedquote)	 escaped quote
	-1 (invalidcharacters)	 characters not in the cool language
	-1 (invalidinvisible)	 unprintable characters not allowed in cool
	-1 (lineno2)	 line number test 2
	-1 (longstring_escapedbackslashes)	 long strings with escaped characters
	-1 (null_in_string)	 null char in string
	-1 (null_in_string_followed_by_tokens)	 null char in string, then tokens
	-1 (objectid)	 objectids
	-1 (opencomment)	 no matching closing comment
	-1 (s03)	 EOF in single-line comment
	-1 (s04)	 different types of whitespaces
	-1 (s25)	 object and type id
	-1 (s31)	 leading underscore
	-1 (s32)	 end of comment without start
	-1 (s33)	 unterminated comment
	-1 (wq0607-c1)	 sequences of one line comments and strings
	-1 (wq0607-c2)	 sequences of block comments and strings
	-1 (wq0607-c3)	 sequence of quotes and backslashes
	-1 (wq0607-c4)	 sequence of quotes, backslashes, and double-dash comment symbols
=====================================================================
You got a score of 36 out of 63.
```

## I'm dumb

I was testing both by examples from the course and by examples modified by me.

Turns out the grading script has **several** test files and not only it grades my code
but it also store the diffs between the desired lexing and mine's.

I should have started using this from the beggining...
