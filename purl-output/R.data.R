## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'data-chunk')


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## install.packages(learnrbook::pkgs_ch_data)


## ----message=FALSE--------------------------------------------------------------------------------------------------
library(learnrbook)
library(tibble)
library(magrittr)
library(wrapr)
library(stringr)
library(dplyr)
library(tidyr)
library(lubridate)


## ----tibble-print-01------------------------------------------------------------------------------------------------
tibble(A = LETTERS[1:5], B = -2:2, C = seq(from = 1, to = 0, length.out = 5))


## ----tibble-print-02------------------------------------------------------------------------------------------------
options(tibble.print_max = 3, tibble.print_min = 3)


## ----tibble-info-01-------------------------------------------------------------------------------------------------
my.tb <- tibble(numbers = 1:3)
is_tibble(my.tb)
inherits(my.tb, "tibble")
class(my.tb)


## ----tibble-01------------------------------------------------------------------------------------------------------
show_classes <- function(x) {
  cat(
    paste(paste(class(x)[1],
    "containing:"),
    paste(names(x),
          sapply(x, class), collapse = ", ", sep = ": "),
    sep = "\n")
    )
}


## ----tibble-02------------------------------------------------------------------------------------------------------
my.df <- data.frame(codes = c("A", "B", "C"), numbers = 1:3, integers = 1L:3L)
is.data.frame(my.df)
is_tibble(my.df)
show_classes(my.df)


## ----tibble-03------------------------------------------------------------------------------------------------------
my.tb <- tibble(codes = c("A", "B", "C"), numbers = 1:3, integers = 1L:3L)
is.data.frame(my.tb)
is_tibble(my.tb)
show_classes(my.tb)


## ----tibble-04------------------------------------------------------------------------------------------------------
print(my.df)
print(my.tb)


## ----tibble-05------------------------------------------------------------------------------------------------------
my_conv.tb <- as_tibble(my.df)
is.data.frame(my_conv.tb)
is_tibble(my_conv.tb)
show_classes(my_conv.tb)


## ----tibble-06------------------------------------------------------------------------------------------------------
my_conv.df <- as.data.frame(my.tb)
is.data.frame(my_conv.df)
is_tibble(my_conv.df)
show_classes(my_conv.df)


## ----tibble-box-01--------------------------------------------------------------------------------------------------
class(my.tb)
class(my_conv.df)
my.tb == my_conv.df
identical(my.tb, my_conv.df)


## ----tibble-box-02--------------------------------------------------------------------------------------------------
my.xtb <- my.tb
class(my.xtb) <- c("xtb", class(my.xtb))
class(my.xtb)
my_conv_x.tb <- as_tibble(my.xtb)
class(my_conv_x.tb)
my.xtb == my_conv_x.tb
identical(my.xtb, my_conv_x.tb)


## ----tibble-07------------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 5:1, c = a + b, d = letters[a + 1])


## ----tibble-08------------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 5:1, c = list("a", 2, 3, 4, 5))


## ----tibble-09------------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 5:1, c = list("a", 1:2, 0:3, letters[1:3], letters[3:1]))


## stdin | grep("abc") | more


## ----pipes-x02------------------------------------------------------------------------------------------------------
data.in <- 1:10
data.tmp <- sqrt(data.in)
data.out <- sum(data.tmp)
rm(data.tmp) # clean up!


## ----pipes-x03------------------------------------------------------------------------------------------------------
data.out <- sum(sqrt(data.in))


## ----pipes-x04------------------------------------------------------------------------------------------------------
data.in %>% sqrt() %>% sum() -> data.out


## ----pipes-x05------------------------------------------------------------------------------------------------------
data.in %.>% sqrt(.) %.>% sum(.) -> data1.out


## ----pipes-x05a-----------------------------------------------------------------------------------------------------
data.in %>% sqrt(.) %>% sum(.) -> data2.out
all.equal(data1.out, data2.out)


## ----pipes-x06------------------------------------------------------------------------------------------------------
data.in %.>% assign(value = ., x = "data3.out")
all.equal(data.in, data3.out)


## ----pipes-x06a-----------------------------------------------------------------------------------------------------
data.in %>% assign(value = ., x = "data4.out")
exists("data4.out")


## ----pipes-x07------------------------------------------------------------------------------------------------------
data.in %.>% (2 + .^2) %.>% assign("data1.out", .)


## ----tidy-tibble-00-------------------------------------------------------------------------------------------------
iris.tb <- as_tibble(iris)


## ----tidy-tibble-01-------------------------------------------------------------------------------------------------
head(iris.tb, 2)
iris.tb %.>%
  gather(., key = part, value = dimension, -Species) -> long_iris.tb
long_iris.tb


## ----tidy-tibble-01aa-----------------------------------------------------------------------------------------------
long_iris.tb_1 <- gather(iris.tb, key = "part", value = "dimension", setdiff(colnames(iris.tb), "Species"))
long_iris.tb_1


## ----tidy-tibble-01a------------------------------------------------------------------------------------------------
part <- "not part"
long_iris.tb_2 <- gather(iris.tb, key = !!part, value = dimension, -Species)
long_iris.tb_2


