## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'plotting-chunk')


## ----eval=FALSE, include=FALSE--------------------------------------------------------------------------------------
## citation(package = "ggplot2")


## ----eval=FALSE-----------------------------------------------------------------------------------------------------
## install.packages(learnrbook::pkgs_ch_ggplot)


## ----message=FALSE--------------------------------------------------------------------------------------------------
library(learnrbook)
library(wrapr)
library(scales)
library(ggplot2)
library(ggrepel)
library(gginnards)
library(ggpmisc)
library(ggbeeswarm)
library(ggforce)
library(tikzDevice)
library(lubridate)
library(tidyverse)
library(patchwork)


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
theme_set(theme_gray(14))


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
# set to TRUE to test non-executed code chunks and rendering of plots
eval_plots_all <- FALSE


## ----ggplot-basics-01-----------------------------------------------------------------------------------------------
ggplot()




## ----ggplot-basics-03-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg))


## ----ggplot-basics-04-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point()


## ----ggplot-basics-04-wb1-------------------------------------------------------------------------------------------
p <- ggplot(data = mtcars,
            aes(x = disp, y = mpg)) +
       geom_point()






## ----ggplot-basics-04a----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point(color = "red", shape = "square")


## ----ggplot-basics-05-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x)


## ----ggplot-basics-06-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x) +
  scale_y_log10()


## ----ggplot-basics-07-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x) +
  coord_cartesian(ylim = c(15, 25))


## ----ggplot-basics-08-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x) +
  coord_trans(y = "log10")


## ----ggplot-basics-09-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  theme_classic()


## ----ggplot-basics-10-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  theme_classic(base_size = 20, base_family = "serif")


## ----ggplot-basics-11-----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point() +
  labs(x = "Engine displacement (cubic inches)",
       y = "Fuel use efficiency\n(miles per gallon)",
       title = "Motor Trend Car Road Tests",
       subtitle = "Source: 1974 Motor Trend US magazine")


## ----ggplot-basics-info-01------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp / cyl, y = mpg)) +
  geom_point()


## ----ggplot-objects-00----------------------------------------------------------------------------------------------
p <- ggplot(data = mtcars,
       aes(x = disp, y = mpg)) +
  geom_point()


## ----ggplot-objects-warn-01, eval=FALSE-----------------------------------------------------------------------------
## str(p, max.level = 1)


## ----ggplot-objects-02----------------------------------------------------------------------------------------------
p +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x)


## ----ggplot-objects-info-01-----------------------------------------------------------------------------------------
my.layers <- list(
  stat_smooth(geom = "line", method = "lm", formula = y ~ x),
  scale_x_log10())


## ----ggplot-objects-info-02-----------------------------------------------------------------------------------------
p + my.layers














## ----scatter-01-----------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg, color = cyl)) +
  geom_point()














## ----scatter-12-----------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg, shape = factor(cyl))) +
  geom_point(size = 2.5) +
  scale_shape_manual(values = c("4", "6", "8"), guide = "none")




## ----scatter-12a----------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_point(alpha = 1/3)




## ----scatter-16-----------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg,
                          color = factor(cyl),
                          size = wt)) +
  scale_size_area() +
  geom_point()




## ----scatter-18-----------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg,
                          shape = factor(cyl),
                          fill = factor(cyl),
                          size = wt)) +
  geom_point(alpha = 0.33, color = "black") +
  scale_size_area() +
  scale_shape_manual(values = c(21, 22, 23))


## ----rug-plot-01----------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg, color = factor(cyl))) +
  geom_point() +
  geom_rug()


## ----line-plot-01---------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       aes(x = age, y = circumference, linetype = Tree)) +
  geom_line()


## ----step-plot-01---------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       aes(x = age, y = circumference, linetype = Tree)) +
  geom_step()




## ----area-plot-01---------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       aes(x = age, y = circumference, fill = Tree)) +
  geom_area(position = "stack")


## ----area-plot-02---------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       aes(x = age, y = circumference, fill = Tree)) +
  geom_area(position = "stack") +
  geom_vline(xintercept = 1000, color = "gray75") +
  geom_vline(xintercept = 1000, linetype = "dotted")


