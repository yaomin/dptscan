## Filename: experiment-config.r
## By: Yaomin Xu (yaomin at gmail.com)
## Date: October 27, 2012
## Notes: Setup running parameters.  
## =============================================================================

###. User Section
##____________________________________________________________________

###... dptscan version
dpt.version = "0.7.1"

###... binning window size
winsize = 50  
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
initfilter.TF = FALSE
initfilter.cutoff = 1

fragsizefilter.TF = T
fragsizefilter.cutoff = 120 ## minimum site width to be included for iDPT analysis

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





