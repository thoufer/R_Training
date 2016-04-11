<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  <span>[Data lifecycle development for Migratory Bird surveys](index.html)</span>

</div>

# <span id="title-text">Data lifecycle development for Migratory Bird surveys : Coding standards & conventions for R</span>

</div>

<div id="content" class="view">

<div class="page-metadata">Created by <span class="author">Zimpfer, Nathan</span>, last modified by <span class="editor">Silverman, Emily</span> on Dec 07, 2015</div>

<div id="main-content" class="wiki-content group">

<div class="columnMacro" style="width:75%;min-width:75%;max-width:75%;">

# <span style="color: rgb(51,51,153);">Background</span>

When moving into a collaborative space where where code maybe used, shared, and modified among the group it becomes increasingly important that there be an agreed upon set of rules for how that code is developed. These standards apply specifically to the layout and formatting of the source code, making them easier to read, verify, and maintain by all developers. There are no right or wrong coding standards only those which are agreed upon. The standards and conventions below are partly derived from historical convention used in other languages, partly from Google's R coding standards, and partly from a standard developed by Hadley Wickham.

Given its dominance in the R world, RStudio is the accepted IDE for R coding, and many of these standards can be set within the options of RStudio, requiring minimal additional input by the developer. Where applicable, the RStudio setting, and its location will be specified and indicated by the information icon (![(info)](images/icons/emoticons/information.png)).

For those that prefer to write "messy" or unformatted code I suggest looking at the fomatR package by Yihui Xie, the same author that brought us Knittr. The package is basically a formatting engine that will take raw unformatted code and output "tidy" code according to a set of rules set by they user.

## Prevalent coding styles

There are many coding style in use today. Choosing a particular style is a trade off between readability, and additional hand movements during typing. The four primary styles in use in R are **SentenceCase**, and **camelCase, underscore_notation**, and **dot.notation.** SentenceCase and camelCase are the most efficient with respect to typing speed, as the shift key is easily reachable, however, some users find it difficult to read especially if an object or function name is more than tow words. Underscore_notation, and dot.notation tend to improve readability at the cost of typing speed, as they both require awkward hand movements to reach the _ and . key.

# <span style="color: rgb(51,51,153);">Notation and Naming</span>

## _File Names_

All file names should end in .R and be meaningful. File naming conventions, are less of an issue, but if a standard could be agreed upon it would be an added bonus. I would recommend that spaces be avoided in filenames, as this is in my opinion a bit of a pain to deal with in a VCS.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Good 
downloadData.R
plotRoutine.R

# Bad
foo.R
untitled.R
RunCode.R</pre>

</div>

</div>

Further, if files are written in such a manner as there is a specific order in which they need to be run, the name must identify that order with a number prefix.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence">0-downloadData.R
1-runModels.R
2-plotResults.R </pre>

</div>

</div>

## _Folder Names_

_Given the nature of navigating folder structure in windows explorer, and on the command line, Folders should use the underscore notation. This eases reading while in windows explorer and removes the challenges faced with changing directories in which the names have spaces._

## _Function & Variable Names_

Where possible, avoid using names of existing R functions and variables. Generally, variable names should be nouns and function names should be verbs. Strive for names that are concise and meaningful (this is a challenge!). <span style="color: rgb(0,0,0);">There</span> <span style="color: rgb(255,0,0);"></span> <span style="color: rgb(0,0,0);"><span style="line-height: 1.4285715;">general preference that functions and variable require more than one word to describe them</span> adequately<span style="line-height: 1.4285715;">,</span> </span>**camelCase**<span style="color: rgb(0,0,0);"> <span style="line-height: 1.4285715;">will be used. For variables and function arguments that only require a one word description, all lower case will be used.</span></span>

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Good
calculateDensity <- function(...)

# Bad
first_day_of_month <- function(...)</pre>

</div>

</div>

_Constants_

We do on occasion benefit from the use of global level constants. All constants should be defined at the top of the file following and `source()` or `library()` commands. Constants should be defined in all caps, and words separated by an underscore. This is the exception to the assignment rule where assignment should be and `=` instead of `<-`.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Good
COHORT = c('AM','AF','YM','YF')
BEGIN_YEAR = 1986

# Bad
cohort <- c('AM','AF','YM','YF')
BeginYear <- 1986 </pre>

</div>

</div>

## True/False

When used, always specify `TRUE` or `FALSE` in its complete capital form, **not** in its abbreviated form T, F.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Good
object <- read.csv(file, ..., stringsAsFactors = FALSE)

# Bad
object <- read.csv(file, ..., stringsAsFactors = F)</pre>

</div>

</div>

# <span style="color: rgb(51,51,153);">Syntax</span>

## _Spacing_

