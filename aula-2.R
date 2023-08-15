# aula 2 - 15-08-2023

# pacotes
install.packages("data.table")
library(data.table)
install.packages("janitor")
library(janitor)
install.packages(c("knitr", "kableExtra"))
library(knitr)
library(kableExtra)


# vamos importar uma base de dados de pib municipais de 2013, do IBGE

# o arquivo está em formato RDS, que é um formato do R, e disponível no meu github. Para importá-lo direto no R, vamos ler o arquivo com a função url e depois import´-lo com a função readRDS. 

pib_cid <- readRDS(url("https://github.com/mgaldino/book-regression/raw/main/dados/pib_cid.RDS"))

# para visualizar os dados que forma importados, temos várias funções
# glimpse, head e View

install.packages("tidyverse")
library("tidyverse") # para glimpse

glimpse(pib_cid)

head(pib_cid)

View(pib_cid)

library(tidyverse)

# digamos que quero o pib total médio e o pib per capita médio
# basta usar o comando summarise, que resume os dados e escolher a função mean.

df <- pib_cid %>%
  summarise(pib_medio = mean(pib_total),
            pib_per_capita_medio = mean(pib_per_capita))

kable(df)
