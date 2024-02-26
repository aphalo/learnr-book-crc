## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'data-chunk')


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
# set to TRUE to execute code chunks that require internet access and instruments, repectively
eval_online_data <- TRUE
eval_yoctopuce <- TRUE


## ----eval=FALSE---------------------------------------------------------------------------------------------------------
## install.packages(learnrbook::pkgs_ch10_2ed)


## ----message=FALSE------------------------------------------------------------------------------------------------------
library(learnrbook)
library(tibble)
library(purrr)
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


## ----copy-data-files----------------------------------------------------------------------------------------------------
pkg.path <- system.file("extdata", package = "learnrbook")
file.copy(pkg.path, ".", overwrite = TRUE, recursive = TRUE)


## ----make-dir-----------------------------------------------------------------------------------------------------------
save.path = "./data"
if (!dir.exists(save.path)) {
  dir.create(save.path)
}


## ----filenames-01-------------------------------------------------------------------------------------------------------
basename("extdata/my-file.txt")


## ----filenames-02-------------------------------------------------------------------------------------------------------
basename("extdata/my-file.txt")
basename("extdata\\my-file.txt")


## ----filenames-03-------------------------------------------------------------------------------------------------------
dirname("extdata/my-file.txt")


## ----filenames-05,eval=FALSE--------------------------------------------------------------------------------------------
## # not run
## getwd()


## ----filenames-06,eval=FALSE--------------------------------------------------------------------------------------------
## # not run
## oldwd <- setwd("..")
## getwd()


## ----filenames-07,eval=FALSE--------------------------------------------------------------------------------------------
## # not run
## oldwd
## setwd(oldwd)
## getwd()


## ----filenames-09-------------------------------------------------------------------------------------------------------
head(list.files())
head(list.dirs())


## ----filenames-08-------------------------------------------------------------------------------------------------------
if (!file.exists("xxx.txt")) {
  file.create("xxx.txt")
}
file.size("xxx.txt")
file.info("xxx.txt")
file.rename("xxx.txt", "zzz.txt")
file.exists("xxx.txt")
file.exists("zzz.txt")
file.remove("zzz.txt")


## ----file-open-01-------------------------------------------------------------------------------------------------------
f1 <- file("extdata/not-aligned-ASCII-UK.csv", open = "r") # open for reading
readLines(f1, n = 1)


## ----file-open-02-------------------------------------------------------------------------------------------------------
readLines(f1, n = 2)
close(f1)


## ----file-io-txt-00a----------------------------------------------------------------------------------------------------
data.frame(a = 1, "a " = 2, " a" = 3, check.names = FALSE)
data.frame(a = 1, "a " = 2, " a" = 3)


## ----file-io-txt-00b----------------------------------------------------------------------------------------------------
data.frame(al = 1, a1 = 2, aO = 3, a0 = 4)


## ----file-io-csv-00a, comment='', echo=FALSE----------------------------------------------------------------------------
cat(readLines("extdata/not-aligned-ASCII-UK.csv"), sep = "\n")


## ----file-io-csv-01-----------------------------------------------------------------------------------------------------
from_csv_a.df <-
  read.csv("extdata/not-aligned-ASCII-UK.csv", stringsAsFactors = FALSE)


## ----file-io-csv-02-----------------------------------------------------------------------------------------------------
from_csv_a.df
from_csv_a.df[["col4"]]
sapply(from_csv_a.df, class)


## ----file-io-csv-03, comment='', echo=FALSE-----------------------------------------------------------------------------
cat(readLines("extdata/aligned-ASCII-UK.csv"), sep = "\n")


## ----file-io-csv-03a----------------------------------------------------------------------------------------------------
from_csv_b.df <-
  read.csv("extdata/aligned-ASCII-UK.csv", stringsAsFactors = FALSE)


## ----file-io-csv-03aa---------------------------------------------------------------------------------------------------
from_csv_b.df
from_csv_b.df[["col4"]]
sapply(from_csv_b.df, class)


