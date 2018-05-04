# Anasisys Association rules R script

![N|Solid](http://www.maestriasenensenada.mx/images/modulos/cetys_universidad-logo.png)

Es un script hecho ne R que que analiza una base de datos transaccional y saca las reglas de asociación haciendo uso de Apriori, una vez con las reglas de asociación hace una serie de gráficas en formato PNG.

  - Dr. Adan Hirales
  - Ing. Luis Enrique Hernandez Navarro


# Requerimientos

  - jsonlite
  - arules
  - arulesViz

### Como usarlo

AARules requiere [R](https://www.r-project.or) para funcionar.

Install the dependencies and devDependencies and start the server.

```sh
$ Rscript AARules.r [database] [Support] [Confidence] [Minimum range] [Output dir]
```

Modo de uso:
  - [database] - Ruta y nombre de la base d e datos
  - [Support] - Soporte a usar en el algoritmo apriori
  - [Confidence] - Confianza a usar en el algoritmo apriori
  - [Minimum range] - Rgango minimo
  - [Output dir] - directorio de salida

### Carpetas

El programa se separa en folder
  - data - Carpeta recomendada para los archvos de entrada
  - src - Aqui se encuentra la funcion AARules
  - analysis - Carpeta recomndada como ruta de salida
