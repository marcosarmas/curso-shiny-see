Integracion con Bases de Datos
========================================================
author: Marcos Armas
date: 20 - Diciembre - 2017
autosize: true

Que es una base de datos relacional?
========================================================

<img src="./imagenes/der.gif" width="600px">

SQL?
===

Structured Query Languaje

```
select * from tabla
where columna = 'valor'
```

Es un lenguaje estandar para hacer consultas a una base de datos relacional

Ejemplo
===

```
select usuario_de.nombre as de,
       usuario_para.nombre as para,
       mensajes.mensaje
from  mensajes
inner join usuarios usuario_de
  on mensajes.idu_de = usuario_de.idu
inner join usuarios usuario_para
  and mensajes.idu_para = usuario_para.idu
where 
  mensaje.fecha = '2017-12-20'
```

Motor de base de datos
===

Es el software que gestiona la estructura de tablas y relaciones.

En el mercado existen muchos motores de bases de datos ejemplo:

1. Microsoft SQL Server
2. MySQL
3. PostgreSQL
4. Oracle
etc...

Librerias de R para conexion a base de datos
===

## PostgreSQL

library(sqldf)

```
options(sqldf.RPostgreSQL.user ="user", 
            sqldf.RPostgreSQL.password ="pass",
            sqldf.RPostgreSQL.dbname ="base",
            sqldf.RPostgreSQL.host ="ip", 
            sqldf.RPostgreSQL.port =5432)
```

Librerias de R para conexion a base de datos
===

## PostgreSQL

```
db  <- dbConnect(PostgreSQL(), dbname = "base", host = "localhost", port = 5432, user = "postgres", password = "pass")

query <- "select * from tabla_x"
data  <- dbGetQuery(db, query)
dbDisconnect(db)
data
```

Librerias de R para conexion a base de datos
===

## Oracle

```
drv <- JDBC(driverClass="oracle.jdbc.driver.OracleDriver",
            classPath="/ojdbc6.jar",
            identifier.quote="`")
conn <- dbConnect(drv=drv,
                 url="jdbc:oracle:thin:@//192.168.1.132:1521/ORAI",
                 user="user",
                 password="pass")

dbGetQuery(conn, "select * from tabla_x")
```

Estilos para las aplicaciones
===

Shiny tiene un estilo sobrio y minimalista, su intencion es que las visualizaciones sean sencillas y no muy cargadas.

Si se desea cambiar el estilo (colores, fuentes, tama�os de letra) puede ser un dolor de cabeza si se los hace manualmente.

Para cambiar un estilo:
===

Necesitas saber CSS y HTML.

CSS: Hoja de estilo en cascada, es un archivo donde se definen estilos personalizados, se puede realizar por tag, id o clase de entrada del codigo HTML.

HTML: HyperText Markup Language, es el formato de las p�ginas web, hasta ahora shiny viene haciendo este trabajo.

Bootstrap
===

No, no hablamos del algoritmo para remuestreo, ni del mecanismo para capitalizar una empresa, en desarrollo web es una forma de estandarizar una pagina de tal forma que puedes utilizar estilos CSS que desarrollan los dise�adores gr�ficos

Para nuestra buena suerte, shiny crea el html con bootstrap, lo que quiere decir que en la web podemos encontrar varios estilos.

(https://rstudio.github.io/shinythemes/)

Instalar un estilo bootstrap
===

```
## ui.R ##
library(shinythemes)

fluidPage(theme = shinytheme("cerulean"),
  ...
)
```

Todos los estilos en un solo click
===

```
...
ui = fluidPage(
    shinythemes::themeSelector(),  
...
```

Mensaje de espera
===

```
tags$div(conditionalPanel(condition="$('html').hasClass('shiny-busy')",
                                                tags$div(id="loadmessageContainer",
                                                         tags$div(id="loadmessage","Loading...",br(),tags$div(class="loader",""))
                                                )
                      )
                      )
```

Descargar datos
===

ui.R

```
downloadButton("descargar", "Descargar datos")
```

server.R

```
output$descargar <- downloadHandler(
    filename = "nacidos_vivos.csv",
    content = function(file) {
      write.csv(cargarDatos(), file)
    }
  )
```

Imprimir graficos
===

Usamos la opcion de highchar hc_export

```
hc_exporting(enabled=T)
```

Lecciones que aprendi ayer
===

1. Las clases en vivo pueden ser peligrosas
2. No confiar en la experiencia, cuando se aborda un nuevo data set es importante saber las particularidades del mismo
3. El proceso de limpieza es largo y tedioso, en una clase de visualizacion debemos partir de que el dataset este pulcro y listo para su aplicacion
4. Tener un programa pre hecho puede agilizar la clase.
