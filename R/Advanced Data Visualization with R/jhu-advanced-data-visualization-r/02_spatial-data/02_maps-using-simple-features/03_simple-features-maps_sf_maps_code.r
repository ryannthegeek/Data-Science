######Drawing Maps using simple features (sf) approach
library(tidyverse)
library(sf)

###"Tiger Lines" data from the US Census bureau

######SET YOUR WORKING DIRECTORY TO THE FOLDER WHERE THE GEOJSON AND ASSOCIATED FILES ARE LOCATED.

###Have all associated files in your working directory

#setwd("YOUR DIRECTORY PATH HERE")


states <- read_sf("tl_2019_us_state.shp")

#######documentation for the data
####https://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2019/TGRSHP2019_TechDoc.pdf

#####this might take a very long time to draw on some computers - if you have an older computer, do not run 
ggplot() + geom_sf(data = states)


#####this packages allows you draw prettier maps of the US
#install.packages("devtools")
#devtools::install_github("hrbrmstr/albersusa")
library(albersusa)

######draws a prettier map
ggplot() + geom_sf(data = usa_sf())

#######read in a geojson

######SET YOUR WORKING DIRECTORY TO THE FOLDER WHERE THE GEOJSON AND ASSOCIATED FILES ARE LOCATED.

#setwd("YOUR DIRECTORY PATH HERE")

seattle_counties <- read_sf("wa_msa_counties.geojson")

######note here that you can put the data into the ggplot() function or the geom_sf() function
ggplot(data = seattle_counties)+ geom_sf()

#####use a subset of census data states to draw data into sf maps

states

####these two filter commands generate the same data
#my_states <- filter(states,STUSPS=="NE" | STUSPS=="KS" | STUSPS=="IA" |STUSPS=="MO")

my_states <- filter(states,STATEFP==31 | STATEFP==29 | STATEFP==20 |STATEFP==19)

ggplot(my_states)+geom_sf()

####make a simple choropleth by adding a data column to the my_states file

dummy_qual<- data.frame("STATEFP"=c("31","29","20","19"),qual=c(LETTERS[1:4]))

######tip: you have to put quotation marks around the FIPS code when you create this dataframe, because the STATEFP column in my_states is a <chr> variable. the class of the two matching columns must be the same

my_states<- left_join(my_states,dummy_qual,by="STATEFP")

dummy_quant<- data.frame("STATEFP"=c("31","29","20","19"),"quant"=c(1,2,3,4))

my_states<- left_join(my_states,dummy_quant,by="STATEFP")

####draw the choropleth
ggplot(my_states)+geom_sf(aes(fill=qual))

ggplot(my_states)+geom_sf(aes(fill=quant))


#####make a bubble plot by using a second data set with longitude and latitude data

cities <- maps::world.cities

my_cities <- filter(cities,name=="Omaha" | name=="Cedar Rapids" | name=="Topeka"|name=="Joplin")
#####tip: be careful, more than one city can have the same name!


ggplot()+geom_sf(data= my_states,aes(fill=NAME))+
  geom_point(data=my_cities,aes(x=long,y=lat))

library(ggrepel)
ggplot()+geom_sf(data= my_states)+
  geom_point(data=my_cities,aes(x=long,y=lat))+
  geom_text_repel(data=my_cities,aes(x=long,y=lat,label=name))
#####tip: because you are using three separate data files here, you have to put the data into each geom commands - you don't want the data to be inherited from ggplot() 