## ----col-plot-01----------------------------------------------------------------------------------------------------
set.seed(654321)
my.col.data <- data.frame(treatment = factor(rep(c("A", "B", "C"), 2)),
                          group = factor(rep(c("male", "female"), c(3, 3))),
                          measurement = rnorm(6) + c(5.5, 5, 7))


## ----col-plot-02----------------------------------------------------------------------------------------------------
ggplot(subset(my.col.data, group == "female"),
       aes(x = treatment, y = measurement)) +
   geom_col()


## ----col-plot-03----------------------------------------------------------------------------------------------------
ggplot(my.col.data, aes(x = treatment, y = measurement, fill = group)) +
     geom_col(color = "white", width = 0.5) +
     scale_fill_grey() + theme_dark()


## ----col-plot-04----------------------------------------------------------------------------------------------------
ggplot(my.col.data, aes(x = treatment, y = measurement, fill = group)) +
     geom_col(color = NA, position = "dodge") +
     scale_fill_grey() + theme_classic()


## ----tile-plot-01---------------------------------------------------------------------------------------------------
set.seed(1234)
randomf.df <- data.frame(F.value = rf(100, df1 = 5, df2 = 20),
                         x = rep(letters[1:10], 10),
                         y = LETTERS[rep(1:10, rep(10, 10))])


## ----tile-plot-02---------------------------------------------------------------------------------------------------
ggplot(randomf.df, aes(x, y, fill = F.value)) +
  geom_tile()


## ----tile-plot-03---------------------------------------------------------------------------------------------------
ggplot(randomf.df, aes(x, y, fill = F.value)) +
  geom_tile(color = "gray75", size = 1.33)




## ----sf_plot-01-----------------------------------------------------------------------------------------------------
nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
ggplot(nc) +
  geom_sf(aes(fill = AREA), color = "gray90")


## ----text-plot-01---------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg,
                          color = factor(cyl),
                          size = wt,
                          label = cyl)) +
  scale_size() +
  geom_point() +
  geom_text(color = "darkblue", size = 3)






## ----text-plot-05---------------------------------------------------------------------------------------------------
my.data <-
  data.frame(x = 1:5, y = rep(2, 5), label = paste("alpha[", 1:5, "]", sep = ""))
my.data$label


## ----text-plot-06---------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y, label = label)) +
  geom_text(hjust = -0.2, parse = TRUE, size = 6) +
  geom_point() +
  expand_limits(x = 5.2)




## ----label-plot-01--------------------------------------------------------------------------------------------------
my.data <-
  data.frame(x = 1:5, y = rep(2, 5),
             label = c("one", "two", "three", "four", "five"))

ggplot(my.data, aes(x, y, label = label)) +
  geom_label(hjust = -0.2, size = 6,
             label.size = 0L,
             label.r = unit(0, "lines"),
             label.padding = unit(0.15, "lines"),
             fill = "yellow", alpha = 0.5) +
  geom_point() +
  expand_limits(x = 5.6)


## ----repel-plot-01--------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       aes(x = disp, y = mpg, color = factor(cyl), size = wt, label = cyl)) +
  scale_size() +
  geom_point(alpha = 1/3) +
  geom_text_repel(color = "black", size = 3,
                  min.segment.length = 0.2, point.padding = 0.1)


## ----table-plot-01--------------------------------------------------------------------------------------------------
mtcars %.>%
  group_by(., cyl) %.>%
  summarize(.,
            "mean wt" = format(mean(wt), digits = 2),
            "mean disp" = format(mean(disp), digits = 0),
            "mean mpg" = format(mean(mpg), digits = 0)) -> my.table
table.tb <- tibble(x = 500, y = 35, table.inset = list(my.table))


## ----table-plot-02--------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg,
                          color = factor(cyl),
                          size = wt,
                          label = cyl)) +
  scale_size() +
  geom_point() +
  geom_table(data = table.tb,
             aes(x = x, y = y, label = table.inset),
             color = "black", size = 3)






