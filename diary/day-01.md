# Day 01 (c88a7565ba1507ad05056c417a4bd08620627752)

Wrapping up day one.

Use some spare time on the night to start the lexer (PA2).

It was strange at first to use lex since COOL Manual specifies (Chapter 10)
something I think I'll be handling on yacc and not here. Took me a while
to realize that.

**Major issue:** __understand what to do__. COOL Manual, COOL Tools Tour,
PA2.pdf... Nowhere talked about basic stuff like which kinds of tokens
store values on cool_yylval.symbol or how I should output symbols like
"{" and ":" as there's no token for that.

Solution? Searched a little bit. Found this guy's tips and tricks:
http://jmoyers.org/flex-lexer-for-cool/ which talked about COOL's
reference lexer which I could use to guide myself.

That link also gave me the tip to diff the real lexer to mine like:

```
make lexer
./lexer ../../examples/hello_world.cl > a.out
../../bin/lexer ../../examples/hello_world.cl > b.out
diff a.out b.out
```

Which is a lot helpful.

Still, I'm hard printing symbols (cool.flex:104) which I simply don't
know if it's the right way to do.

**WIP:** strings. Just started making them when I realized it was 3AM. I'm
just going to crash in the bed for now and resume this when I can.
