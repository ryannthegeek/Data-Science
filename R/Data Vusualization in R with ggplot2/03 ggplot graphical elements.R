#####more theme() modifications
###look at all of the controls you have using the theme() function

ggplot(data = plot_data, aes(x = ideo5, y = CC18_308a, color = Employment)) +
  geom_jitter() +
  scale_color_brewer(name = "Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom")

ggplot(data = plot_data, aes(x = ideo5, y = CC18_308a, color = Employment)) +
  geom_jitter() +
  scale_color_brewer(name = "Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 90, hjust = 1, color = "blue"))

ggplot(data = plot_data, aes(x = ideo5, y = CC18_308a, color = Employment)) +
  geom_jitter() +
  labs(x = "Ideology", y = "Trump Approval",
       title = "Trump Approval, Ideology, and Employment",
       caption = "A caption might have a quick note about the figure or a sourcing.") +
  scale_color_brewer(name = "Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 90, hjust = 1, color = "blue"),
        axis.title = element_text(color = "purple"))

###add axis labels and modify the text
ggplot(plot_data, aes(x = ideo5, y = CC18_308a, color = Employment)) +
  geom_jitter() +
  scale_colour_brewer(name = "Employment", palette = "RdYlGn") +
  theme(legend.position = "bottom") +
  labs(x = "Ideology", y = "Trump Approval",
       title = "Trump Approval, Ideology, and Employment",
       caption = "A caption might have a quick note about the figure or a sourcing.") +
  ####it's ok to have more than one theme command
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = rel(2), color = "blue"),
        title = element_text(color = "red"),
        legend.title = element_text(color = "green")) +
  labs(x = "Ideology", y = "Trump Approval",
       title="Trump Approval, Ideology, and Employment",
       caption = "A caption might have a quick note about the figure or a sourcing.")

####ggthemes contains pre-baked themes that you can try and modify
#####allyourfigurearebelongtous for pictures of themes

ggplot(plot_data, aes(x = ideo5, y = CC18_308a, color = Employment)) +
  geom_jitter()+
  theme_wsj()

####you can still control elements of a pre-baked ggtheme yourself by adding additional theme() functions
ggplot(plot_data, aes(x = ideo5, y = CC18_308a, color = Employment)) +
  geom_jitter()+
  theme_wsj() +
  theme(axis.text = element_text(angle=90))

## Modifications with vector graphics using Inscape
# Inkscape is a vector
#graphics editing program, and it's essentially an
#open-source equivalent of Adobe Illustrator. You can download Inkscape
#for free at Inkscape.org, and version 1 just became available in the spring of 2020. Inkscape is a very
#powerful program with a lot of functionalities
#for graphic designers. But for the purposes of
#tweaking ggplot figures, you don't need to understand all the ins and outs
#of the program.

#####line chart

units <- letters[1:2]
time <- seq(1:10)

time_series <- expand.grid(units = units, time = time)
head(time_series)
time_series$variable <- runif(20,0,5)
head(time_series)

line_plot <- ggplot(data = time_series, aes(x = time, y = variable, group = units)) +
  geom_line()
line_plot

####scatterplot

x_axis <- seq(1:10)
y_axis <- runif(10,0,5)

scatter_dat <- data.frame(x = x_axis,y = y_axis)

scatter_plot <- ggplot(scatter_dat,aes(x=x,y=y))+geom_point()

scatter_plot <- ggplot(data = scatter_dat, aes(x = x, y = y)) +
  geom_point()
scatter_plot

####barplot

cases <- letters[1:5]
y_axis1 <- runif(5,0,5)
y_axis2 <- runif(5,0,5)
y_axis3 <- runif(5,0,5)

bar_dat <- data.frame(cases = cases,
                      y1 = y_axis1,
                      y2 = y_axis2,
                      y3 = y_axis3)

long_bar_dat <- pivot_longer(bar_dat,
                             c("y1", "y2", "y3"),
                             names_to = "measure",
                             values_to = "value")

bar_plot <- ggplot(long_bar_dat,aes(x=cases,y=value,fill=measure))+geom_bar()

bar_plot <- ggplot(data = long_bar_dat, aes(x = cases, y = value, fill = measure)) +
  geom_bar(stat = "identity", position = "dodge")
bar_plot

## saving the plots
ggsave("lineplot.jpg", plot = line_plot)
ggsave("lineplot.pdf", plot = line_plot)

#####to save files as .svg(for use in Inscape) from ggsave
require(svglite)

ggsave("lineplot.svg",plot = line_plot)
