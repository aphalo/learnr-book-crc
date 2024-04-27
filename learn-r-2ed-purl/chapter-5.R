## ----echo=FALSE, cache=FALSE--------------------------------------------------------------------------------------------
set_parent('r4p.main.Rnw')
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'scripts-chunk')


## ----setup-scripts, include=FALSE, cache=FALSE--------------------------------------------------------------------------
show.results <- FALSE


## ----evaluate=FALSE-----------------------------------------------------------------------------------------------------
source("my.first.script.r")


## ----eval=eval_playground-----------------------------------------------------------------------------------------------
a <- 2 # height
b <- 4 # length
C <-
    a *
b
C -> variable
      print(
"area: ", variable
)


## ----compound-1---------------------------------------------------------------------------------------------------------
print("...")
{
  print("A")
  print("B")
}
print("...")


## ----compound-2---------------------------------------------------------------------------------------------------------
{1 + 2; 3 + 4}


## ----compound-3, eval=eval_playground-----------------------------------------------------------------------------------
{1 + 2; {a <- 3 + 4; a + 1}}


## ----fun-calls-01-------------------------------------------------------------------------------------------------------
a <- log10(100)
print(a)


## ----fun-calls-02-------------------------------------------------------------------------------------------------------
print(log10(100))


## stdin | grep("abc") | more

## ----pipes-r-02---------------------------------------------------------------------------------------------------------
sum(sqrt(1:10))


## ----pipes-r-03---------------------------------------------------------------------------------------------------------
data.in <- 1:10
data.tmp <- sqrt(data.in)
sum(data.tmp)
rm(data.tmp) # clean up!


## ----pipes-r-04---------------------------------------------------------------------------------------------------------
1:10 |> sqrt() |> sum()


## ----pipes-r-04a--------------------------------------------------------------------------------------------------------
1:10 |> sqrt() |> sum() -> my_rhs.var
my_rhs.var


## ----pipes-r-04b--------------------------------------------------------------------------------------------------------
my_lhs.var <- 1:10 |> sqrt() |> sum()
my_lhs.var


## ----pipes-r-05---------------------------------------------------------------------------------------------------------
1:10 |> sqrt(x = _) |> sum(x = _)


## ----pipes-r-05a--------------------------------------------------------------------------------------------------------
1:10 |> sqrt(x = _) |> _[2:8] |> sum(x = _)


## ----pipes-box-pipes-02-------------------------------------------------------------------------------------------------
obj.name <- "data.out"
1:10 |> sqrt() |> sum() |> assign(x = obj.name, value = _)


## ----pipes-box-pipes-03-------------------------------------------------------------------------------------------------
value_assign <- function(value, x, ...) {
  assign(x = x, value = value, ...)
}
obj.name <- "data.out"
1:10 |> sqrt() |> sum() |> value_assign(obj.name)


## ----pipes-r-06---------------------------------------------------------------------------------------------------------
data.frame(x = 1:10, y = rnorm(10)) |>
  within(data = _,
         {
           x4 <- x^4
           is.large <- x^4 > 1000
         }) |>
  subset(x = _, is.large)


## ----pipes-r-06aa, eval=eval_playground---------------------------------------------------------------------------------
data.frame(x = 1:10, y = rnorm(10)) |>
  within({x4 <- x^4; is.large <- x^4 > 1000}) |>
  subset(is.large)


## ----pipes-r-06a--------------------------------------------------------------------------------------------------------
data.frame(x = 1:10, y = rnorm(10)) |>
  within(data = _,
         {
           x4 <- x^4
           is.large <- x^4 > 1000
         }) |>
  subset(x = _, is.large, select = -x)


## ----pipes-r-06b--------------------------------------------------------------------------------------------------------
data.frame(x = 1:10, y = rnorm(10)) |>
  within(data = _,
         {
           x4 <- x^4
           is.large <- x^4 > 1000
         }) |>
  subset(x = _, select = c(y, x4))


