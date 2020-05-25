#Leer base de datos
datos<-read.csv("C:/Users/Mine/Desktop/datos/resultados_ageb_urbana_15_cpv2010.csv",na.strings = c("*", 'N/D'),
                encoding = "UTF-8")
#Eliminando el Total de la columna p0_2
id2<- datos$nom_loc == "Total AGEB urbana" |datos$nom_loc == "Total del Municipio" |datos$nom_loc == "Total de la localidad urbana" |datos$nom_loc == "Total de la Entidad"
#Eliminando el Total
datos1<-datos[!id2,]
#Considrando solo los de Toluca
Tol<- datos$nom_mun == "Toluca"
datos1<-datos1[Tol,][c(4,6,7,12)]
#Calcular la suma por cada AGEB y multiplicando por un cuarto
tabla<-tapply(datos1$p_0a2,datos1$ageb,sum,na.rm = TRUE)*0.25
sum(is.na(tabla))
length(unique(datos1$ageb))
