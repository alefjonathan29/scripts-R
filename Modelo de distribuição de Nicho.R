

## ---- Modelagem de distribuição de <Trigona spinipses> na América do Sul ---- ##

## Author: Marília Melo Favalesso
## Data: 31/10/2020

## Pacotes -- 
library(maptools) # pacote para abrir mapas diretamente no R
library(raster) # para baixar os limites territoriais diretamente no computador e trabalhar com rasters. 
library(dismo) # função gbif - download de ocorrências de espécies. 
library(tidyverse) # trabalhar com as planilhas
library(ENMTML) # pacote para modelagem de nicho
library(leaflet) # pacote para mapas interativos - usaremos nos resultados 

## Working directory --
setwd("C:/Users/MMF/Desktop/niche_models")

## Poligono da America do Sul  --
data("wrld_simpl")
wrld_simpl

## Dados de ocorrência de espécies com o gbif --
pontos = gbif('Trigona', # gênero da espécie
              species = "Trigona spinipes", # nome completo da espécie
              sp = TRUE, # Retornar como um SpatialPointsDataFrame?
              removeZeros = TRUE, # Remover linhas com dados de latitude e/ou logitude faltantes
              download = TRUE) # Para realizar o dowload dos registros

# - Colocar o nome "data" na guia de valores (que são as datas de amostragem)
names(pontos) = "data"

## Recortando o mapa para uma extensão mais próxima dos pontos --
# - 1o Olhar a saída de 'pontos' e ver a dimensão geográfica dele
pontos 

# - 2o Determinar novos valores para a extensão, pouco mais amplo que a dos pontos 
#      para enxergarmos mais da América do Sul.
ext = c(-85, -34.81973, -40, 10)

# - 3º Recortar o mapa mundi para a extensão selecionada. 
map = crop(wrld_simpl, ext)

## Plot data -- 

# O mapa de parte da América do Sul (mapa aproximado os pontos de ocorrência)
plot(map, # nosso limite territorial - America do sul
     axes = T, # Pedir para incluir os eixos das coordenadas
     lwd = 1.8, # Grossura da linha do mapa
     col = "#CCFF99", # colorir os países de verde
     bg = "#CCFFFF") # cor do background da imagem em azul

# Plotar o nome dos países no mapa
text(map$LON, map$LAT, map$NAME, cex = 0.7, font = 2)

# Os pontos de ocorrência da nossa espécie
points(pontos, # chamar o poligono de pontos
       pch = 20, # estilo dos pontos de ocorrência 
       col = 'red', # na cor vermelha
       cex = 1.5) # tamanho de 1.5

# Incluir legenda com o nome da espécie
legend('bottomright', # do lado inferior-direito
       pch = 20, # mesmo estilo dos pontos que antes
       legend = c(as.expression(bquote(italic("Trigona spinipes")))), # Nome da sp em itálico
       col = 'red', # Cor do ponto em preto
       bg = 'white', # Cor do background em branco
       bty = 0, # Tipo de caixa ao redor da legenda
       cex = 1) # Tamanho da legenda

## Salvar os dados de ocorrência para utilizar no pacote --

# !!!:
# O arquivo precisa ser salvo em .TXT (separado por tabulação)!
# Precisamos apenas de três colunas:
# um contendo o nome da espécie
# um contendo informações de longitude
# um contendo informações de latitude


# Primeiro, vamos gerar um objeto com o endereço do nosso diretório de trabalho
d_ex = file.path(getwd())
d_ex

# Extrair as informações dos pontos para uma tabela 
tabela = as.data.frame(pontos)

tabela = as.data.frame(pontos) %>% # transformar os dados em data.frame
  select('lon', 'lat') %>% # selecionar apenas long e lat
  add_column('species' = c(rep('Trigona spinipes', length(tabela$lon))),  # Incluir uma coluna com nome da sp ...
             .before = 'lon') # ... antes de coluna "lat".

# Mudar o nome das colunas para facilitar incluir na função depois 
names(tabela)[2:3] = c("x", "y")

# Salvar os pontos de ocorrência como .txt
# - criar uma pasta para os pontos no diretorio chamada "occ":
dir.create(paste0(d_ex, '/occ')) 
# - salvar os pontos de ocorrência em um arquivo chamado "occ.txt"
utils::write.table(tabela, file.path(d_ex, 'occ/occ.txt'), sep = '\t', row.names = FALSE)

## Dados bioclimáticos -- 

# Chamar os dados para o R com a função getData(). 
# Vamos usar os dados da plataforma "wordclim" <https://www.worldclim.org/>
r = getData("worldclim", 
            var="bio", 
            res=10) 

