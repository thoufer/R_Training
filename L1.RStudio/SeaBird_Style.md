# Data lifecycle development for Migratory Bird surveys: Coding standards & conventions for R

## Background

When moving into a collaborative space where where code maybe used, shared, and modified among the group it becomes increasingly important that there be an agreed upon set of rules for how that code is developed. These standards apply specifically to the layout and formatting of the source code, making them easier to read, verify, and maintain by all developers. There are no right or wrong coding standards only those which are agreed upon. The standards and conventions below are partly derived from historical convention used in other languages, partly from Google's R coding standards, and partly from a standard developed by Hadley Wickham.

Given its dominance in the R world, RStudio is the accepted IDE for R coding, and many of these standards can be set within the options of RStudio, requiring minimal additional input by the developer. Where applicable, the RStudio setting, and its location will be specified and indicated by the information icon (![(info)](images/icons/emoticons/information.png)).

For those that prefer to write "messy" or unformatted code I suggest looking at the fomatR package by Yihui Xie, the same author that brought us Knittr. The package is basically a formatting engine that will take raw unformatted code and output "tidy" code according to a set of rules set by they user.

## Prevalent coding styles

There are many coding style in use today. Choosing a particular style is a trade off between readability, and additional hand movements during typing. The four primary styles in use in R are **SentenceCase**, and **camelCase, underscore\_notation**, and **dot.notation.** SentenceCase and camelCase are the most efficient with respect to typing speed, as the shift key is easily reachable, however, some users find it difficult to read especially if an object or function name is more than tow words. Underscore_notation, and dot.notation tend to improve readability at the cost of typing speed, as they both require awkward hand movements to reach the _ and . key.

## Notation and Naming

### File Names

All file names should end in .R and be meaningful. File naming conventions, are less of an issue, but if a standard could be agreed upon it would be an added bonus. I would recommend that spaces be avoided in filenames, as this is in my opinion a bit of a pain to deal with in a VCS.

```
downloadData.R
plotRoutine.R

# Bad
foo.R
untitled.R
RunCode.R
```

Further, if files are written in such a manner as there is a specific order in which they need to be run, the name must identify that order with a number prefix.

```
0-downloadData.R
1-runModels.R
2-plotResults.R
```

### Folder Names

Given the nature of navigating folder structure in windows explorer, and on the command line, Folders should use the underscore notation. This eases reading while in windows explorer and removes the challenges faced with changing directories in which the names have spaces.

### Function & Variable Names

Where possible, avoid using names of existing R functions and variables. Generally, variable names should be nouns and function names should be verbs. Strive for names that are concise and meaningful (this is a challenge!). The general preference for functions and variable require more than one word to describe them adequately, use **camelCase**. For variables and function arguments that only require a one word description, all lower case will be used.

```
# Good
calculateDensity <- function(...)

# Bad
first_day_of_month <- function(...)
```

### Constants

We do on occasion benefit from the use of global level constants. All constants should be defined at the top of the file following and `source()` or `library()` commands. Constants should be defined in all caps, and words separated by an underscore. This is the exception to the assignment rule where assignment should be and `=` instead of `<-`.

```
# Good
COHORT = c('AM','AF','YM','YF')
BEGIN_YEAR = 1986

# Bad
cohort <- c('AM','AF','YM','YF')
BeginYear <- 1986 
```

### True/False

When used, always specify `TRUE` or `FALSE` in its complete capital form, **not** in its abbreviated form T, F.

```
# Good
object <- read.csv(file, ..., stringsAsFactors = FALSE)

# Bad
object <- read.csv(file, ..., stringsAsFactors = F)
```

## Syntax

### Spacing

Place spaces around all infix operators (`=`, `+`, `-`, `<-`, etc.). The same rule applies when using `=` in function calls. Always put a space after a comma, and never before (just like in regular English). The small exception to this rule: `:`, `::` and `:::` don’t need spaces around them.

```
# Good
average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad
average<-mean(feet/12+inches,na.rm=TRUE)
```

### Curly Braces

An opening curly brace should never go on its own line and should always be followed by a new line. A closing curly brace should always go on its own line, unless it’s followed by `else`. Always indent the code inside curly braces.


```
# Good
if (condition) {
  some more code
}

if (y == 0) {
  log(x)
} else {
  y ^ x
}

# Bad
if (condition)
one line of code

if (y == 0) {
  log(x)
} 
else {
  y ^ x
}
```

### Line Length

