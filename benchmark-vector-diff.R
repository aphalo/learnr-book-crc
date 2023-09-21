library(microbenchmark)
library(ggplot2)
library(patchwork)

powers <- 1:8

benchmarks <- list()

for (i in powers) {
  cat("Doing", i, "...")
  gc()

  a <- rnorm(10^i)

  benchmarks[[paste("size",
                    length(a),
                    sep = ".")]] <-
    microbenchmark(
      {
        b <- numeric() # do not pre-allocate memory
        i <- 1
        while (i < length(a)) {
          b[i] <- a[i+1] - a[i]
          i <- i + 1
        }
        b
      },
      {
        b <- numeric(length(a)-1) # pre-allocate memory
        i <- 1
        while (i < length(a)) {
          b[i] <- a[i+1] - a[i]
          i <- i + 1
        }
        b
      },
      {
        b <- numeric() # do not pre-allocate memory
        for(i in seq(along.with = a)) {
          b[i] <- a[i+1] - a[i]
        }
        b
      },
      {
        b <- numeric(length(a)-1) # pre-allocate memory
        for(i in seq(along.with = a)) {
          b[i] <- a[i+1] - a[i]
        }
        b
      },
      {
        b <- a[2:length(a)] - a[1:length(a)-1]
        b
      },
      {
        b <- diff(a)
        b
      },
      times = c(300L, 300L, 300L, 200L, 100L, 50L, 25L, 12L)[i]
    )
  cat(" done\n")
}

summaries <- data.frame()
for (b in benchmarks) {
  summaries <-
    rbind(summaries,
          summary(b, unit = "millisecond")[ , c("expr", "median", "cld")])
}
summaries
summaries$size <- rep(10^powers, each = 6)
summaries$loop <- summaries$expr
levels(summaries$loop) <- c("while", "while prealloc.",
                            "for", "for prealloc.",
                            "extract",
                            "diff")

colnames(summaries)

fig.seconds <-
  ggplot(summaries, aes(size, median*1e-3, color = loop)) +
  geom_point() +
  geom_line() +
  scale_x_log10(name = "Vector length") +
  scale_y_log10(name = "Time (s)") +
  scale_color_discrete(name = "Iteration\napproach") +
  theme_bw() # + theme(legend.position = "top")
fig.seconds

rel.summaries <- data.frame()
for (b in benchmarks) {
  rel.summaries <-
    rbind(rel.summaries,
          summary(b, unit = "relative")[ , c("expr", "median", "cld")])
}
rel.summaries
rel.summaries$size <- rep(10^powers, each = 6)
rel.summaries$loop <- rel.summaries$expr
levels(rel.summaries$loop) <- c("while", "while prealloc.",
                            "for", "for prealloc.",
                            "extract",
                            "diff")

colnames(rel.summaries)

fig.rel <-
  ggplot(rel.summaries, aes(size, median, color = loop)) +
  geom_point() +
  geom_line() +
  scale_x_log10(name = "Vector length") +
  scale_y_log10(name = "Time (relative to shortest)",
                breaks = c(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000)) +
  scale_color_discrete(name = "Iteration\napproach") +
  theme_bw() # + theme(legend.position = "none")
fig.rel

diff.benchmark.fig <-
fig.seconds / fig.rel + plot_layout(guides = "collect")
diff.benchmark.fig

# save(diff.benchmark.fig,
#      fig.seconds,
#      fig.rel,
#      summaries,
#      rel.summaries,
#      file = "benchmarks.pantera.Rda")

save(diff.benchmark.fig,
     fig.seconds,
     fig.rel,
     summaries,
     rel.summaries,
     file = "benchmarks.carbonilla.Rda")
