## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'data-chunk')


## ----tidyverse-00-------------------------------------------------------------------------------------------------------
tidyverse::tidyverse_packages()


## ----eval=FALSE---------------------------------------------------------------------------------------------------------
## install.packages(learnrbook::pkgs_ch_data)


## ----message=FALSE------------------------------------------------------------------------------------------------------
library(learnrbook)
library(tibble)
library(magrittr)
library(wrapr)
library(stringr)
library(dplyr)
library(tidyr)
library(lubridate)


## ----tibble-info-01-----------------------------------------------------------------------------------------------------
my.tb <- tibble(numbers = 1:3)
is_tibble(my.tb)
inherits(my.tb, "tibble")
class(my.tb)


## ----tibble-01----------------------------------------------------------------------------------------------------------
show_classes <- function(x) {
  cat(
    paste(paste(class(x)[1],
    "containing:"),
    paste(names(x),
          sapply(x, class), collapse = ", ", sep = ": "),
    sep = "\n")
    )
}


## ----tibble-02----------------------------------------------------------------------------------------------------------
my.df <- data.frame(codes = c("A", "B", "C"), numbers = -1:1, integers = 1L:3L)
is.data.frame(my.df)
is_tibble(my.df)
show_classes(my.df)


## ----tibble-03----------------------------------------------------------------------------------------------------------
my.tb <- tibble(codes = c("A", "B", "C"), numbers = -1:1, integers = 1L:3L)
is.data.frame(my.tb)
is_tibble(my.tb)
show_classes(my.tb)


## ----tibble-04----------------------------------------------------------------------------------------------------------
print(my.df)
print(my.tb)


## ----tibble-print-02----------------------------------------------------------------------------------------------------
options(tibble.print_max = 3, tibble.print_min = 3)


## ----tibble-05----------------------------------------------------------------------------------------------------------
my_conv.tb <- as_tibble(my.df)
is.data.frame(my_conv.tb)
is_tibble(my_conv.tb)
show_classes(my_conv.tb)


## ----tibble-06----------------------------------------------------------------------------------------------------------
my_conv.df <- as.data.frame(my.tb)
is.data.frame(my_conv.df)
is_tibble(my_conv.df)
show_classes(my_conv.df)


## ----tibble-box-01------------------------------------------------------------------------------------------------------
class(my.tb)
class(my_conv.df)
my.tb == my_conv.df
identical(my.tb, my_conv.df)


## ----tibble-box-02------------------------------------------------------------------------------------------------------
my.xtb <- my.tb
class(my.xtb) <- c("xtb", class(my.xtb))
class(my.xtb)
my_conv_x.tb <- as_tibble(my.xtb)
class(my_conv_x.tb)
my.xtb == my_conv_x.tb
identical(my.xtb, my_conv_x.tb)


## ----tibble-box-03a-----------------------------------------------------------------------------------------------------
class(my.df)
class(my.tb)


## ----tibble-box-03b-----------------------------------------------------------------------------------------------------
class(cbind(my.df, my.tb))
class(cbind(my.tb, my.df))


## ----tibble-box-03c-----------------------------------------------------------------------------------------------------
class(cbind(my.df, added = -3:-1))
class(cbind(my.tb, added = -3:-1))
identical(cbind(my.tb, added = -3:-1), cbind(my.df, added = -3:-1))


## ----tibble-07----------------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 5:1, c = a + b, d = letters[a + 1])


## ----tibble-08----------------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 5:1, c = list("a", 2, 3, 4, 5))


## ----tibble-09----------------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 5:1, c = list("a", 1:2, 0:3, letters[1:3], letters[3:1]))


## ----pipes-x00----------------------------------------------------------------------------------------------------------
data.in <- 1:10


## ----pipes-x04----------------------------------------------------------------------------------------------------------
data.in %>% sqrt() %>% sum() -> data0.out


## ----pipes-x04a---------------------------------------------------------------------------------------------------------
data.in %>% sqrt(x = .) %>% sum(.) -> data1.out
all.equal(data0.out, data1.out)


## ----pipes-x04b---------------------------------------------------------------------------------------------------------
data.in %>% sqrt %>% sum -> data5.out
all.equal(data0.out, data5.out)


## ----pipes-x05----------------------------------------------------------------------------------------------------------
data.in %.>% sqrt(.) %.>% sum(.) -> data2.out
all.equal(data0.out, data2.out)


## ----pipes-x05a---------------------------------------------------------------------------------------------------------
data.in %>% sqrt(.) %>% sum(.) -> data3.out
all.equal(data0.out, data3.out)


## ----pipes-x05b---------------------------------------------------------------------------------------------------------
data.in |> sqrt(x = _) |> sum(x = _) -> data4.out
all.equal(data0.out, data4.out)


## ----pipes-x05c---------------------------------------------------------------------------------------------------------
data.in |> sqrt() |> sum() -> data4.out
all.equal(data0.out, data4.out)


## ----pipes-x07----------------------------------------------------------------------------------------------------------
data.in %.>% (.^2) -> data7.out


