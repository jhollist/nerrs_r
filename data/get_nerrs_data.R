library(SWMPr)
library(dplyr)
library(readr)

wells <- c("weldnwq", "welhtwq", "welinwq", "wellmwq", "welmlwq", "welsmwq", 
           "welupwq")
waquoit <- c("wqbcbwq", "wqbcrwq", "wqbctwq", "wqbmhwq", "wqbmpwq", "wqbnbwq", 
             "wqbnswq", "wqbslwq")
narr_bay <- c("narncwq", "narpcwq", "nartbwq", "nartswq", "nartwwq")
grt_bay <- c("grbgbwq", "grblrwq", "grborwq", "grbsqwq")
sites <- c(wells, waquoit, narr_bay, grt_bay)

if(!file.exists("data/ne_nerrs_wq_2020.csv")){
  ne_nerrs_wq <- data.frame()
  for(i in sites){ 
    err <- tryCatch(
      all_params_dtrng(i,c("05/01/2020", "11/30/2020")),
      error=function(e) e
      )
    if(!inherits(err, "error")){
      df <- all_params_dtrng(i,c("05/01/2020", "11/30/2020"))
      df <- mutate(df, site = i)
      ne_nerrs_wq <- rbind(ne_nerrs_wq, df)
      print(i)
      print(unique(ne_nerrs_wq$site))
    }
  }
} else {
 ne_nerrs_wq <- read_csv("data/ne_nerrs_wq_2020.csv", guess_max = 300000) 
}               

ne_nerrs_sites <- site_codes()
ne_nerrs_sites %>%
  filter(station_code %in% sites) %>%
  View()
