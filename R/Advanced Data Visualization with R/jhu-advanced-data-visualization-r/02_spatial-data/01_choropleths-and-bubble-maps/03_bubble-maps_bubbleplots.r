######bubble maps

library(tidyverse)
library(maps)

####this provides city data

world <- map_data("world")

japan <- filter(world,region=="Japan")

ggplot(data = japan, mapping = aes(x= long, y= lat, group = group))+geom_polygon(color="black",fill="white")

######maps package has city data

head(maps::world.cities)
my_cities <-maps::world.cities

japan_cities <- filter(my_cities,country.etc=="Japan")

head(japan_cities)

####make a point for every city
ggplot(data = japan, mapping = aes(x= long, y= lat, group = group))+
  geom_polygon(color="black",fill="white")+
  geom_point(data = japan_cities,aes(x=long,y=lat,group=NULL),color="red")


####let's pick just the big cities

japan_big_cities <- filter(my_cities,country.etc=="Japan" & pop>500000)

ggplot(data = japan, mapping = aes(x= long, y= lat, group = group))+
  geom_polygon(color="black",fill="white")+
  geom_point(data = japan_big_cities,aes(x=long,y=lat,group=NULL),color="red")


####vary size of point by city size
ggplot(data = japan, mapping = aes(x= long, y= lat, group = group))+
  geom_polygon(color="black",fill="white")+
  geom_point(data = japan_big_cities,aes(x=long,y=lat,group=NULL,size=pop),color="red")

#####now vary the color of the dots

japan_big_cities$qual <- sample(LETTERS[1:5],nrow(japan_big_cities),replace=TRUE)

ggplot(data = japan, mapping = aes(x= long, y= lat, group = group))+
  geom_polygon(color="black",fill="white")+
  geom_point(data = japan_big_cities,aes(x=long,y=lat,group=NULL,color=qual,size=pop))

#####do some tweaking
####no scientific notation in legend r ggplot -- scales package adds the "scale_size_continuous" function to our arsenal, and we can set label=comma
library(scales)

###change the column name to make the legend nicer
japan_big_cities$Population <- japan_big_cities$pop
japan_big_cities$Qualitative <- japan_big_cities$qual

####do some additional refining
ggplot(data = japan, mapping = aes(x= long, y= lat, group = group))+geom_polygon(color="black",fill="white")+
  geom_point(data = japan_big_cities,aes(x=long,y=lat,group=NULL,color=Qualitative,size=Population))+
  scale_size_continuous(label=comma)