Place spaces around all infix operators (`=`, `+`, `-`, `<-`, etc.). The same rule applies when using `=` in function calls. Always put a space after a comma, and never before (just like in regular English). The small exception to this rule: `:`, `::` and `:::` don’t need spaces around them.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Good
average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad
average<-mean(feet/12+inches,na.rm=TRUE)</pre>

</div>

</div>

_Curly Braces_

An opening curly brace should never go on its own line and should always be followed by a new line. A closing curly brace should always go on its own line, unless it’s followed by `else`. Always indent the code inside curly braces.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Good
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
}</pre>

</div>

</div>

_Line Length_

<div class="confluence-information-macro confluence-information-macro-information"><span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

RStudio Setting: Tools Menu >> Global Options >> Code editing – check show margin, set Margin Column to 80\. RStudio will not automatically wrap text when it hits the margins, but it will serve as an indicator of when a line is approaching its limit.

</div>

</div>

Strive to limit your code to 80 characters per line. This fits comfortably on a printed page with a reasonably sized font. If you find yourself running out of room, this is a good indication that you should encapsulate some of the work in a separate function. The exception to this are file paths. R and RStudio are known to have problems when a carriage return is used within a string that contains a file path, and it is used as an argument to a function, like read.csv. There are several alternatives to mitigate this issue:

1.  Specify the file path as a global constant and reference the object holding the path within the function.

2.  Use `setwd()`, to reference the top-level project folder then specify the relative path to the file which is usually shorter
3.  Set up a project within RStudio, which should automagically set the working directory to the directory used to set up the project, then proceed with #2.

Items 2 and 3 are the preferred alternative, as file paths tend to be specific to user and machine, which if using version control will cause GIT to flag the file as modified, since is was in order for another user to run it.

## _Indentation_<span style="color: rgb(51,51,51);"></span>

<div class="confluence-information-macro confluence-information-macro-information"><span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

RStudio Setting: Tools Menu >> Global Options >> Code editing – check insert spaces for tabs and set tab width to 2\. RStudio will insert 2 spaces each time the tab key is pressed, rather than a tab character.

</div>

</div>

When indenting your code, use two spaces. Never use tabs or mix tabs and spaces. The only exception is if a function definition runs over multiple lines. In that case, indent the second line to where the definition starts

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence">someFunction <- function(arg1 = 1, arg2, arg3,
 					     arg4) {
  more lines of code..
}

# Alternative 2 
superFunction <- function(arg1 = 1, 
						  arg2, 
						  arg3,
 					      arg4) {
  more lines of code..
}</pre>

</div>

</div>

_Assignment_

When assigning or objects or functions that will existing in the environment always use `<-` . The exception to this is to use `=` when specifying the value for a constant that is defined at the script level, lives in the environment. When specifying values that are part of function arguments use the `=`.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"> 
SomeFunction <- function(arg1 = 1, arg2 = TRUE){
  more lines of code
}

output <- someOperation()</pre>

</div>

</div>

# <span style="color: rgb(51,51,153);">Organization</span>

## _General Layout and Ordering_

If everyone uses the same general ordering, we'll be able to read and understand scripts written by other staff members faster and more easily.

1.  <span style="color: rgb(0,0,0);">Author comment (name and email)</span>

2.  <span style="color: rgb(0,0,0);">File description comment, including purpose of program, inputs, and outputs</span>

3.  <span style="color: rgb(0,0,0);">`source()` and `library()` statements</span>

4.  <span style="color: rgb(0,0,0);">Function definitions</span>

5.  <span style="color: rgb(0,0,0);">Executed statements, if applicable (e.g., `print`, `plot`)</span>

<span style="color: rgb(0,0,0);">In the future if we decide to make use of unit testing procedures, unit tests should go in a separate file named `originalfilename_test.R`.</span>

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence">#' @author
# 	Awsome Biologist awsome_biologist@fws.gov
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

plot(...)</pre>

</div>

</div>

## _Commenting_

Code and functions should be well commented. Each line of a comment should begin with the comment symbol and a single space: `#`. Comments should explain the why, not the what. Use commented lines of `-` and `=` to break up your file into easily readable chunks. Take advantage of code folding in RStudio, by following comments with four or more `-`, or `=`.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence"># Load Data ----

# Plot Data ====</pre>

</div>

</div>

## _Function Documentation_

Functions should contain a comments section immediately above the function definition line. All comments should be sandwiched between a comment line of `#' ---` that is 80 characters long. Note the apostrophe following the hashtag. This is a Doxygen style comment. The bonus to using this is that when hitting the return carriage RStudio will automatically insert a hashtag on the next line for you, saving some keystrokes.

These comments should consist of a one-sentence description of the function; a list of the function's arguments, denoted by `Args:`, with a description of each (including the data type); and a description of the return value, denoted by `Returns:`. The comments should be descriptive enough that a caller can use the function without reading any of the function's code.

<div>

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

