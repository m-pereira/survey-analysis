library(dplyr)
library(ggplot2)
library(likert)
library(gridExtra)
library(ggpubr)
library(gtExtras)
rawdata <- readxl::read_excel("dataset.xlsx", sheet = 2)
rawdata <- rawdata %>% select(1:4)
rawdata$idade <- rnorm(nrow(rawdata), mean = 42 , sd  = 4)
rawdata %>% 
  gt_plt_summary()



library(tidyverse) 
library(ggbeeswarm) # to make jitter plots 

library(emmeans) # for estimated marginal means and stats 

library(RColorBrewer) # for colors 

library(patchwork) # for putting ggplot objects together 


rawdata$turno <- 
  c(rep("diurno",rawdata %>% nrow()/2-0.5), 
    rep("noturno",rawdata %>% nrow()/2+0.5))

rawdata <- rawdata %>% 
rename(
  "satisfação geral no trabalho" = 1,
  "satisfação no trabalho consirando empregador" = 2,
  "meu trabalho permite utilizar meu conhecimento" = 3,
  "tenho clareza das minhas responsailidades" = 4)

violin_eg <- rawdata %>% 
  ggplot(aes(x = turno, y = `satisfação geral no trabalho` )) +
  geom_violin(aes(fill = turno), 
              alpha = 0.8) +
  stat_summary(geom = "point", fun = median) +
  scale_fill_brewer(palette = "Accent") +
  labs(
    caption = "Satisfação do dirno é mais\n distribuída"
  ) +
  theme_classic()+
  theme(
    text = element_text(size=12, color = "black", face = "bold"),
    axis.text = element_text(color = "black"),
    legend.position = "none",
    plot.caption = element_text(hjust = 0)
  ) +
  ggtitle("Pontos são a mediana")

violin_eg


box_eg <- rawdata %>% 
  ggplot(aes(x = turno, y = `satisfação geral no trabalho`)) +
  geom_boxplot(aes(fill = turno), 
               alpha = 0.8) +
  scale_fill_brewer(palette = "Accent") +
  labs(
    caption = "Satisfação do dirno é mais\n distribuída"
  ) +
  theme_classic()+
  theme(
    text = element_text(size=12, color = "black", face = "bold"),
    axis.text = element_text(color = "black"),
    legend.position = "none",
    plot.caption = element_text(hjust = 0)
  ) +
  ggtitle("IQR do diurno é menor")

box_eg

jitter_eg <- rawdata %>% 
  ggplot(aes(x = turno, y = `satisfação geral no trabalho`)) +
  geom_point(aes(fill = turno), 
             alpha = 0.8, shape = 21, size = 3, color = "grey40",
             position = position_jitter(seed = 666, width = 0.2)) +
  scale_fill_brewer(palette = "Accent") +
  labs(
    caption = "Satisfação do dirno é igualmente\n distribuída"
  ) +
  theme_classic()+
  theme(
    text = element_text(size=12, color = "black", face = "bold"),
    axis.text = element_text(color = "black"),
    legend.position = "none",
    plot.caption = element_text(hjust = 0)
  ) +
  ggtitle(
    "Satisfação indiviual"
  )

jitter_eg

wrap_plots(violin_eg, box_eg, jitter_eg,
           nrow = 1)