## ----pipes-r-07---------------------------------------------------------------------------------------------------------
data.frame(group = factor(rep(c("T1", "T2", "Ctl"), each = 4)),
           y = rnorm(12)) |>
  subset(x = _, group %in% c("T1", "T2")) |>
  aggregate(data = _, y ~ group, mean)


## ----pipes-r-09---------------------------------------------------------------------------------------------------------
data.frame(group = factor(rep(c("T1", "T2", "Ctl"), each = 4)),
           y = rnorm(12)) |>
  subset(x = _, group %in% c("T1", "T2")) |>
  aggregate(data = _, y ~ group, mean) |>
  _[["y"]]


## ----if-1z--------------------------------------------------------------------------------------------------------------
flag <- TRUE
if (flag) print("Hello!")


## ----if-1---------------------------------------------------------------------------------------------------------------
if (FALSE) print("Hello!")


## ----if-2---------------------------------------------------------------------------------------------------------------
printing <- TRUE
if (printing) {
  print("A")
  print("B")
}


## ----if-3---------------------------------------------------------------------------------------------------------------
a <- 10
if (a < 0) print("'a' is negative") else print("'a' is not negative")
print("This is always printed")


## ----auxiliary, echo=FALSE, include = FALSE, eval=TRUE------------------------------------------------------------------
show.results <- TRUE
if (show.results) eval.if.4 <- c(1:4) else eval.if.4 <- FALSE
# eval.if.4
show.results <- FALSE
if (show.results) eval.if.4 <- c(1:4) else eval.if.4 <- FALSE
#eval.if.4


## ----if-4---------------------------------------------------------------------------------------------------------------
# 1
a <- 1
if (a < 0) print("'a' is negative") else print("'a' is not negative")


## ----if-4a, eval=FALSE--------------------------------------------------------------------------------------------------
## # 2 (not evaluated here)
## if (a < 0) print("'a' is negative")
## else print("'a' is not negative")


## ----if-4b--------------------------------------------------------------------------------------------------------------
# 1
a <- 1
if (a < 0) {
    print("'a' is negative")
  } else {
    print("'a' is not negative")
  }


## ----if-4c--------------------------------------------------------------------------------------------------------------
a <- 1
my.message <-
  if (a < 0) "'a' is negative" else "'a' is not negative"
print(my.message)


## ----if-explain_conv----------------------------------------------------------------------------------------------------
message <- "abc"
if (length(message)) print(message)


## ----if-PG-01, eval=FALSE-----------------------------------------------------------------------------------------------
## if (0) print("hello")
## if (-1) print("hello")
## if (0.01) print("hello")
## if (1e-300) print("hello")
## if (1e-323) print("hello")
## if (1e-324) print("hello")
## if (1e-500) print("hello")
## if (as.logical("true")) print("hello")
## if (as.logical(as.numeric("1"))) print("hello")
## if (as.logical("1")) print("hello")
## if ("1") print("hello")


## -----------------------------------------------------------------------------------------------------------------------
my.object <- "two"
b <- switch(my.object,
            one = 1,
            two = 1 / 2,
            four = 1 / 4,
            0
)
b


## -----------------------------------------------------------------------------------------------------------------------
my.object <- "two"
b <- switch(my.object,
            one =, uno = 1,
            two =, dos = 1 / 2,
            four =, cuatro = 1 / 4,
            0
)
b


## -----------------------------------------------------------------------------------------------------------------------
my.number <- 2
b <- switch(my.number,
            1,
            1 / 2,
            1 / 4,
            0
)
b


## ----explain-switch-01--------------------------------------------------------------------------------------------------
my.object <- "ten"
b <- switch(my.object,
            one = 1,
            two = 1 / 2,
            three = 1 / 4,
            {print("No match! Using default"); 0}
)
b


