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
  # remove index categories
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

word_cloud.fig0 <-
  ggplot(word_counts.tb[1:180, ], aes(label = values, size = lengths, color = lengths)) +
  geom_text_wordcloud(family = "mono", fontface = "bold", area_corr = TRUE, grid_margin = 2, seed = 42) +
  scale_size_area(max_size = 11) +
  scale_color_viridis_c() +
  theme_minimal() +
  theme(aspect.ratio = 5/7)

png("CRC/covers/learnrbook-cover-image-300-0.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig0)
dev.off()

word_cloud.fig1 <-
  ggplot(word_counts.tb[1:80, ], aes(label = values, size = lengths, color = lengths)) +
  geom_text_wordcloud(family = "mono", fontface = "bold", area_corr = TRUE, grid_margin = 2, seed = 42, shape = "square") +
  scale_size_area(max_size = 14) +
  scale_color_viridis_c() +
  theme_minimal() +
  theme(aspect.ratio = 5/7)

png("CRC/covers/learnrbook-cover-image-300-1.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig1)
dev.off()

word_cloud.fig2 <-
  ggplot(word_counts.tb[1:160, ], aes(label = values, size = lengths, color = lengths)) +
  geom_text_wordcloud(family = "mono", fontface = "bold", area_corr = TRUE, grid_margin = 2, seed = 42) +
  scale_size_area(max_size = 12) +
  scale_color_viridis_c() +
  theme_minimal() +
  theme(aspect.ratio = 5/7)

png("CRC/covers/learnrbook-cover-image-300-2.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig2)
dev.off()

word_cloud.fig3 <-
  ggplot(word_counts.tb[1:480, ], aes(label = values, size = lengths, color = lengths)) +
  geom_text_wordcloud(family = "mono", fontface = "bold", area_corr = TRUE, grid_margin = 3, seed = 42, shape = "square") +
  scale_size_area(max_size = 10) +
  scale_color_viridis_c() +
  theme_minimal() +
  theme(aspect.ratio = 5/7)

png("CRC/covers/learnrbook-cover-image-300-3.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig3)
dev.off()

word_cloud.fig4 <-
  word_cloud.fig3 %+% scale_color_viridis_c(option = "B")

png("CRC/covers/learnrbook-cover-image-300-4.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig4)
dev.off()

word_cloud.fig5 <-
  word_cloud.fig3 %+% scale_color_viridis_c(option = "C")

png("CRC/covers/learnrbook-cover-image-300-5.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig5)
dev.off()

word_cloud.fig6 <-
  word_cloud.fig3 %+% scale_color_viridis_c(option = "E")

png("CRC/covers/learnrbook-cover-image-300-6.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig6)
dev.off()

word_cloud.fig7 <-
  word_cloud.fig3 %+% scale_color_viridis_c(option = "A")

png("CRC/covers/learnrbook-cover-image-300-7.png", width = 2100, height = 1500, res = 300, bg = "black")
print(word_cloud.fig7)
dev.off()

