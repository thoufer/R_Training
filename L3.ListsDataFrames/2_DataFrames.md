# Data frames

Data frames are the workhorse object in R, and where we will begin to slow down a bit, and spend some time understanding how to work with them.  It's also at this point that we will begin to introduce more functionality of the R language.

## Basic Syntax
Data frames are constructed using the `data.frame()` command. Construction is similar to lists, in that one spcifes the column name followed by a vector of values for each colum.

```rconsole 
> my_df <- data.frame(col1 = c(1,5,6,7,8), 
> col2 = c('apples','pears','kiwi','bannana', 'strawberries'),
> col3 = c(1.89,1.99,0.50,0.49, 2.24))
```
As ususal, we can print the data frame by typing the object name at the prompt.

However, in practice, I find that I rarely create data frames by hand.  In just about all cases data frames are created directly from reading files or database calls.

Rather than manually creating a data.frame with lots of values, were going to use a dataset that comes baked into R.  The dataset contains information extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models; \[`?mtcars`\]). The dataset is loaded using

```rconsole
> data(mtcars)
```
If all went well, nothing happened, and you simply were returned to a commmand prompt. However, we can see that a new object exists in the workspace called mtcars using the `ls()` command. Simply issuing

```rconsole
> mtcars
```
will print the data set. Notice that it looks more like a traditional table that were used to seeing in excel or SAS. While this dataset only has 32 observations, what if it had 1,000's?  Viewing the entire dataset on one screen would be impossible.  R has a couple of functions that allow us to "peek" a the data to develop an understanding of its contents.  These commands are `head()` and `tail()`.  `head` will display the first 6 rows of the dataset, and `tail` will display the last 6 rows. Why two commands?  This helps if the data are sorted.

```rconsole
> head(mtcars)
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
> tail(mtcars)
               mpg cyl  disp  hp drat    wt qsec vs am gear carb
Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.7  0  1    5    2
Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.9  1  1    5    2
Ford Pantera L 15.8   8 351.0 264 4.22 3.170 14.5  0  1    5    4
Ferrari Dino   19.7   6 145.0 175 3.62 2.770 15.5  0  1    5    6
Maserati Bora  15.0   8 301.0 335 3.54 3.570 14.6  0  1    5    8
Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.6  1  1    4    2
> 
```
Six rows is the default number that the command displays. However, if this isn't enough each command takes and additional argument for the number of rows to display.

```rconosle
> head(mtcars, 10)
```

There are a couple of additional commands that allow us to get an undestanding of the contents of a data frame.  One particularly useful command is `str()`.  This command returns a summary of the structure of a data frame.  Executing this on the mtcars data frame, we get the following;

```rconsole
> str(mtcars)
'data.frame':	32 obs. of  11 variables:
 $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
 $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
 $ disp: num  160 160 108 258 360 ...
 $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
 $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
 $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
 $ qsec: num  16.5 17 18.6 19.4 17 ...
 $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
 $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
 $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
 $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```
`str()` can be run on any object.  In this case, the return is telling us that the oject is a data frame with 32 rows, and 11 columns.  It also tells us the column name and type, as well as a sample values.  Where this comand comes in handy is when functions return errors from specific obeject. In some cases errors occur becuase the function is looking for a list and you passed it a vector, or the input must be must be different than the object (i.e., numeric vs. character).

The last command that people fund useful is `summary()`. This returns a mathamatical summary which describes the distrubtion of data for each column in the dataset. 

```rconsole
> summary(mtcars)
      mpg             cyl             disp             hp             drat             wt             qsec             vs               am        
 Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0   Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :19.20   Median :6.000   Median :196.3   Median :123.0   Median :3.695   Median :3.325   Median :17.71   Median :0.0000   Median :0.0000  
 Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7   Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375   Mean   :0.4062  
 3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0   Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000   Max.   :1.0000  
      gear            carb      
 Min.   :3.000   Min.   :1.000  
 1st Qu.:3.000   1st Qu.:2.000  
 Median :4.000   Median :2.000  
 Mean   :3.688   Mean   :2.812  
 3rd Qu.:4.000   3rd Qu.:4.000  
 Max.   :5.000   Max.   :8.000  
```

