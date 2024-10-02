##Task 1
##Exploratory Data Analysis

library(readxl)
my_data <- read_excel("C:/Users/Aashish S/Desktop/Sales_April_2019.xlsx", 
                      col_types = c("text", "text", "numeric", 
                                    "numeric", "text", "text"))
View(my_data)


# INSTALLING NECESSARY PACKAGES FOR ANALYSIS
install.packages("ggplot2")
library(ggplot2)

install.packages("tidyverse")
library(tidyverse)

install.packages("dplyr")
library(dplyr)

install.packages("tidyr")
library(tidyr)


#EXPLORE THE DATA
dim(my_data)# returns the dimensions e.g. the no. of rows and columns
str(my_data)#returns list of objects and their structures
glimpse(my_data)
#used to see the columns of the dataset and display some portion of the datawith respect to each attribute
#disadvantage- it looks messy
head(my_data)#used to get the first n rows
tail(my_data)#used to display the last n rows
names(my_data)# used to get name of objects in dataset
length(my_data)#give the no. of columns 
class(my_data$Product)# used to understand the type of object
class(my_data$Product)
unique(my_data$Product)#used to get unique values and rempve duplicate values or the rows
table(my_data$Product)# used for tabulation of categorical variables and gives frequency as output
View(sort(table(my_data$Product),decreasing=TRUE))
barplot(sort(table(my_data$Product),decreasing=TRUE))
summary(my_data)# returns the minimum,maximum,mean ,median,and 1st and 3rd quaetiles for numerical vectors


#HANDLING MISSING DATA
#Drop NULL or missing values:
# first identify rows with NA
my_data%>%
  select(`Order ID`,Product,`Quantity Ordered`,`Price Each`,`Order Date`)%>%
  filter(!complete.cases(.))
#first method-Drop NULL or missing values:
my_data%>%
  select(`Order ID`,Product,`Quantity Ordered`,`Price Each`,`Order Date`)%>%
  na.omit()
#drop NA vaue of a particular column
my_data%>%
  select(`Order ID`,Product,`Quantity Ordered`,`Price Each`,`Order Date`)%>%
  drop_na(`Quantity Ordered`)%>%
  View()


#second method-calculate mean of the numeric columns 
mean_value_quantity<-mean(my_data$`Quantity Ordered`,na.rm = TRUE)
mean_value_Price<-mean(my_data$`Price Each`,na.rm = TRUE)
#replace NA with mean values
my_data$`Quantity Ordered`[is.na(`Quantity Ordered`)]<-mean_value_quantity

my_data$`Price Each`[is.na(my_data$`Price Each`)] <-mean_value_Price



#HANDLING OUTLIERS

#we must first identify the OUTLIERS in a DATASET
#BOXPLOTS
##a BOXPLOT can help you identify potential OUTLIERS by visualizing the spread of the data and comparing individual data points to the whiskers of the plot.
##OUTLIERS are data points that fall outside the whiskers of the BOXPLOT
my_data %>%
  drop_na(`Quantity Ordered`)%>%
  ggplot(aes(`Quantity Ordered`,""))+
  geom_boxplot(fill = "#0c4c8a")+
  ggtitle("QUANTITY ORDERED IN APRIL 2019")+
  coord_flip()+
  theme_bw()


my_data %>%
  drop_na(`Price Each`)%>%
  ggplot(aes(`Price Each`,""))+
  geom_boxplot(fill = "#0c4c8a")+
  ggtitle("PRICE OF EACH PRODUCT")+
  coord_flip()+
  theme_bw()
#we can conclude from above boxplots that there are outliers

#It is also possible to extract the values of the potential outliers
boxplot.stats(`Quantity Ordered`)$out
#which() function- it is possible to extract the row number corresponding to these outliers:
out <- boxplot.stats(`Quantity Ordered`)$out
out_ind <- which(`Quantity Ordered`%in% c(out))
out_ind
#SCATTERPLOT
##We can identify potential outliers in a dataset by examining a scatterplot, which is a graphical representation of the relationship between two variables. 
##Outliers often appear as points that are distant from the main cluster of data points.
ggplot(data = my_data, aes(x = `Quantity Ordered`, y = `Price Each`)) +
  geom_point(aes(color=factor(Product))) +
  ggtitle("Scatterplot for Checking Outliers") +
  theme_minimal()

##conclusion - we can conclude that there are points that are distant from the main cluster of data points.

##so here we can observe the presence of outliers
#IQR

Q1 <- quantile(my_data$`Quantity Ordered`, 0.25,na.rm=TRUE)
Q3 <- quantile(my_data$`Quantity Ordered`, 0.75,na.rm = TRUE)
IQR<-IQR(my_data$`Quantity Ordered`,na.rm= TRUE)
IQR
IQR2<-Q3-Q1
##The interquartile range (IQR) is a measurement of the spread of values in the middle 50%.

##If an observation is 1.5 times the interquartile range more than the third quartile (Q3) or 1.5 times the interquartile range less than the first quartile (Q1), it is considered an outlier (Q1).
##OUTLIER = Observations > Q3 + 1.5*IQR  or < Q1 – 1.5*IQR
#Remove OOTLIER in R
no_outliers <- subset(my_data, my_data$`Quantity Ordered`> (Q1 - 1.5*IQR) & my_data$`Quantity Ordered` < (Q3 + 1.5*IQR))
dim(no_outliers)


#UNDERSTANDING RELATIONSHIPS AND NEW INSIGHTS THROUGH PLOTS
my_data%>%
  ggplot(aes(x=`Quantity Ordered`))+
  geom_histogram(aes(color=factor(Product)))+
  labs(x="quantity ordered",
       y=NULL,
       title="histogram of quantity ordered")
  
  
