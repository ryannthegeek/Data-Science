#install.packages("gganimate")  ---- if you need to install
#install.packages("gifski") --- needed for PCs

library(tidyverse)
library(gganimate)
library(gifski)
library(transformr)

####this example from gganimate documentation

data(mtcars)

mtcars$gear

###single static boxplot
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) +
  geom_boxplot()

###facetted box plot
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) +
  geom_boxplot()+
  facet_wrap(~gear)

my_anim<- ggplot(mtcars, aes(x=factor(cyl), y=mpg)) +
  geom_boxplot() +
  # Here comes the gganimate code
  transition_states(
    gear)

my_anim

?transition_states

###Example of transition_time

?transition_time

cel <- read_csv(url("https://www.dropbox.com/s/4ebgnkdhhxo5rac/cel_volden_wiseman%20_coursera.csv?raw=1"))

###Plot total number of D and Rs across Congresses

cel$party<-recode(cel$dem,`1`="Democrat",`0`="Republican")

cong_dat<- cel %>% 
  group_by(year,party) %>%
  summarise("Seats"=n())

anim2<-ggplot(cong_dat,aes(x=year,y=Seats,fill=party))+
  geom_bar(stat="identity")+
  geom_hline(yintercept=217)+
  scale_fill_manual(values=c("blue","red"))+
  transition_time(year)

###transition_layers
?transition_layers

ggplot()+
  geom_jitter(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Democrat"))+
  geom_jitter(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Republican"))+
  geom_smooth(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Democrat"))+
  geom_smooth(aes(x=seniority,y=all_pass,color=party),data=filter(cel,congress==115 & party=="Republican"))+
  scale_color_manual(values=c("blue","red"))+
  transition_layers()
  


#####entering and exiting

ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_boxplot()

anim <- ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_boxplot() +
  transition_states(factor(cyl))

# Fade-in, fade-out
anim1 <- anim +
  enter_fade() +
  exit_fade()

anim1

#######shadowing

anim3<-ggplot(cong_dat,aes(x=year,y=Seats,fill=party))+
  geom_bar(stat="identity")+
  geom_hline(yintercept=217)+
  scale_fill_manual(values=c("blue","red"))+
  transition_time(year)+
  shadow_wake(wake_length=1,alpha=FALSE,wrap=FALSE)

anim3

####the animation will save to your working directory
anim_save("test.gif",animation=anim3)