## ----pipes-x07b---------------------------------------------------------------------------------------------------------
data.in %>% `^`(e1 = ., e2 = 2) -> data9.out
all.equal(data7.out, data9.out)


## ----pipes-x07c---------------------------------------------------------------------------------------------------------
data.in %.>% (.^2 + sqrt(. + 1))


## ----pipes-x08----------------------------------------------------------------------------------------------------------
data.in |> print() |> sqrt() |> print() |> sum() |> print() -> data10.out
data10.out


## ----pipes-clean, include=FALSE-----------------------------------------------------------------------------------------
rm(data6.out, data7.out, data8.out)


## ----pipes-x06----------------------------------------------------------------------------------------------------------
data.in |> assign(x = "data6.out", value = _)
all.equal(data.in, data6.out)


## ----pipes-x06a---------------------------------------------------------------------------------------------------------
data.in %.>% assign(x = "data7.out", value = .)
all.equal(data.in, data7.out)


## ----pipes-x06b---------------------------------------------------------------------------------------------------------
data.in %>% assign(x = "data8.out", value = .)
if (exists("data8.out")) {
  all.equal(data.in, data8.out)
} else {
  print("'data8.out' not found!")
}


## ----tidy-tibble-00-----------------------------------------------------------------------------------------------------
iris.tb <- as_tibble(iris)


## ----tidy-tibble-01-----------------------------------------------------------------------------------------------------
long_iris.tb <-
  pivot_longer(iris.tb,
               cols = -Species,
               names_to = "part",
               values_to = "dimension")
long_iris.tb


## ----tidy-tibble-01a----------------------------------------------------------------------------------------------------
wide_iris.tb <-
  pivot_wider(long_iris.tb,
              names_from = "part",
              values_from = "dimension",
              values_fn = list) |>
  unnest(cols = -Species)
wide_iris.tb


## ----tidy-tibble-pivot-pg01, eval=eval_playground-----------------------------------------------------------------------
identical(iris.tb, wide_iris.tb)
all.equal(iris.tb, wide_iris.tb)
all.equal(iris.tb, wide_iris.tb[ , colnames(iris.tb)])


## ----tidy-tibble-01c, eval=eval_playground------------------------------------------------------------------------------
poor_long_iris.tb <-
  poorman::pivot_longer(
    iris,
    cols = -Species,
    names_to = "part",
    values_to = "dimension")
identical(long_iris.tb, poor_long_iris.tb)
all.equal(long_iris.tb, poor_long_iris.tb)
class(long_iris.tb)
class(poor_long_iris.tb)


## ----tidy-tibble-02z----------------------------------------------------------------------------------------------------
tibble(a = 1:5, b = 2 * a)


## ----tidy-tibble-02-----------------------------------------------------------------------------------------------------
long_iris.tb |>
  mutate(plant_part = str_extract(part, "^[:alpha:]*"),
         part_dimension = str_extract(part, "[:alpha:]*$")) -> long_iris.tb
long_iris.tb


## ----tidy-tibble-03-----------------------------------------------------------------------------------------------------
arrange(long_iris.tb, Species, plant_part, part_dimension)


## ----tidy-tibble-04-----------------------------------------------------------------------------------------------------
filter(long_iris.tb, plant_part == "Petal")


## ----tidy-tibble-05-----------------------------------------------------------------------------------------------------
slice(long_iris.tb, 1:5)


## ----tidy-tibble-06-----------------------------------------------------------------------------------------------------
select(long_iris.tb, -part)


## ----tidy-tibble-06a----------------------------------------------------------------------------------------------------
select(iris.tb, -starts_with("Sepal"))


## ----tidy-tibble-06b----------------------------------------------------------------------------------------------------
select(iris.tb, Species, matches("pal"))


## ----tidy-tibble-07-----------------------------------------------------------------------------------------------------
long_iris.tb |>
select(-part) |>
rename(part = plant_part, size = dimension, dimension = part_dimension)


## ----tibble-grouped-01--------------------------------------------------------------------------------------------------
tibble(numbers = 1:9, Letters = rep(letters[1:3], 3)) |>
  group_by(Letters) |>
  summarise(mean_num = mean(numbers),
            median_num = median(numbers),
            n = n()) |>
  ungroup() # not always needed but safer


## ----tibble-grouped-02--------------------------------------------------------------------------------------------------
tibble(numbers = 1:9, Letters = rep(letters[1:3], 3)) |>
  summarise(.by = Letters,
            mean_num = mean(numbers),
            median_num = median(numbers),
            n = n())


## ----tibble-grouped-box-01----------------------------------------------------------------------------------------------
my.tb <- tibble(numbers = 1:9, Letters = rep(letters[1:3], 3))
is.grouped_df(my.tb)
class(my.tb)
names(attributes(my.tb))


## ----tibble-grouped-box-02----------------------------------------------------------------------------------------------
my_gr.tb <- group_by(.data = my.tb, Letters)
is.grouped_df(my_gr.tb)
class(my_gr.tb)


