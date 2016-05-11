# ---------------------------------------------------------------------------
# Khristis Plot Problem  -- Diagnostic plotting
#
# For each state and these 13 species/species groups: duck, goose, sea duck,
# brant, MODO, BTPI, WWDO, AMWO, SACR, snipe, coot, rail, gallinule, create a
# figure that plots 6 metrics, and their long-term average. Only 5 of the
# metrics have 95% confidence intervals.

# AT THE MOMEENT THIS ONLY PLOTS DATA FOR THE DUCK species group
# ---------------------------------------------------------------------------

# Khristi provided a database, so just connect to it directly.
library(RODBC)
db <- 'H:/Network_docs/Projects.git/Rtraining/Harvest estimates.accdb'
con <- odbcConnectAccess2007(db)

# Create a list of the 6 metrics to plot.  These are columns with estimates
# in the database.
var_list <- list('retrieved', 'unretrieved', 'days', 'active_hunters',
                 'BagPerHunter', 'bign')

# Create a function to pull data from the database.  The function take the name
# of the metric as text and creates an SQL query string to pull the data. The
# function knows that if "bign" is provided as input, their is no variance column
# to get.
get_data <- function(var){
  if(var == "bign") {
    res <- sqlQuery(con, paste0("SELECT season, species, st, ", var, "
                                AS est FROM harvestEstimates WHERE
                                species = 'duck' AND
                                st NOT IN ('AF','MF','CF','PF','US')"))
  } else {
    res <- sqlQuery(con, paste0("SELECT season, species, st, ", var,
                                " AS est", paste0(", var_", var), " AS
                                var_est FROM harvestEstimates WHERE
                                species = 'duck' AND st NOT IN ('AF','MF',
                                'CF','PF','US')"))
  }
  res
}

# "loop" over the list of metrics using the *apply (l for list) of functions,
# and pull the data.  This returns a list, with a dataframe in each element. Use
# str(data_to_plot) to see the structure of the object and data_to_plot[[1]]
#to see the first element
data_to_plot <- lapply(var_list, get_data)

# "Loop" over the data, and calculate the long-term average for each metric
# and state. Recall that the long-term average is calculated from n-1 years
# in the dataset (i.e., remove the last year). Returns a list.
lta <- lapply(data_to_plot, function(data){
  Years <- sort(unique(data$season))
  lastYear <- Years[length(Years)]
  data_minusLast <- data[data$season != lastYear, ]
  lta <- aggregate(list(lta = data_minusLast$est),
                  by=list(State = data_minusLast$st), mean,
                  na.rm = TRUE)
  lta
})

# Determine where you want the plots to go.
#windows()
pdf("test.pdf")

# Set up a plot layout that is 2 rows x 3 colums. mar sets the margin for each
# side of a figure as (bottom, left, top right) in lines of text. The default
# is (5,4,4,1).  Reduce the top margin to make for a bigger graph.
par(mfrow=c(2,3),
    mar=c(5,4,2,1)+.1)

# Create a vector of all the states in the data.
states <- unique(data_to_plot[[1]]$st)

# Loop the old-fashioned way over each state
for(j in 1:length(states)){
  # data_to_plot, and lta, contain estimated for all states, subset it to just
  # the one state indexed by states[j]
  state_data <- lapply(data_to_plot, function(x){ x[x$st == states[j],]})
  lta_data <- lapply(lta, function(x){ x[x$State == states[j],]})

  # Now that were down to one state, begin to plot the graphs by looping the
  # old fashioned way over each list element which corresponds to a single
  # metric.
  for(i in 1:length(state_data)){

    # Store the line color for each graph inside a vector.
    col = c("red", "dodgerblue4", "green", "chocolate", "darksalmon",
            "cadetblue")

    # In R the limits of the y-axis are determine by what is specified in the
    # Plot function (below). In this case we have confidence intervals, which
    # are added (not part of the plot call), and we want them run off of the
    # graph. Thus, find the minimum and maximum value of the 95% confidence
    # interval and store in range_val. This is used in the plot function to
    # tell R the min and max y-limits to plot.
    if(var_list[[i]] != "bign"){
        se_part <- sqrt(state_data[[i]]$var_est) * 1.96
        range_val <- range(state_data[[i]]$est + se_part,
                           state_data[[i]]$est - se_part, na.rm = TRUE)
    } else {
        range_val <- range(state_data[[i]]$est, na.rm = TRUE)
    }

    # Plot the estimates of the current metric as a line with filled circles.
    plot(state_data[[i]]$season, state_data[[i]]$est, type = 'o',
       las = 1, xlab = "Hunt Season", ylab = "Estimate",
       main = var_list[[i]], col = col[i], pch=16,
       ylim = range_val)

    # Plot the long-term average, as a dashed gray line
    abline(h=lta_data[[i]], lty= 2, col="gray") #!--- Problem..

    # If the metric being plotted is not bign, plot confidence interval. R doen't
    # plot confidence intervals natively.  So, we hack them by plotting an arrow
    # from the estimate up/down, and make the arrow flat rather then pointed.
    if(var_list[[i]] != "bign"){
      arrows(state_data[[i]]$season, state_data[[i]]$est,
           state_data[[i]]$season, state_data[[i]]$est - se_part,
           angle = 90, length=0.05, col= col[i])
      arrows(state_data[[i]]$season, state_data[[i]]$est,
           state_data[[i]]$season, state_data[[i]]$est + se_part,
           angle = 90, length=0.05, col= col[i])
    }
  }
}

# if using pdf, close the device to actually write the pdf to the hard drive.
dev.off()

