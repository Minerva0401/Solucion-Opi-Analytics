#-----EJERCICIO C--------------#
library(dplyr)
#leemos las bases de datos
boops_bm<-read.csv("C:/Users/Mine/Desktop/BOPS_case/bops_bm1.csv",
                   header = TRUE)
boops_bm<-boops_bm[,1:7]
boops_online<-read.csv("C:/Users/Mine/Desktop/BOPS_case/bops_online1.csv",
                   header = TRUE)

#De las tiendas en B&M nos quedamos solo con aquellas de USA
boops_bm<-boops_bm[boops_bm$usa==1,]

#Podemos pensar en este problema como un diseño factorial con dos
#métodos, A y B, y cada un o con dos niveles:
#El método A indica si es una venta en linea o en B&M
#El método B indica si la venta fue antes o despues de BOPS
#CREAMOS NUESTRAS VARIABLES ENTONCES

on<-summarise(group_by(boops_online,year,month,week),
              sum(sales))
bm<-summarise(group_by(boops_bm,year,month,week),
              sum(sales))
x1<-c(rep(1,51),rep(0,55))#es o no online
x2<-c(rep(0,26),rep(1,25),rep(0,27),rep(1,28))#antes o despues de BOPS
y<-c(on$`sum(sales)`,bm$`sum(sales)`)

dat<-cbind(x1,x2,y)
dat
x1<-as.factor(x1)
mod1<-lm(y~-1+x1*x2)#BUENO
summary(mod1)
#Resultado
#Call:
 # lm(formula = y ~ -1 + x1 * x2)

#Residuals:
#  Min       1Q   Median 
#-2105010  -574788   -63565 
#3Q      Max 
#330613  4668148 

#Coefficients:
#  Estimate Std. Error
#x10     4545581     182943
#x11     3094947     186427
#x2      -454633     258720
#x11:x2    33886     371263
#t value Pr(>|t|)    
#x10     24.847   <2e-16 ***
#  x11     16.601   <2e-16 ***
#  x2      -1.757   0.0819 .  
#x11:x2   0.091   0.9275    
#---
#  Signif. codes:  
#  0 '***' 0.001 '**' 0.01
#'*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 950600 on 101 degrees of freedom
#(1 observation deleted due to missingness)
#Multiple R-squared:  0.9403,	Adjusted R-squared:  0.9379 
#F-statistic: 397.7 on 4 and 101 DF,  p-value: < 2.2e-16

mod1$coefficients

mod1$fitted.values