## ----tidy-tibble-01b, eval=FALSE------------------------------------------------------------------------------------
## spread(long_iris.tb, key = c(!!part, Species), value = dimension) # does not work!!


## ----tidy-tibble-02z------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 2 * a)


## ----tidy-tibble-02-------------------------------------------------------------------------------------------------
long_iris.tb %.>%
  mutate(.,
         plant_part = str_extract(part, "^[:alpha:]*"),
         part_dim = str_extract(part, "[:alpha:]*$")) -> long_iris.tb
long_iris.tb


## ----tidy-tibble-03-------------------------------------------------------------------------------------------------
arrange(long_iris.tb, Species, plant_part, part_dim)


## ----tidy-tibble-04-------------------------------------------------------------------------------------------------
filter(long_iris.tb, plant_part == "Petal")


## ----tidy-tibble-05-------------------------------------------------------------------------------------------------
slice(long_iris.tb, 1:5)


## ----tidy-tibble-06-------------------------------------------------------------------------------------------------
select(long_iris.tb, -part)


## ----tidy-tibble-06a------------------------------------------------------------------------------------------------
select(iris.tb, -starts_with("Sepal"))


## ----tidy-tibble-06b------------------------------------------------------------------------------------------------
select(iris.tb, Species, matches("pal"))


## ----tidy-tibble-07-------------------------------------------------------------------------------------------------
rename(long_iris.tb, dim = dimension)


## ----tibble-grouped-01----------------------------------------------------------------------------------------------
tibble(numbers = 1:9, letters = rep(letters[1:3], 3)) %.>%
  group_by(., letters) %.>%
  summarise(.,
            mean_numbers = mean(numbers),
            median_numbers = median(numbers),
            n = n())


## ----tibble-grouped-box-01------------------------------------------------------------------------------------------
my.tb <- tibble(numbers = 1:9, letters = rep(letters[1:3], 3))
is.grouped_df(my.tb)
class(my.tb)
names(attributes(my.tb))


## ----tibble-grouped-box-02------------------------------------------------------------------------------------------
my_gr.tb <- group_by(.data = my.tb, letters)
is.grouped_df(my_gr.tb)
class(my_gr.tb)


## ----tibble-grouped-box-02a-----------------------------------------------------------------------------------------
names(attributes(my_gr.tb))
setdiff(attributes(my_gr.tb), attributes(my.tb))


## ----tibble-grouped-box-03------------------------------------------------------------------------------------------
my_ugr.tb <- ungroup(my_gr.tb)
class(my_ugr.tb)
names(attributes(my_ugr.tb))


## ----tibble-grouped-box-04------------------------------------------------------------------------------------------
all(my.tb == my_gr.tb)
all(my.tb == my_ugr.tb)
identical(my.tb, my_gr.tb)
identical(my.tb, my_ugr.tb)


## ----tibble-print-10, echo=FALSE------------------------------------------------------------------------------------
options(tibble.print_max = 6, tibble.print_min = 6)


## ----joins-00-------------------------------------------------------------------------------------------------------
first.tb <- tibble(idx = c(1:4, 5), values1 = "a")
second.tb <- tibble(idx = c(1:4, 6), values2 = "b")


## ----joins-01-------------------------------------------------------------------------------------------------------
full_join(x = first.tb, y = second.tb)


## ----joins-01a------------------------------------------------------------------------------------------------------
full_join(x = second.tb, y = first.tb)


## ----joins-02-------------------------------------------------------------------------------------------------------
left_join(x = first.tb, y = second.tb)


## ----joins-02a------------------------------------------------------------------------------------------------------
left_join(x = second.tb, y = first.tb)


## ----joins-03-------------------------------------------------------------------------------------------------------
right_join(x = first.tb, y = second.tb)


## ----joins-03a------------------------------------------------------------------------------------------------------
right_join(x = second.tb, y = first.tb)


## ----joins-04-------------------------------------------------------------------------------------------------------
inner_join(x = first.tb, y = second.tb)


## ----joins-04a------------------------------------------------------------------------------------------------------
inner_join(x = second.tb, y = first.tb)


## ----joins-05-------------------------------------------------------------------------------------------------------
semi_join(x = first.tb, y = second.tb)


## ----joins-05a------------------------------------------------------------------------------------------------------
semi_join(x = second.tb, y = first.tb)


## ----joins-06-------------------------------------------------------------------------------------------------------
anti_join(x = first.tb, y = second.tb)


## ----joins-06a------------------------------------------------------------------------------------------------------
anti_join(x = second.tb, y = first.tb)


## ----joins-01b------------------------------------------------------------------------------------------------------
first2.tb <- rename(first.tb, idx2 = idx)
full_join(x = first2.tb, y = second.tb, by = c("idx2" = "idx"))


## ----tibble-print-11, echo=FALSE------------------------------------------------------------------------------------
options(tibble.print_max = 3, tibble.print_min = 3)


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
try(detach(package:lubridate))
try(detach(package:tidyr))
try(detach(package:dplyr))
try(detach(package:stringr))
try(detach(package:wrapr))
try(detach(package:magrittr))
try(detach(package:tibble))
try(detach(package:learnrbook))