## ----plot-plot-01---------------------------------------------------------------------------------------------------
mtcars %.>%
  group_by(., cyl) %.>%
  summarize(., mean.mpg = mean(mpg)) %.>%
  ggplot(data = .,
         aes(factor(cyl), mean.mpg, fill = factor(cyl))) +
  scale_fill_discrete(guide = "none") +
  scale_y_continuous(name = NULL) +
    geom_col() +
    theme_bw(8) -> my.plot
plot.tb <- tibble(x = 500, y = 35, plot.inset = list(my.plot))


## ----plot-plot-02---------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg,
                          color = factor(cyl))) +
  geom_point() +
  geom_plot(data = plot.tb,
            aes(x = x, y = y, label = plot.inset),
            vp.width = 1/2,
            hjust = "inward", vjust = "inward")


## ----plot-plot-03---------------------------------------------------------------------------------------------------
p.main <- ggplot(data = mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  geom_point()
p.inset <- p.main +
  coord_cartesian(xlim = c(270, 330), ylim = c(14, 19)) +
  labs(x = NULL, y = NULL) +
  scale_color_discrete(guide = "none") +
  theme_bw(8) + theme(aspect.ratio = 1)
p.main +
  geom_plot(x = 480, y = 34, label = list(p.inset), vp.height = 1/2,
            hjust = "inward", vjust = "inward") +
  annotate(geom = "rect", fill = NA, color = "black",
           xmin = 270, xmax = 330, ymin = 14, ymax = 19,
           linetype = "dotted")


## ----plot-grob-01---------------------------------------------------------------------------------------------------
file1.name <-
  system.file("extdata", "Isoquercitin.png", package = "ggpmisc", mustWork = TRUE)
Isoquercitin <- magick::image_read(file1.name)
file2.name <-
  system.file("extdata", "Robinin.png", package = "ggpmisc", mustWork = TRUE)
Robinin <- magick::image_read(file2.name)
grob.tb <- tibble(x = c(0, 100), y = c(10, 20), height = 1/3, width = c(1/2),
                  grobs = list(grid::rasterGrob(image = Isoquercitin),
                               grid::rasterGrob(image = Robinin)))

ggplot() +
  geom_grob(data = grob.tb,
            aes(x = x, y = y, label = grobs, vp.height = height, vp.width = width),
                hjust = "inward", vjust = "inward")


## ----plot-npc-eb-01-------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  geom_point() +
  geom_label_npc(npcx = 0.5, npcy = 0.9, label = "a label", color = "black")


## ----function-plot-01-----------------------------------------------------------------------------------------------
ggplot(data.frame(x = -3:3), aes(x = x)) +
  stat_function(fun = dnorm)






## ----summary-plot-01------------------------------------------------------------------------------------------------
fake.data <- data.frame(
  y = c(rnorm(10, mean = 2, sd = 0.5),
        rnorm(10, mean = 4, sd = 0.7)),
  group = factor(c(rep("A", 10), rep("B", 10)))
  )


## ----summary-plot-02------------------------------------------------------------------------------------------------
ggplot(data = fake.data, aes(y = y, x = group)) +
  geom_point(shape = 21) +
  stat_summary(fun = "mean", geom = "point",
               color = "red", shape = "-", size = 10)










## ----summary-plot-09a-----------------------------------------------------------------------------------------------
ggplot(mpg, aes(class, hwy)) +
  stat_summary(geom = "col", fun = mean)








## ----smooth-plot-02-------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg)) +
  stat_smooth(formula = y ~ x) +
  geom_point()




## ----smooth-plot-04-------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  stat_smooth(method = "lm", formula = y ~ x) +
  geom_point()




## ----smooth-plot-06-------------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 2), color = "black") +
  geom_point()






## ----smooth-plot-12-------------------------------------------------------------------------------------------------
my.formula <- y ~ poly(x, 2)
ggplot(data = mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  stat_smooth(method = "lm", formula = my.formula, color = "black") +
  stat_poly_eq(formula = my.formula, aes(label = ..eq.label..),
               color = "black", parse = TRUE, label.x.npc = 0.3) +
  geom_point()


## ----smooth-plot-13-------------------------------------------------------------------------------------------------
my.formula <- y ~ poly(x, 2)
ggplot(data = mtcars, aes(x = disp, y = mpg, color = factor(cyl))) +
  stat_smooth(method = "lm", formula = my.formula, color = "black") +
  stat_fit_tb(method = "lm",
              method.args = list(formula = my.formula),
              color = "black",
              tb.vars = c(Parameter = "term",
                          Estimate = "estimate",
                          "s.e." = "std.error",
                          "italic(t)" = "statistic",
                          "italic(P)" = "p.value"),
              label.y.npc = "top", label.x.npc = "right",
              parse = TRUE) +
  geom_point()


## ----histogram-plot-00----------------------------------------------------------------------------------------------
set.seed(12345)
my.data <-
  data.frame(x = rnorm(200),
             y = c(rnorm(100, -1, 1), rnorm(100, 1, 1)),
             group = factor(rep(c("A", "B"), c(100, 100))) )


## ----histogram-plot-01----------------------------------------------------------------------------------------------
ggplot(my.data, aes(x)) +
  geom_histogram(bins = 15)




## ----histogram-plot-03----------------------------------------------------------------------------------------------
ggplot(my.data, aes(y, fill = group)) +
  geom_histogram(mapping = aes(y = stat(density)), bins = 15, position = "dodge")




## ----bin2d-plot-01--------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) +
  stat_bin2d(bins = 8) +
  coord_fixed(ratio = 1)


## ----hex-plot-01----------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) +
  stat_bin_hex(bins = 8) +
  coord_fixed(ratio = 1)


## ----density-plot-01------------------------------------------------------------------------------------------------
ggplot(my.data, aes(y, color = group)) +
  geom_density()




## ----density-plot-10------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y, color = group)) +
  geom_point() +
  geom_rug() +
  stat_density_2d()




## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----density-plot-12------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y)) +
stat_density_2d(aes(fill = stat(level)), geom = "polygon") +
  facet_wrap(~group)


## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----bw-plot-01-----------------------------------------------------------------------------------------------------
ggplot(my.data, aes(group, y)) +
  stat_boxplot()


## ----bw-plot-02-----------------------------------------------------------------------------------------------------
ggplot(my.data, aes(group, y)) +
  stat_boxplot(notch = TRUE, width = 0.4,
               outlier.color = "red", outlier.shape = "*", outlier.size = 5)




## ----violin-plot-02-------------------------------------------------------------------------------------------------
ggplot(my.data, aes(group, y, fill = group)) +
  geom_violin(alpha = 0.16) +
  geom_point(alpha = 0.33, size = 1.5,
             color = "black", shape = 21)


## ----ggbeeswarm-plot-01---------------------------------------------------------------------------------------------
ggplot(my.data, aes(group, y)) +
  geom_quasirandom()


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----facets-00------------------------------------------------------------------------------------------------------
p <- ggplot(data = mtcars, aes(wt, mpg)) +
  geom_point()
p


## ----facets-01------------------------------------------------------------------------------------------------------
p + facet_grid(cols = vars(cyl))






## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow_square)




## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----facets-06------------------------------------------------------------------------------------------------------
p + facet_grid(cols = vars(cyl), margins = TRUE)


## ----facets-07------------------------------------------------------------------------------------------------------
p + facet_grid(cols = vars(vs, am), labeller = label_both)




## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide_square)




## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow_square)


## ----facets-13------------------------------------------------------------------------------------------------------
p + facet_wrap(facets = vars(cyl), nrow = 2)




## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----axis-labels-01-------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       aes(x = age, y = circumference, color = Tree)) +
  geom_line() +
  geom_point() +
  expand_limits(y = 0) +
  scale_x_continuous(name = "Time (d)") +
  scale_y_continuous(name = "Circumference (mm)") +
  ggtitle(label = "Growth of orange trees",
          subtitle = "Starting from 1968-12-31")




## ----axis-labels-03-------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       aes(x = age, y = circumference, color = Tree)) +
  geom_line() +
  geom_point() +
  expand_limits(y = 0) +
  labs(title = "Growth of orange trees",
       subtitle = "Starting from 1968-12-31",
       caption = "see Draper, N. R. and Smith, H. (1998)",
       tag = "A",
       x = "Time (d)",
       y = "Circumference (mm)",
       color = "Tree\nnumber")


## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_medium)


## ----scales-01------------------------------------------------------------------------------------------------------
fake2.data <-
  data.frame(y = c(rnorm(20, mean = 20, sd = 5),
                   rnorm(20, mean = 40, sd = 10)),
             group = factor(c(rep("A", 20), rep("B", 20))),
             z = rnorm(40, mean = 12, sd = 6))








## ----scale-limits-04------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z, y)) +
  geom_point() +
  expand_limits(y = 0, x = 0)












## ----scale-ticks-02-------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z, y)) +
  geom_point() +
  scale_y_continuous(breaks = c(20, pi * 10, 40, 60),
                     labels = c("20", expression(10*pi), "40", "60"))


## ----scale-ticks-03-------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z, y / max(y))) +
  geom_point() +
  scale_y_continuous(labels = scales::percent)


## ----scale-trans-01-------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z, y)) +
  geom_point() +
  scale_x_reverse()










## ----axis-position-01-----------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(wt, mpg)) +
  geom_point() +
  scale_x_continuous(position = "top") +
  scale_y_continuous(position = "right")


## ----axis-secondary-01----------------------------------------------------------------------------------------------
ggplot(data = mtcars, aes(wt, mpg)) +
  geom_point() +
  scale_y_continuous(sec.axis = sec_axis(~ . ^-1, name = "1/y") )




## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_very_wide)


## ----scale-datetime-01----------------------------------------------------------------------------------------------
ggplot(data = weather_wk_25_2019.tb,
       aes(with_tz(time, tzone = "EET"), air_temp_C)) +
  geom_line() +
  scale_x_datetime(name = NULL,
                   breaks = ymd_hm("2019-06-11 12:00", tz = "EET") + days(0:1),
                   limits = ymd_hm("2019-06-11 00:00", tz = "EET") + days(c(0, 2))) +
  scale_y_continuous(name = "Air temperature (C)") +
  expand_limits(y = 0)


## ----scale-datetime-02----------------------------------------------------------------------------------------------
ggplot(data = weather_wk_25_2019.tb,
       aes(with_tz(time, tzone = "EET"), air_temp_C)) +
  geom_line() +
  scale_x_datetime(name = NULL,
                   date_breaks = "1 hour",
                   limits = ymd_hm("2019-06-16 00:00", tz = "EET") + hours(c(6, 18)),
                   date_labels = "%H:%M") +
  scale_y_continuous(name = "Air temperature (C)") +
  expand_limits(y = 0)


## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)

## ----scale-discrete-10----------------------------------------------------------------------------------------------
ggplot(mpg, aes(class, hwy)) +
  stat_summary(geom = "col", fun = mean, na.rm = TRUE) +
  scale_x_discrete(limits = c("compact", "subcompact", "midsize"),
                   labels = c("COMPACT", "SUBCOMPACT", "MIDSIZE"))






## ----echo=FALSE, include=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----scale-color-01-------------------------------------------------------------------------------------------------
length(colors())
grep("dark",colors(), value = TRUE)


## ----scale-color-02-------------------------------------------------------------------------------------------------
col2rgb("purple")
col2rgb("#FF0000")


## ----scale-color-03-------------------------------------------------------------------------------------------------
col2rgb("purple", alpha = TRUE)


## ----scale-color-04-------------------------------------------------------------------------------------------------
rgb(1, 1, 0)
rgb(1, 1, 0, names = "my.color")
rgb(255, 255, 0, names = "my.color", maxColorValue = 255)


## ----scale-color-05-------------------------------------------------------------------------------------------------
hsv(c(0,0.25,0.5,0.75,1), 0.5, 0.5)


## ----scale-color-06-------------------------------------------------------------------------------------------------
hcl(c(0,0.25,0.5,0.75,1) * 360)


## ----scale-color-10-------------------------------------------------------------------------------------------------
df99 <- data.frame(x = 1:10, y = dnorm(10), colors = rep(c("red", "blue"), 5))

ggplot(df99, aes(x, y, color = colors)) +
  geom_point() +
  scale_color_identity()


## ----annotate-01----------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z, y)) +
  geom_point() +
  annotate(geom = "text",
           label = "origin",
           x = 0, y = 0,
           color = "blue",
           size=4)


## ----inset-01-------------------------------------------------------------------------------------------------------
p <- ggplot(fake2.data, aes(z, y)) +
  geom_point()
p + expand_limits(x = 40) +
  annotation_custom(ggplotGrob(p + coord_cartesian(xlim = c(5, 10), ylim = c(20, 40)) +
                               theme_bw(10)),
                    xmin = 21, xmax = 40, ymin = 30, ymax = 60)


## ----annotate-03----------------------------------------------------------------------------------------------------
ggplot(data.frame(x = c(0, 2 * pi)), aes(x = x)) +
  stat_function(fun = sin) +
  scale_x_continuous(
    breaks = c(0, 0.5, 1, 1.5, 2) * pi,
    labels = c("0", expression(0.5~pi), expression(pi),
             expression(1.5~pi), expression(2~pi))) +
  labs(y = "sin(x)") +
  annotate(geom = "text",
           label = c("+", "-"),
           x = c(0.5, 1.5) * pi, y = c(0.5, -0.5),
           size = 20) +
  annotate(geom = "point",
           color = "red",
           shape = 21,
           fill = "white",
           x = c(0, 1, 2) * pi, y = 0,
           size = 6)


## ----wind-05--------------------------------------------------------------------------------------------------------
p <- ggplot(viikki_d29.dat, aes(WindDir_D1_WVT))  +
  coord_polar() +
  scale_x_continuous(breaks = c(0, 90, 180, 270),
                     labels = c("N", "E", "S", "W"),
                     limits = c(0, 360),
                     expand = c(0, 0),
                     name = "Wind direction")
p + stat_bin(color = "black", fill = "gray50", geom = "bar",
             binwidth = 30, na.rm = TRUE) + labs(y = "Frequency")


## ----wind-06--------------------------------------------------------------------------------------------------------
p + stat_density(color = "black", fill = "gray50",
                 geom = "polygon", size = 1) + labs(y = "Density")


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_very_wide)


## ----wind-08--------------------------------------------------------------------------------------------------------
ggplot(viikki_d29.dat, aes(WindDir_D1_WVT, WindSpd_S_WVT)) +
  coord_polar() +
  stat_density_2d(aes(fill = stat(level)), geom = "polygon") +
  scale_x_continuous(breaks = c(0, 90, 180, 270),
                     labels = c("N", "E", "S", "W"),
                     limits = c(0, 360),
                     expand = c(0, 0),
                     name = "Wind direction") +
  scale_y_continuous(name = "Wind speed (m/s)") +
  facet_wrap(~factor(ifelse(hour(solar_time) < 12, "AM", "PM")))


## ----echo=FALSE-----------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## -------------------------------------------------------------------------------------------------------------------
ggplot(data = mpg, aes(x = factor(1), fill = factor(class))) +
  geom_bar(width = 1, color = "black") +
  coord_polar(theta = "y") +
  scale_fill_brewer() +
  scale_x_discrete(breaks = NULL) +
  labs(x = NULL, fill = "Vehicle class")


## ----themes-01------------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z, y)) +
  geom_point() +
  theme_gray(base_size = 15,
             base_family = "serif")








## ----themes-11------------------------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z + 1000, y)) +
  geom_point() +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 8)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))