## ----file-io-csv-05-----------------------------------------------------------------------------------------------------
from_csv_c.df <-
  read.csv("extdata/aligned-ASCII-UK.csv",
           stringsAsFactors = FALSE, strip.white = TRUE)


## ----file-io-csv-05aa---------------------------------------------------------------------------------------------------
from_csv_c.df
from_csv_c.df[["col4"]]
sapply(from_csv_c.df, class)


## ----file-io-csv-03b----------------------------------------------------------------------------------------------------
from_csv_b.df <-
  read.csv("extdata/aligned-ASCII-UK.csv", stringsAsFactors = TRUE)


## ----file-io-csv-04-----------------------------------------------------------------------------------------------------
sapply(from_csv_b.df, class)
from_csv_b.df[["col4"]]
levels(from_csv_b.df[["col4"]])


## ----file-io-txt-00, comment='', echo=FALSE-----------------------------------------------------------------------------
cat(readLines("extdata/aligned-ASCII.txt"), sep = "\n")


## ----file-io-txt-01-----------------------------------------------------------------------------------------------------
from_txt_b.df <-
  read.table("extdata/aligned-ASCII.txt",
             stringsAsFactors = FALSE, header = TRUE)


## ----file-io-txt-02-----------------------------------------------------------------------------------------------------
from_txt_b.df
from_txt_b.df[["col4"]]
sapply(from_txt_b.df, class)


## ----file-io-fwf-00, comment='', echo=FALSE-----------------------------------------------------------------------------
cat(readLines("extdata/aligned-ASCII.fwf"), sep = "\n")


## ----file-io-fwf-01-----------------------------------------------------------------------------------------------------
from_fwf_a.df <-
  read.fortran("extdata/aligned-ASCII.fwf",
               format = c("2F3.1", "I3", "A3"),
               col.names = c("col1", "col2", "col3", "col4"))


## ----file-io-fwf-02-----------------------------------------------------------------------------------------------------
from_fwf_a.df
from_fwf_a.df[["col4"]]
sapply(from_fwf_a.df, class)


## ----file-io-txt-03-----------------------------------------------------------------------------------------------------
my.df <- data.frame(x = 1:5, y = 5:1 / 10, z = letters[1:5])


## ----file-io-txt-04-----------------------------------------------------------------------------------------------------
write.csv(my.df, file = "my-file1.csv", row.names = FALSE)
file.show("my-file1.csv", pager = "console")


## ----file-io-txt-05, comment='', echo=FALSE-----------------------------------------------------------------------------
cat(readLines("my-file1.csv"), sep = "\n")


## ----file-io-txt-11-----------------------------------------------------------------------------------------------------
my.lines <- c("abcd", "hello world", "123.45")
cat(my.lines, file = "my-file2.txt", sep = "\n")
file.show("my-file2.txt", pager = "console")


## ----file-io-txt-12, comment='', echo=FALSE-----------------------------------------------------------------------------
cat(readLines('my-file2.txt'), sep = '\n')


## ----eval=FALSE, include=FALSE------------------------------------------------------------------------------------------
## citation(package = "readr")


## ----readr-01-----------------------------------------------------------------------------------------------------------
read_csv(file = "extdata/aligned-ASCII-UK.csv", show_col_types = FALSE)


## ----readr-02-----------------------------------------------------------------------------------------------------------
read_csv(file = "extdata/not-aligned-ASCII-UK.csv", show_col_types = FALSE)


## ----readr-03, eval=FALSE-----------------------------------------------------------------------------------------------
## read_table(file = "extdata/aligned-ASCII.txt")


## ----readr-04, eval=FALSE-----------------------------------------------------------------------------------------------
## read_table(file = "extdata/not-aligned-ASCII.txt")


## ----readr-05a----------------------------------------------------------------------------------------------------------
read_delim(file = "extdata/not-aligned-ASCII.txt",
           delim = " ", show_col_types = FALSE)


## ----tibble-print-20, echo=FALSE----------------------------------------------------------------------------------------
options(tibble.print_max = 6, tibble.print_min = 6)


