# NE NERRS Analysis

################################################################################
# Purpose: The purpose of this document is to serve as motivating example (R
# and Open data are cool!), but will also serve to structure the rest of this
# workshop in that we will see how to work with and visualize data in R, combine
# code and documentation with R Markdown, and introduce The Tidyverse
# (https://tidyverse.org) which is an opinionated (but effective) way to think
# about organizing and analyzing data in R.  To accomplish this, we will be 
# using data from Wells, Great Bay, Waquoit Bay, and Narragansett Bay National 
# Estuarine Research Reserves.  These data provide a nice water quality relevant
# example and you all should be familiar with it to help sort out any issues we 
# might run into.

################################################################################
# Install packages, if needed: This is fancier than it normally needs to be.  It
# checks to make sure that packages are installed and installs if they aren't
# then loads it up.

pkgs <- c("ggplot2", "dplyr", "readr", "plotly", "SWMPr")
for(i in pkgs){
  if(!i %in% installed.packages()){
    install.packages(i)
  }
}

################################################################################
# Load up packages in R session

library(ggplot2)
library(dplyr)
library(readr)
library(plotly)
library(lubridate)
library(stringr)
library(tidyr)

################################################################################
# Get Data: The data we need is available from the National Aquatic Resource
# Survey's website First we can get the dataset that we have saved as a `.csv`
# in this repository.

ne_nerrs_wq <- read_csv("ne_nerrs_wq_2020.csv", guess_max = 600000)

################################################################################
# Manipulate Data: Let's tidy up this dataset by turning all column names to
# lower case (Jeff likes it that way), convert all text in the dataset to lower
# case (again Jeff likes it like that way and it is kind of a hot mess
# otherwise), filter out just the probability samples and the first visits, and
# select a subset of columns.

ne_nerrs_wq <- ne_nerrs_wq %>%
  select(site, datetimestamp:f_do_pct, ph:f_turb) %>%
  mutate(f_temp = case_when(.data$f_temp != 0 ~
                              NA_real_,
                            TRUE ~ .data$f_temp),
         f_spcond = case_when(.data$f_spcond != 0 ~
                                NA_real_,
                              TRUE ~ .data$f_spcond),
         f_sal = case_when(.data$f_sal != 0 ~
                             NA_real_,
                           TRUE ~ .data$f_sal),
         f_do_pct = case_when(.data$f_do_pct != 0 ~
                                NA_real_,
                              TRUE ~ .data$f_do_pct),
         f_ph = case_when(.data$f_ph != 0 ~
                            NA_real_,
                          TRUE ~ .data$f_ph),
         f_turb = case_when(.data$f_turb != 0 ~
                              NA_real_,
                            TRUE ~ .data$f_turb)) %>%
  filter(complete.cases(.)) %>%
  select(site, datetimestamp, temp, sal, do_pct, ph, turb) %>%
  mutate(reserve = str_sub(site, 1, 3),
         datetime = ymd_hms(datetimestamp),
         year = year(datetime),
         month = month(datetime),
         day = day(datetime),
         date = ymd(paste(year, month, day, "-"))) %>%
  select(reserve, site, date, temp, sal, do_pct, ph, turb) %>%
  gather("param", "measurement", temp:turb) %>%
  group_by(reserve, date, param) %>%
  summarize(measurement = mean(measurement, na.rm = TRUE))

ne_nerrs_wq

################################################################################
# Visualize Data: Next step is to visualize the data.  Let's look at the
# association between total nitrogen, total phosphorus, and chlorophyll *a*.

ne_nerrs_wq_gg <- ne_nerrs_wq %>%
  ggplot(aes(x=date,y=measurement)) +
  geom_point(aes(color=reserve)) +
  facet_grid(param ~ reserve, scales = "free_y", 
             labeller = labeller(param = c(do_pct = "%DO", ph = "pH", 
                                           sal = "Salinity", 
                                           temp = "Temperature", 
                                           turb = "Turbidity"),
                                 reserve = c(grb = "Great Bay", 
                                             nar = "Narr. Bay",
                                             wel = "Wells",
                                             wqb = "Waquoit Bay"))) +
  theme_classic() +
  theme(legend.position = "none") +
  labs(x = "Date", y = "", 
       title = "Comparison of basic water quality across northeastern NERRS") +
  scale_color_manual(values = c("darkred","darkblue","grey50","black"))

  
ggplotly(ne_nerrs_wq_gg)



