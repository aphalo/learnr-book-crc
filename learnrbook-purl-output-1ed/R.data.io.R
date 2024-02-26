## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'data-chunk')


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
# set to TRUE to execute code chunks that require internet access and instruments, repectively
eval_online_data <- TRUE
eval_yoctopuce <- FALSE


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## install.packages(learnrbook::pkgs_ch_data)


## ----message=FALSE--------------------------------------------------------------------------------------------------
library(learnrbook)
library(tibble)
library(purrr)
library(wrapr)
library(stringr)
library(dplyr)
library(tidyr)
library(readr)
library(readxl)
library(xlsx)
library(readODS)
library(pdftools)
library(foreign)
library(haven)
library(xml2)
library(XML)
library(ncdf4)
library(tidync)
library(lubridate)
library(jsonlite)


## ----copy-data-files------------------------------------------------------------------------------------------------
pkg.path <- system.file("extdata", package = "learnrbook")
file.copy(pkg.path, ".", overwrite = TRUE, recursive = TRUE)


## ----make-dir-------------------------------------------------------------------------------------------------------
save.path = "./data"
if (!dir.exists(save.path)) {
  dir.create(save.path)
}


## ----filenames-01---------------------------------------------------------------------------------------------------
basename("extdata/my-file.txt")


## ----filenames-02---------------------------------------------------------------------------------------------------
basename("extdata/my-file.txt")
basename("extdata\\my-file.txt")


## ----filenames-03---------------------------------------------------------------------------------------------------
dirname("extdata/my-file.txt")


## ----filenames-05,eval=FALSE----------------------------------------------------------------------------------------
## # not run
## getwd()


## ----filenames-06,eval=FALSE----------------------------------------------------------------------------------------
## # not run
## oldwd <- setwd("..")
## getwd()


## ----filenames-07,eval=FALSE----------------------------------------------------------------------------------------
## # not run
## oldwd
## setwd(oldwd)
## getwd()


## ----filenames-09---------------------------------------------------------------------------------------------------
head(list.files())
head(list.dirs())
head(dir())


## ----filenames-08---------------------------------------------------------------------------------------------------
if (!file.exists("xxx.txt")) {
  file.create("xxx.txt")
}
file.size("xxx.txt")
file.info("xxx.txt")
file.rename("xxx.txt", "zzz.txt")
file.exists("xxx.txt")
file.exists("zzz.txt")
file.remove("zzz.txt")


## ----file-open-01---------------------------------------------------------------------------------------------------
f1 <- file("extdata/not-aligned-ASCII-UK.csv", open = "r") # open for reading
readLines(f1, n = 1L)


## ----file-open-02---------------------------------------------------------------------------------------------------
readLines(f1, n = 2L)
close(f1)


## ----file-io-txt-00a------------------------------------------------------------------------------------------------
data.frame(a = 1, "a " = 2, " a" = 3, check.names = FALSE)
data.frame(a = 1, "a " = 2, " a" = 3)


## ----file-io-txt-00b------------------------------------------------------------------------------------------------
data.frame(al = 1, a1 = 2, aO = 3, a0 = 4)


## ----file-io-csv-00a, comment='', echo=FALSE------------------------------------------------------------------------
cat(readLines("extdata/not-aligned-ASCII-UK.csv"), sep = "\n")


## ----file-io-csv-01-------------------------------------------------------------------------------------------------
from_csv_a.df <- read.csv("extdata/not-aligned-ASCII-UK.csv")


## ----file-io-csv-02-------------------------------------------------------------------------------------------------
sapply(from_csv_a.df, class)
from_csv_a.df[["col4"]]
levels(from_csv_a.df[["col4"]])


## ----file-io-csv-00b, comment='', echo=FALSE------------------------------------------------------------------------
cat(readLines("extdata/aligned-ASCII-UK.csv"), sep = "\n")


## ----file-io-csv-03-------------------------------------------------------------------------------------------------
from_csv_b.df <- read.csv("extdata/aligned-ASCII-UK.csv")


## ----file-io-csv-04-------------------------------------------------------------------------------------------------
sapply(from_csv_b.df, class)
from_csv_b.df[["col4"]]
levels(from_csv_b.df[["col4"]])