## ----readr-06-----------------------------------------------------------------------------------------------------------
read_table(file = "extdata/miss-aligned-ASCII.txt", show_col_types = FALSE)


## ----readr-07-----------------------------------------------------------------------------------------------------------
read_table(file = "extdata/miss-aligned-ASCII.txt", show_col_types = FALSE,
           guess_max = 3L)


## ----tibble-print-21, echo=FALSE----------------------------------------------------------------------------------------
options(tibble.print_max = 3, tibble.print_min = 3)


## ----readr-10-----------------------------------------------------------------------------------------------------------
write_excel_csv(my.df, file = "my-file6.csv")
file.show("my-file6.csv", pager = "console")


## ----readr-11, comment='', echo=FALSE-----------------------------------------------------------------------------------
cat(read_lines('my-file6.csv'), sep = '\n')


## ----readr-12-----------------------------------------------------------------------------------------------------------
one.str <- read_file(file = "extdata/miss-aligned-ASCII.txt")
length(one.str)
cat(one.str)


## ----xml2-00, eval=FALSE, include=FALSE---------------------------------------------------------------------------------
## citation(package = "xml2")


## ----xml2-01------------------------------------------------------------------------------------------------------------
web_page <- read_html("https://www.learnr-book.info/")


## ----xml2-01a, eval=FALSE-----------------------------------------------------------------------------------------------
## html_structure(web_page)


## ----xml2-02------------------------------------------------------------------------------------------------------------
xml_text(xml_find_all(web_page, ".//title"))


## ----gps-01-------------------------------------------------------------------------------------------------------------
xmlTreeParse(file = "extdata/GPSDATA.gpx", useInternalNodes = TRUE) |>
xmlRoot(x = _) |>
xmlToList(node = _) |>
_[["trk"]] |>
assign(x = "temp", value = _) |>
_[names(x = temp) == "trkseg"] |>
unlist(x = _, recursive = FALSE) |>
map_df(.x = _, .f = function(x) as_tibble(x = t(x = unlist(x = x))))
rm(temp) # cleanup


## ----readxl-00, eval=FALSE, include=FALSE-------------------------------------------------------------------------------
## citation(package = "readxl")


## ----readxl-01----------------------------------------------------------------------------------------------------------
sheets <- excel_sheets("extdata/Book1.xlsx")
sheets


## ----readxl-02----------------------------------------------------------------------------------------------------------
Book1.df <- read_excel("extdata/Book1.xlsx",
                       sheet = "my data")
Book1.df


## ----readxl-03----------------------------------------------------------------------------------------------------------
Book1_region.df <- read_excel("extdata/Book1.xlsx",
                              sheet = "my data",
                              range = "A1:B8")
Book1_region.df


## ----readxl-04----------------------------------------------------------------------------------------------------------
Book1_region.df <- read_excel("extdata/Book1.xlsx",
                              sheet = "my data",
                              range = "A2:B8",
                              col_names = c("A", "B"))
Book1_region.df



## ----xlsx-00, eval=FALSE, include=FALSE---------------------------------------------------------------------------------
## citation(package = "xlsx")


## ----xlsx-01------------------------------------------------------------------------------------------------------------
Book1_xlsx.df <- read.xlsx("extdata/Book1.xlsx",
                           sheetName = "my data")
Book1_xlsx.df
sapply(Book1_xlsx.df, class)


## ----xlsx-05------------------------------------------------------------------------------------------------------------
set.seed(456321)
my.data <- data.frame(x = 1:10, y = letters[1:10])
write.xlsx(my.data,
           file = "extdata/my-data.xlsx",
           sheetName = "first copy")
write.xlsx(my.data,
           file = "extdata/my-data.xlsx",
           sheetName = "second copy",
           append = TRUE)


## ----readODS-00---------------------------------------------------------------------------------------------------------
list_ods_sheets("extdata/Book1.ods")


## ----readODS-01---------------------------------------------------------------------------------------------------------
ods.df <- read_ods("extdata/Book1.ods", sheet = 1)