## ----themes-21------------------------------------------------------------------------------------------------------
my_theme <- theme_bw() + theme(text = element_text(color = "darkred"))
p + my_theme


## ----themes-32------------------------------------------------------------------------------------------------------
my_theme_gray <-
  function (base_size = 11,
            base_family = "serif",
            base_line_size = base_size/22,
            base_rect_size = base_size/22,
            base_color = "darkblue") {
    theme_gray(base_size = base_size,
               base_family = base_family,
               base_line_size = base_line_size,
               base_rect_size = base_rect_size) +
    theme(line = element_line(color = base_color),
          rect = element_rect(color = base_color),
          text = element_text(color = base_color),
          title = element_text(color = base_color),
          axis.text = element_text(color = base_color), complete = TRUE)
  }


## ----themes-32a-----------------------------------------------------------------------------------------------------
my_theme_gray <- my_theme_gray


## ----themes-33------------------------------------------------------------------------------------------------------
p + my_theme_gray(15, base_color = "darkred")


## ----patchwork-01---------------------------------------------------------------------------------------------------
p1 <- ggplot(mpg, aes(displ, cty, color = factor(cyl))) +
        geom_point() +
        theme(legend.position = "top")
p2 <- ggplot(mpg, aes(displ, cty, color = factor(year))) +
        geom_point() +
        theme(legend.position = "top")
