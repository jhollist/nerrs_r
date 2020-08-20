

# Tidy Data in R

In this lesson we will cover the basics of data in R and will do so from a somewhat opinionated viewpoint of "Tidy Data".  There are other paradigms and other ways to work with data in R, but focusing on Tidy Data concepts and tools (a.k.a., The Tidyverse) gets people to a productive place the quickest.  For more on data analysis using the Tidyverse, the best resource I know of is [R for Data Science](http://r4ds.had.co.nz).  The approaches we will cover are very much inspired by this book.

## Lesson Outline
- [Tidy data](#tidy-data)

## Exercises
- [Exercise 3.2](#exercise-32)
- [Exercise 3.3](#exercise-33)

## Tidy data

We have learned about data frames, how to create them, and about several ways to read in external data into a data.frame.   At this point there have been only a few rules applied to our data frames (which already separates them from spreadsheets) and that is our datasets must be rectangular.  Beyond that we haven't disscussed how best to organize that data so that subsequent analyses are easier to accomplish. This is, in my opinion, the biggest decision we make as data analysts and it takes a lot of time to think about how best to organize data and to actually re-organize that data.  Luckily, we can use an existing concept for this that will help guide our decisions and re-organization.  The best concept I know of to do this is the concept of [tidy data](http://r4ds.had.co.nz/tidy-data.html).  The essence of which can be summed up as:

1. Each column is a variable
2. Each row is an observation
3. Each cell has a single value
4. The data must be rectangular

Lastly, if you want to read more about this there are several good sources:

- The previously linked R4DS Chapter on [tidy data](http://r4ds.had.co.nz/tidy-data.html)
- The [original paper by Hadley Wickham](https://www.jstatsoft.org/article/view/v059i10)
- The [Tidy Data Vignette](http://tidyr.tidyverse.org/articles/tidy-data.html)
- Really anything on the [Tidyverse page](https://www.tidyverse.org/)
- A lot of what is in the [Data Carpentry Ecology Spreadsheet Lesson](https://datacarpentry.org/spreadsheet-ecology-lesson/) is also very relevant.

Let's now see some of the basic tools for tidying data using the `tidyr` and `dplyr` packages.

### Data manipulation with `dplyr`

There are a lot of different ways to manipulate data in R, but one that is part of the core of the Tidyverse is `dplyr`.  In particular, we are going to look at selecting columns, filtering data, adding new columns, grouping data, and summarizing data.  

#### select

Often we get datasets that have many columns or columns that need to be re-ordered.  We can accomplish both of these with `select`.  Here's a quick example with the `iris` dataset.  We will also be introducing the concept of the pipe: `%>%` which we will be using going forward.  Let's look at some code that we can disect.


```r
iris_petals <- iris %>%
  select(Species, Petal.Width, Petal.Length) %>%
  as_tibble() #the as_tibble function helps make the output look nice
iris_petals
```

```
## # A tibble: 150 x 3
##    Species Petal.Width Petal.Length
##    <fct>         <dbl>        <dbl>
##  1 setosa          0.2          1.4
##  2 setosa          0.2          1.4
##  3 setosa          0.2          1.3
##  4 setosa          0.2          1.5
##  5 setosa          0.2          1.4
##  6 setosa          0.4          1.7
##  7 setosa          0.3          1.4
##  8 setosa          0.2          1.5
##  9 setosa          0.2          1.4
## 10 setosa          0.1          1.5
## # ... with 140 more rows
```

The end result of this is a data frame, `iris_petals` that has three columns: Species, Petal.Width and Petal.Length in the order that we specified.  And the syntax we are now using is "piped" in that we use the `%>%` operator to send something from before the operator (a.k.a. "to the left") to the first argument of the function after the operator (a.k.a. "to the right").  This allows us to write our code in the same order as we think of it.  The best explanation of this is (again) from R For Data Science in the [Piping chapter](http://r4ds.had.co.nz/pipes.html).

#### filter

The `filter()` function allows us to fiter our data that meets certain criteria.  For instance, we might want to further manipulate our 3 column data frame with only one species of Iris and Petals greater than the median petal width.


```r
iris_petals_virginica <- iris %>%
  select(species = Species, petal_width = Petal.Width, petal_length = Petal.Length) %>%
  filter(species == "virginica") %>%
  filter(petal_width >= median(petal_width)) %>%
  as_tibble()
iris_petals_virginica  
```

```
## # A tibble: 29 x 3
##    species   petal_width petal_length
##    <fct>           <dbl>        <dbl>
##  1 virginica         2.5          6  
##  2 virginica         2.1          5.9
##  3 virginica         2.2          5.8
##  4 virginica         2.1          6.6
##  5 virginica         2.5          6.1
##  6 virginica         2            5.1
##  7 virginica         2.1          5.5
##  8 virginica         2            5  
##  9 virginica         2.4          5.1
## 10 virginica         2.3          5.3
## # ... with 19 more rows
```

#### mutate

Now say we have some research that suggest the ratio of the petal width and petal length is imporant.  We might want to add that as a new column in our data set.  The `mutate` function does this for us.


```r
iris_petals_ratio <- iris %>%
  select(species = Species, petal_width = Petal.Width, petal_length = Petal.Length) %>%
  mutate(petal_ratio = petal_width/petal_length) %>%
  as_tibble()
iris_petals_ratio
```

```
## # A tibble: 150 x 4
##    species petal_width petal_length petal_ratio
##    <fct>         <dbl>        <dbl>       <dbl>
##  1 setosa          0.2          1.4      0.143 
##  2 setosa          0.2          1.4      0.143 
##  3 setosa          0.2          1.3      0.154 
##  4 setosa          0.2          1.5      0.133 
##  5 setosa          0.2          1.4      0.143 
##  6 setosa          0.4          1.7      0.235 
##  7 setosa          0.3          1.4      0.214 
##  8 setosa          0.2          1.5      0.133 
##  9 setosa          0.2          1.4      0.143 
## 10 setosa          0.1          1.5      0.0667
## # ... with 140 more rows
```

## Exercise 3.2

For this exercise we will dig into our datasets and find ways to tidy them up.  We first need to clean up the new data frame,`nla_sites`, that we loaded up in Exercise 3.1.  Add new lines of code after the section of code that cleans up the `nla_wq` data frame. Add some comments to your script that describe what we are doing.  

1. Filter out just the first visits (e.g. VISIT_NO equal to 1)
2. Select the following columns: SITE_ID, STATE_NAME, and CNTYNAME
3. Make all of our columns names lower case (Hint: Take a look at the code in nla_analysis.R where we manipulate our data)
4. Make all the character fields lower case (Hint: Take a look at the code in nla_analysis.R where we manipulate our data)
5. Keep all these changes in the `nla_sites` data frame.

#### group_by and summarize

Now back to iris.  What if we want to get some summary statistics of our important petal ratio metric for each of the species?  Grouping the data by species, and then summarizing those groupings will let us accomplish this.


```r
iris_petal_ratio_species <- iris %>%
  select(species = Species, petal_width = Petal.Width, petal_length = Petal.Length) %>%
  mutate(petal_ratio = petal_width/petal_length) %>%
  group_by(species) %>%
  summarize(mean_petal_ratio = mean(petal_ratio),
            sd_petal_ratio = sd(petal_ratio),
            median_petal_ratio = median(petal_ratio))
iris_petal_ratio_species
```

```
## # A tibble: 3 x 4
##   species    mean_petal_ratio sd_petal_ratio median_petal_ratio
##   <fct>                 <dbl>          <dbl>              <dbl>
## 1 setosa                0.168         0.0658              0.143
## 2 versicolor            0.311         0.0292              0.309
## 3 virginica             0.367         0.0502              0.375
```

#### left_join

Lastly, we might also have information spread across multiple data frames.  This is the same concept as having multiple tables in a relational database.  There are MANY ways to combine (aka. "join) tables like this and most of them have a `dplyr` verb implemented for them.  We are going to focus on one, the `left_join()`.

Instead of continuing with the `iris` data we will create some data frames to work with for these examples.


```r
left_table <- data.frame(left_id = 1:6, 
                         names = c("Bob", "Sue", "Jeff", "Alice", "Joe", "Betty"))
right_table <- data.frame(right_id = 1:5, 
                          left_id = c(2,1,3,6,7), 
                          age = c(17,26,45,32,6)) 
left_table
```

```
##   left_id names
## 1       1   Bob
## 2       2   Sue
## 3       3  Jeff
## 4       4 Alice
## 5       5   Joe
## 6       6 Betty
```

```r
right_table
```

```
##   right_id left_id age
## 1        1       2  17
## 2        2       1  26
## 3        3       3  45
## 4        4       6  32
## 5        5       7   6
```

To combine these two tables into one we can `join` them.  In particular we will use a `left_join()` which keeps all records from the first table (i.e the "left" table) and adds only the matching records in the second table (i.e. the "right" table).  This is easier to grok by looking at the results.


```r
left_right_table <- left_table %>%
  left_join(right_table, by = c("left_id" = "left_id"))
left_right_table
```

```
##   left_id names right_id age
## 1       1   Bob        2  26
## 2       2   Sue        1  17
## 3       3  Jeff        3  45
## 4       4 Alice       NA  NA
## 5       5   Joe       NA  NA
## 6       6 Betty        4  32
```

## Exercise 3.3

Let's now practice combining two data frames and summarizing some information in that combine data frame. We are still working on the `nla_analysis.R` script and you can add this code after that section we just completed on `nla_sites`.  Don't forget your comments!

1. Use `left_join()` to combine `nla_wq` and `nla_sites` into a new data frame called `nla_2007`
2. Using `group_by()` and `summarize`, let's look at median chlorophyll per EPA Region. (Hint: There are some NA's that we will need to deal with.  Use `?median` and try to figure out how to remove those when doing this calculation)
3. Re-do the above and include the minimum and maximum values.
4. Bonus: Use `arrange() to order the output by mean chlorophyll.
  
