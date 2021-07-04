## ----setup-1, include=FALSE, cache=FALSE----------------------------------------------------------------------------
library(knitr)
library(svglite)


## ----setup-2, include=FALSE, cache=FALSE----------------------------------------------------------------------------
opts_knit$set(unnamed.chunk.label = 'main-chunk')
opts_knit$set(child.command = 'include')
opts_knit$set(self.contained=FALSE)
opts_chunk$set(fig.path='figure/pos-', fig.align='center', fig.show='hold', size="footnotesize", dev='cairo_pdf', dev.args=list(family='ArialMT'), cache=FALSE) #
opts_chunk$set(tidy=FALSE,size='footnotesize')
# options(replace.assign=TRUE,width=70,tidy.opts=list(blank=FALSE))


## ----fig-setup, include=FALSE, cache=FALSE--------------------------------------------------------------------------
opts_fig_very_wide <- list(fig.width=8, fig.height=3, out.width='.9\\textwidth')
opts_fig_very_wide_square <- list(fig.width=8, fig.height=8, out.width='.9\\textwidth')
opts_fig_wide <- list(fig.width=6, fig.height=3, out.width='.7\\textwidth')
opts_fig_wide_square <- list(fig.width=6, fig.height=6, out.width='.7\\textwidth')
opts_fig_narrow <- list(fig.width=4, fig.height=3, out.width='.54\\textwidth')
opts_fig_narrow_square <- list(fig.width=4, fig.height=4, out.width='.54\\textwidth')
opts_fig_very_narrow <- opts_fig_narrow
opts_fig_medium <- opts_fig_narrow
opts_chunk$set(opts_fig_narrow)


## ----playground-setup, include=FALSE, cache=FALSE-------------------------------------------------------------------
# playground code evaluation switch
# we do not want the code evaluated except when testing it
eval_playground <- FALSE


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


## ----define-cleanup, include=FALSE, cache=FALSE---------------------------------------------------------------------
# to be excluded from cleanup at end of sections/chapters
to.keep <- c("to.keep",
             "incl_all",
             "eval_playground",
             "filename",
             ls(pattern = "opts_fig*"),
             ls(pattern = "*_diag$"))




## ----children-flag, echo=FALSE, include=FALSE, cache=FALSE----------------------------------------------------------
incl_all <- TRUE

















## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## Sys.info()


## ----eval=FALSE, echo=FALSE-----------------------------------------------------------------------------------------
## R.Version()


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## sessionInfo()

