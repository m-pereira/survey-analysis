# https://rstudio-pubs-static.s3.amazonaws.com/167534_c1fd7466282942599764b5ab1329d7e9.html
# https://jakec007.github.io/2021-06-23-R-likert/
library(dplyr)
library(ggplot2)
library(likert)
library(gridExtra)
library(ggpubr)
rawdata <- readxl::read_excel("dataset.xlsx", sheet = 2)
rawdata <- rawdata %>% select(1:10)
# i <- 1
# while(i<=ncol(rawdata)) {
#   rawdata[[i]] = factor(rawdata[[i]],labels = c("concordo totalmente", "2", "3", "4", "discordo totalmente"), levels=c(1:5))
#   i <- i + 1
# }
raw_data <- lapply(rawdata, function(x) {
  factor(x, 
         levels = c("1", "2", "3", "4", "5", "6", "7", "8"), 
         labels = c("concordo totalmente", 
                    "concordo parcialmente", 
                    "concordo um pouco", 
                    "não concordo nem discordo", 
                    "discordo um pouo", 
                    "discordo parcialmente", 
                    "discordo totalmente", "não aplicavel"))
})
raw_data <- raw_data %>% as.data.frame()

raw_data <-
  raw_data %>%
  rename(
    "satisfação geral no trabalho" = 1,
    "satisfação no trabalho consirando empregador" = 2,
    "meu trabalho permite utilizar meu conhecimento" = 3,
    "tenho clareza das minhas responsailidades" = 4,
    "entendo os objetivos da empresa" = 5,
    "tenho autonomia para realizar meu trabalho" = 6,
    "sou suficientemente desafiado" = 7,
    "sou reconhecido pelo meu trabalho" = 8,
    "estou satisfeito com as oportunidades" = 9,
    "tenho orgulho de tabalhar no setor público" = 10
  )

raw_plot <- likert(raw_data)
p <- plot(raw_plot, 
          centered = FALSE, include.histogram = FALSE) + 
  ggtitle("Como você avalia a satisfação no trabalho") + 
  theme(axis.text.y = element_text(colour = "black"), 
  axis.text.x = element_text(colour = "black"))
print(p)
