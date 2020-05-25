install.packages(SparkR)
library(SparkR)
sparkR.session()
sparkR.session(sparkPackages = "com.databricks:spark-avro_2.11:3.0.0")
directory<-"C:/Users/Mine/Desktop/profeco/"

datos<-read.df(paste(directory,"all_data.csv",sep = ""),source="csv",header="true")#cargas los datos
head(datos)#echas un vistazo a los datos
printSchema(datos)#ves cuantas columnas tiene la base de datos
head(count(datos))#numero de registros 62,530,715


head(count(distinct(select(datos,"categoria"))))#42
categoria<-as.data.frame(distinct(select(datos,"categoria")))
#son 40 categorias en relaidad ya que hay datos no observados


head(count(distinct(select(datos,"cadenaComercial"))))#706
cadenaComercial<-as.data.frame(distinct(select(datos,"cadenaComercial")))
#son 704 categorias ya que hay un rneglon vacio

max(datos$precio)
head(count(distinct(select(datos,"estado"))))
#head(where(datos, datos$precio > 100))

datos1<-as.data.frame(summarize(groupBy(datos,"estado","producto"),count=n(datos$producto)))
head(datos1)
#ordenar datos por abecedario, producto mas vendido
id<-order(datos1$estado)
#Datos ordenados
datos2<-datos1[id[id],]
id2<-order(datos2$count)
#Indentificaror de los estados Colima con el producto CORN FLAKES
id1<-unique(datos2$estado)#hay 36 datos 
# 4 no son estados entonces son 31 estados y un distrito

datos3<-as.data.frame(summarize(groupBy(datos,"cadenaComercial","producto"),count=n(datos$producto)))
head(datos3)
#ordenar datos por abecedario, producto mas vendido
id3<-order(datos3$cadenaComercial)
#Datos ordenados
datos4<-datos3[id3[id3],]
id4<-order(datos4$count)
#Indentificaror de Cadena Comercial
id5<-unique(datos4$cadenaComercial)#hay 663






