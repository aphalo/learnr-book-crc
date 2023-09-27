# Feedback -- chapter 6 of Learn R

## General
- are names containing the dot character ('.') common in R? If yes, everything is fine. I was just surprised by that fact, since in other languages, dot is used for calling methods of objects.
- What version of R are you using? Sometimes there are phrases like "at the time of writing" or similar, but I don't know, which versions of R and its packages were used at that time.
- I've checked that links are working, it seems ok.
- I have noticed some mishmash of 1st person singular and 1st person plural, i.e. both "I used ..." and "we used ..." occur in the book... I think it's good to stick to just one pronoun.

## 6.2
- Should the term "encapsulation" be mention? I did not find it there.
- p. 170 -- numbered list of items (i.e. 1), 2),... ) could be written as list instead of 1 paragraph, i.e. use `enumerate` or `compactenum` in LaTeX 
    - one more point could be added -- "5) dividing code into functions is important for writing tests"
    - the "DRY" (don't repeat yourself) could be mentioned
- Example code 6.1 -- the last should be "print.x.5", not "print.x.4", and it should return "test", not "NULL"... I think it is a typo
- In the paragraph about "Scoping", terms "local variable" and "global variable" could be used
    - Does it mean that objects from calling environment are "read-only", unless `<<-` or `assign()` is used? If so, the term "read-only" could be used explicitely.

### 6.2.1
- I don't think naming function arguments or variables like built-in functions is a good practice. In the example provided, `na.omit` is used as boolean variable, but also a built-in function. Maybe I am too influenced by C or Python, though... How does R know, when do I want to use the variable and when the function, when they are called the same?
 
### 6.2.2
- You mention "The parameters of many binary R operators are named e1 and
e2." -- is it up to the user to name the arguments, or is it mandatory to name them e1, e2,...?

## 6.3
- "We say that specific methods are dispatched..." -- I think it would help me to understand if a toy example would be given immediately after this paragraph.
- The first example on p. 178 `class(a) <- c("myclass", class(a))` -- What is this good for? It seems a bit confusing... Clearly, `a` is an instance of "numeric" class, but why am I adding "myclass" to it? And what is myclass, anyway?

## 6.4
- After reading 6.4, it seems to me that the example with `na.omit` should not work, since the binary variable overwrites (shadows) the function...

## 6.5
- Could you provide an example comparing installation of package from CRAN vs from GitHub?


### 6.5.4
- Could you provide some more examples on when to use `attach` / `detach` with packages?
