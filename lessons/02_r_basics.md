

# R Basics

In this lesson we are going to go over the very basics of R, cover some basic terminology, talk a little about syntax and point you to resources for getting help.

## Lesson Outline:

- [Functions and basic syntax](#functions-and-basic-syntax)
- [Packages](#packages)
- [Operators and objects](#operators-and-objects)
- [Getting help](#getting-help)

## Lesson Exercises:
- [Homework 2.1](#homework-21)


## Exercise 2.1
Let's start off by making sure we are in the correct project and create a script to hold the examples we will work through.  

1. Open your `nerrs_intro_r` project.  
2. Create a new R script.
3. Save the (currently empty) R script as `r_basics.R`
4. Look at the file tab.  You should be in a `nerrs_intro_r` folder and there should now be a `r_basics.R` file there.
5. When this is finished, just say "done" in the Teams chat. 
6. As I am showing examples, you can follow along, type the same functions and code in your script, and run the code to see what happens.

## Functions and basic syntax 

R is a functional programming language and as such, most everything you do uses a function.

The basic syntax of function follows the form: `function_name(arg1, arg2, ...)`.  With the base install, you will gain access to many (3123 functions, to be exact).  Some examples:


```r
#Print
print("hello world!")
```

```
## [1] "hello world!"
```

```r
#A sequence
seq(1,10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
#Random normal numbers
rnorm(100, mean = 10, sd = 2)
```

```
##   [1] 11.774941  9.755222 10.644634 13.176252  9.006489 11.554359 14.173181 11.578140 11.707258 11.998450
##  [11] 10.255856 11.364268 10.924988 12.997515 10.051627  9.953177 12.735151  9.763948 10.157999  9.695424
##  [21]  8.490866 11.361951 12.031373  7.430028 12.042021 10.720755  8.385387  8.315540 10.620627 11.086578
##  [31] 13.257756 10.583243  7.677336  7.891017 13.054420  7.183739  9.952981  7.051380  9.410241  6.652752
##  [41]  8.776118  5.718915  7.618740  7.239075 10.837383 12.975702  7.287595 11.130890 10.445671 10.012267
##  [51] 11.114204  9.796478  8.138881 10.355476  9.157933  9.435478 13.118380 11.271895  7.696851  6.404370
##  [61]  8.802922  7.736816  8.628646 12.454230  8.655269  9.569524 11.054948 11.867015  8.564536 11.516404
##  [71] 10.651067 11.976049  9.519118 10.608099 11.763441 12.931088 10.415705 12.781116 11.580237 12.204982
##  [81] 11.782649 10.098290 13.736950  8.703808  7.226944 11.236686 10.752244 10.703843 11.711457  4.868540
##  [91] 10.466506  9.227441  8.199443 13.286191 11.197270  9.406691 10.876606  8.676810 10.686328 12.325854
```

```r
#Mean
mean(rnorm(100))
```

```
## [1] -0.07329567
```

```r
#Sum
sum(rnorm(100))
```

```
## [1] -9.689879
```

### A few side notes 

There are several other characters that commonly show up in R code.  These are:

```
# - comments
() - wraps function arguments and order of operations
[] - indexing
{} - grouping code
```

The `#` indicates a comment.  You can put whatever else you'd like after this, but on the same line as the `#`.  R will not evaluate it. Multiple `#####`, are still just seen as a comment.  When commenting your code, err on the side of too much!  Also, you will see `()`, `[]`, and `{}` used in R code.  The `()` indicates a function (almost always), the `[]` indicates indexing (grabbing values by the location), and the `{}` groups code that is meant to be run together and is usually used when programming functions in R.

## Packages

The base install of R is quite powerful, but you will soon have a need or desire to go beyond this.  Packages provide this ability.  They are a standardized method for extending R with new methods, techniques, and programming functionality.  There is a lot to say about packages regarding finding them, using them, etc., but for now let's focus just on the basics.  

### CRAN

One of the reasons for R's popularity is CRAN, [The Comprehensive R Archive Network](http://cran.r-project.org/).  This is where you download R and also where most will gain access to packages (there are other places, but that is for later).  Not much else to say about this now other than to be aware of it.  As of 2020-10-22, there are 16415 packages on CRAN! 

### Installing packages

When a package gets installed, that means the source is downloaded and put into your library.  A default library location is set for you so no need to worry about that.  In fact on Windows most of this is pretty automatic.  Let's give it a shot.



```r
#Installing Packages from CRAN
#Install dplyr and ggplot2
install.packages("ggplot2")
install.packages("dplyr")

#You can also put more than one in like
install.packages(c("elevatr", "formatR"))
```


### Using packages

One source of confusion that many have is when they cannot access a package that they just installed. This is because getting to this point requires an extra step, loading (or attaching) the package.   


```r
#Loading packages into your library
#Add libraries to your R Session
library("ggplot2")
library("dplyr")

#You can also access functions without loading by using package::function
dplyr::mutate
```

```
## function (.data, ...) 
## {
##     UseMethod("mutate")
## }
## <bytecode: 0x00000188b3038298>
## <environment: namespace:dplyr>
```

You will often see people use `require()` to load a package. It is better form to not do this. For a more detailed explanation of why `library()` and not `require()` see [Yihui Xie's post on the subject](http://yihui.name/en/2014/07/library-vs-require/.)

And now for a little pedantry.  You will often hear people use the terms "library" and "package" interchangeably.  This is not correct.  A package is what is submitted to CRAN, it is what contains a group of functions that address a common problem, and it is what has allowed R to expand.  A library is, more or less, where your packages are stored.  You have a path to that library and this is where R puts new packages that you install (e.g. via `install.packages()`).  These two terms are related, but most certainly different.  Apologies up front if I slip and use one when I actually mean the other...


## Operators and objects
As I mentioned above, the console and using R interactively is very powerful.  We will do this quite a bit.  Let's spend a little time playing around in the console and learn a few new functions.

R can be used as a calculator and a way to compare values.  Some examples of the basic operators:


```r
#A really powerful calculator!
1 + 1 #Add
```

```
## [1] 2
```

```r
10 - 4 #Subtract
```

```
## [1] 6
```

```r
3 * 2 #Multiply
```

```
## [1] 6
```

```r
3 ^ 3 #Exponents
```

```
## [1] 27
```

```r
100 / 10 #Divide
```

```
## [1] 10
```

```r
5 %% 2 #Modulus
```

```
## [1] 1
```

```r
5 > 2 #Greater than
```

```
## [1] TRUE
```

```r
4 < 5 #Less than
```

```
## [1] TRUE
```

```r
5 <= 5 #Less than or equal
```

```
## [1] TRUE
```

```r
8 >= 2 #Greater than or equal
```

```
## [1] TRUE
```

```r
2 == 2 #Equality: notice that it is TWO equal signs!
```

```
## [1] TRUE
```

```r
5 != 7 #Not Equals
```

```
## [1] TRUE
```

That's neat, but so what...  

Well, it could be interesting to do something with those values and save them for re-use.  We can do that with objects (everything in R is an object) and use the assignment operator, `<-`.  Know that object names cannot start with a number, contain spaces, or (most) special characters.  Underscores and periods are allowed.  

**NOTE:** If you have experience with other, object-oriented languages, then just be aware that R objects, at least the general use of the term, are different.  


```r
#Numeric assignment
x <- 5
x
```

```
## [1] 5
```

```r
y <- x + 1
y
```

```
## [1] 6
```

```r
z <- x + y
z
```

```
## [1] 11
```

```r
#Character
a <- "Bob"
a
```

```
## [1] "Bob"
```

```r
b <- "Sue"
b
```

```
## [1] "Sue"
```

```r
a2 <- "Larry"
a2
```

```
## [1] "Larry"
```

Now that we have a little experience working in the console and creating objects with `<-`, we might want to be able to do some additional things to navigate around, look at these objects etc.  You can do a lot of this directly in RStudio in the Environment, History pane which is likely in the upper right corner of the window.  Alternatively, you can explore your current environment via the console.  Some functions that you might find useful for working with your R workspace:


```r
#List all objects in current workspace
ls() 
ls(pattern = "a")

#Remove an object
rm(x)

#Save your workspace
#Saves the whole thing to a file called lesson2.RData
save.image("lesson2.RData") 
#Saves just the a and y objects to a file called lesson2_ay.RData
save(a, y, file = "lesson2_ay.RData")
```

This is probably a good spot to bring up quotes vs no quotes around arguments in a function.  This is a very common stumbling block.  The general rule is that no quotes are used only when referring to an object that currently exists.  Quotes are used in all other cases.  For instance in `save(a, y, file = "lesson2_ay.RData")` the objects `a` and `y` are not quoted because they are objects in the workspace.  `file` is an argument of save and argument names are never quoted.  We quote the name of the file "lesson2_ay.RData" because it is not an R object but the name of a file to be created.  You will likely still have some issues with this.  My recommendation is to think about if it is an object in your R workspace or not.  If so, no quotes! This isn't foolproof, but works well most of the time.

Next thing you might want to do is navigate around your files and directories. While you can do this directly from the console, it is going to be better practice to mostly use RStudio projects to manage your folders, working directory etc.  You can also navigate using the Files, etc. pane. 

### A quick word about assignment

We have now seen how to assign object in R using the assignment operator, `<-`.  Assignment can also be done with `=`.  I suggest that you don't use this, not for "correct" syntax reasons, but for readability and code style reasons.  Use `<-` for assignment (fun note, `->` also works but the object it is assigned to lives on the right side of the operator).  Reserve `=` for assigning arguments inside of functions (e.g. `rnorm(10, mean = 5)`).

## Getting help

Being able to find help and interpret that help is probably one of the most important skills for learning a new language.  R is no different. Help on functions and packages can be accessed directly from R, can be found on CRAN and other official R resources, searched on Google, found on StackOverflow, or from any number of fantastic online resources. I will cover a few of these here. 

### Help from the console

Getting help from the console is straightforward and can be done numerous ways.


```r
#Using the help command/shortcut
#When you know the name of a function
help("print") #Help on the print command
?print #Help on the print command using the `?` shortcut

#When you know the name of the package
help(package="dplyr") #Help on the package `dplyr`

#Don't know the exact name or just part of it
apropos("print") #Returns all available functions with "print" in the name
??print #Shortcut, but also searches demos and vignettes in a formatted page
```

### Official R Resources

In addition to help from within R itself, CRAN and the R-Project have many resources available for support.  Two of the most notable are the mailing lists and the [task views](http://cran.r-project.org/web/views/).

- [R Help Mailing List](https://stat.ethz.ch/mailman/listinfo/r-help): The main mailing list for R help.  Can be a bit daunting and some (although not most) senior folks can be, um, curmudgeonly...
- [R-sig-ecology](https://stat.ethz.ch/mailman/listinfo/r-sig-ecology): A special interest group for use of R in ecology.  Less daunting the the main help with participation from some big names in ecological modelling and statistics (e.g., Ben Bolker, Gavin Simpson, and Phil Dixon).  One of the moderators is great, the other is a bit of a jerk (it's me).
- [Environmetrics Task View](http://cran.r-project.org/web/views/Environmetrics.html): Task views are great in that they provide an annotated list of packages relevant to a particular field.  This one is maintained by Gavin Simpson and has great info on packages relevant to much of the work at EPA.
- [Spatial Analysis Task View](http://cran.r-project.org/web/views/Spatial.html): One I use a lot that lists all the relevant packages for spatial analysis, GIS, and Remote Sensing in R. 

### Google and StackOverflow

While the resources already mentioned are useful, often the quickest way is to just turn to Google.  However, a search for "R" is a bit challenging.  A few ways around this.  Google works great if you search for a given package or function name.  You can search for mailing lists directly (i.e. "R-sig-geo").  An R specific search tool, [RSeek.org](http://www.rseek.org/), has been created to facilitate this.  

One specific resource that I use quite a bit is [StackOverflow with the 'r' tag](http://stackoverflow.com/questions/tagged/r).  StackOverflow is a discussion forum for all things related to programming.  You can then use this tag and the search functions in StackOverflow and find answers to almost anything you can think of.

### Other Resources

As I mentioned earlier, there are TOO many resources to mention and everyone has their favorites.  Below are just a few that I like.

- [R For Data Science](http://r4ds.had.co.nz/): Another book by Hadley and Garrett Grolemund.  First reference I suggest for new (and experienced) R Learners, especially for all things Tidy.
- [Advanced R](http://adv-r.had.co.nz/): Web home of Hadley Wickham's new book.  Gets into more advanced topics, but also covers the basics in a great way.
- [Swirl](https://swirlstats.com/): Self-paced lessons to learn R, in R...
- [RStudio Beginners](https://education.rstudio.com/learn/beginner/): There are many great resources from RStudio.  This is the beginners link, but look around for more.
- [R For Cats](http://rforcats.net/): Basic introduction site, meant to be a gentle and light-hearted introduction.
- [CRAN Cheatsheets](http://cran.r-project.org/doc/contrib/Short-refcard.pdf): A good cheat sheet from the official source
- [RStudio Cheatsheets](http://www.rstudio.com/resources/cheatsheets/): Additional cheat sheets from RStudio.  I am especially fond of the data wrangling one.


## Homework 2.1

Start up the class project that we created last class, `nerrs_intro_r` and open up the `nerrs_analysis.R` file.  

Take a look at this file and find the following:

1. Find the `read_csv()` function.  What lines is it on?  What is the name of the argument in this function and what is the value that we have assigned to that argument?
2. Now find the lines on which you think we install packages and load up our packages for your use.  The installation is fancier than it needs to be, but loading the packages is pretty standard.  In your own words, what do you think each of these lines is telling R to do.
3. Add a line of code after line 25 (or so) to install the package `lubridate`.  Add a line after line 36 (or so) to load `lubridate`.
5. Bring up the package level help for the `lubridate` package.  What does this package do?

Be prepared to answer these questions when we meet next time.  If you run into problems, I am available via Teams to help out.  Just send me an email.
