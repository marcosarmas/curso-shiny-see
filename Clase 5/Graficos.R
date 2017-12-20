

library(highcharter)
library(plyr)
#seteamos el area de trabajo
setwd("F:/cursos/curso-shiny-see/Clase 5")

#leemos archivo
nacidos <- read.csv("./ENV_2016.csv")

summary(nacidos)

lapply(nacidos, typeof)

typeof(nacidos$fecha_nac)

#transformar la fecha en fecha valida
#%m = mes
#%d = dia
#%y = año ej: 95
#%Y = año ej: 1995
nacidos$fecha_nac <- as.Date(nacidos$fecha_nac, format='%m/%d/%Y')

#filtramos a partir del 2016
nacidos <- nacidos[(nacidos$fecha_nac>='2016-01-01' & nacidos$fecha_nac<='2016-01-31'),]

a <- count(nacidos, c("fecha_nac","sexo"))

hchart(a, "line", hcaes(x = fecha_nac, y = freq))

highchart()%>%
  hc_chart(type="line")%>%
  hc_title(text = "Nacimientos") %>%
  hc_xAxis(categories=a$fecha_nac)%>%
  hc_add_series(a[a$sexo=="Hombre",]$freq, name="Hombres")%>%
  hc_add_series(a[a$sexo=="Mujer",]$freq, name="Mujeres")



nacidos$talla <- as.character(nacidos$talla)
nacidos$peso <- as.character(nacidos$peso)

nacidosScatter <- nacidos[(nacidos$talla != "Sin información"),]
nacidosScatter <- nacidos[(nacidos$peso != "Sin información"),]

#nacidosScatter <- nacidos[(nacidos$talla != "Sin información" || nacidos$peso != "Sin información" ),]

nacidosScatter$talla <- as.numeric(nacidosScatter$talla)
nacidosScatter$peso <- as.numeric(nacidosScatter$peso)

summary(nacidosScatter$talla)
summary(nacidosScatter$peso)

nacidosScatter <- count(nacidosScatter, c("talla","peso", "sexo"))
head(nacidosScatter)

colors <- c("#009922","#FF9922")
nacidosScatter$color <- colorize(nacidosScatter$sexo, colors)

hchart(nacidosScatter, "scatter", hcaes(x=talla, y=peso, size=freq))

library(reshape)
meses <- count(nacidos, c("mes_nac","sexo"))
meses

meses <- cast(meses,mes_nac  ~ sexo, sum)
meses$Hombre

meses$Hombre
meses$Mujer

highchart()%>%
  hc_chart(type="column")%>%
  hc_add_series(name="Hombres", data=list(list(sequence=meses$Hombre)))%>%
  hc_add_series(name="Mujeres", data=list(list(sequence=meses$Mujer)))%>%
  hc_motion(enabled=TRUE, 
            labels=meses$mes_nac, #c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"),
            series=c(0,1),
            autoplay = TRUE, updateInterval = 1
            )


areas <- count(nacidos, "area_res")

highchart()%>%
  hc_title(text="Area de residencia")%>%
  hc_chart(type="pie")%>%
  hc_xAxis(categories = areas$area_res)%>%
  hc_add_series(areas$freq, name= "Cantidad")


ps <- count(nacidos, c("prov_nac","sexo"))
ps <- ps[order(ps$freq, decreasing = T ),]
hchart(ps, "bar", hcaes(x = prov_nac, y = freq, group = sexo))