## Row/Column referencing
Selecting particular rows from a data frame, works similar to arrays.  We can select a particular row using 

```rconsole
> mtcars[5,]
```
which will return the 5th row, and all of the colums.  If we desire to see all of the rows and a few columns, we can perfrom that via

```rconsole
> mtcars[, c(1,3,6)]
```
This will display all of the rows and columns 1,3, and 5. While this is quick and simple, its not very clear for other users who might read your code. We can improve readability and accomplish the same thing using

```rconsole
> mtcars[, c("mpg","disp","wt")]
```

In R, data frame columns are stored in the order in which they were created. This isn't a problem, however, some people what the columns in a particular order.  This question can be approached with 2 answers: 1) change the order in which columns are displayed (i.e., temporary), or 2.) change the order in which the columns are stored (permenant).

Print different column order
```rconsole
> mtcars[,c('wt', 'mpg', 'disp')]
```
To store the data frame in its new order, we simply assign it to an object with a new name, or store it back to itself.

## Sorting
We saw in the vector lesson, that we could sort vector in ascending or decending order, using the `sort()` command. Unfortunalty, this command is limited to vectors, and data frames use a slightly different approach. This function is called `order()`. If we wanted to order the mtcars data frame by mpg of each vehicle we would use the following;

```rconsole
> mtcars[order(mtcars$mpg),]
```
Let's stop for a moment and think about what is occuring above.  Currently, mtcars data frame is not sorted, and thus the rows are ordered sequentially from 1:32. The `order(mtcars$mpg)` are taking the values in the mpg column, sorting them in asecending order and returning the new **position** or location of that value. We can see this by
```rconsole
> order(mtcars$mpg)
 [1] 15 16 24  7 17 31 14 23 22 29 12 13 11  6  5 10 25 30  1  2  4 32 21  3  9
[26]  8 27 26 19 28 18 20
```
So, the value that was originally in "row" or position 15 is now at poisition 1, and 16 has moved to 2, etc. By embeding this within a call to the data frame (e.g.,`mtcars[,]`), it prints new order. By adding additional columns to the order function we can sort on multiple columns.
 
```rconsole
> mtcars[order(mtcars$gear, mtcars$hp),]
```
So, why wouldn't sort work here? The difference between `sort()` and `order()` is that sort returns the order _values_ while order returns the ordered _position index_.

Finally, we can use our knowledge so far and print the mtcars data frame that is order by the number of gears, and horsepower, but limit printing to just those columns.

```rconsole
> mtcars[order(mtcars$gear, mtcars$hp), c('gear','hp')]
```
## Appending Additional data
### Adding additional rows or columns
Adding data to dataframes is done using the same functions to add rows/columns to matricies, `rbind()` and `cbind()`. In the following example, we create a data frame, add a new column and then add a new row.

```rconsole
> df <- data.frame(colA= rep(1,4), colB = rnorm(4))
> df_add_col <- cbind(df, colC = rep(c('Treatment', 'Control'),2))
> df_add_row <- rbind(df_add_col, data.frame(colA =5, colB= 1, colC='Control'))
```
Note that when adding rows that we are adding "rows" to a data frame that the additional rows are also of the data.frame object type.

1. Add this additional row to the above data frame; `data.frame(6, 0.5, 'Treatment')`. Did it work? 
2. Add a second row to the above data frame; `c(6, 0.5, 'Treatment')`. Did it work? Is the data frame different? if so how is it different? (Hint: use `str()`)

### Merging 2 data frames
Merging or joining 2 data frames is a very common operation for the nature of work we do and completed with the `merge()` command. Assume that we have a data frame that contains wing parts, and there is a column that contains the 3 number code for flyway and state.  Our challenge is to subset the data to just wing parts reported from NY.  One solution would be to lookup what the state number for NY is and then subset.  However, if we had and addtional data frame that contained 2 columns; the 3 digit code and the 2 letter abbreviation we could merge them and then subset on 'NY'.

