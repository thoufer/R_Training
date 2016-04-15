# Importing External Data in to R
One of the great power features of R is that it can read a variety of data file formats. Files, can be broadly catagorized at delimited text files, binary files, and databases.

### From delimited Files

read.table()
read.csv()
read.fwf()


### Reading SAS datasets
The ability to read SAS datasets is relativley new in R. Thanks, to one determined developer who was able to reverse engineer the file, we have the ability to read sas data files without the need to have SAS installed.

This library is still considered somewhat experimental, and one may encounter problems with some data sets. However, reading SAS files is as simple a loading the sas7bdat library, and then using the `read.sas7bdat()` function to load a particular data set.

```rconsole
library(sas7bdat)
mySASData <- read.sas7bdat("example.sas7bdat")
```

### Reading Excel Files

```rconsole
library(xlsx)
Loan <- read.xlsx('H:/Network_docs/LoanCalculatory.xlsx', sheetIndex = 1, 
          rowIndex = 2:7, colIndex = 1:3)
```

### Connecting to Databases
Connecting to databases are a very powerful way of interacting with large sets of data, especially since R's is limited to your available about of Ram. 

RODBC, DBI, RMySQL, Rpostgres, dplyr, ROracle, RJDBC, RSQLServer

ODBC 32bit vs 64bit problem

## Writing Infromation to files.
### Data objects
### Text objects
