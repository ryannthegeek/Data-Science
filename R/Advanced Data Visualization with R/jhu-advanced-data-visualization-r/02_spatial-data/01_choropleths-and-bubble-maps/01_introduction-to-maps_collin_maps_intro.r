library(tidyverse)
library(maps)

####tell us what data is in this package
help(package="maps")
?map_data

my_world_map <- map_data("world")

######this doesn't work because there is no group aesthetic
#ggplot(data = my_world_map, mapping = aes(x= long, y= lat))+geom_polygon()

####here the group is specified correctly
ggplot(data = my_world_map, mapping = aes(x= long, y= lat,group=group))+
  geom_polygon(fill="white",color="black")


#####let's look at just a country or countries

germany <- filter(my_world_map,region=="Germany")

ggplot(data=germany,mapping=aes(x=long,y=lat,group=group))+geom_polygon(fill="white",color="black")

france_germany <- filter(my_world_map,region=="France" | region=="Germany")

ggplot(data = france_germany, mapping = aes(x= long, y= lat,group=group))+geom_polygon(fill="white",color="black")

#####get a region by filtering with lat and long

a_region<- filter(my_world_map,long>-10 & long<15.1 & lat>32 & lat<55)

ggplot(data = a_region, mapping = aes(x= long, y= lat,group=group))+geom_polygon(fill="white",color="black")