## ----explain-switch-11--------------------------------------------------------------------------------------------------
my.object <- "two"
if (my.object == "one") {
  b <- 1
} else if (my.object == "two") {
  b <- 1 / 2
} else if (my.object == "four") {
  b <- 1 / 4
} else {
  b <- 0
}
b


## ----ifelse-0-----------------------------------------------------------------------------------------------------------
my.test <- c(TRUE, FALSE, TRUE, TRUE)
ifelse(test = my.test, yes = 1, no = -1)


## ----ifelse-0a----------------------------------------------------------------------------------------------------------
nums <- -3:+3
ifelse(nums < 0, -nums, nums)


## -----------------------------------------------------------------------------------------------------------------------
ifelse(TRUE, 1:5, -5:-1)
ifelse(FALSE, 1:5, -5:-1)
ifelse(c(TRUE, FALSE), 1:5, -5:-1)
ifelse(c(FALSE, TRUE), 1:5, -5:-1)
ifelse(c(FALSE, TRUE), 1:5, 0)


## ----ifelse-1, eval=eval_playground-------------------------------------------------------------------------------------
a <- 1:10
ifelse(a > 5, 1, -1)
ifelse(a > 5, a + 1, a - 1)
ifelse(any(a > 5), a + 1, a - 1) # tricky
ifelse(logical(0), a + 1, a - 1) # even more tricky
ifelse(NA, a + 1, a - 1) # as expected


## ----ifelse-2, eval=eval_playground-------------------------------------------------------------------------------------
a <- -10:-1
b <- +1:10
c <- c(rep("a", 5), rep("b", 5))
# your code


## ----for-00-------------------------------------------------------------------------------------------------------------
b <- 0 # variable needs to set to a valid numeric value!
for (a in 1:5) b <- b + a
b


## ----for-unrolled-------------------------------------------------------------------------------------------------------
b <- 0
# start of loop
# first iteration
a <- 1
b <- b + a
# second iteration
a <- 2
b <- b + a
# third iteration
a <- 3
b <- b + a
# fourth iteration
a <- 4
b <- b + a
# fifth iteration
a <- 5
b <- b + a
# end of loop
b


## ----for-replaced-by-sum------------------------------------------------------------------------------------------------
sum(1:5)


## ----for-00a------------------------------------------------------------------------------------------------------------
b <- 0
for (a in numeric()) b <- b + a
print(b)


## ----for-01-------------------------------------------------------------------------------------------------------------
a <- c(1, 4, 3, 6, 8)
for(x in a) {
  b <- x*2
  print(b)
  }


## ----for-02-------------------------------------------------------------------------------------------------------------
b <- for(x in a) x*2
x
b


## ----for-03a------------------------------------------------------------------------------------------------------------
b <- numeric() # an empty vector
for(i in seq(along.with = a)) {
  b[i] <- a[i]^2
}
b


## ----for-03d, eval=eval_playground--------------------------------------------------------------------------------------
b <- numeric() # an empty vector
for(i in seq(along.with = a)) {
  b[i] <- a[i]^2
  print(i)
  print(a)
  print(b)
}
b


## ----for-04, eval=eval_playground---------------------------------------------------------------------------------------
A <- -5:5 # assign different numeric vector to A
B <- numeric(length(A))
for(i in seq(along.with = A)) {
  B[i] <- A[i]^2
}
B

C <- numeric(length(A))
for(i in 1:length(A)) {
  C[i] <- A[i]^2
}
C


## ----for-03c------------------------------------------------------------------------------------------------------------
b <- a^2
b


## ----for-05-------------------------------------------------------------------------------------------------------------
b <- 0
a <- -10:100
idxs <- seq_along(a)
for(i in idxs) {
  if (a[i] < 0) next()
  b <- b + a[i]
  if (b > 100) break()
}
b
i
a[i]


## ----while-02-----------------------------------------------------------------------------------------------------------
a <- 2
while (a < 50) {
  print(a)
  a <- a^2
}
print(a)