## ----readODS-02---------------------------------------------------------------------------------------------------------
ods.df


## ----foreign-00, eval=FALSE, include=FALSE------------------------------------------------------------------------------
## citation(package = "foreign")


## ----foreign-01---------------------------------------------------------------------------------------------------------
my_spss.df <- read.spss(file = "extdata/my-data.sav", to.data.frame = TRUE)
my_spss.df[1:6, c(1:6, 17)]


## ----foreign-02---------------------------------------------------------------------------------------------------------
thiamin.df <- read.spss(file = "extdata/thiamin.sav", to.data.frame = TRUE)
head(thiamin.df)


## ----foreign-03---------------------------------------------------------------------------------------------------------
my_systat.df <- read.systat(file = "extdata/BIRCH1.SYS")
head(my_systat.df)


## ----haven-00, eval=FALSE, include=FALSE--------------------------------------------------------------------------------
## citation(package = "haven")


## ----haven-01-----------------------------------------------------------------------------------------------------------
my_spss.tb <- read_sav(file = "extdata/my-data.sav")
my_spss.tb[1:6, c(1:6, 17)]


## ----haven-02-----------------------------------------------------------------------------------------------------------
thiamin.tb <- read_sav(file = "extdata/thiamin.sav")
thiamin.tb


## ----haven-02a----------------------------------------------------------------------------------------------------------
thiamin.tb <- as_factor(thiamin.tb)
thiamin.tb


## ----ncdf4-00, eval=FALSE, include=FALSE--------------------------------------------------------------------------------
## citation(package = "ncdf4")


## ----ncdf4-01-----------------------------------------------------------------------------------------------------------
meteo_data.nc <- nc_open("extdata/pevpr.sfc.mon.ltm.nc")
str(meteo_data.nc, max.level = 1)


## ----ncdf4-02-----------------------------------------------------------------------------------------------------------
time.vec <- ncvar_get(meteo_data.nc, "time")
head(time.vec)
longitude <-  ncvar_get(meteo_data.nc, "lon")
head(longitude)
latitude <- ncvar_get(meteo_data.nc, "lat")
head(latitude)


## ----ncdf4-03-----------------------------------------------------------------------------------------------------------
pet.tb <-
    tibble(time = time.vec,
           month = month(ymd("1800-01-01") + days(time)),
           lon = longitude[6],
           lat = latitude[2],
           pet = ncvar_get(meteo_data.nc, "pevpr")[6, 2, ]
           )
pet.tb


## ----tidync-00, eval=FALSE, include=FALSE-------------------------------------------------------------------------------
## citation(package = "tidync")


## ----tidync-01----------------------------------------------------------------------------------------------------------
meteo_data.tnc <- tidync("extdata/pevpr.sfc.mon.ltm.nc")
meteo_data.tnc


## ----tidync-01a---------------------------------------------------------------------------------------------------------
hyper_dims(meteo_data.tnc)


## ----tidync-01b---------------------------------------------------------------------------------------------------------
hyper_vars(meteo_data.tnc)


## ----tidync-02----------------------------------------------------------------------------------------------------------
hyper_tibble(meteo_data.tnc,
             lon = signif(lon, 1) == 9,
             lat = signif(lat, 2) == 87) |>
  mutate(.data = _, month = month(ymd("1800-01-01") + days(time))) |>
  select(.data = _, -time)


## ----tidync-03----------------------------------------------------------------------------------------------------------
hyper_tibble(meteo_data.tnc,
             lon = signif(lon, 1) == 9) |>
  mutate(.data = _, month = month(ymd("1800-01-01") + days(time))) |>
  select(.data = _, -time)


## ----url-01, eval=eval_online_data--------------------------------------------------------------------------------------
logger.df <-
      read.csv2(file = "http://r4photobiology.info/learnr/logger_1.txt",
                header = FALSE,
                col.names = c("time", "temperature"))
sapply(logger.df, class)


