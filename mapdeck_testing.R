library(tidyverse)
library(sf)
library(mapdeck)

mapdeck(token = key, 
        style = mapdeck_style("dark"),
        location = c(32.8, -79.9)) %>%
  add_sf(
    data = parcels %>%
      st_transform(crs = 4326) %>%
      mutate(PrtlDOS = as.numeric(PrtlDOS)*100,
             DOS_AR  = DOS_AR * 100)
    , layer = "polygon_layer"
    , elevation = "DOS_AR"
    , fill_colour = "tod_suit"
    #, palette = "viridis"
    , legend = TRUE
    , legend_options = list(title = "TOD Suitability")

  ) %>%
  add_sf(
    data = stn_area %>% st_transform(crs = 4326)
    , layer = "station_areas"
    #, fill_colour ="#FFFFFF"
    , fill_opacity  = 0
    , stroke_colour = "#FFFFFF"
    , stroke_width  = 15
  ) %>%
  add_sf(
    data = stations %>% st_transform(crs = 4326)
    , layer = "stations"
    , fill_colour = "#D3D3D3"
    , fill_opacity = 255
    , radius_min_pixels = 8
    , radius_max_pixels = 12
  ) 
