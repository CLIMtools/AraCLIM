require(shiny)
require(shinydashboard)
require(shinyjs)
require(leaflet)
require(ggvis)
library(plyr)
require(dplyr)
library(tidyr)
library(RColorBrewer)
require(raster)
require(gstat)
require(rgdal)
require(Cairo)
library(sp)
library(htmltools)


FULL.val <-read.csv("data/shiny climatesd.csv")
class(FULL.val)  
na.omit(FULL.val)

vlc <- read.delim("data/variable_label_category.txt", header = FALSE, sep = "\t")
colnames(FULL.val) <- vlc[,2]
by_cat <- vlc %>% filter(V3 != "-") %>% group_by(V3) %>% summarise(V3,V2) %>% nest()
cats <- read.delim("data/categories.txt", header = FALSE, sep = "\t")
vars <- vector("list",dim(cats)[1])
names(vars) <- cats$V1
n = dim(vlc)[1]
for(i in 1:n) {
	c <- vlc[i,3]
	l <- vlc[i,2]
	if (is.null(vars[[c]])) {
		vars[c] = c(l)
	}
	else {
		vars[[c]] = c(vars[[c]], l)
	}
}

# a data.frame

FULL <- SpatialPointsDataFrame(FULL.val[,c("lng", "lat")], FULL.val[,1:212])

#########

descriptiondataset <-read.csv("data/datadescription.csv")


datasets <- list(
  'FULL'=  FULL,
	'cats'= vars,
  'descriptiondataset'
  
)

baselayers <- list(
  'FULL'='Esri.WorldImagery'
)