## ----url-11, eval=eval_online_data--------------------------------------------------------------------------------------
download.file("http://r4photobiology.info/learnr/my-data.xlsx",
              "data/my-data-dwn.xlsx",
              mode = "wb")


## ----url-03, eval=eval_online_data--------------------------------------------------------------------------------------
remote_thiamin.df <-
  read.spss(file = "http://r4photobiology.info/learnr/thiamin.sav",
            to.data.frame = TRUE)
head(remote_thiamin.df)


## ----url-04, eval=eval_online_data--------------------------------------------------------------------------------------
remote_my_spss.tb <-
    read_sav(file = "http://r4photobiology.info/learnr/thiamin.sav")
remote_my_spss.tb


## ----url-05, eval=eval_online_data--------------------------------------------------------------------------------------
if (!file.exists("extdata/pevpr.sfc.mon.ltm.nc")) {
  my.url <- paste("ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/",
                  "surface_gauss/pevpr.sfc.mon.ltm.nc",
                  sep = "")
  download.file(my.url,
                mode = "wb",
                destfile = "extdata/pevpr.sfc.mon.ltm.nc")
}
pet_ltm.nc <- nc_open("extdata/pevpr.sfc.mon.ltm.nc")


## ----dbplyr-00a, eval=FALSE, include=FALSE------------------------------------------------------------------------------
## citation(package = "dbplyr")


## ----dbplyr-00b, eval=FALSE, include=FALSE------------------------------------------------------------------------------
## citation(package = "DBI")


## ----dbplyr-00c, eval=FALSE, include=FALSE------------------------------------------------------------------------------
## citation(package = "RSQLite")


## ----dbplyr-01----------------------------------------------------------------------------------------------------------
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
weather.db |>
  filter(.data = _, sun_elevation > 5) |>
  group_by(.data = _, day_of_year) |>
  summarise(.data = _, energy_Wh = sum(global_watt, na.rm = TRUE) * 60 / 3600)


## ----clear-up-data-folders----------------------------------------------------------------------------------------------
unlink("./data", recursive = TRUE)
unlink("./extdata", recursive = TRUE)


## ----iot-00, eval=FALSE, include=FALSE----------------------------------------------------------------------------------
## citation(package = "jsonlite")


## ----iot-01, eval=eval_yoctopuce----------------------------------------------------------------------------------------
hub.url <- "http://localhost:4444/"
Meteo01.df <-
    fromJSON(paste(hub.url, "byName/C1-Meteo/dataLogger.json",
                   sep = ""), flatten = TRUE)
str(Meteo01.df, max.level = 2)


## ----iot-02, eval=eval_yoctopuce, cache=TRUE----------------------------------------------------------------------------
Meteo01.df[["streams"]][[which(Meteo01.df$id == "temperature")]] |>
  as_tibble(x = _) |>
  dplyr::transmute(.data = _,
                   utc.time = as.POSIXct(utc, origin = "1970-01-01", tz = "UTC"),
                   t_min = unlist(val)[c(TRUE, FALSE, FALSE)],
                   t_mean = unlist(val)[c(FALSE, TRUE, FALSE)],
                   t_max = unlist(val)[c(FALSE, FALSE, TRUE)]) -> temperature.df

Meteo01.df[["streams"]][[which(Meteo01.df$id == "humidity")]] |>
  as_tibble(x = _) |>
  dplyr::transmute(.data = _,
                   utc.time = as.POSIXct(utc, origin = "1970-01-01", tz = "UTC"),
                   hr_min = unlist(val)[c(TRUE, FALSE, FALSE)],
                   hr_mean = unlist(val)[c(FALSE, TRUE, FALSE)],
                   hr_max = unlist(val)[c(FALSE, FALSE, TRUE)]) -> humidity.df

full_join(temperature.df, humidity.df)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
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
try(detach(package:tibble))
try(detach(package:learnrbook))


## ----eval=eval_diag, include=eval_diag, echo=eval_diag, cache=FALSE-----------------------------------------------------
## knitter_diag()
## R_diag()
## other_diag()