# Cortar os rasters pela extensão da América do sul
rr = crop(mask(r, map), map)

# Visualizar os dados 
plot(rr)

# Salvando os dados bioclimáticops
dir.create(paste0(d_ex, '/env')) 

# Para salvar cada um dos rasters individualmente no repositório 
for(i in names(rr)){
  writeRaster(rr[[i]], paste0(file.path(d_ex, 'env'), "/", i, '.tif'), overwrite = T)
}

################## --- MODELAGEM DE DISTRIBUIÇÃO --- ##################

# Criar uma pasta para salvar os resultados dos modelos 
dir.create(paste0(d_ex, '/resultados')) 

# Precisamos indicar os endereços de cada informação para a função 
d_env = file.path("C:/Users/MMF/Desktop/niche_models/env") # endereço das variáveis climáticas
d_occ = "C:/Users/MMF/Desktop/niche_modelse/occ/occ.txt" # endereço dos pontos de ocorrência
res = "C:/Users/MMF/Desktop/niche_models/resultados" # local em que iremos salvar os resultados 

ENMTML(
  pred_dir = d_env, # endereço para o diretório dos preditores
  proj_dir = NULL, # Quando trabalhamos com projeções - diferentes locais no espaço ou tempo
  result_dir = res, # Pasta para salvar as saídas/resultados 
  occ_file = d_occ, # Pasta onde estão nossos pontos de ocorrência
  sp = 'species', # coluna que contêm o nome das espécies 
  x = 'x', # coluna que corresponde a longitude
  y = 'y', # coluna que corresponde a latitude
  min_occ = 10, # Número minimo de ocorrências para cada espécie
  thin_occ = NULL, # Inserimos os métodos de filtragem de ocorrências dados redundantes 
  eval_occ = NULL, # Tabela com dados de ocorrência para validação dos dados 
  colin_var = c(method='PEARSON', threshold='0.7'), # Onde inserimos os métodos para evitar a colinearidade entre os dados 
  imp_var = TRUE, # Calcula a importância das variáveis em curvas de resposta 
  sp_accessible_area = NULL, # Método de restrição de área acessível para as espécies 
  pseudoabs_method = c(method = 'RND'), # Método de seleção de pseudo-ausências aleatório
  pres_abs_ratio = 1, # Razão presença-ausência (valores entre 0 e 1)
  part=c(method= 'KFOLD', folds='10'), # Método de partição para validação do modelo.
  save_part = TRUE, # Save partitioned data?
  save_final = TRUE, # Salvar o modelo final em .tif (?)
  algorithm = c('BIO', 'MAH', 'MXD'), # algoritmos de modelagem
  thr = c(type='MAX_TSS'), # Para binarizar o mapa, qual método utilizar?
  msdm = NULL, # Métodos de restrição no modelo para próximo das ocorrências conhecidas 
  ensemble = c(method='PCA'), # Qual método ensemble, ou de combinação, realizar entre os diferentes algoritmos? 
  extrapolation = FALSE, # Se TRUE, a função calculará a extrapolação com base na análise de paridade orientada para
  # a mobilidade (MOP) para as condições atuais
  cores = 1 # Defina o número de núcleos de CPU para executar procedimentos de modelagem em paralelo (padrão 1).
)


## ---- Visualizar os resultados  ---- ##

## Abrir o resultado em objeto chamado 'res' 
res = paste0(d_ex, '/resultados/Ensemble/PCA/Trigona_spinipes.tif') %>% raster()

## Vamos plotar os resultados usando o pacote "leaflet" 
# Fazer uma palheta de cores variando de verde até vermelho
pal = colorNumeric(c("#003300", "#006633", "#009300", "#FFFFCC",
                     "#FF9900", "#FF6600", "#FF3300"), values(res),
                   na.color = "transparent")

# Plotar em mapa interativo
leaflet(pontos) %>% # Usaremos a função 'leaflet' para produzir os mapas e já chamaremos os pontos de occ.
  addTiles() %>% # add um mapa de fundo
  addRasterImage(res, # adicionar o raster 'res' (com nossos resultados)
                 col = pal, opacity = 0.5, group = "Suitability") %>% # com cor = pal, transparência de 50% e nome suitability
  addLegend(pal = pal, values = values(res), title = "Suitability", group = "Suitability") %>% # add legenda para raster
  addLayersControl(overlayGroups = c("Suitability"), # Incluir opção de ligar e desligar o raster
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addCircleMarkers(radius = 1, col = "black") %>% # adicionar os pontos de ocorrência como circulos
  addScaleBar() # Adicionar uma barra de escala
