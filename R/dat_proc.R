library(tidyverse)
library(sf)
library(proj4shortcut)

prj <- geo_wgs84

######
# get all csci scores in contra costa county

data(csci_raw)

# all csci scores in CA
csci <- csci_raw %>% 
  st_as_sf(coords = c('Longitude', 'Latitude'), crs = prj) 

# Contra Costa county polygon
cnty <- st_read('S:/Spatial_Data/CA_Counties/cnty24k97.shp') %>% 
  filter(NAME %in% c('Contra Costa')) %>% 
  st_transform(crs = prj)

# intersect csci and cc county
csci_cc <- st_intersection(csci, cnty)

save(csci_cc, file = 'data/csci_cc.RData', compress = 'xz')