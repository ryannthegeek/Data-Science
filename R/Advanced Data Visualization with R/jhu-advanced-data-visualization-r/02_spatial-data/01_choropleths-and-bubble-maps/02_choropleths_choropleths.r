####drawing choropleths

####all we have to do to make a choropleth is to merge data into a data frame, then we just use an aesthetic mapping like before, using fill.

library(tidyverse)
library(maps)

#####make a map of us states using state data from map_data command

my_state_map <- map_data("state")

ggplot(data = my_state_map, mapping = aes(x= long, y= lat, group = group))+geom_polygon(fill="white",color="black")

#####this provides a list of continental states plus Washington, DC
states<- unique(my_state_map$region)

####make some fake data for painting the map

some_data_values <- data.frame(
  
  ####the region column is here so you can join this fake data with the my_state_map data by the region column
  "region"=states,
  
  "qual_value"=c(rep(LETTERS[1:10],4),
                 LETTERS[1:9]),
  
  "quant_value"=runif(49,0,5))


######join the data using the region as the column for merging
######be really careful about merging! tiny inconsistencies can create BIG problems

map_data_combined <- left_join(my_state_map,some_data_values,by="region")

#View(map_data_combined)


######make a choropleth with default colors
ggplot(data = map_data_combined, mapping = aes(x= long, y= lat, group = group,fill=qual_value))+geom_polygon(color="black")

######make a choropleth with some fancy fixes
ggplot(data = map_data_combined, mapping = aes(x= long, y= lat, group = group,fill=qual_value))+
  geom_polygon(color="black")+
  theme_classic()+
  labs(x="",y="",title="A Test Choropleth")+
  theme(axis.text.x = element_blank(),axis.text.y=element_blank(),axis.line = element_blank(),axis.ticks = element_blank())+
  scale_fill_brewer(palette="Spectral")

#####switch out for a quantitative value
ggplot(data = map_data_combined, mapping = aes(x= long, y= lat, group = group,fill=quant_value))+
  geom_polygon(color="black")