Using pseudo code this task would be accomplished using;

```rconsole
> merge(parts, state_code, by.x= 'state_code', by.y='state_code')
```

The arguments by.x and by.y, specify those columns in which R will do the join on.  There can be more than one column specified, and their names do not need to be identical. 

At this point we need to pause, and explain join operations. When joining 2 data frames, R can return 3 sets of data that might result from that operation.  We'll use the following image to explain these (from [http://www.dofactory.com/sql/join](http://www.dofactory.com/sql/join))

[![Join types](sql-joins.png)]
  
This question appeared on [Stack Overflow](http://stackoverflow.com/questions/1299871/how-to-join-merge-data-frames-inner-outer-left-right), and the answer was described with excellent detail.

Assume you have the 2 data frames below. How can the merge command be used to accomplish the above join types.

```rconsole
df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

df1
#  CustomerId Product
#           1 Toaster
#           2 Toaster
#           3 Toaster
#           4   Radio
#           5   Radio
#           6   Radio

df2
#  CustomerId   State
#           2 Alabama
#           4 Alabama
#           6    Ohio
```
The various join types are accomplished by using optional arguments specified in the merge command.

**Inner join:** merge(df1, df2) will work for these examples because R automatically joins the frames by common variable names, but you would most likely want to specify merge(df1, df2, by = "CustomerId") to make sure that you were matching on only the fields you desired. You can also use the by.x and by.y parameters if the matching variables have different names in the different data frames.

**full Outer join:** merge(x = df1, y = df2, by = "CustomerId", all = TRUE)

**Left outer:** merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)

**Right outer:** merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)

**Cross join:** merge(x = df1, y = df2, by = NULL)

The answer included a join type not shown in the image; the cross join.  The cross join, creates a data frame that contains all possible row combinations of the 2 data frames.

## Filter or Subsetting
Generally, when working with data frames there is a need to filter or subset the data.  As R has been developed, people have started to think about data in different ways, and thus have developed new methods to slice and dice data.  I will show you 2 ways in which to subset data that are part of the base R functionality. However, if you find these unintuitive I would suggest you look at methods including in the dplyr and data.table pacakges.

R comes with another dataset called airquality, which are daily air quality measurements in New York, May to September 1973 (`?airquality`).  
```rconsole
> data(airquality)
```
Let's subset this dataset to show only rows where the daily temperature was greater than 80 degrees.
```rconsole
> airquality[airquality$Temp > 80, ]
    Ozone Solar.R Wind Temp Month Day
29     45     252 14.9   81     5  29
35     NA     186  9.2   84     6   4
36     NA     220  8.6   85     6   5
38     29     127  9.7   82     6   7
39     NA     273  6.9   87     6   8
40     71     291 13.8   90     6   9
41     39     323 11.5   87     6  10
42     NA     259 10.9   93     6  11
43     NA     250  9.2   92     6  12
44     23     148  8.0   82     6  13
61     NA     138  8.0   83     6  30
62    135     269  4.1   84     7   1
63     49     248  9.2   85     7   2
64     32     236  9.2   81     7   3
65     NA     101 10.9   84     7   4
66     64     175  4.6   83     7   5
67     40     314 10.9   83     7   6
68     77     276  5.1   88     7   7
69     97     267  6.3   92     7   8
70     97     272  5.7   92     7   9
71     85     175  7.4   89     7  10
72     NA     139  8.6   82     7  11
74     27     175 14.9   81     7  13
75     NA     291 14.9   91     7  14
77     48     260  6.9   81     7  16
78     35     274 10.3   82     7  17
79     61     285  6.3   84     7  18
80     79     187  5.1   87     7  19
81     63     220 11.5   85     7  20
83     NA     258  9.7   81     7  22
84     NA     295 11.5   82     7  23
85     80     294  8.6   86     7  24
86    108     223  8.0   85     7  25
87     20      81  8.6   82     7  26
88     52      82 12.0   86     7  27
89     82     213  7.4   88     7  28
90     50     275  7.4   86     7  29
91     64     253  7.4   83     7  30
92     59     254  9.2   81     7  31
93     39      83  6.9   81     8   1
94      9      24 13.8   81     8   2
95     16      77  7.4   82     8   3
96     78      NA  6.9   86     8   4
97     35      NA  7.4   85     8   5
98     66      NA  4.6   87     8   6
99    122     255  4.0   89     8   7
100    89     229 10.3   90     8   8
101   110     207  8.0   90     8   9
102    NA     222  8.6   92     8  10
103    NA     137 11.5   86     8  11
104    44     192 11.5   86     8  12
105    28     273 11.5   82     8  13
117   168     238  3.4   81     8  25
118    73     215  8.0   86     8  26
119    NA     153  5.7   88     8  27
120    76     203  9.7   97     8  28
121   118     225  2.3   94     8  29
122    84     237  6.3   96     8  30
123    85     188  6.3   94     8  31
124    96     167  6.9   91     9   1
125    78     197  5.1   92     9   2
126    73     183  2.8   93     9   3
127    91     189  4.6   93     9   4
128    47      95  7.4   87     9   5
129    32      92 15.5   84     9   6
134    44     236 14.9   81     9  11
143    16     201  8.0   82     9  20
146    36     139 10.3   81     9  23
```
The way to interpret this command is think about it in these terms. Within the airquality data frame, show me all column and specific rows where the values in the Temp column are greater than 80 degrees.

