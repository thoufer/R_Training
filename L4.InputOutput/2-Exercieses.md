# Exercises for importing data

# Read delimited files
Several years ago, BBL changed from band manager to Bandit. Every year I enter data into the banding program during banding operations, and the program creates a file that submit to BBL at the close of operations.  

1. Read in my bandit Submission file into R.  I can tell you that the data column order 
Band Disposition (1 = new band, 4= replaced, 8=destroyed)
Band Number (band number are always 9 digits)
species (Alpha Code)
Species (AOU Code)
Band Status code (300 = Normal Wild)
Age code (1 = AHY, 2 = Hatch Year)
Sex (4 = Male, 5 = Female)
Location
Date (Year, Month, Day)

1. Summarize my catch to show the number banded by species and location

# Read Excel files
Recently, I needed some data from a colleague to complete an analysis for eastern mallards. I got this speadsheet attached in an email... (Note: The data have been changed to protect the innocent.)

1. In the bpop worksheet pull in the 1990-2015 abundance estimates for the  NE plot survey, May Survey strata, and their totals associated with eastern mallards..  No need to pull column names, as we could rename them later.

1. We also want to crate a second data frame that has the information associated with model parameters used for AHM model updating, found on the updating worksheet, rows 18-51, and columns A-N.  Do not import rows with no data!  

# connect to database

1. At the moment we store survey data inside an access data base from which we can make queries, about abundance estimates for species in different strata.  Connect to the database stored in this directory and issue the following query, and examine the results.  Just by looking at the SQL string, can you tell what is being returned.

'SELECT Yr, round(sum(pop)) AS EST, round(SQR(sum(se_pop^2))) AS SE FROM SASBpop
WHERE aou = 1320 and yr > 1991 and stratum BETWEEN 1 AND 18 or aou = 1320 and
yr > 1991 and stratum BETWEEN 20 AND 50 or aou = 1320 and yr > 1991 and stratum BETWEEN 75 AND 77
GROUP BY yr'


