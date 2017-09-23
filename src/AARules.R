##########################################################
#
#          Anasisys Association rules R script
#
#    AARules Es un script hecho en R que que analiza 
#   una base de datos transaccional y saca las reglas 
#    de asociación haciendo uso de Apriori, una vez 
#     con las reglas de asociación hace una serie de 
#     gráficas en formato PNG. Todos los archivos
#   empiezan con AAR__.La forma de invocar AARules es:
#                      
#  
#  AARules.r [database] [Support] [Confidence] [Minimum range] [Output dir]
#
#
#      Autores:
#      Dr. Adan Hirales
#      Luis Hernandez
#      Octavio Romero
#
#
#  *Tomar como ejemplo el cvs de Groceries para ver como debe estar 
#  la base de datos de entrada
#
#
#############################################################

AARules <- function( ) {
  
  rm(list=ls())
  
  # Get command line arguments
  args = commandArgs(trailingOnly=TRUE)
  
  # Parse de argumentos: ruta DB, soporte, confianza, minimo y ruta de salida)
  inFile <-  as.character(args[1])
  soporte <- as.double(args[2])
  confianza <- as.double(args[3])
  mlen <- as.double(args[4])
  outFile <- as.character(args[5])
  
  #Datos locales
  #inFile = "groceries.csv"
  #soporte = 0.001
  #confianza = 0.5
  #mlen = 1
  #outFile = "res/"
  
  
  expedientes <- read.transactions(inFile, sep=",")
   
  ruleSet <- apriori(expedientes, parameter = list(support=soporte, confidence=confianza, minlen=mlen))
  
  summary(ruleSet)
  
  
  temp<-as((sort(ruleSet, by ="lift")), "data.frame")
  
  #graba en un archvo de texto txt y csv las reglas ordenadas por lift
  write.table(temp,paste(outFile,"AAR_ARules.txt"),sep="\t",row.names=FALSE)
  write.csv(temp, file = paste(outFile,"AAR_ARules.csv"))
  
  inspect(head(sort(ruleSet, by ="lift"),3))
  
  #graficalas todas reglas
  png(paste(outFile,"AAR_Rule_set.png"), width=12, height=8, units="in", res=300)
    plot(ruleSet)
  dev.off()
  
  head(quality(ruleSet))
  
  png(paste(outFile,"AAR_Two-key plot.png"), width=12, height=8, units="in", res=300)
    plot(ruleSet, shading="order", control=list(main = "Two-key plot"))
  dev.off()
  
  #sel <- plot(ruleSet, measure=c("support", "lift"), shading="confidence", interactive=TRUE)
  
  #filtramos las mejroes reglas en base a la confianza
  subrules <- ruleSet[quality(ruleSet)$confidence > 0.8]
  subrules
  
  png(paste(outFile,"AAR_Matrix plot.png"), width=12, height=8, units="in", res=300)
    plot(subrules, method="matrix", measure="lift")
  dev.off()
  
  #Misma grafica de arriba
  #png("Matrix plot.png", width=12, height=8, units="in", res=300)
  #plot(subrules, method="matrix", measure="lift", control=list(reorder=TRUE))
  #dev.off
  
  #Graficaen 3D
  png(paste(outFile,"AAR_3D plot.png"), width=12, height=8, units="in", res=300)
    plot(subrules, method="matrix3D", measure="lift")
  dev.off()
  
  png(paste(outFile,"AAR_Matrix2 plot.png"), width=12, height=8, units="in", res=300)
    plot(subrules, method="matrix", measure=c("lift", "confidence"))
  dev.off()
  
  #plot(subrules, method="matrix", measure=c("lift", "confidence"), + control=list(reorder=TRUE))
  
  #Reglas agrupadas
  png(paste(outFile,"AAR_Rules Grouped plot.png"), width=12, height=8, units="in", res=300)
    plot(ruleSet, method="grouped")
  dev.off()
  
  png(paste(outFile,"AAR_Rules Grouped plot K=50.png"), width=12, height=8, units="in", res=300)
    plot(ruleSet, method="grouped", control=list(k=50))
  dev.off()
  
  #sel <- plot(ruleSet, method="grouped", interactive=TRUE)
  
  #filtramos las 10 mejores reglas con base a lift
  
  subrules2 <- head(sort(ruleSet, by="lift"), 10)
  
  png(paste(outFile,"AAR_Graph for 10 rules.png"), width=12, height=8, units="in", res=300)
    plot(subrules2, method="graph")
  dev.off()
  
  png(paste(outFile,"AAR_Graph2 for 10 rules.png"), width=12, height=8, units="in", res=300)
    plot(subrules2, method="graph", control=list(type="itemsets"))
  dev.off()
  
  saveAsGraph(head(sort(ruleSet, by="lift"),1000), file="rules.graphml")
  
  png(paste(outFile,"AAR_paracoord plot.png"), width=12, height=8, units="in", res=300)
    plot(subrules2, method="paracoord")
  dev.off()
  
  png(paste(outFile,"AAR_paracoord 2 plot.png"), width=12, height=8, units="in", res=300)
    plot(subrules2, method="paracoord", control=list(reorder=TRUE))
  dev.off()
  
  oneRule <- sample(ruleSet, 1)
  inspect(oneRule)
  
  png(paste(outFile,"AAR_Doubledecker one rule plot.png"), width=12, height=8, units="in", res=300)
    plot(oneRule, method="doubledecker", data = expedientes)
  dev.off()
       
  
}
#revisar ruta de librearias 
#.libPaths("C:/Users/Louis/Documents/R/win-library/3.4")
library(jsonlite, quietly=TRUE)
library(arules, quietly = TRUE)
library(arulesViz, quietly = TRUE)

AARules()