RStudio Setting: Tools Menu >> Global Options >> Code editing – check show margin, set Margin Column to 80. RStudio will not automatically wrap text when it hits the margins, but it will serve as an indicator of when a line is approaching its limit.

Strive to limit your code to 80 characters per line. This fits comfortably on a printed page with a reasonably sized font. If you find yourself running out of room, this is a good indication that you should encapsulate some of the work in a separate function. The exception to this are file paths. R and RStudio are known to have problems when a carriage return is used within a string that contains a file path, and it is used as an argument to a function, like read.csv. There are several alternatives to mitigate this issue:

1. Specify the file path as a global constant and reference the object holding the path within the function.

2. Use `setwd()`, to reference the top-level project folder then specify the relative path to the file which is usually shorter

3. Set up a project within RStudio, which should automagically set the working directory to the directory used to set up the project, then proceed with #2.

Items 2 and 3 are the preferred alternative, as file paths tend to be specific to user and machine, which if using version control will cause GIT to flag the file as modified, since is was in order for another user to run it.

### Indentation

RStudio Setting: Tools Menu >> Global Options >> Code editing – check insert spaces for tabs and set tab width to 2. RStudio will insert 2 spaces each time the tab key is pressed, rather than a tab character.

When indenting your code, use two spaces. Never use tabs or mix tabs and spaces. The only exception is if a function definition runs over multiple lines. In that case, indent the second line to where the definition starts

```
someFunction <- function(arg1 = 1, arg2, arg3,
 					     arg4) {
  more lines of code..
}

# Alternative 2 
superFunction <- function(arg1 = 1, 
			  arg2, 
			  arg3,
 			  arg4) {
  more lines of code..
}
```

### Assignment

When assigning or objects or functions that will existing in the environment always use `<-` . The exception to this is to use `=` when specifying the value for a constant that is defined at the script level, lives in the environment. When specifying values that are part of function arguments use the `=`.


``` 
SomeFunction <- function(arg1 = 1, arg2 = TRUE){
  more lines of code
}

output <- someOperation()
```

## Organization

### General Layout and Ordering

If everyone uses the same general ordering, we'll be able to read and understand scripts written by other staff members faster and more easily.

1. Author comment (name and email)

2. File description comment, including purpose of program, inputs, and outputs

3. `source()` and `library()` statements

4. Function definitions

5. Executed statements, if applicable (e.g., `print`, `plot`)

In the future if we decide to make use of unit testing procedures, unit tests should go in a separate file named `originalfilename_test.R`

```
#' @author
#' Awsome Biologist awsome_biologist@fws.gov
#'
#' @description
#' some long description that at a minimum describes the purpose of the program.
#' Inputs and outputs are probably only necessary if the file describes a class or
#' function.
#'

source(someFile.R)

library(lattice)
library(MASS)

someFunction <- Function(...){
}

.
.
.

plot(...)
```

### Commenting

Code and functions should be well commented. Each line of a comment should begin with the comment symbol and a single space: `#`. Comments should explain the why, not the what. Use commented lines of `-` and `=` to break up your file into easily readable chunks. Take advantage of code folding in RStudio, by following comments with four or more `-`, or `=`.


```
# Load Data ----

# Plot Data ====
```

### Function Documentation

Functions should contain a comments section immediately above the function definition line. All comments should be sandwiched between a comment line of `#' ---` that is 80 characters long. Note the apostrophe following the hashtag. This is a Doxygen style comment. The bonus to using this is that when hitting the return carriage RStudio will automatically insert a hashtag on the next line for you, saving some keystrokes.

These comments should consist of a one-sentence description of the function; a list of the function's arguments, denoted by `Args:`, with a description of each (including the data type); and a description of the return value, denoted by `Returns:`. The comments should be descriptive enough that a caller can use the function without reading any of the function's code.

```
#' -----------------------------------------------------------------------------
#' Description: Some brief summary of what the function does.
#'
#' Args:
#'  arg1: <datatype> arg1 does something cool.
#'	arg2: <datatype>
#'  verbose: <logical> If TRUE something will be printed to the console as 
#'						function executes.
#'
#' Returns:
#	a description of the return object, including data type (vector, list, array,
#'	dataframe). 
#' -----------------------------------------------------------------------------
fancyFunction <- function(arg1, arg2, verbose = TRUE){
  function code
} 
```

### Examples

All custom written function should have an example section following the function if multiple functions are defined in one file, or at the bottom of the file if using a 1 function per file standard. The example(s) should be fully self contained, in that no additional files should be necessary to run the function. This necessitates generating random data. The example(s) should be commented out entirely to avoid running the examples if the entire file is sourced.

