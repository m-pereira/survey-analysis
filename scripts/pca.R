library(dplyr)
library(factoextra)
library(cluster)
library(FactoMineR)
library(factoextra)
library(psych)
my_df <- readxl::read_excel("dataset.xlsx", sheet = 2)
my_df <- my_df %>% select(1:10)
my_pca <- PCA(my_df)   
fviz_screeplot(my_pca)
fviz_contrib(my_pca,choice = "var", axes = 1,top = 10)
fviz_contrib(my_pca,choice = "var", axes = 2,top = 10)
fviz_pca_var(my_pca,col.var = "contrib",
             gradient.cols = c("#00AFBB","#E7B800","#FC4E07"),
             repel = TRUE) +
  theme_minimal()
