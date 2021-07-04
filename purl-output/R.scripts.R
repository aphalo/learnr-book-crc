## ----echo=FALSE, cache=FALSE----------------------------------------------------------------------------------------
set_parent('r4p.main.Rnw')
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'scripts-chunk')


## ----setup-scripts, include=FALSE, cache=FALSE----------------------------------------------------------------------
show.results <- FALSE


## ----evaluate=FALSE-------------------------------------------------------------------------------------------------
source("my.first.script.r")




## ----compound-1-----------------------------------------------------------------------------------------------------
print("A")
{
  print("B")
  print("C")
}


## ----if-1z----------------------------------------------------------------------------------------------------------
flag <- TRUE
if (flag) print("Hello!")


## ----if-1-----------------------------------------------------------------------------------------------------------
if (TRUE) print("Hello!")


## ----if-2-----------------------------------------------------------------------------------------------------------
printing <- TRUE
if (printing) {
  print("A")
  print("B")
}


## ----if-3-----------------------------------------------------------------------------------------------------------
a <- 10.0
if (a < 0.0) print("'a' is negative") else print("'a' is not negative")
print("This is always printed")


## ----auxiliary, echo=FALSE, include = FALSE, eval=TRUE--------------------------------------------------------------
show.results <- TRUE
if (show.results) eval.if.4 <- c(1:4) else eval.if.4 <- FALSE
# eval.if.4
show.results <- FALSE
if (show.results) eval.if.4 <- c(1:4) else eval.if.4 <- FALSE
#eval.if.4


## ----if-4-----------------------------------------------------------------------------------------------------------
# 1
a <- 1
if (a < 0.0) print("'a' is negative") else print("'a' is not negative")


## ----if-4a, eval=FALSE----------------------------------------------------------------------------------------------
## # 2 (not evaluated here)
## if (a < 0.0) print("'a' is negative")
## else print("'a' is not negative")


## ----if-4b----------------------------------------------------------------------------------------------------------
# 1
a <- 1
if (a < 0.0) {
    print("'a' is negative")
  } else {
    print("'a' is not negative")
  }


## ----if-4c----------------------------------------------------------------------------------------------------------
a <- 1
my.message <-
  if (a < 0.0) "'a' is negative" else "'a' is not negative"
print(my.message)


## ----if-PG-01, eval=FALSE-------------------------------------------------------------------------------------------
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


## -------------------------------------------------------------------------------------------------------------------
my.object <- "two"
b <- switch(my.object,
            one = 1,
            two = 1 / 2,
            three = 1 / 4,
            0
)
b


## ----ifelse-0-------------------------------------------------------------------------------------------------------
my.test <- c(TRUE, FALSE, TRUE, TRUE)
ifelse(test = my.test, yes = 1, no = -1)


## ----ifelse-0a------------------------------------------------------------------------------------------------------
nums <- -3:+3
ifelse(nums < 0, -nums, nums)




## -------------------------------------------------------------------------------------------------------------------
ifelse(TRUE, 1:5, -5:-1)
ifelse(FALSE, 1:5, -5:-1)
ifelse(c(TRUE, FALSE), 1:5, -5:-1)
ifelse(c(FALSE, TRUE), 1:5, -5:-1)
ifelse(c(FALSE, TRUE), 1:5, 0)




## ----for-0----------------------------------------------------------------------------------------------------------
b <- 0
for (a in 1:5) b <- b + a
b
b <- sum(1:5) # built-in function (faster)
b


## ----for-1----------------------------------------------------------------------------------------------------------
a <- c(1, 4, 3, 6, 8)
for(x in a) {print(x*2)} # print is needed!


## ----for-1a---------------------------------------------------------------------------------------------------------
b <- for(x in a) {x*2}
b

b <- numeric()
for(i in seq(along.with = a)) {
  b[i] <- a[i]^2
  print(b)
}
b

# runs faster if we first allocate a long enough vector
b <- numeric(length(a))
for(i in seq(along.with = a)) {
  b[i] <- a[i]^2
  print(b)
}
b
# a vectorized expression is simplest and fastest
b <- a^2
b




## ----while-2--------------------------------------------------------------------------------------------------------
a <- 2
while (a < 50) {
  print(a)
  a <- a^2
}
print(a)






