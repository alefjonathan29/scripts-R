library(dplyr)
starwars

starwars_pt <- starwars

class(starwars)
head(starwars, 10)

starwars %>% 
  head(10)

starwars_pt <- starwars %>% 
  rename(Nome = name,
         Altura_cm = height,
         Peso_Kg = mass,
         Cor_dos_cabelos = hair_color,
         Cor_da_pele = skin_color,
         Cor_dos_olhos = eye_color,
         Idade = birth_year,
         Sexo = sex,
         Genero = gender,
         Planeta_Natal = homeworld,
         Especies = species,
         Filmes = films,
         Veiculos = vehicles,
         Naves = starships)

starwars_pt <- starwars_pt %>% rename(Episodios = Filmes)

####Função: distinct()
#A função distinct() seleciona apenas as linhas únicas (distintas) de uma determinada variável do banco de dados.
starwars_pt %>% 
  distinct(Planeta_Natal)

#Aplique a função distinct() na variável **Especies**:
starwars_pt %>% 
  distinct(Especies)

####Função: select()
#Agora veremos a função que vamos estudar é o *select()*. 
#Esta função irá *selecionar* as colunas do banco de dados 
#que você colocou como argumento. Vejamos o exemplo a seguir:
starwars_pt %>% 
  select(Nome, Especies, Planeta_Natal)

#Na função *select()*, podemos usar outra função que é *everything()* 
#que irá nos ajudar a organizar as colunas.
starwars_pt %>% 
  select(Nome, Especies, Genero, everything())


