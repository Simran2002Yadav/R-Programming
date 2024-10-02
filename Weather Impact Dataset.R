
#####IMPORT DATA#####
library(readxl)
Summary_of_Weather <- read_excel("C:/Users/Aashish S/Desktop/Summary of Weather.xlsx")
View(Summary_of_Weather)
dim(Summary_of_Weather)
#####INSTALL NECESSARY PACKAGES#####
install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
str(Summary_of_Weather)
#####VISUALIZATION OF DATA
#####BARPLOT
## A bar chart is used when we want to compare metric values across different subgroups of the data. If we have a greater number of groups, a bar chart is preferred over a column chart.
## BARPLOT OF MAX TEMP
ggplot(Summary_of_Weather, aes(x=Date, y=MaxTemp)) + 
  geom_bar(stat = "identity",fill="red", alpha = 0.5)+
  labs(title ="Barplot of Max Temperature",
       X="DATE",
       Y="Max Temp")+
  theme_classic()
## BARPLOT OF MIN TEMP  
ggplot(Summary_of_Weather, aes(x=Date, y=MinTemp)) + 
  geom_bar(stat = "identity",fill="red", alpha = 0.5)+
  labs(title ="Barplot of Min Temperature",
       X="DATE",
       Y="Min Temp")+
  theme_classic()

##GROUPRD BARPLOT

ggplot(Summary_of_Weather, aes(x = Date)) +
  geom_bar(aes(y = MaxTemp, fill = "MaxTemp"), stat = "identity", position = "dodge") +
  geom_bar(aes(y = MinTemp, fill = "MinTemp"), stat = "identity", position = "dodge") +
  labs(title = "Grouped Bar Chart of Max and Min Temperatures",
       x = "Date",
       y = "Temperature") +
  scale_fill_manual(values = c("MaxTemp" = "red", "MinTemp" = "blue")) +
  theme_minimal()

#####LINE CHART
##A line chart is used for the representation of continuous data points. This visual can be effectively utilized when we want to understand the trend across time.
## LINE CHART OF MAX TEMP
plot(Summary_of_Weather$Date,Summary_of_Weather$MaxTemp,type = "l", col = "red", xlab = "Date", ylab = "MaxTemp",
     main = "Line Chart for Max Temperature")

##LINE CHART OF MIN TEMP
plot(Summary_of_Weather$Date,Summary_of_Weather$MinTemp,type = "o", col = "red", xlab = "Date", ylab = "MinTemp",
     main = "Line Chart for Min Temperature")

#####AREA CHART
##Area charts are used to track changes over time for one or more groups.
##Area graphs are preferred over line charts when we want to capture the changes over time for more than 1 group.
ggplot(Summary_of_Weather, aes(x=Date, y= MeanTemp)) +
  geom_area( fill="#69b3a2", alpha=0.4) +
  geom_line(color="#69b3a2",width=2) +
  geom_point(width=3, color="#69b3a2") +
  theme_classic() +
  ggtitle("Area Chart of Mean Temperature")



#####HISTOGRAM
##A histogram is a very popular graph that is used to show frequency distributions across continuous (numeric) variables.
##COLUMN HISTOGRAM

ggplot(Summary_of_Weather) +
  geom_histogram(mapping = aes(x = MaxTemp ), binwidth = 2)

ggplot(Summary_of_Weather) +
  geom_histogram(mapping = aes(x = MinTemp ), binwidth = 1)

#####LINE HISTOGRAM
##Line histograms are used to observe the distribution for a single variable with many data points.
ggplot(Summary_of_Weather, aes(x = MeanTemp, y = after_stat(density))) +
  geom_density(color= "green", linewidth = 2)+
  labs(x = "Mean Temperature", y = "", title = " Line Histogram of Mean Temperature")


#####SCATTERPLOT
##Scatter plots can be leveraged to identify relationships between two variables. It can be effectively used in circumstances where the dependent variable can have multiple values for the independent variable.
##BETWEEN MEAN TEMPERATURE AND SNOWFALL
ggplot(data = Summary_of_Weather) +
  geom_point(mapping = aes(x = Snowfall,
                           y = MeanTemp), colour = "darkgreen", shape = "square", alpha = 0.5) +
  geom_hline(yintercept = mean(Summary_of_Weather$MeanTemp), colour = "darkred") +
  geom_vline(xintercept = mean(Summary_of_Weather$Snowfall), colour = "darkblue") 
##BETWEEN MIN TEMP AND MAX TEMP
ggplot(data = Summary_of_Weather) +
  geom_point(mapping = aes(x = MinTemp,
                           y = MaxTemp), colour = "darkgreen", shape = "square", alpha = 0.5) +
  geom_hline(yintercept = mean(Summary_of_Weather$MaxTemp), colour = "darkred") +
  geom_vline(xintercept = mean(Summary_of_Weather$MinTemp), colour = "darkblue") 
#####BUBBLE PLOT
library(RColorBrewer)
my_data<-data.frame(
  Year=Summary_of_Weather$Date,
  Temperature=Summary_of_Weather$MeanTemp,
  weather=Summary_of_Weather$PoorWeather
)
ggplot(my_data, aes(x=Year, y=Temperature, size =weather)) +
  geom_point(alpha=0.7)+
  scale_color_brewer(palette="Spectral")

#WATERFALL CHART
#A waterfall chart should be used when:
##There is a need to graphically display change from a starting to a final value.
##The data has positive and negative values.
##it can show movement of a variable over time, 
##prepare data
df <- Summary_of_Weather %>%
  mutate(change = c(MeanTemp[1], diff(MeanTemp)),
         cumulative = cumsum(change),
         start = cumulative - change)
ggplot(df, aes(x = Date, y = change, fill = factor(change > 0))) +
  geom_bar(stat = "identity", position = "identity", color = "black") +
  scale_x_continuous(limits=df$Date) +
  geom_line(aes(x =Date , y = cumulative), color = "blue") +
  scale_fill_manual(values = c("#FF7F7F", "#7FBFFF")) +
  theme_bw() +
  labs(x = "Date", y = "MeanTemp", title = "Waterfall Chart")


#BOXPLOT
##BOXPLOT OF MAXIMUM TEMPERATURE
boxplot(Summary_of_Weather$MaxTemp, horizontal = TRUE,
        main = "Boxplot of Max Temperature",
        xlab = "Temperature",
        ylab = "Value")#, notch = TRUE)
geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE)

##BOXPLOT OF MIN TEMPERATURE
boxplot(Summary_of_Weather$MinTemp, horizontal = TRUE,
        main = "Boxplot of Min Temperature",
        xlab = "Temperature",
        ylab = "Value")#, notch = TRUE)
geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE)