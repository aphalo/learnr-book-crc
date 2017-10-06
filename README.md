# README #

### What is this repository for? ###

This repository contains draft chapters of a book titled _Learning R... as you learnt your mother tongue_. 
Some of these chapters started as teaching notes and others as appendixes to a handbook. However, they grew too big to be appendixes. 

### Is the book available as a PDF file for download? ###

Yes, the book draft is available for download at (http://leanpub.com/learnr).

### Just clone the repository ###

To build the pdf you will need XeLaTeX and the KOMA script classes, and current versions of R and knitr. 
The source files are in Rnw format using 'knitr'.
As many different packages are used, R's limit of 100 loaded DLLs is reached. 
To increase this limit operating system variable `R_MAX_NUM_DLLS` needs to be
set to a higher value. Using 120 or larger should be more than enough. Be aware that
this variable is recognized only by R (>= 3.4.0).

### Contribution guidelines ###

You are welcome to contribute pull requests and through issues.

### Who do I talk to? ###

* Pedro J. Aphalo 

* [pedro.aphalo@r4photobiology.info](mailto:pedro.aphalo@r4photobiology.info)

* [www.r4photobiology.info](http://www.r4photobiology.info/)