<pre class="syntaxhighlighter-pre" data-syntaxhighlighter-params="brush: cpp; gutter: false; theme: Confluence" data-theme="Confluence">#' -----------------------------------------------------------------------------
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
} </pre>

</div>

</div>

</div>

## _Examples_

All custom written function should have an example section following the function if multiple functions are defined in one file, or at the bottom of the file if using a 1 function per file standard. The example(s) should be fully self contained, in that no additional files should be necessary to run the function. This necessitates generating random data. The example(s) should be commented out entirely to avoid running the examples if the entire file is sourced.

</div>

</div>

<div class="pageSection group">

<div class="pageSectionHeader">

## Comments:

</div>

<table border="0" width="100%">

<tbody>

<tr>

<td><a name="comment-535987754"></a><font class="smallfont">

This all makes good sense to me and I try to follow a lot of these conventions, although I am not good with all. For naming, I think I would go with camel or dot. I use sentence, but actually find it hard to read in some cases. The underscore feels like an assignment to me and can be hard to see in some contexts, so I don't like it as much. I never use setwd() and often put my functions outside the main Rproject directory, but I can learn .... The rest of this would be good for me to take up to make my programs and code more coherent ....

</font>

<div align="left" class="smallfont" style="color: #666666; width: 98%; margin-bottom: 10px;">![](images/icons/contenttypes/comment_16.png) Posted by emily_silverman@fws.gov at Apr 28, 2015 15:36</div>

</td>

</tr>

<tr>

<td style="border-top: 1px dashed #666666"><a name="comment-535987777"></a><font class="smallfont">

In your case, there is good reason to store R code outside of the annual working directory.. You know you can use relative referencing here too right? For example `../../somefolder` would look for somefolder 2 levels above the current one .. The better option would be to create a package and dispense with the code directory entirely..hint, hint.

</font>

<div align="left" class="smallfont" style="color: #666666; width: 98%; margin-bottom: 10px;">![](images/icons/contenttypes/comment_16.png) Posted by nathan_zimpfer@fws.gov at Apr 29, 2015 07:01</div>

</td>

</tr>

<tr>

<td style="border-top: 1px dashed #666666"><a name="comment-535987823"></a><font class="smallfont">

I will see what I can do. Most of that makes sense but bad habits are hard to break!

</font>

<div align="left" class="smallfont" style="color: #666666; width: 98%; margin-bottom: 10px;">![](images/icons/contenttypes/comment_16.png) Posted by anthony_roberts@fws.gov at Apr 29, 2015 14:11</div>

</td>

</tr>

<tr>

<td style="border-top: 1px dashed #666666"><a name="comment-535987996"></a><font class="smallfont">

You and I had briefly discussed folder/file naming. The page describes file naming but not folder naming, which we thought might be beneficial to add. However, I can't recall if we decided to continue the camelCase naming scheme or whether it was preferred to move to an underscore notation? Do you recall where we ended that?

</font>

<div align="left" class="smallfont" style="color: #666666; width: 98%; margin-bottom: 10px;">![](images/icons/contenttypes/comment_16.png) Posted by nathan_zimpfer@fws.gov at May 01, 2015 07:55</div>

</td>

</tr>

<tr>

<td style="border-top: 1px dashed #666666"><a name="comment-535988002"></a><font class="smallfont">

Underscore for folders, although I was going to look at fonts in GitBash to be sure. I am still ok with underscore and think it is good to have a different convention for folder v. files and that will distinguish them in Git. Do we want camel case for text files and reports, pdfs, etc. or something else?

</font>

<div align="left" class="smallfont" style="color: #666666; width: 98%; margin-bottom: 10px;">![](images/icons/contenttypes/comment_16.png) Posted by emily_silverman@fws.gov at May 01, 2015 08:09</div>

</td>

</tr>

<tr>

<td style="border-top: 1px dashed #666666"><a name="comment-535988008"></a><font class="smallfont">

Sounds good wrt folder naming.. I don't think that there needs to be a standard naming scheme for text files, report, etc.. These files are typically one off items that are independent of one another, whereas R code tends to have a relationship among files (i.e., function files, operations/processing files). In my own workflow, for these one offs, I do tend to use CapitalCase, and underscore in combination, as FileName_year.ext. I might suggest holding off on a standard for this, unless ancillary files, begin get out of control.

</font>

<div align="left" class="smallfont" style="color: #666666; width: 98%; margin-bottom: 10px;">![](images/icons/contenttypes/comment_16.png) Posted by nathan_zimpfer@fws.gov at May 01, 2015 08:23</div>

</td>

</tr>

</tbody>

</table>

</div>

</div>

</div>

<div id="footer" role="contentinfo">

<section class="footer-body">

Document generated by Confluence on Apr 11, 2016 07:05

<div id="footer-logo">[Atlassian](http://www.atlassian.com/)</div>

</section>

</div>

</div>
