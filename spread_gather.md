

### Spread and Gather with `tidyr`
So far we have seen how to do some manipulation of the data, but we didn't really do too much with the structure of that data frame.  In some cases we might need to have data that are stored in rows, as columns or vice-versa.  Two of the function I use the most in `tidyr`, `spread()` and `gather()`, will accomplish this for us.  They are somewhat similar to pivot tables in spreadsheets and allow us combine columns together or spread them back out.  I'll admit it still sometimes feels a bit like magic.  So, abracadabra!

Load up the library:


```r
library(tidyr)
```

#### gather

Let's build an untidy data frame.  This is made up, but let's say we want to grab some monthly stats on some variable (e.g., average number of Boston Red Sox Hats, in thousands) per state. This time we will use the `tibble` function.  This is similar to `data.frame` but it makes good assumptions about the data and has some nice display options built in.  It comes from the `dplyr` package. 


```r
dirty_df <- tibble(state = c("CT","RI","MA"), jan = c(3.1,8.9,9.3), feb = c(1.0,4.2,8.6), march = c(2.9,3.1,12.5), april = c(4.4,5.6,14.2))
dirty_df
```

```
## # A tibble: 3 x 5
##   state   jan   feb march april
##   <chr> <dbl> <dbl> <dbl> <dbl>
## 1 CT      3.1   1     2.9   4.4
## 2 RI      8.9   4.2   3.1   5.6
## 3 MA      9.3   8.6  12.5  14.2
```

What would be a tidy way to represent this same data set?

They way I would do this is to gather the month columns into two new columns that represent month and number of visitors.


```r
tidy_df <- gather(dirty_df, month, vistors, jan:april) 
tidy_df
```

```
## # A tibble: 12 x 3
##    state month vistors
##    <chr> <chr>   <dbl>
##  1 CT    jan       3.1
##  2 RI    jan       8.9
##  3 MA    jan       9.3
##  4 CT    feb       1  
##  5 RI    feb       4.2
##  6 MA    feb       8.6
##  7 CT    march     2.9
##  8 RI    march     3.1
##  9 MA    march    12.5
## 10 CT    april     4.4
## 11 RI    april     5.6
## 12 MA    april    14.2
```

#### spread

Here's another possibility from a water quality example.  We have data collected at multiple sampling locations and we are measuring multiple water quality parameters.


```r
long_df <- data_frame(station = rep(c("A","A","B","B"),3), 
                      month = c(rep("june",4),rep("july",4),rep("aug", 4)), 
                      parameter = rep(c("chla","temp"), 6),
                      value = c(18,23,3,22,19.5,24,3.5,22.25,32,26.7,4.2,23))
long_df
```

```
## # A tibble: 12 x 4
##    station month parameter value
##    <chr>   <chr> <chr>     <dbl>
##  1 A       june  chla       18  
##  2 A       june  temp       23  
##  3 B       june  chla        3  
##  4 B       june  temp       22  
##  5 A       july  chla       19.5
##  6 A       july  temp       24  
##  7 B       july  chla        3.5
##  8 B       july  temp       22.2
##  9 A       aug   chla       32  
## 10 A       aug   temp       26.7
## 11 B       aug   chla        4.2
## 12 B       aug   temp       23
```

We might want to have this in a wide as opposed to long format.  That can be accomplished with `spread()`


```r
wide_df <- spread(long_df,parameter,value)
wide_df
```

```
## # A tibble: 6 x 4
##   station month  chla  temp
##   <chr>   <chr> <dbl> <dbl>
## 1 A       aug    32    26.7
## 2 A       july   19.5  24  
## 3 A       june   18    23  
## 4 B       aug     4.2  23  
## 5 B       july    3.5  22.2
## 6 B       june    3    22
```

While these two simple examples showcase the general ideas, deciding on a given tidy structure for your data will depend on many things and the result will differ based on your task (i.e. data entry, visualization, modeling, etc.).  A couple of nice reads about this are:

- [Best Pracitces for Using Google Sheets in Your Data Project](https://matthewlincoln.net/2018/03/26/best-practices-for-using-google-sheets-in-your-data-project.html)
- And again, R4DS [Tidy Data Chapter](http://r4ds.had.co.nz/tidy.html)