What if we wanted to see only those rows where the daily Temperature exceeded 80 degrees in May.

```rconsole
> airquality[airquality$Temp > 80 & airquality$Month == 5, ]
   Ozone Solar.R Wind Temp Month Day
29    45     252 14.9   81     5  29
```
Notice here that we specified the Month of May using `==`.  This is the "equals" operator. Using `=` would result in an error becuase R understand `=` to assign the value to some object. Try running the above command with `=` rather than `==` to see the error message.  So, based on the above we could subset this data using any combination of columns and values for greater than (>), greater than or equal to (>=), less than (<), less than or equal to (<=), and equals.  What about where we want only those values in a range, say Temperature between 70 and 80 degrees in May?  Well this isn't too difficult.

```rconsole
airquality[airquality$Temp > 70 & airquality$Temp < 80 & airquality$Month == 5, ]
   Ozone Solar.R Wind Temp Month Day
2     36     118  8.0   72     5   2
3     12     149 12.6   74     5   3
11     7      NA  6.9   74     5  11
22    11     320 16.6   73     5  22
30   115     223  5.7   79     5  30
31    37     279  7.4   76     5  31
```
However, if we has a lot of ranges this typing could become tedious.  For these cases R provides us with a shortcut, the `%in%` operator.  We can accomplish the same thing above using;

```rconsole
> airquality[airquality$Temp %in% c(70:80) & airquality$Month == 5, ]
   Ozone Solar.R Wind Temp Month Day
2     36     118  8.0   72     5   2
3     12     149 12.6   74     5   3
11     7      NA  6.9   74     5  11
22    11     320 16.6   73     5  22
30   115     223  5.7   79     5  30
31    37     279  7.4   76     5  31
```

The `%in%` operator is telling R to return values in the temperature collumn that occur in the vector that follows. Thus, were not limited to a continuous range. For instance, we can subset to rows days where with temperature values **equaled** of 70, 75, or 80;

```rconsole
> airquality[airquality$Temp %in% c(70,75,80),]
    Ozone Solar.R Wind Temp Month Day
45     NA     332 13.8   80     6  14
56     NA     135  8.0   75     6  25
59     NA      98 11.5   80     6  28
76      7      48 14.3   80     7  15
106    65     157  9.7   80     8  14
115    NA     255 12.6   75     8  23
130    20     252 10.9   80     9   7
132    21     230 10.9   75     9   9
149    30     193  6.9   70     9  26
151    14     191 14.3   75     9  28
```
So far, we've been connecting statement with the and `&` operator.  There is also an or `|` operator.  It functions in a similar manner.  The code below returns rows where the temperature is between 70 and 80 degrees in May or August.


