Dualex_uvb_uva_oex <- read.csv(file="Dualex_flav_OX_UVB_and_UVA.csv", header = TRUE)
#Dualex_uvb_trip <- read.table(file="Dualex_flav_UVB_triple_2.csv", header = FALSE, sep=",")
head(Dualex_uvb_uva_oex)
str(Dualex_uvb_uva_oex)
Dualex_uvb_uva_oex2 <-subset(Dualex_uvb_uva_oex, Treatment!= "UVA_Bl") 
Dualex_uvb_uva_oex3 <-subset(Dualex_uvb_uva_oex2, Treatment!= "UVB_Bl") 
Dualex_uvb_uva_oex3$Treatment<-factor(Dualex_uvb_uva_oex3$Treatment,levels=c("Control", "UVB", "UVA", "Blue", "Blue_Bl"),
                                       labels=c("GR","UVB","UVA", "Blue", "Blue+Blue"))
Dualex_uvb_uva_oex3$Block<-factor(Dualex_uvb_uva_oex3$Block)
Dualex_uvb_uva_oex3$Genotype<-factor(Dualex_uvb_uva_oex3$Genotype, levels=c("Ws", "uvr8", "UVR8_OX"),
                                      labels= c("Ws", "uvr8-7", "UVR8 oex"))

library(knitr)
library(nlme)
library(Hmisc)
library(ggplot2)
library(wle)
library(plyr)
library(reshape2)
library(gmodels)
library(ggsignif)

levels(Dualex_uvb_uva_oex3$Treatment)
levels(Dualex_uvb_uva_oex3$Genotype)

y_pos_first <- 0.02
y_step <- 0.05

signif_labels<- data.frame(Genotype=rep(c("Ws", "uvr8-7", "UVR8 oex"), c(5,5,5)),
                           start= rep(c("GR", "GR", "GR", "GR", "Blue"), 3),
                           end= rep(c("UVB", "UVA", "Blue", "Blue+Blue", "Blue+Blue"), 3),
                           label= gsub("^0$", "<0.001", sprintf("%.2g", round(c(stats1, stats2, stats3), 3))),
                           y_pos= rep(y_pos_first + 0:4 * y_step, 3))
print(signif_labels)

fig_Dualex3<-ggplot(data=Dualex_uvb_uva_oex3, aes(x=Treatment, y=Flav))+
  stat_summary(fun.data="mean_se", size=0.4)+
  stat_summary(fun.data="mean_se", geom = "errorbar",width= 0.15)+ 
  facet_grid(.~Genotype)+
  labs(title="Adaxial UV-A absorbance at 20 h ", y = "Epidermal UV-A absorbance", x= "Radiation Treatments")+
  expand_limits(y=0)+
  geom_signif(data=signif_labels, aes(xmin=start, xmax=end, annotations=label, y_position=y_pos),step_increase=0.05,
              textsize = 2.8, tip_length = 0.01, manual= TRUE) +  
  theme_bw() +
  theme (axis.text.x=element_text(angle=90,vjust=0.5,hjust=1,colour="black"), 
                                                                         axis.text.y=element_text(colour="black"))
  
  #geom_signif (comparisons=list(c("GR","UVB"),c("GR","UVA"),c("GR","Blue"), c("GR", "Blue+Blue"), c("Blue", "Blue+Blue")),
                                # annotations = gsub("^0$", "<0.001", sprintf("%.2g", stats1)),
                                 #map_signif_level=TRUE,
                                 #step_increase=0.1)

fig_Dualex3

Dualex.lme<- lme(Flav ~ Treatment * Genotype, random = ~ 1|Block, data = Dualex_uvb_uva_oex3, na.action=na.omit, weights = varPower())
anova(Dualex.lme) 
plot(Dualex.lme) 

#Ws
Ws.dualex3.lme <- lme(Flav~Treatment, random = ~1|Block, 
                       data=Dualex_uvb_uva_oex3, subset = Genotype == "Ws")
anova(Ws.dualex3.lme)
levels(Dualex_uvb_uva_oex3$Treatment)

fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))
fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0)) 
fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0)) 
fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1)) 
fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1)) 

p.adjust(c(
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))[1,4],
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0))[1,4], 
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0))[1,4], 
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1))[1,4],
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1))[1,4]
))

stats1<- p.adjust(c(
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))[1,4],
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0))[1,4], 
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0))[1,4], 
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1))[1,4],
  fit.contrast(Ws.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1))[1,4]
))

#uvr8-7

uvr8.dualex3.lme <- lme(Flav~Treatment, random = ~1|Block, 
                        data=Dualex_uvb_uva_oex3, subset = Genotype == "uvr8-7")
anova(uvr8.dualex3.lme)
levels(Dualex_uvb_uva_oex3$Treatment)

fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))
fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0)) 
fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0)) 
fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1)) 
fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1)) 

p.adjust(c(
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))[1,4],
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0))[1,4], 
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0))[1,4], 
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1))[1,4],
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1))[1,4]
))

stats2<-p.adjust(c(
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))[1,4],
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0))[1,4], 
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0))[1,4], 
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1))[1,4],
  fit.contrast(uvr8.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1))[1,4]
))
# UVR8_oex
UVR8oex.dualex3.lme <- lme(Flav~Treatment, random = ~1|Block, 
                            data=Dualex_uvb_uva_oex3, subset = Genotype == "UVR8 oex")
anova(UVR8oex.dualex3.lme)
levels(Dualex_uvb_uva_oex3$Treatment)

fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))
fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0)) 
fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0)) 
fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1)) 
fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1)) 

stats3<-p.adjust(c(
  fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, -1, 0, 0, 0))[1,4],
  fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, 0, -1, 0, 0))[1,4], 
  fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, 0, 0, -1, 0))[1,4], 
  fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(1, 0, 0, 0, -1))[1,4],
  fit.contrast(UVR8oex.dualex3.lme, "Treatment", coeff = c(0, 0, 0, 1, -1))[1,4]
))
print(stats3)

