setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


require(dplyr)
require(tigris)
require(sf)
require(covid19nytimes)

covid19nytimes_states <- refresh_covid19nytimes_states() %>%
  filter(date == max(date)) 

covid19nytimes_counties <- refresh_covid19nytimes_counties()%>%
  filter(date == max(date)) 