## ----repeat-1-------------------------------------------------------------------------------------------------------
a <- 2
repeat{
  print(a)
  if (a > 50) break()
  a <- a^2
}


## ----loops-timing-01------------------------------------------------------------------------------------------------
system.time({a <- numeric()
            for (i in 1:1000000) {
              a[i] <- i / 1000
              }
            })


## ----loops-data-1, eval=FALSE---------------------------------------------------------------------------------------
## a <- rnorm(10^7) # 10 000 0000 pseudo-random numbers


## ----loops-while-1, eval=FALSE--------------------------------------------------------------------------------------
## # b <- numeric()
## b <- numeric(length(a)-1) # pre-allocate memory
## i <- 1
## while (i < length(a)) {
##   b[i] <- a[i+1] - a[i]
##   print(b)
##   i <- i + 1
## }
## b


## ----loops-for-2, eval=FALSE----------------------------------------------------------------------------------------
## # b <- numeric()
## b <- numeric(length(a)-1) # pre-allocate memory
## for(i in seq(along.with = b)) {
##   b[i] <- a[i+1] - a[i]
##   print(b)
## }
## b


## ----loops-vectorized-, eval=FALSE----------------------------------------------------------------------------------
## # although in this case there were alternatives, there
## # are other cases when we need to use indexes explicitly
## b <- a[2:length(a)] - a[1:length(a)-1]
## b


## ----loops-r-function-2, eval=FALSE---------------------------------------------------------------------------------
## # or even better
## b <- diff(a)
## b


## ----nested-1-------------------------------------------------------------------------------------------------------
A <- matrix(1:50, 10)
A


## ----nested-22------------------------------------------------------------------------------------------------------
row.sum <- numeric()
for (i in 1:nrow(A)) {
  row.sum[i] <- 0
  for (j in 1:ncol(A))
    row.sum[i] <- row.sum[i] + A[i, j]
}
print(row.sum)


## ----nested-3-------------------------------------------------------------------------------------------------------
row.sum <- numeric(nrow(A)) # faster
for (i in 1:nrow(A)) {
  row.sum[i] <- sum(A[i, ])
}
print(row.sum)


## ----nested-4-------------------------------------------------------------------------------------------------------
row.sum <- apply(A, MARGIN = 1, sum) # MARGIN=1 indicates rows
print(row.sum)


## ----nested-5-------------------------------------------------------------------------------------------------------
rowSums(A)


## ----on-exit-01-----------------------------------------------------------------------------------------------------
file.create("temp.file")
on.exit(file.remove("temp.file"))
# code that makes use of the file goes here


## ----apply-01-------------------------------------------------------------------------------------------------------
set.seed(123456) # so that a.vector does not change
a.vector <- runif(6) # A short vector as input to keep output short
str(a.vector)


## ----apply-01a------------------------------------------------------------------------------------------------------
my.fun <- function(x, k) {log(x) + k}


## ----apply-01b------------------------------------------------------------------------------------------------------
z <- lapply(X = a.vector, FUN = my.fun, k = 5)
str(z)


## ----apply-02-------------------------------------------------------------------------------------------------------
z <- sapply(X = a.vector, FUN = my.fun, k = 5)
str(z)


## ----apply-03-------------------------------------------------------------------------------------------------------
z <- sapply(X = a.vector, FUN = my.fun, k = 5, simplify = FALSE)
str(z)


## ----apply-04-------------------------------------------------------------------------------------------------------
z <- sapply(X = a.vector, FUN = function(x, k) {log(x) + k}, k = 5)
str(z)


## ----apply-05-------------------------------------------------------------------------------------------------------
z <- log(a.vector) + 5
str(z)


## ----apply-06-------------------------------------------------------------------------------------------------------
set.seed(123456)
a.list <- lapply(rep(4, 5), rnorm, mean = 10, sd = 1)
str(a.list)


## ----apply-07-------------------------------------------------------------------------------------------------------
mean_and_sd <- function(x, na.rm = FALSE) {
       c(mean(x, na.rm = na.rm),  sd(x, na.rm = na.rm))
    }


