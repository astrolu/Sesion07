###################################################
##### RETO 1: SESION 7 #############

# Crea un repositorio en Github llamado Reto_Sesion_7

# Crea un Project llamado Reto_Sesion_07 dentro de RStudio Cloud utilizando tu 
# cuenta de RStudio, que esté ligado al repositorio recién creado

# Ahora en RStudio crea un script llamado queries.R en donde se conecte a la 
# BDD shinydemo

MyDB <- dbConnect(
  drv = RMySQL::MySQL(),  
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
  )

my_db <- dbPool(
  RMySQL::MySQL(), 
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)


# Una vez hecha la conexión a la BDD, generar una búsqueda con dplyr que 
# devuelva el porcentaje de personas que hablan español en todos los países

library(dplyr)

dbListTables(MyDB)
dbListFields(MyDB,"CountryLanguage")

data <- dbGetQuery(MyDB, "select * from CountryLanguage")

class(data)

spanish <-  data %>% filter(Language == "Spanish") 
tail(spanish)

# Realizar una gráfica con ggplot que represente este porcentaje de tal modo 
# que en el eje de las Y aparezca el país y en X el porcentaje, y que
# diferencíe entre aquellos que es su lengua oficial y los que no, con 
# diferente color (puedes utilizar geom_bin2d() ó geom_bar() y coord_flip(),
# si es necesario para visualizar mejor tus gráficas)

install.packages("ggplot2")
library(ggplot2)
ggplot(spanish, aes(x=CountryCode, y=Percentage, fill=IsOfficial)) +
geom_bin2d() +
  coord_flip()

# Una vez hecho esto hacer el commit y push para mandar tu archivo (queries.R), 
#al repositorio de Github Reto_Sesion_7