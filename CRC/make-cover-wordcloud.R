library(ngram)
library(ggplot2)
library(ggwordcloud)
library(dplyr)
library(tidytext)
library(stringr)
library(wrapr)

getwd()
list.files(path = ".", pattern = "*.idx$")
indexed.words <- multiread(extension=".idx", prune.empty = FALSE)

get_words <- function(x) {
  # remove laTeX commands
  gsub("\\\\textsf|\\\\textit|\\\\textsf|\\\\texttt|\\\\indexentry|\\\\textbar|\\\\ldots", "", x) -> temp
  # replace scaped characters
  gsub("\\\\_", "_", temp) -> temp
  gsub('\\\\"|\\"|\"', '"', temp) -> temp
  gsub("\\\\%", "%", temp) -> temp
  gsub("\\\\$|\\$", "$", temp) -> temp
  gsub("\\\\&|\\&", "&", temp) -> temp
  gsub("\\\\^|\\^", "^", temp) -> temp
  # remove index catagories
  gsub("[{]functions and methods!|[{]classes and modes!|[{]data objects!|[{]operators!|[{]control of execution!|[{]names and their scope!|[{]constant and special values!", "", temp) -> temp
  # remove page numbers
  gsub("[{][0-9]*[}]", "", temp) -> temp
  # remove LaTeX formated versions of index entries
  gsub("@  [{][a-zA-Z_.:0-9$<-]*[(][])][}][}]", "", temp) -> temp
  gsub("@  [{][-a-zA-Z_.:0-9$<+*/>&^\\]*[}][}]", "", temp) -> temp
  gsub("@  [{][\\<>.!=, \"%[]*]*[}][}]", "", temp)
}

assign(sub("./", "", names(indexed.words)[1]), get_words(indexed.words[[1]]))

string.summary(rcatsidx.idx)

str_replace(rcatsidx.idx, "@", "") %.>%
  str_replace(., '\\"|\\\\"|\"', "") %.>%
  str_replace(., '\\\\$"', "$") %.>%
  str_replace(., "^[{]", "") %.>%
  str_replace(., "[}][}]$", "") %.>%
  str_split(., " ") %.>%
  unlist(.) %.>%
  sort(.) %.>%
  rle(.) %.>%
  tibble(lengths = .$lengths, values = .$values) %.>%
  filter(., !values %in% c("", "NA", "\\$")) %.>%
  mutate(., values = ifelse(values %in% c("{%in%}}","{%in%}", "%in%@"), "%in%", values)) %.>%
  mutate(., values = ifelse(values %in% c("{levels()<-}}","{levels()<-}", "levels()<-@"), "%in%", values)) %.>%
  group_by(., values) %>%
  summarise(., lengths = sum(lengths)) %>%
  dplyr::arrange(., desc(lengths)) -> word_counts.tb

nrow(word_counts.tb)

set.seed(42)
ggplot(word_counts.tb[1:140, ], aes(label = values, size = lengths, color = lengths)) +
  geom_text_wordcloud(family = "mono", fontface = "bold", area_corr = TRUE) +
  scale_size_area(max_size = 10) +
  scale_color_viridis_c() +
  theme_minimal() +
  theme(aspect.ratio = 3/4,
        panel.background = element_rect(fill = "black"))
