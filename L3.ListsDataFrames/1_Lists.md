# Lists

Formally, lists are a generic vector that contain other elements. lists are created directly via the `list()` function, or through cohersion using `as.list()`

For example, the following object x is a list that contains copies of 3 vectors, n, s, b, and a numeric value 3.

```rconsole
> n <- c(2,5,3)
> s <- c("aa", "bb","cc","dd")
> b <- c(TRUE, FALSE, TRUE, FALSE, FALSE)
> x <- list(n,s,b,3)  # x contains copies of n,s,b
```
One should note that unlike vectors and arrays, lists elements don't need to be the same object types. That is one element could contain text, another a vector, or any othe valid data type.  In fact, list elements can contain other lists (e.g., nested lists). It's important to note that x contains _copies_ of n,s, and b.  We can prove this by modifying one of the original objects.

```rconsole
> n <- c(2,10,4,5)
> # print x 
> x
```
The output should still show that the first element of the list which contained the vector n, still has the values 2,5, and 3.

The second way to create lists is through cohersion.  Let's assume that we have a vector and for some reason we need it to be a list.

```rconsole
> y <- c(2,5,6,7)
> mylist <- as.list(y)
[[1]]
[1] 2

[[2]]
[1] 5

[[3]]
[1] 6

[[4]]
[1] 7
```

## list slicing

list elements or slices are retrieved using the square brackets "[]" operator. The following is a slice containing the second element of x, which is a copy of s
```rconsole
> x[2]
[[1]]
[1] "aa" "bb" "cc" "dd"
```
We can retrieve multple elements or slices from a list using vector notation. Here we are requesting the second and fourth elements of x
```rconsole
> x[c(2,4)]
[[2]]
[1] "aa" "bb" "cc" "dd"

[[4]]
[1] 3
```
## Member reference
In order to reference a member directly, we have to use the _double square brackets_ "[[]]" operator. 

```rconsole
x[[2]]
[1] "aa" "bb" "cc" "dd"
```
So, Whats the difference between referencing a slice ("[]") and a member ("[[]]")?  The first difference is that the single bracket notation can be used to select a range of elements, whereas the double bracket notation, can only select a single element.  This in turn leads to the second difference, which can trip up seasoned R coders. Using single brackets the object returned will be of the class list, while the double bracket notation will return the class of the object stored in the list element.This can be shown with the following code:

```rconsole
> class(x[2])
[1] "list"

> class(x[[2]])
[1] "character"
```
So, why is this important?  If you were using this as input to another function, sometimes, the function is expecting the input to be a list, while in other cases the function may be expecting a vector.  Second, the double bracket notation allows you to modify the values in the vector, which in not possible using the single bracket notation.  Looking carefully at the output return you can tell the class of the object returned.  Notice that the output above using the single bracket operator begins with `[[1]]` indicating a list.  This is absent from the output using the double bracket operator.

## Named Lists
Similar to vectors, we can assign names to list elements. This can be done at the time of creation or after creation using the `names()` function.

```rconosle
> v <- list(bob = c(2,3,5), john = c("aa", "bb"))
> v
$bob
[1] 2 3 5

$john
[1] "aa" "bb"
```
## list slicing
We can also slice named lists using the single square bracket notation.  Here is a slice containing a member of v named "bob"

```rconsole
> v["bob"]
$bob
[1] 2 3 5

Again using the single bracket notation we can reference a vector of elements to return as:

```rconsole
> v[c("bob", "john")]
$bob
[1] 2 3 5

$john
[1] "aa" "bb"
```

## Member reference
Referencing memebers directly requires using the double bracket operator

```rconsole
> v[["bob"]]
[1] 2 3 5
```
However, with named lists we can also access members directly with the "$" operator.

```rconosle
> v$bob
[1] 2 3 5
```

This ends our journey with lists. Lists are commonly used in the R language, and we will see how useful they are in later lessons.