## ----while-03, eval=eval_playground-------------------------------------------------------------------------------------
a <- 2
print(a)
while (a < 50) print(a <- a^2)


## ----while-04, eval=eval_playground-------------------------------------------------------------------------------------
a <- b <- c <- 1:5
a


## ----while-05-----------------------------------------------------------------------------------------------------------
a <- c(1, 4, 3, 6, 8)
b <- numeric() # an empty vector
i <- 1
while(i <= length(a)) {
  b[i] <- a[i]^2
  print(b)
  i <- i + 1
}
b


## ----repeat-1-----------------------------------------------------------------------------------------------------------
a <- 2
repeat{
  print(a)
  if (a > 50) break()
  a <- a^2
}


## ----nested-1-----------------------------------------------------------------------------------------------------------
A <- matrix(1:50, nrow = 10)
A


## ----nested-22----------------------------------------------------------------------------------------------------------
row.sum <- numeric()
for (i in 1:nrow(A)) {
  row.sum[i] <- 0
  for (j in 1:ncol(A))
    row.sum[i] <- row.sum[i] + A[i, j]
}
print(row.sum)


## ----apply-00-----------------------------------------------------------------------------------------------------------
set.seed(123456) # so that vct1 does not change
vct1 <- runif(6) # A short vector as input to keep output short
str(vct1)


## ----apply-01a----------------------------------------------------------------------------------------------------------
z <- lapply(X = vct1, FUN = log)
str(z)


## ----apply-02-----------------------------------------------------------------------------------------------------------
z <- sapply(X = vct1, FUN = log)
str(z)


## ----apply-03, eval=eval_playground-------------------------------------------------------------------------------------
z <- sapply(X = vct1, FUN = log, simplify = FALSE)
str(z)


## ----apply-01b----------------------------------------------------------------------------------------------------------
z <- sapply(X = vct1, FUN = log, base = 10)
str(z)


## ----apply-04-----------------------------------------------------------------------------------------------------------
z <- sapply(X = vct1, FUN = function(x) {log10(x + 1)})
str(z)


## ----apply-05a----------------------------------------------------------------------------------------------------------
sapply(X = cars, FUN = mean)


## ----apply-07-----------------------------------------------------------------------------------------------------------
mean_and_sd <-
  function(x, na.rm = FALSE) {
    c(mean = mean(x, na.rm = na.rm),  sd = sd(x, na.rm = na.rm))
  }


## ----apply-07b----------------------------------------------------------------------------------------------------------
values <- vapply(X = cars,
                 FUN = mean_and_sd,
                 FUN.VALUE = c(mean = 0, sd = 0),
                 na.rm = TRUE)
class(values)
values


## ----apply-06-----------------------------------------------------------------------------------------------------------
set.seed(123456)
ls1 <- lapply(X = c(v1 = 2, v2 = 5, v3 = 3, v4 = 1, v5 = 4),
              FUN = rnorm, mean = 10, sd = 1)
str(ls1)


## ----apply-10-----------------------------------------------------------------------------------------------------------
mat1 <- matrix(rnorm(6, mean = 10, sd = 1), ncol = 2)
mat1 <- round(mat1, digits = 1)
dimnames(mat1) <- # add row and column names
  list(paste("row", 1:nrow(mat1)), paste("col", 1:ncol(mat1)))
mat1


## ----apply-08-----------------------------------------------------------------------------------------------------------
apply(mat1, MARGIN = 2, FUN = mean)


## ----apply-11-----------------------------------------------------------------------------------------------------------
z <- apply(X = mat1, MARGIN = 2, FUN = I)
dim(z)
z


## ----apply-12-----------------------------------------------------------------------------------------------------------
z <- apply(X = mat1, MARGIN = 1, FUN = I)
dim(z)
z


## ----apply-13-----------------------------------------------------------------------------------------------------------
z <- apply(X = mat1, MARGIN = 2, FUN = summary)
z