## ----apply-07b------------------------------------------------------------------------------------------------------
values <- vapply(X = a.list,
                 FUN = mean_and_sd,
                 FUN.VALUE = c(mean = 0, sd = 0),
                 na.rm = TRUE)
class(values)
values


## ----apply-08-------------------------------------------------------------------------------------------------------
a.matrix <- matrix(runif(100), ncol = 10)
z <- apply(a.matrix, MARGIN = 1, FUN = mean)
str(z)


## ----apply-10-------------------------------------------------------------------------------------------------------
a.small.matrix <- matrix(rnorm(6, mean = 10, sd = 1), ncol = 2)
a.small.matrix <- round(a.small.matrix, digits = 1)
a.small.matrix


## ----apply-10a------------------------------------------------------------------------------------------------------
no_op.fun <- function(x) {x}


## ----apply-11-------------------------------------------------------------------------------------------------------
z <- apply(X = a.small.matrix, MARGIN = 2, FUN = no_op.fun)
class(z)
z


## ----apply-12-------------------------------------------------------------------------------------------------------
z <- apply(X = a.small.matrix, MARGIN = 1, FUN = no_op.fun)
z
t(z)


## ----apply-13-------------------------------------------------------------------------------------------------------
mean_and_sd <- function(x, na.rm = FALSE) {
       c(mean(x, na.rm = na.rm),  sd(x, na.rm = na.rm))
    }


## ----apply-13a------------------------------------------------------------------------------------------------------
z <- apply(X = a.small.matrix, MARGIN = 2, FUN = mean_and_sd, na.rm = TRUE)
z


## ----apply-14-------------------------------------------------------------------------------------------------------
z <- apply(X = a.small.matrix, MARGIN = 1, FUN = mean_and_sd, na.rm = TRUE)
z


## ----apply-15-------------------------------------------------------------------------------------------------------
set.seed(123456) # so that a.vector does not change
a.vector <- runif(10)
z <- sapply(X = a.vector, FUN = `+`, e2 = 5)
str(z)


## ----assignx-01-----------------------------------------------------------------------------------------------------
assign("a", 9.99)
a


## ----assignx-01a----------------------------------------------------------------------------------------------------
name.of.var <- "b"
assign(name.of.var, 9.99)
b


## ----assignx-02-----------------------------------------------------------------------------------------------------
for (i in 1:5) {
   assign(paste("zz_", i, sep = ""), i^2)
}
ls(pattern = "zz_*")


## ----assignx-03-----------------------------------------------------------------------------------------------------
get("a")
get("b")


## ----assignx-04-----------------------------------------------------------------------------------------------------
obj_names <- ls(pattern = "zz_*")
obj_lst <- mget(obj_names)
str(obj_lst)


## ----loops-function-names-------------------------------------------------------------------------------------------
x <- rnorm(10)
results <- numeric()
fun.names <- c("mean", "max", "min")
for (f.name in fun.names) {
   results[[f.name]] <- do.call(f.name, list(x))
   }
results


## ----loops-functions-1----------------------------------------------------------------------------------------------
results <- numeric()
funs <- list(mean, max, min)
for (f in funs) {
   results <- c(results, f(x))
   }
results


## ----loops-functions-2----------------------------------------------------------------------------------------------
results <- numeric()
funs <- list(average = mean, maximum = max, minimum = min)
for (f in names(funs)) {
   results[[f]] <- funs[[f]](x)
   }
results


## ----loops-formulas-1-----------------------------------------------------------------------------------------------
my.data <- data.frame(x = 1:10, y = 1:10 + rnorm(10, 1, 0.1))
results <- list()
models <- list(linear = y ~ x, linear.orig = y ~ x - 1, quadratic = y ~ x + I(x^2))
for (m in names(models)) {
   results[[m]] <- lm(models[[m]], data = my.data)
   }
str(results, max.level = 1)
do.call(anova, unname(results))


## ----loops-formulas-2-----------------------------------------------------------------------------------------------
results <- list()
models <- list(y ~ x, y ~ x - 1, y ~ x + I(x^2))
for (i in seq(along.with = models)) {
   results[[i]] <- lm(models[[i]], data = my.data)
   }
str(results, max.level = 1)
do.call(anova, results)

