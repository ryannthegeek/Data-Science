## Extensions of scatterplots
require(tidyverse)

## Import the cel and cces data, dropping NAs
cces <- drop_na(read_csv("cces_data.csv"))
cel <- drop_na(read_csv("cel_data.csv"))
attach(cces)
attach(cel)

#####Variations on Scatterplots
####Add a best-fit line with geom_smooth

####Using some survey data
ggplot(data = cces, aes(x = educ, y = ideo5)) +
  geom_point()

ggplot(data = cces, aes(x = educ, y = ideo5)) +
  geom_jitter()

ggplot(data = cces, aes(x = educ, y = ideo5)) +
  geom_jitter() +
  geom_smooth() ####the default line is a loess curve

####change the method for drawing the line, here using linear regression
ggplot(data = cces, aes(x = educ, y = ideo5)) +
  geom_jitter() +
  geom_smooth(method = "lm")

###Change the confidence level

ggplot(data = cces, aes(x = educ, y = ideo5)) +
  geom_jitter() +
  geom_smooth(method = "lm", level = .9) ###specify confidence level

####Scatterplot Matrix

require(GGally)

####Make up some numeric data. Two variables will be positively correlated, and the third will be negatively correlated with the first

var1<-runif(100, 0, 1)
var2<- var1 + rnorm(100, 1, .2)
var3<- var1 * (-rnorm(100, 1, .2))

df <- tibble(var1, var2, var3);df

ggpairs(df)

######Customize the matrix figures

####Write your own function for the scatterplot


my_scatter <- function(data, mapping){
  ggplot(data = data, mapping = mapping) +
    geom_jitter(color = "red")
}

my_density <- function(data, mapping){
  ggplot(data = data, mapping = mapping) +
    geom_density(alpha =.05, fill = "red")
}

#####substitute your functions for the functions that ggpairs() uses to draw the figures

ggpairs(df,
        lower = list(continuous = my_scatter),
        diag = list(continuous = my_density))

#### Correlation plots
require(ggcorrplot)
require(ggthemes)

#####Use some example survey data

df <- cces %>% 
  select(educ, pid7, pew_religimp)

#####calculate correlation coefficients

r <- cor(df, use = "complete.obs")

####generate the correlation plot

ggcorrplot(r)

####show just the lower part of the figure (to avoid 1 correlations on the diagonals)

ggcorrplot(r, type = "lower")

####modify some visual elements

ggcorrplot(r, type = "lower",
           title = "Correlations",
           colors = c("yellow", "green", "blue"),
           outline.color = "purple")

####Use a ggtheme if you want

ggcorrplot(r, type = "lower",
           title = "Correlations",
           ggtheme = theme_wsj())

#####Cleveland Dot Plots

####Use some of the congress data

cel_114 <- cel %>% 
  filter(congress == 114)
set.seed(12345)
members <-sample_n(cel_114, 25)
head(members)
####points only

ggplot(data = members, aes(x = les,y = thomas_name)) +
  geom_point()

####Some refinements

ggplot(members, aes(x = les, y = reorder(thomas_name, les))) + ######reorder in descending
  geom_point(size = 5) +
  labs(x = "Legislative Effectivness", y= " ") +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(linetype = "dashed", color = "blue"))

#Lollipop figure

ggplot(members, aes(x = reorder(thomas_name, les), y = les)) +
  geom_point() +
  geom_segment(aes(x = thomas_name, xend = thomas_name, y = 0, yend = les)) +
  theme(axis.text.x = element_text(angle = 90))


## More temporal figures
 
#####geom_area()

#####A line chart that is filled in below

#####make temporal data
set.seed(12344)
var1<-runif(10, 0, 25)
time<-seq(1:10)

df<-tibble(var1,time)

####just filling in the space under the line

ggplot(df, aes(x = time, y = var1)) +
  geom_area() ####color in the area under the line

####a little aesthetic tweaking

ggplot(df, aes(x =time,y=var1,fill="red"))+ ####set the color
  geom_area()+
  guides(fill=FALSE) ##drop legend

ggplot(data = df, aes(x = time, y = var1, fill = "red")) +
  geom_area() +
  guides(fill = "none")

#####Make a stacked line graph

####Create fake data for three people at three different time points

Bob <- tibble(person = rep("Bob", 5), time = seq(1:5), change = runif(5, 0, 25))
Sue <- tibble(person = rep("Sue", 5), time = seq(1:5), change = runif(5, 0, 25))
Lisa <- tibble(person = rep("Lisa", 5), time = seq(1:5), change = runif(5, 0, 25))

df <- bind_rows(Bob, Sue, Lisa)
head(df)

####plot the stacked lineplot

ggplot(df, aes(x = time, y = change, fill = person)) +
  geom_area()

####test your understanding of what the plot is showing
df_wide <- df %>% 
  pivot_wider(id_cols = time, values_from = change, names_from = person)

####note that the stacked areas add up to the totals
df_wide$total<-
  df_wide$Bob +
  df_wide$Sue +
  df_wide$Lisa

####Dumbbell charts

require(ggalt)

#####reformat the fake data from the stacked area chart, so we are comparing times at 1 and 5 for Bob, Sue, and Lisa

df2 <- df %>%
  filter(time == 1 | time == 5) %>%
  pivot_wider(names_from = time, values_from = change) %>%
  rename(year1 = `1`, year5 = `5`)

###basic dumbbell chart

ggplot(df2,aes(y = person,
           x = year1, ####the starting point, earliest time
           xend = year5)) + ####the ending point, final time
  geom_dumbbell() ####connects the points

####reorder the y axis

ggplot(df2,
       aes(y = reorder(person, year1), ####reorders the y axis
           x = year1,
           xend = year5)) +
  geom_dumbbell()

####change the colors and sizes

ggplot(df2,
       aes(y = reorder(person, year1), ####reorders the y axis
           x = year1,
           xend = year5)) +
  geom_dumbbell(
    colour_x = "purple", ####adds color --- makes sure you "colour", not color
    colour_xend = "red",
    size_x = 3,
    size_xend = 3
  )