## ----apply-14-----------------------------------------------------------------------------------------------------------
z <- apply(X = mat1, MARGIN = 1, FUN = summary)
z


## ----apply-15-----------------------------------------------------------------------------------------------------------
set.seed(123456) # so that vct1 does not change
vct1 <- runif(10)
z <- sapply(X = vct1, FUN = `+`, e2 = 5)
str(z)


## ----loops-function-names-----------------------------------------------------------------------------------------------
vct1 <- rnorm(10)
results <- numeric()
fun.names <- c("mean", "max", "min")
for (f.name in fun.names) {
  results[[f.name]] <- do.call(f.name, list(vct1))
}
results


## ----loops-functions-1--------------------------------------------------------------------------------------------------
results <- numeric()
funs <- list(mean, max, min)
for (f in funs) {
  results <- c(results, f(x))
}
results


## ----loops-functions-2--------------------------------------------------------------------------------------------------
results <- numeric()
funs <- list(average = mean, maximum = max, minimum = min)
for (f in names(funs)) {
  results[[f]] <- funs[[f]](x)
}
results


## ----loops-formulas-1---------------------------------------------------------------------------------------------------
my.data <- data.frame(x = 1:10, y = 1:10 + rnorm(10, 1, 0.1))
results <- list()
models <- list(linear = y ~ x, linear.orig = y ~ x - 1, quadratic = y ~ x + I(x^2))
for (m in names(models)) {
  results[[m]] <- lm(models[[m]], data = my.data)
}
str(results, max.level = 1)
do.call(anova, unname(results))


## ----loops-formulas-2---------------------------------------------------------------------------------------------------
results <- list()
models <- list(y ~ x, y ~ x - 1, y ~ x + I(x^2))
for (i in seq(along.with = models)) {
  results[[i]] <- lm(models[[i]], data = my.data)
}
str(results, max.level = 1)
do.call(anova, results)


## ----include=FALSE, cache=FALSE-----------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide_square)


## ----bench-diff-01, echo=FALSE------------------------------------------------------------------------------------------
library(scales)
library(ggplot2)
library(patchwork)

load("benchmarks.pantera.Rda")

