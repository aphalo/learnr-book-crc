## ----setup-1, include=FALSE, cache=FALSE----------------------------------------------------------------------------
library(knitr)
library(svglite)


## ----setup-2, include=FALSE, cache=FALSE----------------------------------------------------------------------------
opts_knit$set(unnamed.chunk.label = 'main-chunk')
opts_knit$set(child.command = 'include')
opts_knit$set(self.contained=FALSE)
opts_chunk$set(fig.path='figure/pos-', fig.align='center', fig.show='hold', size="footnotesize", dev='pdf', dev.args=list(family='ArialMT'), cache=FALSE) #
opts_chunk$set(tidy=FALSE,size='footnotesize')
options(replace.assign=TRUE,width=70)


## ----fig-setup, include=FALSE, cache=FALSE--------------------------------------------------------------------------
opts_fig_very_wide <- list(fig.width=9, fig.height=3.9, out.width='.98\\textwidth')
opts_fig_wide <- list(fig.width=7, fig.height=3.9, out.width='.76\\textwidth')
opts_fig_wide_square <- list(fig.width=7, fig.height=7, out.width='.76\\textwidth')
opts_fig_narrow <- list(fig.width=5.444, fig.height=3.9, out.width='.60\\textwidth')
opts_fig_narrow_square <- list(fig.width=5.444, fig.height=5.444, out.width='.60\\textwidth')
opts_fig_very_narrow <- opts_fig_narrow
opts_fig_medium <- opts_fig_narrow
opts_chunk$set(opts_fig_narrow)


## ----match-setup, include=FALSE-------------------------------------------------------------------------------------
options(warnPartialMatchAttr = FALSE,
        warnPartialMatchDollar = FALSE,
        warnPartialMatchArgs = FALSE)


## ----diagnose-set-up, echo=FALSE, include=FALSE, cache=FALSE--------------------------------------------------------
eval_diag <- FALSE
knitter_diag <- function() {opts_knit$get()["unnamed.chunk.label"]}
R_diag <- function(){
    list(
      "Search path" = search(),
      "Working dir" = getwd(),
      "Number of loaded DLLs" = length(getLoadedDLLs()),
      "Max. loaded DLLs" = Sys.getenv(x = "R_MAX_NUM_DLLS", names = TRUE)
      )
}
other_diag <- function(){NULL}




## ----children-flag, echo=FALSE, include=FALSE, cache=FALSE----------------------------------------------------------
incl_all <- TRUE
















## ----child-r-maps, child='R.maps.Rnw', eval= FALSE------------------------------------------------------------------
## NA




## -------------------------------------------------------------------------------------------------------------------
Sys.info()


## ----eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------
## R.Version()


## -------------------------------------------------------------------------------------------------------------------
sessionInfo()

