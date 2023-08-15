# aula 2 - 15-08-2023

# pacotes
# install.packages("data.table")

library(data.table)
library(tidyverse)
library(stringr)


# vamos importar uma base de dados de pib municipais de 2013, do IBGE

# o arquivo está em formato RDS, que é um formato do R, e disponível no meu github. Para importá-lo direto no R, vamos ler o arquivo com a função url e depois import´-lo com a função readRDS. 

# comando url antes para conseguir puxar a base

pib_cid <- readRDS(url("https://github.com/mgaldino/book-regression/raw/main/dados/pib_cid.RDS"))

# para visualizar os dados que forma importados, temos várias funções
# glimpse, head e View

install.packages("tidyverse")
library("tidyverse") # para glimpse

glimpse(pib_cid)

head(pib_cid)

View(pib_cid)


# digamos que quero o pib total médio e o pib per capita médio
# basta usar o comando summarise, que resume os dados e escolher a função mean.

df <- pib_cid %>% 
  summarise(pib_medio = mean(pib_total),
            pib_per_capita_medio = mean(pib_per_capita))


# se eu quiser a soma dos pibs municipais
df <- pib_cid %>%
  summarise(soma_pib = sum(pib_total)) %>%
  head()

pib_cid %>%
  filter(sigla_uf == "SP") %>% 
  filter(str_detect(nome_munic, "São")== T) %>% 
  group_by(nome_munic) %>% 
  reframe(pib_cidade = sum(pib_total)) %>% 
  View()



# maior e menos pibs e pibs per capita entre municípios
df <- pib_cid %>%
  summarise(pib_max = max(pib_total),
            pib_min = min(pib_total),
            pib_per_capita_max = max(pib_per_capita),
            pib_per_capita_min = min(pib_per_capita))


df <- pib_cid %>%
  mutate(pib_max = max(pib_total),
         pib_min = min(pib_total),
         pib_per_capita_max = max(pib_per_capita),
         pib_per_capita_min = min(pib_per_capita)) %>%
  filter(pib_total == pib_max
         | pib_total == pib_min 
         | pib_per_capita == pib_per_capita_max
         | pib_per_capita == pib_per_capita_min)

df <- pib_cid %>%
  mutate(pib_max = max(pib_total),
         pib_min = min(pib_total),
         pib_per_capita_max = max(pib_per_capita),
         pib_per_capita_min = min(pib_per_capita)) %>%
  filter(pib_total %in% c(pib_max,pib_min) |
           pib_per_capita %in% c(pib_per_capita_max,pib_per_capita_min))


# agora, quero criar uma nova variável, que é o pib estadual
df <- pib_cid %>%
  group_by(sigla_uf) %>%
  summarise(pib_uf = sum(pib_total),
            pib_medio_uf = mean(pib_total),
            pib_uf_mediana = median(pib_total))


# gráficos

pib_cid %>%
  ggplot(aes(y = pib_total, 
             x = impostos)) + 
  geom_point() +
  geom_smooth(method = 'lm')

# gráficos  mais bonitos


pib_cid %>%
  ggplot(aes(y = pib_total, 
             x = impostos)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  scale_y_continuous(labels = scales::dollar) + 
  scale_x_continuous(labels = scales::dollar) + 
  theme_light() + 
  theme(text = element_text(size = 20)) +
  xlab("impostos municipais") + 
  ggtitle("PIB municipal de 2013 x impostos municipais")


# gráficos ainda mais bonitos

install.packages("remotes")

remotes::install_github("MatthewBJane/theme_park")

library(ThemePark)

pib_cid %>%
  ggplot(aes(y=pib_total, x=impostos)) + 
  geom_point() +
  scale_y_continuous(labels = scales::dollar) + 
  theme(text=element_text(size=20)) + 
  theme_ +
  xlab("impostos municipais") + 
  ggtitle("PIB municipal de 2013 x impostos municipais")


# com bbc

install.packages('devtools')
devtools::install_github('bbc/bbplot')
library(bbplot)

pib_cid %>%
  ggplot(aes(y=pib_total, x=impostos)) + 
  geom_point() +
  scale_y_continuous(labels = scales::dollar) + 
  theme(text=element_text(size=20)) + 
  bbplot::bbc_style() +
  xlab("impostos municipais") + 
  ggtitle("PIB municipal de 2013 x impostos municipais")



# Histograma


pib_cid %>%
  ggplot(aes(x=pib_per_capita)) + 
  geom_histogram() +
  theme_light() + 
  theme(text=element_text(size=20)) + 
  ggtitle("PIB per capita municipal")
