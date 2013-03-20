## Filename: experiment-config.r
## By: Yaomin Xu (yaomin at gmail.com)
## Date: January 8, 2013
## Notes: Setup running parameters.  
## =============================================================================

###. User Section
##____________________________________________________________________

###... dptscan version
dpt.version = "0.7.2"

###... profile binning
winsize = 50
read.extension <- 120
read.length <- 36
use.FPKM <- F
output.binnedProfile <- T

###... differential testing
diffTest.cutoff = 0.05  # qvalue cutoff
which.escore = 0 # quantitle function for composite event score, should be a small quantile between 0-0.5

###. Advanced Section
##____________________________________________________________________
###... gap parameters
join.gap = 500
shear.gap = 500
region.gap = 2000

###... filters
initfilter.TF = TRUE
initfilter.cutoff = 0.1

fragsizefilter.TF = T
fragsizefilter.cutoff = 120 ## fragment size for read extension

bf.cutoff = NULL

###... normalization
bg.process = "norm"

###... patterns & scan
events.cutoff.method = "best"
events.cut = 0.1
cleansite.cutoff = 0.25
cleanZeroPattern.cutoff = 0.25

###... differential testing
diffTest.cutoff.method = "qvalue"





