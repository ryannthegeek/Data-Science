

########More temporal figures











###basic dumbbell chart


####clean the axis labels

ggplot(df2,
       aes(y=reorder(person,year1),
           x=year1,
           xend=year5))+
  geom_dumbbell(
    colour_x="purple", 
    colour_xend="red",
    size_x=3,
    size_xend=3
  )+
  labs(x="",#### clears out the x axis
       y="Person")

##########Flows

######Alluvial Diagrams
#Adapted from: https://github.com/corybrunson/ggalluvial

#install.packages("ggalluvial")
library("ggalluvial")

####Let's create some fake data about student performance in classes
####21 students are divided in 3 groups, they are men and women, and they get High Pass, Pass, or Fail


group1<-tibble(groupid=groupid<-rep("group1",7),
               studentID=sample(seq(from=1,to=20),7),
               gender=sample(c("M","F"),7,replace=TRUE),
               grades=sample(c("High Pass","Pass","Fail"),7,replace=TRUE))

group2<-tibble(groupid=groupid<-rep("group2",7),
               studentID=sample(seq(from=21,to=30),7),
               gender=sample(c("M","F"),7,replace=TRUE),
               grades=sample(c("High Pass","Pass","Fail"),7,replace=TRUE))

group3<-tibble(groupid=groupid<-rep("group3",7),
               studentID=sample(seq(from=31,to=40),7),
               gender=sample(c("M","F"),7,replace=TRUE),
               grades=sample(c("High Pass","Pass","Fail"),7,replace=TRUE))

students<-bind_rows(group1,group2,group3)

####Summarize data
students_table<- students %>%
  group_by(groupid,gender,grades) %>%
  count()

####barebones alluvial
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium()

####add strata
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium()+
  geom_stratum()

####add labels
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium()+
  geom_stratum()+
  geom_text(stat="stratum",
            aes(label=after_stat(stratum)))

####Change colors
ggplot(students_table,
       aes(axis1=groupid,
           axis2=grades,
           y=n))+
  geom_alluvium(aes(fill=gender))+
  geom_stratum()+
  geom_text(stat="stratum",
            aes(label=after_stat(stratum)))+
  scale_fill_manual(values=c("purple","green"))


#Packed circle figure

#Adapted from https://www.r-graph-gallery.com/305-basic-circle-packing-with-one-level.html

#install.packages("packcircles")
library(packcircles)

####Use congress data as an example
####Sample a number of members from the 114th Congress
cel_114<- cel %>% filter(congress==114)
members<-sample_n(cel_114,25)


####circleProgressiveLayout automatically creates a data frame with x and y centers for circles and radii, based on the values for the data you feed it.
####You'll probably get a message about missing values, don't worry about it - some members didn't get any bills passed, so they are non-positive and are ignored
packing<-circleProgressiveLayout(members$all_pass,sizetype='area')

####add the centers and radii to the sample data
members<-add_column(members,packing)

####Provides more points for ggplot to draw the perimeters of the circles
dat.gg<-circleLayoutVertices(packing,npoints=50)

####combine the circle data with text data
ggplot()+
  geom_polygon(data=dat.gg,
               aes(x=x, ###this x value is the x-axis value of the center of the circles
                   y=y, ###this y value is the x-axis value of the center of the circles
                   group=id, ####this is the id number for the circles
                   fill=as.factor(id), ####fill in the colors for the circles
                   alpha=0.6))+ ####adds some transparency to the colors
  geom_text(data=members, ####You have to respecifiy the data here for the labels
            aes(x=x, ###this x value is the x-axis value of the center of the circles
                y=y,###this y value is the x-axis value of the center of the circles
                size=all_pass,####vary the size of the text based on relative magnitude of the variable of interest
                label=thomas_name))+
  theme(legend.position="none")+
  coord_equal() ####makes your plot square




####Pie Charts

#Don't make these, use a barplot instead. For why, see https://www.data-to-viz.com/caveat/pie.html

#If you really want to make a pie chart, just use pie() from Base R


#This code from https://www.r-graph-gallery.com/131-pie-plot-with-r.html
# Create Data
Prop <- c(3,7,9,1,2)

# Make the default Pie Plot
pie(Prop)

