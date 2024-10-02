library(readxl)
data <- read_excel("C:/Users/Aashish S/Desktop/transformed_data.xlsx")
View(data)

data2 <- read_excel("C:/Users/Aashish S/Desktop/raw_data.xlsx")
View(data2)

#let’s have a look at how many samples of each country are present in the dataset:
country_counts <- table(data$COUNTRY)

# To view the counts in descending order
country_counts <- sort(country_counts, decreasing = TRUE)

# Print the counts
print(country_counts)
# Find the mode (most frequent values)
mode_values <- names(country_counts[country_counts == max(country_counts)])

# Print the mode values
print(mode_values)

# Initialize empty vectors/lists
code <- unique(data$CODE)
country <- unique(data$COUNTRY)
hdi <- numeric(length(country))
tc <- numeric(length(country))
td <- numeric(length(country))
sti <- numeric(length(country))
population <- numeric(length(country))

# Loop through each unique country
for (i in 1:length(country)) {
  # Filter data for the current country
  country_data <- data[data$COUNTRY == country[i], ]
  
  # Filter data2 for the current country
  country_data2 <- data2[data2$location == country[i], ]
  
  # Handle missing values by replacing NA with zeros
  country_data$TC[is.na(country_data$TC)] <- 0
  country_data2$total_cases[is.na(country_data2$total_cases)] <- 0
  country_data2$total_deaths[is.na(country_data2$total_deaths)] <- 0
  
  # Calculate sums
  hdi[i] <- sum(country_data$HDI) / 294
  tc[i] <- sum(country_data2$total_cases)
  td[i] <- sum(country_data2$total_deaths)
  sti[i] <- sum(country_data$STI) / 294
  population[i] <- sum(country_data2$population) / 294
}

# Create a data frame
aggregated_data <- data.frame(
  "Country Code" = code,
  "Country" = country,
  "HDI" = hdi,
  "Total Cases" = tc,
  "Total Deaths" = td,
  "Stringency Index" = sti,
  "Population" = population
)

# Print the first few rows of the data frame
head(aggregated_data)

# Load the dplyr library
library(dplyr)

# Sort 'aggregated_data' by the "Total Cases" column in descending order
data3<- aggregated_data%>%
  arrange(desc(`Total.Cases`))
# Print the first few rows of the sorted data frame
print(data3)


# Select the top 10 countries with the highest COVID-19 cases
data4<- head(data3, 10)

# Print the selected data
print(data4)

#Now I will add two more columns
#(GDP per capita before Covid-19, GDP per capita during Covid-19) to this dataset:

df <- data4 %>% mutate(GDP_Before_Covid=c(65279.53, 8897.49, 2100.75, 
                                       11497.65, 7027.61, 9946.03, 
                                       29564.74, 6001.40, 6424.98, 42354.41),
                    GDP_During_Covid=c(63543.58, 6796.84, 1900.71, 
                                       10126.72, 6126.87, 8346.70, 
                                       27057.16, 5090.72, 5332.77, 40284.64))
print(df)

##Analyzing the Spread of Covid-19

install.packages("ggplot2")
# Load the ggplot2 library
library(ggplot2)
#total cases in Millions

df <- transform(df, Total.Cases_Millions = Total.Cases / 1e6)
# the countries with the highest number of covid-19 cases:
plot <- ggplot(df, aes(x = Country, y = `Total.Cases_Millions`, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(title = "Countries with Highest Covid Cases")+
  theme(axis.text.x = element_text(angle = 90))
  
# Print the created bar chart
print(plot)

#total deaths in millions
df <- transform(df, Total.Deaths_Millions = Total.Deaths / 1e6)
#Now let’s have a look at the total number of deaths 
#among the countries with the highest number of covid-19 cases:
plot2<- ggplot(df, aes(x = Country, y = `Total.Deaths_Millions`, fill = Country)) +
  geom_bar(stat = "identity") +
  labs(title = "Countries with Highest Covid Deaths")+
  theme(axis.text.x = element_text(angle = 90))
  
# Print the created bar chart
print(plot2)


#. Now let’s compare the total number of cases and total deaths in all these countries:
plot3 <- ggplot(df, aes(x = Country)) +
  geom_bar(aes(y = `Total.Cases_Millions`, fill = "Total.Cases_Millions"), stat = "identity", position = "dodge", width = 0.4) +
  geom_bar(aes(y = `Total.Deaths_Millions`, fill = "Total.Deaths_Millions"), stat = "identity", position ="dodge", width = 0.4) +
  labs(
    title = "COVID-19 Statistics by Country",
    x = "Country",
    y = "Count"
  ) +
  scale_fill_manual(values = c("Total.Cases_Millions" = "indianred", "Total.Deaths_Millions" = "lightsalmon")) +
  theme(axis.text.x = element_text(angle = 90))


print(plot3)


#Another important column in this dataset is the stringency index.
#It is a composite measure of response indicators, including school closures, workplace closures, and travel bans. It shows how strictly countries are following these measures to control the spread of covid-19:

plot5<- ggplot(df, aes(x = Country, y = `Total.Cases_Millions`, fill = `Stringency.Index`)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = `Total.Deaths_Millions`), vjust = -0.5, size = 3) +
  labs(
    title = "Stringency Index during Covid-19",
    x = "Country",
    y = "Total Cases",
    fill = "Stringency.Index"
  ) +
  theme(axis.text.x = element_text(angle =90))


print(plot5)
#Analyzing Covid-19 Impacts on Economy
#GDP BEFORE COVID
plot6<- ggplot(df, aes(x = Country, y = `Total.Cases_Millions`, fill = `GDP_Before_Covid`)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = `Total.Deaths_Millions`), vjust = -0.5, size = 3) +
  labs(
    title = "GDP Before Covid",
    x = "Country",
    y = "Total Cases",
    fill = "GDP_Before_Covid"
  ) +
  theme(axis.text.x = element_text(angle=90))

  
  
print(plot6)

# GDP DURING COVID
plot7<- ggplot(df, aes(x = Country, y = `Total.Cases_Millions`, fill = `GDP_During_Covid`)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = `Total.Deaths_Millions`), vjust = -0.5, size = 3) +
  labs(
    title = "GDP During Covid",
    x = "Country",
    y = "Total Cases",
    fill = "GDP_During_Covid"
  ) +
  theme(axis.text.x = element_text(angle=90))



print(plot7)
#One other important economic factor is Human Development Index.
#It is a statistic composite index of life expectancy, education, and per capita indicators. Let’s have a look at how many countries were spending their budget on the human development:

plot8<- ggplot(df, aes(x = Country, y = `Total.Cases_Millions`, fill = `HDI`)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = `Total.Deaths_Millions`), vjust = -0.5, size = 3) +
  labs(
    title = "HDI During Covid",
    x = "Country",
    y = "Total Cases",
    fill = "HDI"
  ) +
  theme(axis.text.x = element_text(angle=90))



print(plot8)