## ----file-io-csv-05-------------------------------------------------------------------------------------------------
from_csv_e.df <- read.csv("extdata/aligned-ASCII-UK.csv", strip.white = TRUE)
sapply(from_csv_e.df, class)
from_csv_e.df[["col4"]]
levels(from_csv_e.df[["col4"]])


## ----file-io-csv-06-------------------------------------------------------------------------------------------------
from_csv_c.df <- read.csv("extdata/not-aligned-ASCII-UK.csv",
                          stringsAsFactors = FALSE)


## ----file-io-csv-07-------------------------------------------------------------------------------------------------
sapply(from_csv_c.df, class)
from_csv_c.df[["col4"]]


## ----file-io-txt-00, comment='', echo=FALSE-------------------------------------------------------------------------
cat(readLines("extdata/aligned-ASCII.txt"), sep = "\n")


## ----file-io-txt-01-------------------------------------------------------------------------------------------------
from_txt_b.df <- read.table("extdata/aligned-ASCII.txt", header = TRUE)


## ----file-io-txt-02-------------------------------------------------------------------------------------------------
sapply(from_txt_b.df, class)
from_txt_b.df[["col4"]]
levels(from_txt_b.df[["col4"]])


## ----file-io-fwf-00, comment='', echo=FALSE-------------------------------------------------------------------------
cat(readLines("extdata/aligned-ASCII.fwf"), sep = "\n")


## ----file-io-fwf-01-------------------------------------------------------------------------------------------------
from_fwf_a.df <- read.fortran("extdata/aligned-ASCII.fwf",
                              format = c("2F3.1", "F3.0", "A3"),
                              col.names = c("col1", "col2", "col3", "col4"))


## ----file-io-fwf-02-------------------------------------------------------------------------------------------------
sapply(from_fwf_a.df, class)
from_fwf_a.df[["col4"]]


## ----file-io-txt-03-------------------------------------------------------------------------------------------------
my.df <- data.frame(x = 1:5, y = 5:1 / 10, z = letters[1:5])


## ----file-io-txt-04-------------------------------------------------------------------------------------------------
write.csv(my.df, file = "my-file1.csv", row.names = FALSE)
file.show("my-file1.csv", pager = "console")


## ----file-io-txt-05, comment='', echo=FALSE-------------------------------------------------------------------------
cat(readLines("my-file1.csv"), sep = "\n")


## ----file-io-txt-11-------------------------------------------------------------------------------------------------
my.lines <- c("abcd", "hello world", "123.45")
cat(my.lines, file = "my-file2.txt", sep = "\n")
file.show("my-file2.txt", pager = "console")


## ----file-io-txt-12, comment='', echo=FALSE-------------------------------------------------------------------------
cat(readLines('my-file2.txt'), sep = '\n')


## ----eval=FALSE, include=FALSE--------------------------------------------------------------------------------------
## citation(package = "readr")


## ----readr-01-------------------------------------------------------------------------------------------------------
read_csv(file = "extdata/aligned-ASCII-UK.csv")


## ----readr-02-------------------------------------------------------------------------------------------------------
read_csv(file = "extdata/not-aligned-ASCII-UK.csv")


## ----readr-03-------------------------------------------------------------------------------------------------------
read_table(file = "extdata/aligned-ASCII.txt")


## ----readr-04-------------------------------------------------------------------------------------------------------
read_table2(file = "extdata/not-aligned-ASCII.txt")


## ----readr-05-------------------------------------------------------------------------------------------------------
read_delim(file = "extdata/not-aligned-ASCII.txt", delim = " ")


## ----tibble-print-20, echo=FALSE------------------------------------------------------------------------------------
options(tibble.print_max = 6, tibble.print_min = 6)


## ----readr-06-------------------------------------------------------------------------------------------------------
read_table2(file = "extdata/miss-aligned-ASCII.txt")


## ----readr-07-------------------------------------------------------------------------------------------------------
read_table2(file = "extdata/miss-aligned-ASCII.txt", guess_max = 3L)


## ----tibble-print-21, echo=FALSE------------------------------------------------------------------------------------
options(tibble.print_max = 3, tibble.print_min = 3)


## ----readr-10-------------------------------------------------------------------------------------------------------
write_excel_csv(my.df, file = "my-file6.csv")
file.show("my-file6.csv", pager = "console")


## ----readr-11, comment='', echo=FALSE-------------------------------------------------------------------------------
cat(read_lines('my-file6.csv'), sep = '\n')


## ----readr-12-------------------------------------------------------------------------------------------------------
one.str <- read_file(file = "extdata/miss-aligned-ASCII.txt")
length(one.str)
cat(one.str)


## ----xml2-00, eval=FALSE, include=FALSE-----------------------------------------------------------------------------
## citation(package = "xml2")


## ----xml2-01--------------------------------------------------------------------------------------------------------
web_page <- read_html("https://r.r4photobiology.info/index.html")
html_structure(web_page)


## ----xml2-02--------------------------------------------------------------------------------------------------------
xml_text(xml_find_all(web_page, ".//title"))


## ----gps-01---------------------------------------------------------------------------------------------------------
xmlTreeParse(file = "extdata/GPSDATA.gpx", useInternalNodes = TRUE) %.>%
xmlRoot(x = .) %.>%
xmlToList(node = .)[["trk"]] %.>%
unlist(x = .[names(.) == "trkseg"], recursive = FALSE) %.>%
map_df(.x = ., .f = function(x) as_tibble(x = t(x = unlist(x = x))))


## ----readxl-00, eval=FALSE, include=FALSE---------------------------------------------------------------------------
## citation(package = "readxl")


## ----readxl-01------------------------------------------------------------------------------------------------------
sheets <- excel_sheets("extdata/Book1.xlsx")
sheets


## ----readxl-02------------------------------------------------------------------------------------------------------
Book1.df <- read_excel("extdata/Book1.xlsx", sheet = "my data")
Book1.df


## ----readxl-03------------------------------------------------------------------------------------------------------
Book1_region.df <- read_excel("extdata/Book1.xlsx", sheet = "my data", range = "A1:B8")
Book1_region.df


## ----xlsx-00, eval=FALSE, include=FALSE-----------------------------------------------------------------------------
## citation(package = "xlsx")


## ----xlsx-01--------------------------------------------------------------------------------------------------------
Book1_xlsx.df <- read.xlsx("extdata/Book1.xlsx", sheetName = "my data")
Book1_xlsx.df


## ----xlsx-05--------------------------------------------------------------------------------------------------------
set.seed(456321)
my.data <- data.frame(x = 1:10, y = letters[1:10])
write.xlsx(my.data, file = "extdata/my-data.xlsx", sheetName = "first copy")
write.xlsx(my.data, file = "extdata/my-data.xlsx", sheetName = "second copy", append = TRUE)


## ----readODS-01-----------------------------------------------------------------------------------------------------
ods.df <- read_ods("extdata/Book1.ods", sheet = 1)


## ----readODS-02-----------------------------------------------------------------------------------------------------
ods.df


## ----foreign-00, eval=FALSE, include=FALSE--------------------------------------------------------------------------
## citation(package = "foreign")


## ----foreign-01-----------------------------------------------------------------------------------------------------
my_spss.df <- read.spss(file = "extdata/my-data.sav", to.data.frame = TRUE)
my_spss.df[1:6, c(1:6, 17)]


## ----foreign-02-----------------------------------------------------------------------------------------------------
thiamin.df <- read.spss(file = "extdata/thiamin.sav", to.data.frame = TRUE)
head(thiamin.df)


## ----foreign-03-----------------------------------------------------------------------------------------------------
my_systat.df <- read.systat(file = "extdata/BIRCH1.SYS")
head(my_systat.df)


## ----haven-00, eval=FALSE, include=FALSE----------------------------------------------------------------------------
## citation(package = "haven")


## ----haven-01-------------------------------------------------------------------------------------------------------
my_spss.tb <- read_sav(file = "extdata/my-data.sav")
my_spss.tb[1:6, c(1:6, 17)]


## ----haven-02-------------------------------------------------------------------------------------------------------
thiamin.tb <- read_sav(file = "extdata/thiamin.sav")
thiamin.tb
thiamin.tb <- as_factor(thiamin.tb)
thiamin.tb


## ----ncdf4-00, eval=FALSE, include=FALSE----------------------------------------------------------------------------
## citation(package = "ncdf4")


## ----ncdf4-01-------------------------------------------------------------------------------------------------------
meteo_data.nc <- nc_open("extdata/pevpr.sfc.mon.ltm.nc")
str(meteo_data.nc, max.level = 1)


## ----ncdf4-02-------------------------------------------------------------------------------------------------------
time.vec <- ncvar_get(meteo_data.nc, "time")
head(time.vec)
longitude <-  ncvar_get(meteo_data.nc, "lon")
head(longitude)
latitude <- ncvar_get(meteo_data.nc, "lat")
head(latitude)


## ----ncdf4-03-------------------------------------------------------------------------------------------------------
pet.tb <-
    tibble(time = ncvar_get(meteo_data.nc, "time"),
           month = month(ymd("1800-01-01") + days(time)),
           lon = longitude[6],
           lat = latitude[2],
           pet = ncvar_get(meteo_data.nc, "pevpr")[6, 2, ]
           )
pet.tb


## ----tidync-00, eval=FALSE, include=FALSE---------------------------------------------------------------------------
## citation(package = "tidync")


## ----tidync-01------------------------------------------------------------------------------------------------------
meteo_data.tnc <- tidync("extdata/pevpr.sfc.mon.ltm.nc")
meteo_data.tnc


## ----tidync-01a-----------------------------------------------------------------------------------------------------
hyper_dims(meteo_data.tnc)


## ----tidync-01b-----------------------------------------------------------------------------------------------------
hyper_vars(meteo_data.tnc)


## ----tidync-02------------------------------------------------------------------------------------------------------
hyper_tibble(meteo_data.tnc,
             lon = signif(lon, 1) == 9,
             lat = signif(lat, 2) == 87) %.>%
  mutate(.data = ., month = month(ymd("1800-01-01") + days(time))) %.>%
  select(.data = ., -time)


## ----tidync-03------------------------------------------------------------------------------------------------------
hyper_tibble(meteo_data.tnc,
             lon = signif(lon, 1) == 9) %.>%
  mutate(.data = ., month = month(ymd("1800-01-01") + days(time))) %.>%
  select(.data = ., -time)














## ----iot-00, eval=FALSE, include=FALSE------------------------------------------------------------------------------
## citation(package = "jsonlite")






## ----dbplyr-00a, eval=FALSE, include=FALSE--------------------------------------------------------------------------
## citation(package = "dbplyr")

## ----dbplyr-00b, eval=FALSE, include=FALSE--------------------------------------------------------------------------
## citation(package = "DBI")

## ----dbplyr-00c, eval=FALSE, include=FALSE--------------------------------------------------------------------------
## citation(package = "RSQLite")


## ----dbplyr-01------------------------------------------------------------------------------------------------------
library(dplyr)
con <- DBI::dbConnect(RSQLite::SQLite(), dbname = ":memory:")
copy_to(con, weather_wk_25_2019.tb, "weather",
        temporary = FALSE,
        indexes = list(
          c("month_name", "calendar_year", "solar_time"),
          "time",
          "sun_elevation",
          "was_sunny",
          "day_of_year",
          "month_of_year"
        )
)
weather.db <- tbl(con, "weather")
colnames(weather.db)
weather.db %.>%
  filter(., sun_elevation > 5) %.>%
  group_by(., day_of_year) %.>%
  summarise(., energy_Wh = sum(global_watt, na.rm = TRUE) * 60 / 3600)


## ----clear-up-data-folders------------------------------------------------------------------------------------------
unlink("./data", recursive = TRUE)
unlink("./extdata", recursive = TRUE)


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
try(detach(package:jsonlite))
try(detach(package:lubridate))
try(detach(package:tidync))
try(detach(package:ncdf4))
try(detach(package:xml2))
try(detach(package:haven))
try(detach(package:foreign))
try(detach(package:xlsx))
try(detach(package:readxl))
try(detach(package:readr))
try(detach(package:tidyr))
try(detach(package:dplyr))
try(detach(package:stringr))
try(detach(package:wrapr))
try(detach(package:tibble))
try(detach(package:learnrbook))