```rconsole
> airquality[airquality$Temp %in% c(70:80) & airquality$Month == 5 | airquality$Month == 7, ]
   Ozone Solar.R Wind Temp Month Day
2     36     118  8.0   72     5   2
3     12     149 12.6   74     5   3
11     7      NA  6.9   74     5  11
22    11     320 16.6   73     5  22
30   115     223  5.7   79     5  30
31    37     279  7.4   76     5  31
62   135     269  4.1   84     7   1
63    49     248  9.2   85     7   2
64    32     236  9.2   81     7   3
65    NA     101 10.9   84     7   4
66    64     175  4.6   83     7   5
67    40     314 10.9   83     7   6
68    77     276  5.1   88     7   7
69    97     267  6.3   92     7   8
70    97     272  5.7   92     7   9
71    85     175  7.4   89     7  10
72    NA     139  8.6   82     7  11
73    10     264 14.3   73     7  12
74    27     175 14.9   81     7  13
75    NA     291 14.9   91     7  14
76     7      48 14.3   80     7  15
77    48     260  6.9   81     7  16
78    35     274 10.3   82     7  17
79    61     285  6.3   84     7  18
80    79     187  5.1   87     7  19
81    63     220 11.5   85     7  20
82    16       7  6.9   74     7  21
83    NA     258  9.7   81     7  22
84    NA     295 11.5   82     7  23
85    80     294  8.6   86     7  24
86   108     223  8.0   85     7  25
87    20      81  8.6   82     7  26
88    52      82 12.0   86     7  27
89    82     213  7.4   88     7  28
90    50     275  7.4   86     7  29
91    64     253  7.4   83     7  30
92    59     254  9.2   81     7  31
```

For me, this is the most straight forward way of subsetting data. However, if you find this non-intuitive, R provides a `subset()` function.  The function can take 3 arguments `subset(data.frame, conditions, columns_to_return)`. Repeating a few of the above conditions using the subset function follow;

```rconsole
> subset(airquality, Temp > 80 & Month == 5)
   Ozone Solar.R Wind Temp Month Day
29    45     252 14.9   81     5  29
>
> subset(airquality, Temp %in% c(70:80) & Month == 5)
   Ozone Solar.R Wind Temp Month Day
2     36     118  8.0   72     5   2
3     12     149 12.6   74     5   3
11     7      NA  6.9   74     5  11
22    11     320 16.6   73     5  22
30   115     223  5.7   79     5  30
31    37     279  7.4   76     5  31
> 
```

## Frequency Tables
On occassion we just want an understanding of the frequency of observations of a particular type within a data set. There are 2 functions that are .. `table()`, and `xtabs()`.  In the following example I want to know the number of vehicles of each cylinder type, and manufacturer evaluated by Motor Trend Magazine. Since the Car manufacturer is contained in the row name along with the model, it needs to be stripped out before we can calculate the frequencies.


```rconsole
> data(mtcars)
>  table(mtcars$cyl) # How many observations of each cylinder type
>
> # use advanced code to strip out manufacturer
> split_names <- strsplit(rownames(mtcars),' ')  # split each string element where ever a space occurs
> man <- sapply(split_names, function(lst){ lst[1]}, simplify=TRUE) # return just manufacturer, always first element.
> mtcars2 <- cbind(mtcars, Manufac = man, stringsAsFactors = FALSE)
> table(mtcars2$Manufac, mtcars2$cyl)
```
We can perform the an identical frequency using `xtabs()`.  The difference between the 2 is that xtabs uses a formula notation for specifying the desired output.

```rconsole
> xtabs(~ Manufac + cyl, data=mtcars2)
```

Just as an aside we will be covering the `strsplit()` which allows us to slice and dice character strings as needed, as well as the `sapply()` function which is an iteration function.

These functions, in conjunction with other functions can be used to summarize data in interesting ways.  The best suggestion here is to look at, run, the examples in the help files for xtabs and table (`?xtabs` and `?table`)