p3 <- ggplot(mpg, aes(factor(model), cty)) +
        geom_point() +
        theme(axis.text.x =
                element_text(angle = 90, hjust = 1, vjust = 0.5))


## ----patchwork-00a, echo=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_very_wide_square)




## ----patchwork-03---------------------------------------------------------------------------------------------------
((p1 | p2) / p3) +
   plot_annotation(title = "Fuel use in city traffic:", tag_levels = 'a')


## ----patchwork-00b, echo=FALSE--------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----plotmath-01----------------------------------------------------------------------------------------------------
set.seed(54321) # make sure we always generate the same data
my.data <-
  data.frame(x = 1:5,
             y = rnorm(5),
             greek.label = paste("alpha[", 1:5, "]", sep = ""))


## ----plotmath-02----------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y, label = greek.label)) +
   geom_point() +
   geom_text(angle = 45, hjust = 1.2, parse = TRUE) +
   labs(x = expression(alpha[i]),
        y = expression(Speed~~(m~s^{-1})),
        title = "Using expressions",
        subtitle = expression(sqrt(alpha[1] + frac(beta, gamma))))


## ----plotmath-02a---------------------------------------------------------------------------------------------------
my_eq.char <- "alpha[i]"
ggplot(my.data, aes(x, y)) +
   geom_point() +
   labs(title = parse(text = my_eq.char)) +
   scale_x_continuous(name = expression(alpha[i]),
                      breaks = c(1,3,5),
                      labels = expression(alpha[1], alpha[3], alpha[5]))


