fig.seconds <-
  ggplot(summaries,
         aes(x = size, y = median*1e-3,
         color = loop, shape = loop)) +
  geom_point() +
  geom_line() +
  scale_x_log10(name = "Vector length (n)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(name = "Time (s)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_color_discrete(name = "Iteration\napproach") +
  scale_shape(name = "Iteration\napproach", solid = TRUE) +
  expand_limits(y = 1e-6) +
  theme_bw(14)

fig.rel <-
  ggplot(rel.summaries,
         aes(x = size, y = median, color = loop, shape = loop)) +
  geom_point() +
  geom_line() +
  scale_x_log10(name = "Vector length (n)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(name = "Time (relative to shortest)",
                breaks = c(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000)) +
  scale_color_discrete(name = "Iteration\napproach") +
  scale_shape(name = "Iteration\napproach", solid = TRUE) +
  theme_bw(14)

print(fig.seconds / fig.rel + plot_layout(guides = "collect"))


## ----include=FALSE, cache=FALSE-----------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----loops-while-0, eval=FALSE------------------------------------------------------------------------------------------
## b <- numeric() # do not pre-allocate memory
## i <- 1
## while (i < length(a)) {
##   b[i] <- a[i+1] - a[i]
##   i <- i + 1
## }


## ----loops-while-1, eval=FALSE------------------------------------------------------------------------------------------
## b <- numeric(length(a)-1) # pre-allocate memory
## i <- 1
## while (i < length(a)) {
##   b[i] <- a[i+1] - a[i]
##   i <- i + 1
## }


## ----loops-for-2, eval=FALSE--------------------------------------------------------------------------------------------
## b <- numeric() # do not pre-allocate memory
## for(i in seq(along.with = b)) {
##   b[i] <- a[i+1] - a[i]
## }


## ----loops-for-2a, eval=FALSE-------------------------------------------------------------------------------------------
## b <- numeric(length(a)-1) # pre-allocate memory
## for(i in seq(along.with = b)) {
##   b[i] <- a[i+1] - a[i]
## }


## ----loops-vectorised-, eval=FALSE--------------------------------------------------------------------------------------
## # vectorised using extraction operators
## b <- a[2:length(a)] - a[1:length(a)-1]


## ----loops-r-function-2, eval=FALSE-------------------------------------------------------------------------------------
## # vectorised function diff()
## b <- diff(a)


## ----include=FALSE, cache=FALSE-----------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide_square)


## ----bench-rowsums-01, echo=FALSE---------------------------------------------------------------------------------------
#library(scales)
#library(ggplot2)
#library(patchwork)

load("benchmarks-rowSums-pantera.Rda")

fig.seconds <-
  ggplot(summaries,
         aes(x = size, y = median*1e-3, color = loop, shape = loop)) +
  geom_point() +
  geom_line() +
  scale_x_log10(name = "Matrix size (n)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(name = "Time (s)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_color_discrete(name = "Iteration\napproach") +
  scale_shape(name = "Iteration\napproach", solid = TRUE) +
  expand_limits(y = 1e-6) +
  theme_bw(14)

fig.rel <-
  ggplot(rel.summaries,
         aes(x = size, y = median, color = loop, shape = loop)) +
  geom_point() +
  geom_line() +
  scale_x_log10(name = "Matrix size (n)",
                breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_y_log10(name = "Time (relative to shortest)",
                breaks = c(1, 2, 5, 10, 20, 50, 100, 200, 500, 1000)) +
  scale_color_discrete(name = "Iteration\napproach") +
  scale_shape(name = "Iteration\napproach", solid = TRUE) +
  theme_bw(14)

print(fig.seconds / fig.rel + plot_layout(guides = "collect"))


## ----include=FALSE, cache=FALSE-----------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----nested-22, eval=FALSE----------------------------------------------------------------------------------------------
## row.sum <- numeric()
## for (i in 1:nrow(A)) {
##   row.sum[i] <- 0
##   for (j in 1:ncol(A))
##     row.sum[i] <- row.sum[i] + A[i, j]
## }
## print(row.sum)


## ----nested-3, eval=FALSE-----------------------------------------------------------------------------------------------
## row.sum <- numeric(nrow(A)) # faster
## for (i in 1:nrow(A)) {
##   row.sum[i] <- sum(A[i, ])
## }


## ----nested-4, eval=FALSE-----------------------------------------------------------------------------------------------
## row.sum <- apply(A, MARGIN = 1, sum) # MARGIN=1 indicates rows


## ----nested-5, eval=FALSE-----------------------------------------------------------------------------------------------
## rowSums(A)


## ----assignx-01---------------------------------------------------------------------------------------------------------
assign("a", 9.99)
a


## ----assignx-01a--------------------------------------------------------------------------------------------------------
name.of.var <- "b"
assign(name.of.var, 9.99)
b


## ----assignx-02---------------------------------------------------------------------------------------------------------
for (i in 1:5) {
   assign(paste("square_of_", i, sep = ""), i^2)
}
ls(pattern = "square_of_*")


## ----assignx-03---------------------------------------------------------------------------------------------------------
get("a")
get("b")


## ----assignx-04---------------------------------------------------------------------------------------------------------
obj_names <- ls(pattern = "square_of_*")
obj_lst <- mget(obj_names)
str(obj_lst)


## ----on-exit-01---------------------------------------------------------------------------------------------------------
file.create("temp.file")
on.exit(file.remove("temp.file"))
# code that makes use of the file goes here


## ----cleanup-02---------------------------------------------------------------------------------------------------------
detach(package:patchwork)
detach(package:ggplot2)
detach(package:scales)

