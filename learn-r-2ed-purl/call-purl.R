library(knitr)

eval_diag <- FALSE
incl_all <- TRUE
eval_plots_all <- TRUE
eval_playground <- TRUE
eval_online_data <- TRUE
eval_yoctopuce <- TRUE

purl(input = "R.as.calculator.Rnw", output = "learn-r-2ed-purl/R.as.calculator.R")

purl(input = "R.data.containers.Rnw", output = "learn-r-2ed-purl/R.data.containers.R")

purl(input = "R.data.io.Rnw", output = "learn-r-2ed-purl/R.data.io.R")

purl(input = "R.data.Rnw", output = "learn-r-2ed-purl/R.data.R")

purl(input = "R.functions.Rnw", output = "learn-r-2ed-purl/R.functions.R")

purl(input = "R.plotting.Rnw", output = "learn-r-2ed-purl/R.plotting.R")

purl(input = "R.scripts.Rnw", output = "learn-r-2ed-purl/R.scripts.R")

purl(input = "R.stats.Rnw", output = "learn-r-2ed-purl/R.stats.R")

# purl(input = "R.intro.Rnw", output = "learn-r-2ed-purl/R.intro.R")

purl(input = "R.learning.Rnw", output = "learn-r-2ed-purl/R.learning.R")
