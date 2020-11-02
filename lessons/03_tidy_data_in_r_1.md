

# Tidy Data in R

In this lesson we will cover the basics of data in R and will do so from a somewhat opinionated viewpoint of "Tidy Data".  There are other paradigms and other ways to work with data in R, but focusing on Tidy Data concepts and tools (a.k.a., The Tidyverse) gets people to a productive place the quickest.  For more on data analysis using the Tidyverse, the best resource I know of is [R for Data Science](http://r4ds.had.co.nz).  The approaches we will cover are very much inspired by this book.

## Lesson Outline
- [Data in R: The data frame](#data-in-r-the-data-frame)
- [Reading in data](#reading-in-data)

## Exercises
- [Homework.1](#homework-31)

## Data in R: The data frame

Simply put, a data structure is a way for programming languages to handle storing information.  Like most languages, R has several structures (vectors, matrix, lists, etc.).  But R was originally built for data analysis, so the data frame, a spreadsheet like structure with rows and columns, is the most widely used and useful to learn first.  In addition, the data frame (or is it data.frame) is the basis for many modern R pacakges (e.g. the tidyverse) and getting used to it will allow you to quickly build your R skills.

*Note:* It is useful to know more about the different data structures such as vectors, lists, and factors (a weird one that is for catergorical data).  But that is beyond what we have time for.  The best source on this information, I think, is Hadley Wickham's [Data Structures Chapter in Advanced R](http://adv-r.had.co.nz/Data-structures.html).  

*Another note:* Data types (e.g. numeric, character, logcial, etc.) are important to know about too, but details are more than we have time for.  Take a look at the chapter on vectors in R for Data Science, in particular [Section 20.3](https://r4ds.had.co.nz/vectors.html#important-types-of-atomic-vector).  

*And, yet another note:* Computers aren't very good at math.  Or at least they don't deal with floating point data they way many would think.  First, any value that is not an integer, is considered a "Double."  These are approximations, so if we are looking to compare to doubles, we might not always get the result we are expecting.   Again, R4DS is a great read on this: [Section on Numeric Vectors](https://r4ds.had.co.nz/vectors.html#numeric).  But also see [this take from Revolution Analytics](https://blog.revolutionanalytics.com/2009/11/floatingpoint-errors-explained.html) and [techradar](https://www.techradar.com/news/computing/why-computers-suck-at-maths-644771/2). 

<details>
<summary>Does` 1.0 == 1.001`?</summary>
  

```r
1.0 == 1.001
```

```
## [1] FALSE
```

</details>  

<details>
<summary>Does` 1.0 == 1.0000000000000001`?</summary>
  

```r
1.0 == 1.0000000000000001
```

```
## [1] TRUE
```

</details>     
  

*Last note, I promise:* Your elementary education was wrong, at least about rounding. 

<details>
<summary>What do you get when you round `3.5`?</summary>
  

```r
round(3.5)
```

```
## [1] 4
```

</details>

<details>
<summary>What do you get when you round `2.5`?</summary>
  

```r
round(2.5)
```

```
## [1] 2
```

</details>

<details>
<summary>In other words...</summary>
In other words, if the last digit is a 5, and the digit we are rounding is even, the we round down. But, if the last digit is a 5, and the digit we around rounding is odd, the we round up. There are actually good reasons for this (think bias).  Read up on the IEEE 754 standard [rules on rounding](https://en.wikipedia.org/wiki/IEEE_754#Rounding_rules).  
</details>

### Build a data frame
Best way to learn what a data frame is is to look at one.  Let's now build a simple data frame from scratch with the `data.frame()` function.  This is mostly a teaching excercise as we will use the function very little in the excercises to come.  


```r
# Our first data frame

my_df <- data.frame(names = c("joe","jenny","bob","sue"), 
                    age = c(45, 27, 38,51), 
                    knows_r = c(FALSE, TRUE, TRUE,FALSE), 
                    stringsAsFactors = FALSE)
my_df
```

```
##   names age knows_r
## 1   joe  45   FALSE
## 2 jenny  27    TRUE
## 3   bob  38    TRUE
## 4   sue  51   FALSE
```

That created a data frame with 3 columns (names, age, knows_r) and four rows.  For each row we have some information on the name of an individual (stored as a character/string), their age (stored as a numeric value), and a column indicating if they know R or not (stored as a boolean/logical).

If you've worked with data before in a spreadsheet or from a table in a database, this rectangular structure should look somewhat familiar.   One way (there are many!) we can access the different parts of the data frame is like:


```r
# Use the dollar sign to get a column
my_df$age
```

```
## [1] 45 27 38 51
```

```r
# Grab a row with indexing
my_df[2,]
```

```
##   names age knows_r
## 2 jenny  27    TRUE
```

At this point, we have:

- built a data frame from scratch
- seen rows and columns
- heard about "rectangular" structure
- seen how to get a row and a column

The purpose of all this was to introduce the concept of the data frame.  Moving forward we will use other tools to read in data, but the end result will be the same: a data frame with rows (i.e. observations) and columns (i.e. variables).

## Reading in data

Completely creating a data frame from scratch is useful (especially when you start writing your own functions), but more often than not data is stored in an external file that you need to read into R.  These may be delimited text files, spreadsheets, relational databases, SAS files ...  You get the idea.  Instead of treating this subject exhaustively, we will focus just on a single file type, the `.csv` file, that is very commonly encountered and (usually) easy to create from other file types.  For this, we will use the Tidyverse way to do this and use  `read_csv()` from the `readr` pacakge.

The `read_csv()` function is a re-imagined version of the base R fucntion, `read.csv()`.  This command assumes a header row with column names and that the delimiter is a comma. The expected no data value is NA and by default, strings are NOT converted to factors.  This is a big benefit to using `read_csv()` as opposed to `read.csv()`.  Additionally, `read_csv()` has some performance enhancements that make it preferrable when working with larger data sets.  In my limited experience it is about 45% faster than the base R options.  For instance a ~200 MB file with hundreds of columns and a couple hundred thousand rows took ~14 seconds to read in with `read_csv()` and about 24 seconds with `read.csv()`.  As a comparison at 45 seconds Excel had only opened 25% of the file!

Source files for `read_csv()` can either be on a local hard drive or, and this is pretty cool, on the web. We will be using the former for our examples and exercises. If you had a file available from a URL it would be accessed like `mydf <- read.csv("https://example.com/my_cool_file.csv")`. As an aside, paths and the use of forward vs back slash is important. R is looking for forward slashes ("/"), or unix-like paths. You can use these in place of the back slash and be fine. You can use a back slash but it needs to be a double back slash ("\\\\"). This is becuase the single backslash in an escape character that is used to indicate things like newlines or tabs. 

For today's workshop we will focus on both grabbing data from a local file and from a URL, we already have an example of this in our `nerrs_analysis.R`.  In that file look for the line where we use `read_csv()`

For your convenience, it looks like:









