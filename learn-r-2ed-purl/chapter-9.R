## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)
opts_knit$set(concordance=TRUE)
opts_knit$set(unnamed.chunk.label = 'plotting-chunk')


## ----eval=FALSE, include=FALSE------------------------------------------------------------------------------------------
## citation(package = "ggplot2")


## ----eval=FALSE---------------------------------------------------------------------------------------------------------
## install.packages(learnrbook::pkgs_ch_ggplot)


## ----message=FALSE------------------------------------------------------------------------------------------------------
library(learnrbook)
library(scales)
library(ggplot2)
library(ggrepel)
library(gginnards)
library(broom)
library(ggpmisc)
library(ggbeeswarm)
library(lubridate)
library(tibble)
library(dplyr)
library(patchwork)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
theme_set(theme_gray(14))


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
# set to TRUE to test non-executed code chunks and rendering of plots
eval_plots_all <- FALSE


## ----ggplot-basics-01---------------------------------------------------------------------------------------------------
ggplot()


## ----ggplot-basics-02, eval=eval_plots_all------------------------------------------------------------------------------
ggplot(data = mtcars)


## ----ggplot-basics-03---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg))


## ----ggplot-basics-04---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point()


## ----ggplot-basics-04-wb1-----------------------------------------------------------------------------------------------
p1 <- ggplot(data = mtcars,
             mapping = aes(x = disp, y = mpg)) +
       geom_point()


## ----ggplot-basics-04-wb2, eval=eval_plots_all--------------------------------------------------------------------------
print(p1)


## ----ggplot-basics-04a--------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point(colour = "blue", shape = "square")


## ----ggplot-basics-04b--------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point(mapping = aes(colour = "blue", shape = "square"))


## ----ggplot-basics-05---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x)


## ----ggplot-basics-06---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x) +
  scale_y_log10()


## ----ggplot-basics-07---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x) +
  coord_cartesian(ylim = c(15, 25))


## ----ggplot-basics-08---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  stat_smooth(geom = "line", method = "lm", formula = y ~ x) +
  coord_trans(y = "log10")


## ----ggplot-basics-09---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  theme_classic()


## ----ggplot-basics-10---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  theme_classic(base_size = 20, base_family = "serif")


## ----ggplot-basics-11---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point() +
  labs(x = "Engine displacement (cubic inches)",
       y = "Fuel use efficiency\n(miles per gallon)",
       title = "Motor Trend Car Road Tests",
       subtitle = "Source: 1974 Motor Trend US magazine")


## ----ggplot-basics-info-01----------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp / cyl, y = mpg)) +
  geom_point()


## ----ggplot-basics-04-wb1-----------------------------------------------------------------------------------------------
p1 <- ggplot(data = mtcars,
             mapping = aes(x = disp, y = mpg)) +
       geom_point()


## ----ggplot-objects-02--------------------------------------------------------------------------------------------------
p1 + stat_smooth(geom = "line", method = "lm", formula = y ~ x)


## ----ggplot-objects-info-01---------------------------------------------------------------------------------------------
p.ls <- list(
  stat_smooth(geom = "line", method = "lm", formula = y ~ x),
  scale_y_log10())


## ----ggplot-objects-info-02---------------------------------------------------------------------------------------------
p1 + p.ls


## ----ggplot-objects-03a-------------------------------------------------------------------------------------------------
summary(p1)


## ----ggplot-objects-03b-------------------------------------------------------------------------------------------------
names(p1)


## ----ggplot-objects-box-03, eval=FALSE----------------------------------------------------------------------------------
## str(p1$layers, max.level = 1)


## ----ggplot-basics-12a--------------------------------------------------------------------------------------------------
p2 <-
  ggplot(data = mtcars,
         mapping = aes(x = disp, y = mpg, colour = cyl)) +
  geom_point()
p2


## ----ggplot-basics-12b--------------------------------------------------------------------------------------------------
p2 + scale_colour_viridis_c(option = "magma", end = 0.85)


## ----ggplot-basics-12c--------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  geom_point()


## ----ggplot-basics-12d, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = ordered(cyl))) +
  geom_point()


## ----ggplot-basics-13, eval=eval_plots_all------------------------------------------------------------------------------
p3 <-
  ggplot() +
  geom_point(data = mtcars,
             mapping = aes(x = disp, y = mpg, colour = cyl))
p3


## ----ggplot-basics-14, eval=eval_plots_all------------------------------------------------------------------------------
ggplot(data = mtcars) +
       aes(x = disp, y = mpg) +
  geom_point()


## ----ggplot-basics-15, eval=eval_plots_all------------------------------------------------------------------------------
ggplot() +
  aes(x = disp, y = mpg) +
  geom_point(data = mtcars)


## ----ggplot-basics-15a, eval=eval_plots_all-----------------------------------------------------------------------------
my.mapping <- aes(x = disp, y = mpg)
ggplot(data = mtcars,
       mapping = my.mapping) +
  geom_point()


## ----ggplot-basics-15b--------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping =aes(x = disp, y = mpg * 0.43)) +
  geom_point()


## ----ggplot-basics-16---------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point(size = 4) +
  geom_point(data = function(x){subset(x = x, cyl == 4)},
             colour = "yellow", size = 1.5)


## ----ggplot-basics-17, eval=eval_plots_all------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point(size = 4) +
  geom_point(data = . %>% subset(x = ., cyl == 4), colour = "yellow",
             size = 1.5)


## ----ggplot-basics-18, eval=eval_plots_all------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg)) +
  geom_point(size = 4) +
  geom_point(colour = "yellow",
             mapping = aes(size = ifelse(cyl == 4, 1.5, NA)),
             na.rm = TRUE) +
  scale_size_identity()


## ----mapping-stage-01---------------------------------------------------------------------------------------------------
set.seed(4321)
X <- 0:10
Y <- (X + X^2 + X^3) + rnorm(length(X), mean = 0, sd = mean(X^3) / 4)
df1 <- data.frame(X, Y)
df2 <- df1
df2[6, "Y"] <-df1[6, "Y"] * 10


## ----mapping-stage-02---------------------------------------------------------------------------------------------------
ggplot(data = df2, mapping = aes(x = X, y = Y)) +
  stat_fit_residuals(formula = y ~ poly(x, 3, raw = TRUE), method = "rlm",
                     mapping = aes(colour = after_stat(weights)),
                     show.legend = TRUE) +
  scale_colour_gradient(low = "red", high = "blue", limits = c(0, 1),
                       guide = "colourbar")


## ----mapping-stage-03---------------------------------------------------------------------------------------------------
ggplot(df2) +
  stat_fit_residuals(formula = y ~ poly(x, 3, raw = TRUE),
                     method = "rlm",
                     mapping = aes(x = X,
                                   y = stage(start = Y,
                                             after_stat = y * weights),
                                   colour = after_stat(weights)),
                     show.legend = TRUE) +
  scale_colour_gradient(low = "red", high = "blue", limits = c(0, 1),
                        guide = "colourbar")


## ----scatter-01---------------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, shape = factor(cyl))) +
  geom_point()
p.base


## ----scatter-11---------------------------------------------------------------------------------------------------------
p.base +
  scale_shape_discrete(solid = FALSE)


## ----scatter-11a, eval=eval_plots_all-----------------------------------------------------------------------------------
p.base +
  scale_shape_manual(values = c("circle open",
                                "square open",
                                "diamond open"))


## ----scatter-12, eval=eval_plots_all------------------------------------------------------------------------------------
p.base +
 scale_shape_manual(values = c("4", "6", "8"), guide = "none")


## ----scatter-14, eval=eval_plots_all------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg,
       shape = factor(cyl), colour = factor(cyl))) +
  geom_point()


## ----scatter-12a--------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = factor(cyl), y = mpg)) +
  geom_point(alpha = 1/3)


## ----scatter-13---------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = factor(cyl), y = mpg)) +
  geom_point(position = position_jitter(width = 0.25, heigh = 0))


## ----scatter-13info, eval=eval_plots_all--------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = factor(cyl), y = mpg), colour = factor(cyl)) +
  geom_point(position = "jitter")


## ----scatter-16---------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl), size = wt)) +
  scale_size_area() +
  geom_point(shape = "circle open", stroke = 1.5)


## ----scatter-18---------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, shape = factor(cyl),
                     fill = factor(cyl), size = wt)) +
  geom_point(alpha = 0.33, colour = "black") +
  scale_size_area() +
  scale_shape_manual(values = c("circle filled",
                                "square filled",
                                "diamond filled"))


## ----rug-plot-01--------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  geom_point() +
  geom_rug(sides = "btlr")


## ----line-plot-01-------------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       mapping = aes(x = age, y = circumference, linetype = Tree)) +
  geom_line()


## ----step-plot-01-------------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       mapping = aes(x = age, y = circumference, linetype = Tree)) +
  geom_step()


## ----line-plots-PG01,eval=eval_playground-------------------------------------------------------------------------------
toy.df <- data.frame(x = c(1,3,2,4), y = c(0,1,0,1))


## ----area-plot-01-------------------------------------------------------------------------------------------------------
p1 <- # will be used again later
  ggplot(data = Orange,
         mapping = aes(x = age, y = circumference, fill = Tree)) +
  geom_area(position = "stack", colour = "white", linewidth = 1)
p1


## ----area-plot-02-------------------------------------------------------------------------------------------------------
p1 +
  geom_vline(xintercept = 365 * 1:3, colour = "gray75") +
  geom_vline(xintercept = 365 * 1:3, linetype = "dashed")


## ----col-plot-01--------------------------------------------------------------------------------------------------------
set.seed(654321)
my.col.data <-
  data.frame(treatment = factor(rep(c("A", "B", "C"), 2)),
             group = factor(rep(c("male", "female"), c(3, 3))),
             measurement = rnorm(6) + c(5.5, 5, 7))


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_medium)


## ----col-plot-02--------------------------------------------------------------------------------------------------------
ggplot(subset(my.col.data, group == "female"),
       mapping = aes(x = treatment, y = measurement)) +
  geom_col()


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----col-plot-03--------------------------------------------------------------------------------------------------------
p.base <-
 ggplot(my.col.data,
        mapping = aes(x = treatment, y = measurement, fill = group))


## ----col-plot-03a-------------------------------------------------------------------------------------------------------
p1 <- p.base + geom_col(width = 0.5) + ggtitle("stack (default)")


## ----col-plot-04--------------------------------------------------------------------------------------------------------
p2 <- p.base + geom_col(position = "dodge") + ggtitle("dodge")


## ----col-plot-04a-------------------------------------------------------------------------------------------------------
p1 + p2


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----tile-plot-01-------------------------------------------------------------------------------------------------------
set.seed(1234)
randomf.df <- data.frame(F.value = rf(100, df1 = 2, df2 = 20),
                         x = rep(letters[1:10], 10),
                         y = LETTERS[rep(1:10, rep(10, 10))])


## ----tile-plot-02-------------------------------------------------------------------------------------------------------
ggplot(data = randomf.df,
       mapping = aes(x, y, fill = F.value)) +
  geom_tile()


## ----tile-plot-03-------------------------------------------------------------------------------------------------------
ggplot(data = randomf.df,
       mapping = aes(x, y, fill = F.value)) +
  geom_tile(colour = "gray75", linewidth = 1)


## ----tile-plot-04, eval=eval_plots_all----------------------------------------------------------------------------------
ggplot(data = randomf.df,
       mapping = aes(x, y, fill = F.value)) +
  geom_tile(colour = "white") +
  scale_fill_gradient(low = "gray15", high = "gray85", na.value = "red")


## ----sf_plot-01---------------------------------------------------------------------------------------------------------
nc <- sf::st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)
ggplot(nc) +
  geom_sf(mapping = aes(fill = AREA), colour = "gray90")


## ----text-plot-01-------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
         mapping = aes(x = disp, y = mpg,
                       colour = factor(cyl), size = wt, label = cyl)) +
  geom_point(alpha = 1/3) +
  geom_text(colour = "darkblue", size = 3)


## ----text-plot-02-------------------------------------------------------------------------------------------------------
my.data <-
  data.frame(x = 1:5,
             y = rep(2, 5),
             label = c("ab", "bc", "cd", "de", "ef"))


## ----text-plot-02a------------------------------------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x, y, label = label)) +
  geom_text(angle = 90, hjust = 1.5, size = 4) +
  geom_point()


## ----text-plot-04, eval=eval_plots_all----------------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x, y, label = label)) +
  geom_text(angle = 90, hjust = 1.5, size = 4, family = "serif") +
  geom_point()


## ----text-plot-05-------------------------------------------------------------------------------------------------------
my.data <-
  data.frame(x = 1:5, y = rep(2, 5), label = paste("alpha[", 1:5, "]", sep = ""))
my.data$label


## ----text-plot-06-------------------------------------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x, y, label = label)) +
  geom_text(hjust = -0.2, parse = TRUE, size = 6) +
  geom_point() +
  expand_limits(x = 5.2)


## ----text-plot-07, eval=eval_plots_all----------------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x, y, label = paste("alpha[", x, "]", sep = ""))) +
  geom_text(hjust = -0.2, parse = TRUE, size = 6) +
  geom_point()


## ----label-plot-01------------------------------------------------------------------------------------------------------
my.data <-
  data.frame(x = 1:5, y = rep(2, 5),
             label = c("one", "two", "three", "four", "five"))

ggplot(data = my.data,
       mapping = aes(x, y, label = label)) +
  geom_label(hjust = -0.2, size = 6,
             label.size = 0,
             label.r = unit(0, "lines"),
             label.padding = unit(0.15, "lines"),
             fill = "yellow", alpha = 0.5) +
  geom_point() +
  expand_limits(x = 5.6)


## ----repel-plot-01------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg,
                     colour = factor(cyl), size = wt, label = cyl)) +
  scale_size() +
  geom_point(alpha = 1/3) +
  geom_text_repel(colour = "black", size = 3,
                  min.segment.length = 0.2, point.padding = 0.1)


## ----table-plot-01------------------------------------------------------------------------------------------------------
mtcars |>
  group_by(cyl) |>
  summarize("mean wt" = format(mean(wt), digits = 3),
            "mean disp" = format(mean(disp), digits = 2),
            "mean mpg" = format(mean(mpg), digits = 2)) -> my.table
table.tb <- tibble(x = 500, y = 35, table.inset = list(my.table))


## ----table-plot-02------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl), size = wt)) +
  scale_size() +
  geom_point() +
  geom_table(data = table.tb,
             mapping = aes(x = x, y = y, label = table.inset),
             colour = "black", size = 3)


## ----plot-plot-01-------------------------------------------------------------------------------------------------------
mtcars |>
  group_by(cyl) |>
  summarize(mean.mpg = mean(mpg)) |>
  ggplot(data = _,
         mapping = aes(factor(cyl), mean.mpg, fill = factor(cyl))) +
  scale_fill_discrete(guide = "none") +
  scale_y_continuous(name = NULL) +
    geom_col() +
    theme_bw(8) -> my.plot
plot.tb <- data.frame(x = 500, y = 35, plot.inset = I(list(my.plot)))


## ----plot-plot-02-------------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  geom_point() +
  geom_plot(data = plot.tb,
            aes(x = x, y = y, label = plot.inset),
            vp.width = 1/2,
            hjust = "inward", vjust = "inward")


## ----plot-plot-03a------------------------------------------------------------------------------------------------------
p.main <-
  ggplot(data = mtcars,
         mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  geom_point()


## ----plot-plot-03b------------------------------------------------------------------------------------------------------
p.inset <- p.main +
  coord_cartesian(xlim = c(270, 330), ylim = c(14, 19)) +
  labs(x = NULL, y = NULL) +
  scale_colour_discrete(guide = "none") +
  theme_bw(8) + theme(aspect.ratio = 1)


## ----plot-plot-03c------------------------------------------------------------------------------------------------------
p.main +
  geom_plot(x = 480, y = 34, label = list(p.inset), vp.height = 1/2) +
  annotate(geom = "rect", fill = NA, colour = "black",
           xmin = 270, xmax = 330, ymin = 14, ymax = 19,
           linetype = "dotted")


## ----plot-grob-01a------------------------------------------------------------------------------------------------------
file1.name <-
  system.file("extdata", "Isoquercitin.png",
              package = "ggpp", mustWork = TRUE)
Isoquercitin <- magick::image_read(file1.name)
file2.name <-
  system.file("extdata", "Robinin.png",
              package = "ggpp", mustWork = TRUE)
Robinin <- magick::image_read(file2.name)


## ----plot-grob-01b------------------------------------------------------------------------------------------------------
grob.tb <-
  data.frame(x = c(0, 100), y = c(10, 20), height = 1/3, width = c(1/2),
             grobs = I(list(grid::rasterGrob(image = Isoquercitin),
                            grid::rasterGrob(image = Robinin))))


## ----plot-grob-01c------------------------------------------------------------------------------------------------------
ggplot() +
  geom_grob(data = grob.tb,
            mapping = aes(x = x, y = y, label = grobs,
                          vp.height = height, vp.width = width),
                          hjust = "inward", vjust = "inward")


## ----plot-npc-eb-02-----------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  geom_point() +
  geom_label(x = I(0.5), y = I(0.9), label = "a label", colour = "black")


## ----plot-npc-eb-01, eval=eval_plots_all--------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  geom_point() +
  geom_label_npc(npcx = 0.5, npcy = 0.9, label = "a label", colour = "black",
             vjust = "center")


## ----function-plot-01---------------------------------------------------------------------------------------------------
ggplot(data = data.frame(x = c(-3,3)),
       mapping = aes(x = x)) +
  stat_function(fun = dnorm)


## ----function-plot-02, eval=eval_plots_all------------------------------------------------------------------------------
ggplot(data = data.frame(x = c(-3,4)),
       mapping = aes(x = x)) +
  stat_function(fun = dnorm, args = list(mean = 1, sd = .5))


## ----function-plot-03, eval=eval_plots_all------------------------------------------------------------------------------
ggplot(data = data.frame(x = 0:1),
       mapping = aes(x = x)) +
  stat_function(fun = function(x, a, b){a + b * x^2},
                args = list(a = 1, b = 1.4))


## ----summary-plot-00----------------------------------------------------------------------------------------------------
fake.data <- data.frame(
  y = c(rnorm(10, mean = 2, sd = 0.5),
        rnorm(10, mean = 4, sd = 0.7)),
  group = factor(c(rep("A", 10), rep("B", 10))))


## ----summary-plot-01----------------------------------------------------------------------------------------------------
p1.base <-
  ggplot(data = fake.data, mapping = aes(y = y, x = group)) +
  geom_point(shape = "circle open")


## ----summary-plot-02----------------------------------------------------------------------------------------------------
p1.base + stat_summary()


## ----summary-plot-03----------------------------------------------------------------------------------------------------
p1.base +
  stat_summary(fun = "mean", geom = "point",
               colour = "red", shape = "-", size = 15)


## ----summary-plot-04----------------------------------------------------------------------------------------------------
p1.base +
  stat_summary(fun.data = "mean_cl_normal", fun.args = list(conf.int = 0.99),
               colour = "red", size = 0.7, linewidth = 1, alpha = 0.5)


## ----summary-plot-09a---------------------------------------------------------------------------------------------------
p2.base <-
  ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  stat_summary(geom = "col", fun = mean)


## ----summary-plot-12----------------------------------------------------------------------------------------------------
p2.base +
  stat_summary(geom = "linerange", fun.data = "mean_cl_normal",
               linewidth = 1, colour = "red")


## ----summary-plot-10, eval=eval_plots_all-------------------------------------------------------------------------------
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_col(stat = "summary", fun = mean)

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  stat_summary(geom = "col", fun = mean)


## ----smooth-plot-01-----------------------------------------------------------------------------------------------------
p3 <-
  ggplot(data = mtcars, mapping = aes(x = disp, y = mpg)) +
  geom_point()


## ----smooth-plot-02-----------------------------------------------------------------------------------------------------
p3 + stat_smooth(method = "loess", formula = y ~ x)


## ----smooth-plot-03, eval=eval_plots_all--------------------------------------------------------------------------------
p3 + stat_smooth(method = "lm", formula = y ~ x)


## ----smooth-plot-04-----------------------------------------------------------------------------------------------------
p3 + aes(colour = factor(cyl)) +
  stat_smooth(method = "lm", formula = y ~ x)


## ----smooth-plot-05, eval=eval_plots_all--------------------------------------------------------------------------------
p3 + aes(colour = factor(cyl)) +
  stat_smooth(method = "lm", formula = y ~ x, colour = "black")


## ----smooth-plot-06-----------------------------------------------------------------------------------------------------
p3 + aes(colour = factor(cyl)) +
  stat_smooth(method = "lm", formula = y ~ poly(x, 2), colour = "grey20")


## ----smooth-plot-07-----------------------------------------------------------------------------------------------------
ggplot(data = Puromycin,
       mapping = aes(conc, rate, colour = state)) +
  geom_point() +
  geom_smooth(method = "nls", formula =  y ~ SSmicmen(x, Vm, K), se = FALSE)


## ----smooth-plot-08, eval=eval_plots_all--------------------------------------------------------------------------------
ggplot(data = Puromycin,
       mapping = aes(conc, rate, colour = state)) +
  geom_point() +
  geom_smooth(method = "nls",
              formula =  y ~ (Vmax * x) / (k + x),
              method.args = list(start = list(Vmax = 200, k = 0.05)),
              se = FALSE)


## ----smooth-plot-12, warning=FALSE--------------------------------------------------------------------------------------
my.formula <- y ~ x + I(x^2)
p3 + aes(colour = factor(cyl)) +
  stat_poly_line(formula = my.formula, colour = "black") +
  stat_poly_eq(formula = my.formula, mapping = use_label(c("eq", "F")),
               colour = "black", label.x = "right")


## ----smooth-plot-13-----------------------------------------------------------------------------------------------------
ggplot(data = mtcars,
       mapping = aes(x = disp, y = mpg, colour = factor(cyl))) +
  stat_poly_line(formula = my.formula, colour = "black") +
  stat_fit_tb(method.args = list(formula = my.formula),
              colour = "black",
              parse = TRUE,
              tb.vars = c(Parameter = "term",
                          Estimate = "estimate",
                          "s.e." = "std.error",
                          "italic(t)" = "statistic",
                          "italic(P)" = "p.value"),
              label.y = "top", label.x = "right") +
  geom_point() +
  expand_limits(y = 40)


## ----histogram-plot-00--------------------------------------------------------------------------------------------------
set.seed(54321)
my.data <-
  data.frame(X = rnorm(600),
             Y = c(rnorm(300, -1, 1), rnorm(300, 1, 1)),
             group = factor(rep(c("A", "B"), c(300, 300))) )


## ----histogram-plot-01--------------------------------------------------------------------------------------------------
ggplot(data = my.data, mapping = aes(x = X)) +
  geom_histogram(bins = 15)


## ----histogram-plot-04, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x = Y, fill = group)) +
  stat_bin(bins = 15, position = "dodge")


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----histogram-plot-02--------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = my.data,
         mapping = aes(x = Y, fill = group))


## ----histogram-plot-02a-------------------------------------------------------------------------------------------------
p1 <- p.base + geom_histogram(bins = 15, position = "dodge")


## ----histogram-plot-03--------------------------------------------------------------------------------------------------
p2 <- p.base + geom_histogram(mapping = aes(y = after_stat(density)),
                              bins = 15, position = "dodge")


## ----histogram-plot-03a-------------------------------------------------------------------------------------------------
p1 + p2


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----bin2d-plot-01a-----------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = my.data,
         mapping = aes(x = X, y = Y)) +
  facet_wrap(facets = vars(group))


## ----bin2d-plot-01------------------------------------------------------------------------------------------------------
p.base + stat_bin2d(bins = 8)


## ----hex-plot-01--------------------------------------------------------------------------------------------------------
p.base + stat_bin_hex(bins = 8)


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----density-plot-01----------------------------------------------------------------------------------------------------
p3 <-
  ggplot(data = my.data,
       mapping = aes(x = Y, colour = group, fill = group)) +
  geom_density(alpha = 0.3)


## ----density-plot-02----------------------------------------------------------------------------------------------------
p4 <-
  ggplot(data = my.data,
       mapping = aes(x = X, colour = group, fill = group)) +
  geom_density(alpha = 0.3)


## ----density-plot-03----------------------------------------------------------------------------------------------------
p3 + p4 # plot composition


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow_square)


## ----density-plot-10, out.width='.46\\textwidth'------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x = X, y = Y, colour = group)) +
  stat_density_2d()


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----density-plot-12----------------------------------------------------------------------------------------------------
ggplot(data = my.data,
       mapping = aes(x = X, y = Y)) +
  stat_density_2d(aes(fill = after_stat(level)), geom = "polygon") +
  facet_wrap(facets = vars(group))


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----bw-plot-00---------------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = my.data[c(TRUE, rep(FALSE, 5)) , ],
         mapping = aes(x = group, y = Y))


## ----bw-plot-01---------------------------------------------------------------------------------------------------------
p1 <- p.base + stat_boxplot()


## ----bw-plot-02---------------------------------------------------------------------------------------------------------
p2 <-
  p.base +
  stat_boxplot(notch = TRUE, width = 0.4,
               outlier.colour = "red", outlier.shape = "*", outlier.size = 5)


## ----bw-plot-03---------------------------------------------------------------------------------------------------------
p1 + p2


## ----violin-plot-02-----------------------------------------------------------------------------------------------------
p3 <- p.base +
  geom_violin(aes(fill = group), alpha = 0.16) +
  geom_point(alpha = 0.33, size = 1.5, colour = "black", shape = 21)


## ----ggbeeswarm-plot-01-------------------------------------------------------------------------------------------------
p4 <- p.base + geom_quasirandom()


## ----ggbeeswarm-plot-012------------------------------------------------------------------------------------------------
p3 + p4


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_medium)


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----flipping_box-01a-ggplot--------------------------------------------------------------------------------------------
p.base <-
   ggplot(data = mtcars[1:8, ], mapping = aes(x = hp, y = mpg)) +
    geom_point()
p1 <- p.base + geom_line() + ggtitle("Not flipped")
p2 <- p.base + geom_line(orientation = "y") + ggtitle("Flipped")
p1 + p2


## ----flipping-01-ggplot-------------------------------------------------------------------------------------------------
p3 <-
  ggplot(data = iris, mapping = aes(x = Species, y = Sepal.Length)) +
  stat_boxplot()


## ----flipping-02-ggplot-------------------------------------------------------------------------------------------------
p4 <-
  ggplot(data = iris, mapping = aes(x = Sepal.Length, y = Species)) +
  stat_boxplot()


## ----flipping-01-02-ggplot----------------------------------------------------------------------------------------------
p3 + p4


## ----flipping-03-ggplot-------------------------------------------------------------------------------------------------
p5 <-
  ggplot(data = iris,
         mapping = aes(x = Sepal.Length, colour = Species)) +
  stat_density(geom = "line", position = "identity")


## ----flipping-04-ggplot-------------------------------------------------------------------------------------------------
p6 <-
  ggplot(data = iris,
         mapping = aes(y = Sepal.Length, colour = Species)) +
  stat_density(geom = "line", position = "identity")


## ----flipping-03-04-ggplot----------------------------------------------------------------------------------------------
p5 + p6


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----flipping-05base-ggplot---------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = iris,
       mapping = aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() +
  facet_wrap(~Species, scales = "free")


## ----flipping-05-ggplot-------------------------------------------------------------------------------------------------
p.base + stat_smooth(method = "lm", formula = y ~ x)


## ----flipping-06-ggplot-------------------------------------------------------------------------------------------------
p.base + stat_smooth(method = "lm", formula = y ~ x, orientation = "y")


## ----flipping-06a-ggplot------------------------------------------------------------------------------------------------
p.base +
  stat_smooth(method = "lm", formula = y ~ x) +
  coord_flip()


## ----flipping-07-ggpmisc------------------------------------------------------------------------------------------------
p.base +
    stat_poly_line() +
    stat_poly_line(formula = x ~ y, colour = "red", fill = "yellow")


## ----flipping-08-ggpmisc, message=FALSE, warning=FALSE------------------------------------------------------------------
p.base + stat_ma_line()


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----facets-00----------------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = mtcars,
         mapping = aes(x = wt, y = mpg)) +
  geom_point()
p.base


## ----facets-01----------------------------------------------------------------------------------------------------------
p.base + facet_grid(cols = vars(cyl))


## ----facets-01a, eval=eval_plots_all------------------------------------------------------------------------------------
p.base + facet_wrap(facets = vars(cyl), nrow = 1)


## ----facets-02a---------------------------------------------------------------------------------------------------------
p.base + facet_wrap(facets = vars(cyl), nrow = 1, scales = "free_y")


## ----facets-02b, eval = FALSE, include = FALSE--------------------------------------------------------------------------
## p.base + facet_grid(cols = vars(cyl), scales = "free_y", space = "free_y")


## ----facets-06----------------------------------------------------------------------------------------------------------
p.base + facet_grid(cols = vars(cyl), margins = TRUE)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow_square)


## ----facets-05----------------------------------------------------------------------------------------------------------
p.base + facet_grid(rows = vars(vs), cols = vars(am), labeller = label_both)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----facets-07----------------------------------------------------------------------------------------------------------
p.base + facet_grid(cols = vars(vs, am), labeller = label_both)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow_square)


## ----facets-13----------------------------------------------------------------------------------------------------------
p.base + facet_wrap(facets = vars(cyl), nrow = 2)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----facets-11, eval=eval_plots_all-------------------------------------------------------------------------------------
mtcars$cyl12 <- factor(mtcars$cyl,
                       labels = c("alpha", "beta", "sqrt(x, y)"))
ggplot(data = mtcars,
       mapping = aes(mpg, wt)) +
  geom_point() +
  facet_grid(cols = vars(cyl12), labeller = label_parsed)


## ----facets-12----------------------------------------------------------------------------------------------------------
p.base +
  facet_grid(cols = vars(cyl),
             labeller = label_bquote(cols = .(cyl)~"cylinders"))


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----position-01--------------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = Orange,
         mapping = aes(x = age, y = circumference, fill = Tree))


## ----position-02--------------------------------------------------------------------------------------------------------
p1 <- p.base + geom_area(position = "stack", colour = "white", linewidth = 1) +
  ggtitle("stack")
p2 <- p.base + geom_area(position = "fill", colour = "white", linewidth = 1) +
  ggtitle("fill")


## ----position-03--------------------------------------------------------------------------------------------------------
p1 + p2


## ----position-04--------------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = mtcars,
         mapping = aes(x = factor(cyl), y = mpg)) +
  geom_point(colour = "blue")
p3 <- p.base +
  geom_point_s(position = position_jitter_keep(width = 0.35, heigh = 0.6),
               colour = "red") +
  ggtitle("jitter")


## ----position-05--------------------------------------------------------------------------------------------------------
p4 <- p.base +
  geom_point_s(position = position_nudge_keep(x = 0.25, y = 1),
               colour = "red") +
  ggtitle("nudge")


## ----position-06--------------------------------------------------------------------------------------------------------
p3 + p4


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## ----axis-labels-00-----------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = Orange,
         mapping = aes(x = age, y = circumference, colour = Tree)) +
  geom_line() +
  geom_point()


## ----axis-labels-01-----------------------------------------------------------------------------------------------------
p.base +
  expand_limits(y = 0) +
  labs(title = "Growth of orange trees",
       subtitle = "Starting from 1968-12-31",
       caption = "see Draper, N. R. and Smith, H. (1998)",
       tag = "A",
       alt = "A data plot",
       x = "Time (d)",
       y = "Circumference (mm)",
       colour = "Tree\nnumber")


## ----axis-labels-02-----------------------------------------------------------------------------------------------------
p.base +
  expand_limits(y = 0) +
  scale_x_continuous(name = "Time (d)") +
  scale_y_continuous(name = "Circumference (mm)") +
  ggtitle(label = "Growth of orange trees",
          subtitle = "Starting from 1968-12-31")


## ----scales-01----------------------------------------------------------------------------------------------------------
fake2.data <-
  data.frame(y = c(rnorm(20, mean = 20, sd = 5),
                   rnorm(20, mean = 40, sd = 10)),
             group = factor(c(rep("A", 20), rep("B", 20))),
             z = rnorm(40, mean = 12, sd = 6))


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----scale-limits-00----------------------------------------------------------------------------------------------------
p1.base <-
  ggplot(data = fake2.data, mapping = aes(x = z, y = y)) +
  geom_point()


## ----scale-limits-01----------------------------------------------------------------------------------------------------
p1 <- p1.base + scale_y_continuous(limits = c(0, 100))


## ----scale-limits-02----------------------------------------------------------------------------------------------------
p2 <-p1.base + scale_y_continuous(limits = c(50, NA))


## ----scale-limits-02a---------------------------------------------------------------------------------------------------
p1 + p2


## ----scale-limits-03, eval=eval_plots_all-------------------------------------------------------------------------------
p1.base +  ylim(50, NA)


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_medium)


## ----scale-limits-04----------------------------------------------------------------------------------------------------
p1.base + expand_limits(y = 0, x = 0)


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_2fig_very_wide)


## ----scale-limits-05----------------------------------------------------------------------------------------------------
p2.base <-
  ggplot(data = fake2.data,
         mapping = aes(fill = group, colour = group, x = y)) +
  stat_density(alpha = 0.3, position = "identity")


## ----scale-limits-05a---------------------------------------------------------------------------------------------------
p1 <-
  p2.base + scale_y_continuous(expand = expansion(add = c(0, 0.01)))


## ----scale-limits-06----------------------------------------------------------------------------------------------------
p2 <-
  p2.base + scale_y_continuous(expand = expansion(mult = c(0, 0.1)))


## ----scale-limits-07----------------------------------------------------------------------------------------------------
p1 + p2


## ----scale-limits-PG01, eval=eval_playground----------------------------------------------------------------------------
p1.base <- scale_y_continuous(limits = c(100, 0))


## ----scale-ticks-00-----------------------------------------------------------------------------------------------------
p3.base <-
  ggplot(data = fake2.data, mapping = aes(x = z, y = y)) +
  geom_point()


## ----scale-ticks-01, eval=eval_plots_all--------------------------------------------------------------------------------
p3.base + scale_y_continuous(breaks = c(20, pi * 10, 40, 60))


## ----scale-ticks-01a----------------------------------------------------------------------------------------------------
p3 <-
  p3.base + scale_y_continuous(breaks = pretty_breaks(n = 7))


## ----scale-ticks-02-----------------------------------------------------------------------------------------------------
p4 <-
  p3.base +
  scale_y_continuous(breaks = c(20, pi * 10, 40, 60),
                     labels = c("20", expression(10*pi), "40", "60"))


## ----scale-ticks-02a----------------------------------------------------------------------------------------------------
p3 + p4


## ----scale-ticks-03-----------------------------------------------------------------------------------------------------
p5 <-
  ggplot(data = fake2.data, mapping = aes(x = z, y = y / max(y))) +
  geom_point() +
  scale_y_continuous(labels = percent)


## ----scale-ticks-04-----------------------------------------------------------------------------------------------------
p6 <-
  ggplot(data = fake2.data, mapping = aes(x = z, y = y * 1000)) +
  geom_point() +
  scale_y_continuous(name = "Mass",
                     labels = label_number(scale_cut = cut_si("g")))


## ----scale-ticks-05-----------------------------------------------------------------------------------------------------
p5 + p6


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_medium)


## ----scale-trans-02-----------------------------------------------------------------------------------------------------
ggplot(data = fake2.data, mapping = aes(x = z, y = y)) +
  geom_point() +
  scale_y_log10(breaks=c(10,20,50,100))


## ----scale-trans-03, eval=eval_plots_all--------------------------------------------------------------------------------
ggplot(data = fake2.data, mapping = aes(x = z, y = log10(y))) +
  geom_point()


## ----scale-trans-04, eval=eval_plots_all--------------------------------------------------------------------------------
ggplot(data = fake2.data, mapping = aes(x = z, y = y)) +
  geom_point() +
  scale_y_continuous(trans = "reciprocal")


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----scale-trans-05-----------------------------------------------------------------------------------------------------
ggplot(data = Orange,
       mapping = aes(x = age, y = circumference, colour = Tree)) +
  geom_line() +
  geom_point() +
  scale_y_continuous(trans = "log", breaks = c(20, 50, 100, 200))


## ----axis-position-01---------------------------------------------------------------------------------------------------
ggplot(data = mtcars, mapping = aes(x = wt, y = mpg)) +
  geom_point() +
  scale_x_continuous(position = "top") +
  scale_y_continuous(position = "right")


## ----axis-secondary-01--------------------------------------------------------------------------------------------------
ggplot(data = mtcars, mapping = aes(x = wt, y = mpg)) +
  geom_point() +
  scale_y_continuous(sec.axis = sec_axis(~ . ^-1, name = "gpm") )


## ----axis-secondary-02, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(data = mtcars, mapping = aes(x = wt, y = mpg)) +
  geom_point() +
  scale_y_continuous(sec.axis = sec_axis(~ . / 2.3521458,
                                         name = expression(km / l),
                                         breaks = c(5, 7.5, 10, 12.5)))


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_very_wide)


## ----scale-datetime-01--------------------------------------------------------------------------------------------------
ggplot(data = weather_wk_25_2019.tb,
       mapping = aes(x = with_tz(time, tzone = "EET"),
                     y = air_temp_C)) +
  geom_line(na.rm = TRUE) +
  scale_x_datetime(name = NULL,
                   breaks = ymd_h("2019-06-11 12", tz = "EET") + days(0:1),
                   limits = ymd_h("2019-06-11 00", tz = "EET") + days(c(0, 2))) +
  scale_y_continuous(name = "Air temperature (C)") +
  expand_limits(y = 0)


## ----scale-datetime-02--------------------------------------------------------------------------------------------------
ggplot(data = weather_wk_25_2019.tb,
       mapping = aes(x = with_tz(time, tzone = "EET"),
                     y = air_temp_C)) +
  geom_line(na.rm = TRUE) +
  scale_x_datetime(name = NULL,
                   date_breaks = "1 hour",
                   limits = ymd_h("2019-06-16 00", tz = "EET") + hours(c(6, 18)),
                   date_labels = "%H:%M") +
  scale_y_continuous(name = "Air temperature (C)") +
  expand_limits(y = 0)


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)

## ----scale-discrete-10, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(data = mpg,
       mapping = aes(x = class, y = hwy)) +
  stat_summary(geom = "col", fun = mean, na.rm = TRUE) +
  scale_x_discrete(limits = c("compact", "subcompact", "midsize"),
                   labels = c("COMPACT", "SUBCOMPACT", "MIDSIZE"))


## ----scale-discrete-10a-------------------------------------------------------------------------------------------------
ggplot(data = mpg,
       mapping = aes(x = class, y = hwy)) +
  stat_summary(geom = "col", fun = mean, na.rm = TRUE, width = 0.6) +
  scale_x_discrete(name = "Vehicle class",
                   limits = c("compact", "subcompact", "midsize"),
                   labels = toupper) +
  scale_y_continuous(name = "Petrol use efficiency (mpg)", limits = c(0, 30))


## ----scale-discrete-11, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(data = mpg,
       mapping = aes(x = reorder(x = factor(class), X = hwy, FUN = mean),
                     y = hwy)) +
  stat_summary(geom = "col", fun = mean)


## ----echo=FALSE, include=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----scale-colour-01----------------------------------------------------------------------------------------------------
length(colors())
grep("dark",colors(), value = TRUE)


## ----scale-colour-02----------------------------------------------------------------------------------------------------
col2rgb("purple")
col2rgb("#FF0000")


## ----scale-colour-03----------------------------------------------------------------------------------------------------
col2rgb("purple", alpha = TRUE)


## ----scale-colour-04----------------------------------------------------------------------------------------------------
rgb(1, 1, 0)
rgb(1, 1, 0, names = "my.color")
rgb(255, 255, 0, names = "my.color", maxColorValue = 255)