## ----tibble-grouped-box-02a---------------------------------------------------------------------------------------------
names(attributes(my_gr.tb))
setdiff(attributes(my_gr.tb), attributes(my.tb))


## ----tibble-grouped-box-03----------------------------------------------------------------------------------------------
my_ugr.tb <- ungroup(my_gr.tb)
class(my_ugr.tb)
names(attributes(my_ugr.tb))


## ----tibble-grouped-box-04----------------------------------------------------------------------------------------------
all(my.tb == my_gr.tb)
all(my.tb == my_ugr.tb)
identical(my.tb, my_gr.tb)
identical(my.tb, my_ugr.tb)


## ----tibble-print-10, echo=FALSE----------------------------------------------------------------------------------------
options(tibble.print_max = 6, tibble.print_min = 6)


## ----joins-00-----------------------------------------------------------------------------------------------------------
first.tb <- tibble(idx = c(1:4, 5), values1 = "a")
second.tb <- tibble(idx = c(1:4, 6), values2 = "b")


## ----joins-01-----------------------------------------------------------------------------------------------------------
full_join(x = first.tb, y = second.tb)


## ----joins-01a----------------------------------------------------------------------------------------------------------
full_join(x = second.tb, y = first.tb)


## ----joins-02-----------------------------------------------------------------------------------------------------------
left_join(x = first.tb, y = second.tb)


## ----joins-02a----------------------------------------------------------------------------------------------------------
left_join(x = second.tb, y = first.tb)


## ----joins-03-----------------------------------------------------------------------------------------------------------
right_join(x = first.tb, y = second.tb)


## ----joins-03a----------------------------------------------------------------------------------------------------------
right_join(x = second.tb, y = first.tb)


## ----joins-04-----------------------------------------------------------------------------------------------------------
inner_join(x = first.tb, y = second.tb)


## ----joins-04a----------------------------------------------------------------------------------------------------------
inner_join(x = second.tb, y = first.tb)


## ----joins-05-----------------------------------------------------------------------------------------------------------
semi_join(x = first.tb, y = second.tb)


## ----joins-05a----------------------------------------------------------------------------------------------------------
semi_join(x = second.tb, y = first.tb)


## ----joins-06-----------------------------------------------------------------------------------------------------------
anti_join(x = first.tb, y = second.tb)


## ----joins-06a----------------------------------------------------------------------------------------------------------
anti_join(x = second.tb, y = first.tb)


## ----joins-01b----------------------------------------------------------------------------------------------------------
first2.tb <- rename(first.tb, idx2 = idx)
full_join(x = first2.tb, y = second.tb, by = c("idx2" = "idx"))


## ----tibble-print-11, echo=FALSE----------------------------------------------------------------------------------------
options(tibble.print_max = 3, tibble.print_min = 3)


## ----lubridate-01-------------------------------------------------------------------------------------------------------
this.day <- today()
class(this.day)
as.POSIXct(this.day, tz = "") # local time zone


## ----lubridate-02-------------------------------------------------------------------------------------------------------
this.instant <- now()
class(this.instant)
this.instant


## ----lubridate-03-------------------------------------------------------------------------------------------------------
dmy_h("04/10/23 15", tz = "EET")
dmy_h("04/10/23 3pm", tz = "EET")
dmy_h("04/10/23 15 EET") # Wrong decoding!


## ----lubridate-04-------------------------------------------------------------------------------------------------------
class(ymd("2023-10-04"))
class(ymd("2023-10-04", tz = ""))
class(today(tzone = ""))


## ----lubridate-05-------------------------------------------------------------------------------------------------------
as.POSIXct(ymd("2023-10-04"), tzone = "") - ymd("2023-10-04", tz = "")


## ----lubridate-05a------------------------------------------------------------------------------------------------------
force_tz(as.POSIXct(ymd("2023-10-04")), tzone = "") - ymd("2023-10-04", tz = "")


## ----lubridate-06-------------------------------------------------------------------------------------------------------
ymd_hms("2010-05-25 12:05:00") - ymd_hms("1810-05-25 12:00:00")


## ----lubridate-07-------------------------------------------------------------------------------------------------------
ymd_hms("1810-05-25 12:00:00") + years(200) + minutes(5)
ymd_hms("2010-05-25 12:05:00") - ymd_hms("1810-05-25 12:00:00")
ymd("2023-01-01") + seconds(123)


## ----lubridate-08-------------------------------------------------------------------------------------------------------
my.time <- now()
my.time
year(my.time)
hour(my.time)
second(my.time)
second(my.time) <- 0


## ----lubridate-09-------------------------------------------------------------------------------------------------------
trunc(my.time, "days")
round(my.time, "hours")


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
try(detach(package:lubridate))
try(detach(package:tidyr))
try(detach(package:dplyr))
try(detach(package:stringr))
try(detach(package:wrapr))
try(detach(package:magrittr))
try(detach(package:tibble))
try(detach(package:learnrbook))


## ----eval=eval_diag, include=eval_diag, echo=eval_diag, cache=FALSE-----------------------------------------------------
## knitter_diag()
## R_diag()
## other_diag()

