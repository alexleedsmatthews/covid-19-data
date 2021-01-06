# set working directory to the folder containing this script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# load required packages
install.packages("tigris", "ggplot2", "readr", "dplyr", "scales", "tidyverse", "gganimate", "lubridate", "gifski", "png", "stringr", "tigris", "sf", "RColorBrewer")
library(ggplot2)
library(readr)
library(dplyr)
library(scales)
library(tidyverse)
library(gganimate)
library(lubridate)
library(gifski)
library(png)
library(stringr)
library(RColorBrewer)
library(sf)
library(tigris)
library(maproj)


mask_use_by_county <- read_csv("~/Documents/covid-19-data/mask-use/mask-use-by-county.csv", 
                               col_types = cols(ALWAYS = col_number(), 
                                                FREQUENTLY = col_number(), NEVER = col_number(), 
                                                RARELY = col_number(), SOMETIMES = col_number()))
View(mask_use_by_county)

# install.packages("tidycensus")
# library(tidycensus)
# 

# merge sfs from tidycensus with mask use data




# v17 <- load_variables(2017, "acs5", cache = TRUE)
# 
# View(v17)

# county_level <- get_acs(geography = "county",
#                         year = 2017,
#                         geometry = TRUE,
#                         cb = FALSE,
#                         shift_geo = TRUE)

# making mask compliance a single, continuous variable

mask_use_by_county$COMPLIANT <- mask_use_by_county$FREQUENTLY + mask_use_by_county$ALWAYS

mask_use_by_county$NONCOMPLIANT <- mask_use_by_county$RARELY + mask_use_by_county$NEVER


# setting up a county map
county_map_sf <- counties(cb = TRUE, resolution = '20m', class = "sf") 

county_lookup <- mask_use_by_county %>%
  as_tibble() %>%
  select(COUNTYFP, COMPLIANT) %>%
  rename (GEOID = COUNTYFP)

county_mask_map <- county_map_sf %>%
  left_join(county_lookup) %>%
  st_as_sf(crs = st_crs(county_map))

  
# county_mask_map2 <- county_map %>%
#   left_join(county_lookup) %>%
#   mutate(COMPLIANT = COMPLIANT*100) %>%
#   st_as_sf(crs = st_crs(county_map))




ggplot(county_mask_map) +
  geom_sf(color = "white", size = 0.0002, aes(fill = COMPLIANT)) +
  scale_fill_distiller(palette = "RdBu",
                       direction = 1,
                       name = "Mask Compliance") +
  coord_map()
  theme_void()


# try to lay it over biden/trump counties with margins--see what comes up

