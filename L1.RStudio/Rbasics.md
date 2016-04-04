# R Basics

R is an open source version of the S+ language.  S+ and R were originially developed at Bell Labs, by statisticians, primarily for statistical analyses.  Since the mid- to late 1990's the adoption of the R lanugage by statisticians, data scientists, and others has been exponential. There are a myriad reasons behind this adoption.  First and foremost is that the R language while primarily designed for statistical analysis is more of a general programming language similar to C, c++, Java, etc., thus its capable of doing much more. Obviously R can handle Stats analysis, but R can do GIS (spatial operations), text processing, web scraping and more. Looking at the [CRAN task views](https://cran.r-project.org/) page will provide some insight into the diverity of arenas R works in.  R has been able to work in these arenas becuase it has the ability to add additional functionality.  Further this added functionality is driven by the large community of R users themselves.  In other words, if R doesn't have the ability to perform a necessary function needed, you, with a little skill and time can write that functionality, and if desired share it.  Finally, R has the ability to interact with other "platforms".  It can make calls to outside software, and get results back for additional processing.  One example of this, is Program MARK.  You can develop models within R and send them to MARK for estimation, and get the results back, without ever having to muddle through the MARK GUI. 

#Adding Functionality
# Packages

Most of the functionality needed by people in SAS comes baked in the base version. If you wanted additional functions you needed to pony up $$$ to SAS to add them.  In R additional functionality is added to R via 'packages'.  This was a bit of a poor choice of words by developers, since packages are loaded using `library()` command
As stated earlier most libraries not developed by Core R developers, but by the community itsef.  In essence, packages are simply a series of commands or functions that have been aggregated into an easy to distribute format.  

As an aside, functions make use of a property called encapsulation.  Encapsulation hides the implementatiaon of the function. That is you only need to understand what the function takes and what the function returns.  This allows the programmer to update, modify, and improve functions without breaking your code.  An analogy to this is driving a car. Let's say a function called forward takes a gas pedal argument. Depressing the gas pedal results in forward movement (the return object).  You as a driver don't need to know how the engine works, and how it transfers power to the wheels.  This allows car company to change the implementation like changeing the engine from a 4-cylinder to a 6-cylinder or a transmission from a 4-speed to a 6-speed.

## Getting Help

As you begin your journey in learning R. You will need to seek help a lot.  Some resources are better than others.

If you known the command:

```rconsole
> ?<command>
```
or
```rconsole
> help("<command>")
```
A word on help files.  Many have expressed discontent with R help files, and indeed they can be a bit challenging to decipher. All help files are laid out the same, at the top will be the function call, and all of the possible arguments, followed by a detailed description about each argument.  This will be followed about details of the function like what actions are being perfomed, and possible what object type is being returned. At the bottom of the file are examples of the function in use.  Personally, I find it easiest to look at the function call at the top, then scroll to the bottom to see the example, then read the description of the funciton and arguments. 

Searching the interwebs:

In most cases, google what your are trying to perform and add R at the beginning, and you get get results.  There exist specific websites dedicated to R, and these below have been helpful in the pass

[rseek](http://www.rseek.org/)
[Stack Overflow](http://stackoverflow.com/questions/tagged/r)

When all else fails:

seek a real person!!



#  Workspaces, objects, and functions
## Worskpaces
Everything you create in R is stored inside a workspace, or in a script.  All of this informaiton (i.e., data objects) is stored in temporary memory (RAM), and must be written out to explicity save it, otherwise all of your information will be lost when you close R/RStudio. In most cases, this is not a problem, since scripts are actual files, and should recreate everything simply by running them again.  This is what makes R reproducible.  

The few exceptions to this are a.) when you are performing operations, such as simulations that take extensive time to run, or b.) you are loading a large dataset into memory, like the full mallard banding dataset.  In these cases, analysis and interpretation may occur over several days and weeks, thus saving the workspace will make your workflow more efficient.

## Objects
Technically, everything in R is an object. For our purposes, we will break this up into *objects* which store data, and *functions* which perform an action on data.

About the only rule that exists when it comes to naming objects and functions is that they **cannot begin** with a number. Names may contain numbers, just not as the furst chaacter.

Objects are created through assigment. 

```rconsole
x <- 5 
```
In the above example we've assigned a value of 5 to an object named x.  The following is also valid syntax, however, most discourage its use, for reasons that will become evident.

```rconsole
x = 5 
```

## Functions and arguments
In R calling function is relatively straight forward.  Functions can be identified as a name followed by a set of ().  An example might `be myfunction()`. In most cases, function take an arugment or inputs necessary to for the function to run.

```rconsole
squared <- square(value = 2)
```
In this ficticous example, we have a function that returns the square of a number.  The function is *square* and the argument is *value*.  This example makes it clear why `<-` should be used for assignment of objects over `=`.  Typically the `=` is used for function arguments.  

Arguments are named, however, in some cases those names could be omitted, and they were work just fine as:

```rconsole
squared <- square(2)
```
In this case since there is only one argument, R will fill the argument with that value.  Care must be taken when functions contain more than one argument.

```rconsole
x2y <- power(value= 2, exponent= 3)
```
This is another ficitous example that computes 2 to the power 3.  Again, we could simplify typing this by:

```rconsole
x2y <- power(2,3)
```

and R will substitute the values into the arguments in the **order in which they appear**. Cases where omitting argument names causes problems is when you may not be specifiying all of the arguments.

```rconsole
myObject <- function(arg1, arg2, arg3)
``` 
specifying the function as `function(1,2)` would assign them to arguments 1 and 2.  If you ment to assign them to 1 and 3, that would be accomplished through,

````rconsole
function(arg1= 1, arg3=2)
```

If arguments are named, the order in which they appear inside the () doesn't matter.. It only matters if the argument name is not specified.


## Case sensitivity
Unlike some other languages, R is case sensitive. Thus, the following objects are different.

```rconsole
x <- 22
X <- 1
```

If not careful, or if you consider yourself a lazy programmer, this can make your life miserable.  While learning R, its best to adopt a set of naming conventions, often referred to as a 'style', and use them throughout all of your programming.  This not only reduces mistakes, but makes your code more readable by others, assuming they know the conventions.  

Styles promoted by Hadley Wickham, an idol in the R programming world, and Google (yes they are heavy R users):
[Hadley's conventions](http://adv-r.had.co.nz/Style.html)
[Google's conventions](https://google.github.io/styleguide/Rguide.xml)


# Operators 
R has all of the traditional operators..

**+**: addition
**-**: subtraction
**/**: division
*** **: multiplcation
**%*%**: Matrix multiplication
**== **: equals
**%%**: modulo division. This returns only the remainder portion of the division.
**&**: and
**|**: or
**!**: not
**%in%**: ?

## NULL Values
If your coming from a SAS world, missing values were defined using the  a . In R missing values can be defined use either NA or NULL.  However, NA is the preferred method.  See the following website for an explanation of why. [Explanation of NA vs NULL](http://www.r-bloggers.com/r-na-vs-null/)

## Some useful fuctions

**ls()**: Print a list of the objects in the workspace to the console
**rm()**: Delete objects from the workspace (example: rm(x)) 
**str()** Print a string representation of the object to the workspace.  This can be useful to understand how objects are stored in R.

# Summary
What follows isn't meant to serve as a end all be all training in R.  In fact, that are numerous tutorial out there on the interwebs, and I encourage you to seek them out.  Sometimes the best way to learn R is just to see it a lot. After a while things begin to sink in.


