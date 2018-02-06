# Day 03

It's not exactly the third day in a row, it's the third day I was free to do it.

If we where to count days exactly it would go from the point I've started learning flex
some time ago but that's not the point.

## Exclusive start conditions

If I only had read flex manual instead of lex's I'd know that and it would be great...

What happens is that with exclusive start conditions I can scope where the lexer will try
to get regexes from so I don't need to try to overcome regexes from different things...

Now both comments and string are scoped on exclusive start conditions. Made my life easier...

## I cheated, sorta

I made great effort not to look in any lexer over the internet and that didn't happen.

But when I was reading the flex manual... Right in my face the solution for my string and comments
problems... Felt like cheating. Yes, I had to write more cases for stuff of COOL, but didn't felt right...

## TDD ftw

Now that I know what exactly to do by the grading script (read [day-02.md](diary/day-02.md)) I was
simply fixing stuff or adding missing stuff. Mostly errors I didn't handle and edge cases of strings/comments.

It was good to start fixing a error then you run a grading script and realize you fixed like 5 of them.

## Final grade

```sh
Grading .....
make: Entering directory '/home/lubien/dev/cool/assignments/PA2'
make: 'lexer' is up to date.
make: Leaving directory '/home/lubien/dev/cool/assignments/PA2'
=====================================================================
submission: ..

=====================================================================
You got a score of 63 out of 63.

Submit code: 

```

Time to study for the next assignment. But first I'm gonna take a nap it's 5AM already.

![](https://78.media.tumblr.com/893216ee8e4c5e54338bbc38108eab97/tumblr_owxzdrpUUa1r6a1vco2_500.gif)