## ----sprintf-01-----------------------------------------------------------------------------------------------------
sprintf("log(%.3f) = %.3f", 5, log(5))
sprintf("log(%.3g) = %.3g", 5, log(5))


## ----expr-bquote-01-------------------------------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  labs(title = bquote(Time~zone: .(Sys.timezone())),
       subtitle = bquote(Date: .(as.character(today())))
       )


## ----expr-substitute-01---------------------------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  labs(title = substitute(Time~zone: tz, list(tz = Sys.timezone())),
       subtitle = substitute(Date: date, list(date = as.character(today())))
       )


## ----expr-deparse-01------------------------------------------------------------------------------------------------
deparse_test <- function(x) {
  print(deparse(substitute(x)))
}

a <- "saved in variable"

deparse_test("constant")
deparse_test(1 + 2)
deparse_test(a)




















## ----echo=FALSE-----------------------------------------------------------------------------------------------------
try(detach(package:tidyverse))
try(detach(package:lubridate))
try(detach(package:tikzDevice))
try(detach(package:ggforce))
try(detach(package:ggbeeswarm))
try(detach(package:ggpmisc))
try(detach(package:gginnards))
try(detach(package:ggrepel))
try(detach(package:ggplot2))
try(detach(package:scales))
try(detach(package:wrapr))
try(detach(package:learnrbook))

