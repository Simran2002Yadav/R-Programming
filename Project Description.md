# Sales Data Analysis (12-month dataset)
For this task, I explored a 12-month sales dataset and carried out several steps to clean, prepare, and analyze the data, uncovering valuable insights about product performance, customer behavior, and sales trends.

## Exploring the Dataset:
First, I examined the dataset’s structure using functions like dim(), str(), and summary() to understand its dimensions, variable types, and general characteristics. I also checked for duplicates and missing values.
I assessed the product data by using table() and barplot() to identify the most frequently ordered products, giving me an idea of which products performed the best in terms of sales volume.

## Handling Missing Data:
I started by identifying rows with missing values in critical columns like Quantity Ordered and Price Each. For these columns, I employed two strategies:

Dropping missing values: I removed rows with NA values using na.omit() and drop_na().

Imputing missing data: Instead of losing valuable data, I replaced missing numeric values with the mean of the respective columns (Quantity Ordered and Price Each), ensuring the dataset remained intact without introducing bias from missing data.

## Outlier Detection and Handling:
To detect outliers, I created boxplots for the Quantity Ordered and Price Each columns. The boxplots revealed outliers, as several data points were far from the main cluster.

I also visualized potential outliers with a scatterplot, which showed points deviating significantly from the general trend between Quantity Ordered and Price Each.

Using the Interquartile Range (IQR) method, I calculated Q1 and Q3 to define the IQR. I then removed outliers by filtering out rows where Quantity Ordered exceeded 1.5 times the IQR. This helped clean the dataset of extreme values that could distort the analysis.

## Data Cleaning and Preparation:
After removing the missing values and outliers, I finalized the cleaned dataset. This prepared data was now free from irregularities, making it suitable for further analysis.

## Gaining Insights through Visualization:
Finally, I created a histogram of Quantity Ordered by product category to identify the most ordered products. This visualization provided clear insight into customer ordering patterns and product performance.

## Key Takeaways:
By conducting this EDA, I was able to clean and structure the sales data, handle missing values and outliers effectively, and visualize customer and product trends. This analysis provided important insights, such as which products were the top performers, how often customers ordered, and the average order values across different products.

# COVID-19 Data Analysis Across 170 Countries

## Project Overview: 
This project focuses on analyzing global COVID-19 data for 170 countries using R programming. The primary objectives were to examine infection rates, fatalities, and the impact of various socio-economic indicators during the pandemic. The analysis explored the influence of factors such as population, stringency index, Human Development Index (HDI), and GDP on COVID-19 outcomes. Advanced data visualization techniques were employed to uncover insights about the pandemic’s spread and its broader economic implications.

## Key Tasks:

Data Cleaning & Preparation:

Imported and merged datasets, handling missing values by replacing NA values with zeros.

Aggregated data by country to create a summary dataset containing total cases, deaths, population, stringency index, HDI, and GDP figures (before and during COVID).

Descriptive Statistics:

Analyzed country-wise distribution of COVID-19 cases and deaths.

Identified the most affected regions globally and calculated the mode for country representation in the dataset.

Data Visualization: 
Multiple chart types were used to gain deeper insights into the data:

Total Cases and Deaths: Bar charts were created to visualize countries with the highest COVID-19 cases and deaths, comparing their respective figures.

Comparative Analysis: Visualized the differences between total cases and total deaths using dodge bar charts for a side-by-side comparison.

Stringency Index: Analyzed how strictly countries implemented response measures like lockdowns and travel restrictions, correlating them with COVID-19 cases.

Economic Impact: Explored the impact of COVID-19 on GDP before and during the pandemic, using bar charts to visualize the relationship between infection rates and economic outcomes.

Human Development Index (HDI): Assessed how HDI, a measure of a country's development, correlated with total COVID-19 cases.

## Key Insights:

Countries Most Affected: Visualized the top 10 countries with the highest number of COVID-19 cases and deaths, highlighting significant global hotspots.

Impact of Stringency Measures: Countries with higher stringency index values displayed different patterns of infection rates, emphasizing the effect of government measures on the spread of the virus.

Economic Impact: The comparison of GDP before and during COVID-19 revealed notable economic slowdowns, with some countries experiencing a significant decline in GDP per capita.

Human Development Index (HDI): Countries with varying HDI levels showed different outcomes in COVID-19 cases and fatalities, indicating the potential role of development in managing the pandemic's impact.


## Conclusion: 
This analysis provided a detailed overview of the global impact of COVID-19, highlighting not only the spread of the virus but also its significant economic and social consequences. The use of R and ggplot2 allowed for a comprehensive examination of key patterns, offering valuable insights into the factors influencing the pandemic’s outcomes worldwide.

# Analysis of WWII Aerial Bombing Dataset: Impact of Weather on Operational Outcomes

The analysis utilizes a six-year dataset of weather conditions during World War II aerial bombing operations, examining how temperature variations and weather conditions influenced operational outcomes.

## Visualizations
Bar Plots:

Max Temperature: A bar plot displays the maximum temperatures recorded over the specified dates, indicating variations throughout the year.

Min Temperature: A similar bar plot for minimum temperatures illustrates the temperature fluctuations and trends, providing insights into the colder conditions during the bombing periods.

Grouped Bar Plot: This visualization compares both maximum and minimum temperatures side by side for each date, allowing for a direct comparison of temperature extremes.

Line Charts: Separate line charts depict the trends of maximum and minimum temperatures over time, highlighting seasonal patterns and significant fluctuations that may correlate with operational events.

Area Chart: An area chart represents the mean temperature over time, emphasizing overall temperature trends and how they change across the duration of the dataset.

Histograms:

Histograms for maximum and minimum temperatures show the distribution of these temperature values, revealing how often different temperature ranges occurred during the bombing campaigns.

Density Plot:

A line histogram (density plot) of the mean temperature illustrates the distribution's smooth curve, offering a clearer picture of the temperature variations.
Scatter Plots:

Scatter plots illustrate the relationship between mean temperature and snowfall, as well as between minimum and maximum temperatures. These visualizations help identify correlations or trends between these variables.

Bubble Plot:

A bubble plot represents mean temperature against the year, with bubble size indicating the extent of poor weather. This visualization allows for a nuanced understanding of how adverse weather conditions impacted temperature and operations.

Waterfall Chart:

The waterfall chart visually represents the cumulative changes in mean temperature over time, showing how temperature trends fluctuated, including both positive and negative changes.

Box Plots:

Box plots for maximum and minimum temperatures provide insights into the statistical distribution of temperature values, highlighting median, quartiles, and potential outliers. These plots reveal the spread and central tendency of temperature data.
## Conclusion
The diverse array of visualizations provides a comprehensive overview of how weather conditions, particularly temperature variations, impacted aerial bombing operations during World War II. The analysis highlights key trends and relationships within the dataset, offering valuable insights into the operational challenges posed by weather.
