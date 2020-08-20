# This code makes sure all packages are installed
pkgs <- c("ggplot2", "dplyr", "readr", "tidyr", "lubridate")
for(i in pkgs){
  if(!i %in% installed.packages()){
    install.packages(i)
  }
}

# Loads up all the packages to use for this analysis
library(readr)
library(tidyr)
library(dplyr)
library(lubridate)
library(ggplot2)

# Open data from John's Hopkins Center for Systems Science and Engineering via GitHub
confirmed_url <- "https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"

# Data munging to get data ready to plot
coronavirus <- read_csv(confirmed_url) %>% 
  pivot_longer(cols = 5:ncol(.), names_to = "date", values_to = "number") %>%
  mutate(date = mdy(date)) %>%
  rename_all(tolower) %>%
  rename(province_state = `province/state`, country_region = `country/region`) %>%
  group_by(date, country_region) %>%
  summarize(cases = sum(number, na.rm = TRUE)) %>%
  ungroup() %>%
  filter(cases > 0) %>%
  arrange(date) %>% 
  group_by(country_region) %>%
  mutate(days_since = as.numeric(date - min(date)),
         min_date = min(date),
         Country = paste(country_region, ":", max(cases))) %>%
  ungroup() %>%
  select(Country, country_region, date, days_since, cases)

# This code recreates (kinda) the graph at 
#https://www.npr.org/sections/goatsandsoda/2020/03/12/814522489/singapore-wins-praise-for-its-covid-19-strategy-the-u-s-does-not

total_days_country_gg <- coronavirus %>%
  filter(country_region == "US" | country_region == "Italy" | 
           country_region == "Korea, South" | country_region == "Japan" |
           country_region == "Singapore" | country_region == "Iran") %>%
  ggplot(aes(x = days_since, y = cases, color = Country)) +
  geom_line(size = 1.2) +
  theme_minimal() +
  scale_color_manual(values = c("darkred", "darkblue", "lightblue", "yellow", 
                                "darkorange", "darkgreen")) +
  labs(x = "Days since first case →", y = "", color = "Country: Total cases",
       title = "COVID-19 Outbreaks Can Vary Dramatically",
       subtitle = "The way a country responds to a COVID-19 outbreak has an impact on the speed and degree of spread.") +
  theme(axis.title.x = element_text(hjust = 0, vjust = 0.1))
total_days_country_gg
