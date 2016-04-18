# Exporting Data or Objects to a File.
I can think of 2 reasons to print information to file.  In the first case, that information is data (i.e., an object) and you wnat to store that object outside of R, or that data was requested by someone, and their analysis software is unknown.  The second reason, is that we might want to write information to a file in a structured format for later reference.  

## Delimited files
Writing delimited files is simiar to reading delimited files.. The function is simply `write.table()`.  The function takes the object that you want to write to a file, the path and filename of the file to be created and the separator.

```rconsole
> write.table(mydata, "c:/mydata.txt", sep="\t")
```

For convienence, there is a function `write.csv()` for writing comma delimited files.  The one thing to be aware of when using these functions, is that by default it will write out row names as the first column.  If you have created custom row names, this is probably a must, however, most of the time the row name data is a number from 1:n and isn't necessary.  To supress output of the row names one must add the `row.names = FALSE` argument to the function call.

## Other Binary formats
R can output Binary formats too.  To output an object to an Excel Spreadsheet;

```rconsole
library(xlsx)
write.xlsx(mydata, "c:/mydata.xlsx")
```
By adding a sheetName you can output to a specific sheet in an existing workbook.  However, it doesn't appear that you can write information to a specific range of cells. If you need to write to other program formats like SPSS, minitab, SAS, consult the foreign library.

## Writing R objects to send to another R user.
On occassion, you might want to send data objects to someone that is also an R user.
Most of the time I would just use `save.image()` and send them everything.  However, depending on the the analysis these image files can be rather large (e.g., 100's of MB).  This can be particularly annoying if all they needed was a single object.

Developers created a function called `dput()` that writes an ASCII text representation of an R object to file.  This file can then be read in and object using `dget()`.

```rconsole
> dput(object, file='c:/mydatafile.rdata')
> new_object <- dget('c:/mydatafile.rdata')
```

If you need to send more than one object their is a function `dump()`.  Instead of taking a single object as input it takes a **list** of objects that are to be written to a file.

```rconsole
> # Write 3 object to a file.
> dump(list= list("obj1", "obj2", "obj3"), file = "dumpdata.R")
```

# Writing information to file
These functions are great for when you simply want to write data to a file. But what if we needed to write data to a file, but in a more structured way, or write multiple pieces of data to a file in an ordered fashion. Consider the Bayesian modeling typcially conducted by the program.  These models often take a long time to run and ducing that time we move on to other things. I might be worthwhile if at the end of the model run we wrote to a file the time it finished, the model file, how many chains, and iterations were run, and parameter estimates.  Anyone who has run these models know that this infomration is typcially stored in the return object from WinBUGS, OpenBUGS, or JAGS.  The problem is that power tends to be flaky, and if you forget and the model continues to run through a Wedneday night, IRTM will restart you computer irregardless if any updates are pushed or not.  It this occurs, anything stored in the R workspace would be lost.

A second case of this is to summarize information. Protocols for the annual waterfowl status report are such that in the crew area sections we report area estimates for the 10 species only if they are significantly different from last year or the LTA.  I wrote code that outputs for each crew area the the species and values of those in which the differences are significant.  This reduces the amount of time necessary to search through other reports to locate this information while drafting the report.

The best way to understand this is to write the example, and then we'll step through what is occurring.

```rconsole
> sink(file= 'test_text.txt', type='output') #open file for writing
> cat('This is the first line in the file using cat.\n') #\n = newline or return carriage.
> print('This is line in the file using print.\n') 
> x <- rpois(7, 10)
> for(i in 1:length(x)){
>    cat(paste('value ',i,':\t',x[i], '\n', sep=""))
> }
> cat('\n\n')
> for(i in 1:length(x)){
>    cat(sprintf("Measured Value %d is %.1f.\n", i, x[i]))
> }
> sink() # close file
```

The process begins by opening a file for writing. Followed by the function `cat()`. Essentailly this prints the line as is to the console window.  If functions much the same way as the `print()` function but performs less conversion on text.  Notice the difference in output between the to function in the resulting text file.

I then decided that we needed some data to write to a file, so I sampled some values from a poisson distribution which models count type data.  Note that nothing here is printed to the text file. We now want to write those values out to a file embeded inside some repeated text. The following code is doing several operations all smasshed together.. For each value in the vector paste together in a single string the words 'Index' the position in the vector, followed by ":	value', followed by the value sampled from the distribution ending with a nnew line character.  With `sep=""` were, telling R to put all of these strings together without addin anything between the values.  Thus were able to form complex statements that are a combination of text and data, or multiple data elements. 

```rconsole
> for(i in 1:length(x)){
>    cat(paste('Index ',i,':\t value',x[i], '\n', sep=""))
> }
```

Another way to perform the same operation is to use "C-style printing" with the `sprintf()` function. This function is a bit harder to use, but it has the advantage of allowing us to format the data before printing. For example, printing to a specific number of decimal places. To do this you embed special codes in the text string, those that have a '%' which determine the format.  The values are to be substitued are placed at the end of the function.  Not that values are substituted into the string in the order in which they appear.

```rconsole
> for(i in 1:length(x)){
>    cat(sprintf("Measured Value %d is %.1f.\n", i, x[i]))
> }
```
