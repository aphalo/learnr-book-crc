library(microbenchmark)
library(ggplot2)
library(patchwork)

powers <- c(2, 4, 6, 8) # square matrices

benchmarks <- list()

for (i in powers) {
  cat("Doing", i, "...")
  gc()

  num_rows <- 10^(i %/% 2)
  A <- matrix(rnorm(10^i), nrow = num_rows)

  benchmarks[[paste("dimension",
                    paste(dim(A), collapse = "*"),
                    sep = " ")]] <-
    microbenchmark(
      {
        row.sum <- numeric()
        for (i in 1:nrow(A)) {
          row.sum[i] <- 0
          for (j in 1:ncol(A))
            row.sum[i] <- row.sum[i] + A[i, j]
        }
      },
      {
        row.sum <- numeric(nrow(A))
        for (i in 1:nrow(A)) {
          row.sum[i] <- 0
          for (j in 1:ncol(A))
            row.sum[i] <- row.sum[i] + A[i, j]
        }
      },
      {
        row.sum <- numeric()
        for (i in 1:nrow(A)) {
          row.sum[i] <- sum(A[i, ])
        }
      },
      {
        row.sum <- numeric(nrow(A))
        for (i in 1:nrow(A)) {
          row.sum[i] <- sum(A[i, ])
        }
      },
      {
        row.sum <- apply(A, MARGIN = 1, sum)
      },
      {
        row.sum <- rowSums(A)
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
levels(summaries$loop) <- c("nested for", "nested for alloc.",
                            "for and sum", "for and sum alloc.",
                            "apply and sum", "rowSums")

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
levels(rel.summaries$loop) <- c("nested for", "nested for alloc.",
                                "for and sum", "for and sum alloc.",
                                "apply and sum", "rowSums")

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
#      file = "benchmarks-rowSums-pantera.Rda")

save(diff.benchmark.fig,
     fig.seconds,
     fig.rel,
     summaries,
     rel.summaries,
     file = "benchmarks-rowSums-angus.Rda")