## ----scale-colour-05----------------------------------------------------------------------------------------------------
hsv(c(0,0.25,0.5,0.75,1), 0.5, 0.5)


## ----scale-colour-06----------------------------------------------------------------------------------------------------
hcl(c(0,0.25,0.5,0.75,1) * 360)


## ----mapping-stage-01---------------------------------------------------------------------------------------------------
set.seed(4321)
X <- 0:10
Y <- (X + X^2 + X^3) + rnorm(length(X), mean = 0, sd = mean(X^3) / 4)
df1 <- data.frame(X, Y)
df2 <- df1
df2[6, "Y"] <-df1[6, "Y"] * 10


## ----mapping-stage-01a--------------------------------------------------------------------------------------------------


## ----binned-scales-01---------------------------------------------------------------------------------------------------
ggplot(data = df2) +
  stat_fit_residuals(formula = y ~ poly(x, 3, raw = TRUE),
                     method = "rlm",
                     mapping = aes(x = X,
                                   y = stage(start = Y,
                                             after_stat = y * weights),
                                   colour = after_stat(weights)),
                     show.legend = TRUE) +
  scale_colour_binned(low = "red", high = "blue", limits = c(0, 1),
                     guide = "colourbar", n.breaks = 5)


## ----scale-colour-10----------------------------------------------------------------------------------------------------
df3 <- data.frame(X = 1:10, Y = dnorm(10), colours = rep(c("red", "blue"), 5))

ggplot(data = df3, mapping = aes(x = X, y = Y, colour = colours)) +
  geom_point() +
  scale_colour_identity()


## ----annotate-01--------------------------------------------------------------------------------------------------------
ggplot(data = fake2.data, mapping = aes(x = z, y = y)) +
  geom_point() +
  annotate(geom = "text",
           label = "origin",
           x = 0, y = 0,
           colour = "blue",
           size=4)


## ----inset-01-----------------------------------------------------------------------------------------------------------
p <- ggplot(data = fake2.data, mapping = aes(x = z, y = y)) +
  geom_point()
p + expand_limits(x = 40) +
  annotation_custom(ggplotGrob(p + coord_cartesian(xlim = c(4, 10), ylim = c(20, 30)) +
                               theme_bw(10)),
                    xmin = 25, xmax = 40, ymin = 30, ymax = 60)


## ----annotate-03--------------------------------------------------------------------------------------------------------
ggplot(data = data.frame(x = c(0, 2 * pi)),
       mapping = aes(x = x)) +
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
           colour = "red",
           shape = 21,
           fill = "white",
           x = c(0, 1, 2) * pi, y = 0,
           size = 6)


## ----wind-05------------------------------------------------------------------------------------------------------------
p.wind <-
  ggplot(data = viikki_d29.dat,
       mapping = aes(x = WindDir_D1_WVT))  +
  stat_bin(colour = "black", fill = "gray50", geom = "bar",
           binwidth = 30, boundary = 0, na.rm = TRUE) +
  coord_polar() +
  scale_x_continuous(breaks = c(0, 90, 180, 270),
                     labels = c("N", "E", "S", "W"),
                     limits = c(0, 360),
                     expand = c(0, 0),
                     name = "Wind direction") +
  scale_y_continuous(name = "Frequency (min/d)")
p.wind


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_very_wide)


## ----wind-08------------------------------------------------------------------------------------------------------------
p.wind +
  facet_wrap(~factor(ifelse(hour(solar_time) < 12, "AM", "PM")))


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_narrow)


## -----------------------------------------------------------------------------------------------------------------------
ggplot(data = mpg,
       mapping = aes(x = factor(1), fill = factor(class))) +
  geom_bar(width = 1, colour = "black") +
  coord_polar(theta = "y") +
  scale_fill_brewer() +
  scale_x_discrete(breaks = NULL) +
  labs(x = NULL, fill = "Vehicle class")


## ----themes-01----------------------------------------------------------------------------------------------------------
ggplot(data = fake2.data,
       mapping = aes(x = z, y = y)) +
  geom_point() +
  theme_gray(base_size = 18,
             base_family = "serif")


## ----themes-03----------------------------------------------------------------------------------------------------------
p.base <-
  ggplot(data = fake2.data,
         mapping = aes(x = z, y = y)) +
  geom_point()
print(p.base + theme_bw())


## ----themes-05, eval=eval_plots_all-------------------------------------------------------------------------------------
old_theme <- theme_set(theme_bw(15))


## ----themes-06, eval=eval_plots_all-------------------------------------------------------------------------------------
theme_set(old_theme)


## ----themes-11----------------------------------------------------------------------------------------------------------
ggplot(data = fake2.data,
       mapping = aes(x = z + 1000, y = y)) +
  geom_point() +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 8)) +
  theme(axis.text.x = element_text(angle = 33, hjust = 1, vjust = 1))


## ----themes-12, eval=eval_plots_all-------------------------------------------------------------------------------------
ggplot(fake2.data, aes(z + 100, y)) +
  geom_point() +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 20)) +
  theme(axis.text.x = element_text(size = rel(0.6)))


## ----themes-15, eval=eval_plots_all-------------------------------------------------------------------------------------
old_theme <- theme_update(text = element_text(colour = "darkred"))


## ----themes-16, eval=eval_plots_all-------------------------------------------------------------------------------------
theme_set(old_theme)


## ----themes-21----------------------------------------------------------------------------------------------------------
my_theme <- theme_bw(15) + theme(text = element_text(colour = "darkred"))
p.base + my_theme


## ----themes-32----------------------------------------------------------------------------------------------------------
my_theme_gray <-
  function (base_size = 11,
            base_family = "serif",
            base_line_size = base_size/22,
            base_rect_size = base_size/22,
            base_colour = "darkblue") {

    theme_gray(base_size = base_size,
               base_family = base_family,
               base_line_size = base_line_size,
               base_rect_size = base_rect_size) +

    theme(line = element_line(colour = base_colour),
          rect = element_rect(colour = base_colour),
          text = element_text(colour = base_colour),
          title = element_text(colour = base_colour),
          axis.text = element_text(colour = base_colour),
          complete = TRUE)
  }


## ----themes-32a---------------------------------------------------------------------------------------------------------
my_theme_grey <- my_theme_gray


## ----themes-33----------------------------------------------------------------------------------------------------------
p.base + my_theme_gray(15, base_colour = "darkred")


## ----patchwork-01-------------------------------------------------------------------------------------------------------
p1 <- ggplot(mpg, aes(displ, cty, colour = factor(cyl))) +
        geom_point() +
        theme(legend.position = "top")
p2 <- ggplot(mpg, aes(displ, cty, colour = factor(year))) +
        geom_point() +
        theme(legend.position = "top")
p3 <- ggplot(mpg, aes(factor(model), cty)) +
        geom_point() +
        theme(axis.text.x =
                element_text(angle = 90, hjust = 1, vjust = 0.5))


## ----patchwork-00a, echo=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_very_wide_square)


## ----patchwork-02, eval=eval_plots_all----------------------------------------------------------------------------------
p1 | (p2 / p3)


## ----patchwork-02a, eval=eval_plots_all---------------------------------------------------------------------------------
(p1 | p2) / p3


## ----patchwork-03-------------------------------------------------------------------------------------------------------
((p1 | p2) / p3) +
   plot_annotation(title = "Fuel use in city traffic:", tag_levels = 'a')


## ----patchwork-00b, echo=FALSE------------------------------------------------------------------------------------------
opts_chunk$set(opts_fig_wide)


## ----plotmath-00--------------------------------------------------------------------------------------------------------
p1 + labs(y = expression("Fuel use"~~(m~g^{-1})),
          x = "Engine displacement (L)",
          colour = "Engine\ncylinders") +
          theme(legend.position = "right")


## ----plotmath-01--------------------------------------------------------------------------------------------------------
set.seed(54321) # make sure we always generate the same data
my.data <-
  data.frame(x = 1:5,
             y = rnorm(5),
             greek.label = paste("alpha[", 1:5, "]", sep = ""))


## ----plotmath-02--------------------------------------------------------------------------------------------------------
ggplot(my.data, aes(x, y, label = greek.label)) +
   geom_point() +
   geom_text(angle = 45, hjust = 1.2, parse = TRUE) +
   labs(x = expression(alpha[i]),
        y = expression(Speed~~(m~s^{-1})),
        title = "Using expressions",
        subtitle = expression(sqrt(alpha[1] + frac(beta, gamma))))


## ----plotmath-02a-------------------------------------------------------------------------------------------------------
my_eq.char <- "alpha[i]"
ggplot(my.data, aes(x, y)) +
   geom_point() +
   labs(title = parse(text = my_eq.char)) +
   scale_x_continuous(name = expression(alpha[i]),
                      breaks = c(1,3,5),
                      labels = expression(alpha[1], alpha[3], alpha[5]))


## ----expr-parse-box-01, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(expression(x[1]*"  test"))


## ----expr-parse-box-02, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(parse(text = "x[1]*\"  test\""))


## ----expr-parse-box-03, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(parse(text = "x[1]*italic(\"  test\")"))


## ----expr-parse-box-06, eval=eval_plots_all-----------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(expression(x[1], "  test"))


## ----expr-parse-box-07, eval=eval_plots_all, echo=3---------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(parse(text = "x[1]~~~~\"test\""))


## ----expr-parse-box-08, eval=eval_plots_all, echo=3---------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(parse(text = "x[1]~~~~plain(test)"))


## ----expr-parse-box-09, eval=eval_plots_all, echo=3---------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  xlab(parse(text = "x[1]*plain(   test)"))


## ----sprintf-01---------------------------------------------------------------------------------------------------------
sprintf("log(%.3f) = %.3f", 5, log(5))
sprintf("log(%.3g) = %.3g", 5, log(5))


## ----expr-bquote-01-----------------------------------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  labs(title = bquote(Time~zone: .(Sys.timezone())),
       subtitle = bquote(Date: .(as.character(today())))
       )


## ----expr-substitute-01-------------------------------------------------------------------------------------------------
ggplot(cars, aes(speed, dist)) +
  geom_point() +
  labs(title = substitute(Time~zone: tz, list(tz = Sys.timezone())),
       subtitle = substitute(Date: date, list(date = as.character(today())))
       )


## ----expr-deparse-01----------------------------------------------------------------------------------------------------
deparse_test <- function(x) {
  print(deparse(substitute(x)))
}

a <- "saved in variable"

deparse_test("constant")
deparse_test(1 + 2)
deparse_test(a)


## ----plot_composition-01, eval=eval_plots_all---------------------------------------------------------------------------
p.base <- ggplot(data = mtcars,
                 aes(x = disp, y = mpg,
                 colour = factor(cyl))) +
          geom_point()

p.labels <- labs(x = "Engine displacement)",
                 y = "Gross horsepower",
                 colour = "Number of\ncylinders",
                 shape = "Number of\ncylinders")


## ----plot_composition-02, eval=eval_plots_all---------------------------------------------------------------------------
p.base
p.base + p.labels + theme_bw(16)
p.base + p.labels + theme_bw(16) + ylim(0, NA)


## ----plot_composition-03, eval=eval_plots_all---------------------------------------------------------------------------
p.log <- p.base + scale_y_log10(limits=c(8,55))
p.log + p.labels + theme_bw(16)


## ----plot_composition-11, eval=eval_plots_all---------------------------------------------------------------------------
p.parts <- list(p.labels, theme_bw(16))
p1 + p.parts


## ----plot_composition-21, eval=eval_plots_all---------------------------------------------------------------------------
bw_ggplot <- function(...) {
  ggplot(...) +
  theme_bw()
}


## ----plot_composition-22, eval=eval_plots_all---------------------------------------------------------------------------
bw_ggplot(data = mtcars,
          mapping = aes(x = disp, y = mpg,
          colour = factor(cyl))) +
          geom_point()


## ----plot-file-01, eval=eval_plots_all----------------------------------------------------------------------------------
fig1 <- ggplot(data.frame(x = -3:3), aes(x = x)) +
  stat_function(fun = dnorm)
pdf(file = "fig1.pdf", width = 8, height = 6)
print(fig1)
dev.off()


## ----plot-file-02, eval=eval_plots_all----------------------------------------------------------------------------------
postscript(file = "fig1.eps", width = 8, height = 6)
print(fig1)
dev.off()


## ----plot-file-03, eval=eval_plots_all----------------------------------------------------------------------------------
tiff(file = "fig1.tiff", width = 1000, height = 800)
print(fig1)
dev.off()


## ----ggplot-debug-01----------------------------------------------------------------------------------------------------
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Species)) +
  stat_summary(geom = "debug")


## ----ggplot-debug-02----------------------------------------------------------------------------------------------------
ggplot(data = iris, mapping = aes(x = Petal.Length)) +
  stat_bin(geom = "debug")


## ----echo=FALSE---------------------------------------------------------------------------------------------------------
try(detach(package:learnrbook))
try(detach(package:ggbeeswarm))
try(detach(package:ggpmisc))
try(detach(package:ggpp))
try(detach(package:gginnards))
try(detach(package:ggrepel))
try(detach(package:ggplot2))
try(detach(package:scales))
try(detach(package:lubridate))
try(detach(package:dplyr))
try(detach(package:tibble))


## ----eval=eval_diag, include=eval_diag, echo=eval_diag, cache=FALSE-----------------------------------------------------
## knitter_diag()
## R_diag()
## other_diag()

