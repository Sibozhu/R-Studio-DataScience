library(sp)
library(RgoogleMaps)
library(ggmap)
library(tidyverse)
library(maptools)
library(datasets)
library(tigris)


# figure 2
murder <- subset(crime, offense == "murder") # the data is from ggmap
qmplot(lon, lat, data = murder, 
       colour = I('red'), size = I(3), darken = .3)


### boston crime


boston.crime <- read.csv("crime.csv")

boston.murder <- filter(boston.crime, OFFENSE_CODE == 111)




qmplot(Long, Lat, data = boston.murder, 
       colour = I('red'), size = I(3), darken = .3)

boston.murder <- filter(boston.murder, Lat>0)

qmplot(Long, Lat, data = boston.murder, 
       colour = I('red'), size = I(3), darken = .3)


## from google maps
# ?geocode
#
geocode("the white house")
qmap("the white house",zoom=18)

tmp <- get_map(location = c(lon = -77.0364,lat = 38.898), zoom = 18)
ggmap(tmp)

# 
# geocode("Hawaii")
# qmap("Hawaii",zoom=8)

tmp <- get_map(location = c(lon = -157.5, lat = 21),zoom=7)
ggmap(tmp)

# find the location on google earch and ...
tmp <- get_map(location = c(lon = -159.5, lat = 22.21), 
               zoom = 12)
ggmap(tmp)

tmp <- get_map(location = c(lon = -159.5, lat = 22.21), 
               zoom = 14)
ggmap(tmp)


tmp <- get_map(location = c(lon = -159.5, lat = 22.21), 
               zoom = 15)
ggmap(tmp)

qmap("hanalei", zoom = 14, source = "stamen", maptype = "watercolor")


geocode(location="02134")

qmap(location="02215", zoom=18)

# figure 3


geocode("boston university")
qmap("boston university", zoom=14)



# figure 4
set.seed(50)
df <- round(data.frame(
  x = jitter(rep(-71.05977, 40), amount = .3),
  y = jitter(rep( 42.35843, 40), amount = .3)
), digits = 2)
map <- get_googlemap('Boston', markers = df, path = df, scale = 1)
ggmap(map, extent = 'device')

# figure 5
qmap(baylor, zoom = 14, source = "stamen", maptype = "watercolor")
qmap(baylor, zoom = 14, source = "stamen", maptype = "toner")


paris <- get_map(location="paris")
str(paris)

# ggplot(aes(x = lon, y = lat), data = fourCorners) +
#   geom_blank() + coord_map("mercator") +
#   annotation_raster(ggmap, xmin, xmax, ymin, ymax)

# figure 7
ggmap(paris, extent = "normal")



# find a reasonable spatial extent
qmap('houston', zoom=13)
#gglocator(2)
# only violent crimes
violent_crimes <- subset(crime, offense != "auto theft" & offense != "theft" & offense != "burglary")
# order violent crimes
violent_crimes$offense <- factor(violent_crimes$offense, levels=c("robbery", "aggravated assault", "rape", "murder"))
# restrict to downtown
violent_crimes <- subset(violent_crimes, -95.39681 <= lon & lon <= -95.34188 & 29.73631 <= lat & lat <= 29.78400)

# figure 8
theme_set(theme_bw(16))
HoustonMap <- qmap("houston", zoom=14, color="bw")#, legend="topleft") # it's just like ggplot()
HoustonMap + geom_point(aes(x=lon, y=lat, colour=offense, size=offense), data=violent_crimes)
HoustonMap + stat_bin2d(aes(x=lon, y=lat, colour=offense, fill=offense), 
                        size=.5, 
                        bins=30, 
                        alpha=0.5, # transparency
                        data=violent_crimes)

# figure 9
houston <- get_map("houston", zoom=14)
HoustonMap + stat_density2d(aes(x=lon,y=lat,fill=..level.., alpha=..level..),
                            size=2, bins=4, data=violent_crimes,
                            geom="polygon")
overlay <- stat_density2d(aes(x=lon, y=lat, fill=..level.., alpha=..level..),
                          bins=4, geom="polygon",
                          data=violent_crimes)
HoustonMap + overlay + inset(grob=ggplotGrob(ggplot()+overlay+theme_inset()),
                             xmin=-95.35836, xmax=Inf, ymin=-Inf, ymax=29.75062)

# figure 10
houston <- get_map(location="houston", zoom=14, color="bw",
                   source="osm")
HoustonMap <- ggmap(houston, base_layer=ggplot(aes(x=lon,y=lat),
                                               data=violent_crimes))
HoustonMap + 
  stat_density2d(aes(x=lon,y=lat,fill=..level..,alpha=..level..),
                 bins=5, geom="polygon",
                 data=violent_crimes) +
  scale_fill_gradient(low="black", high="red") +
  facet_wrap(~day)

# ggmap's utility functions
geocode("baylor university", output="more")
gc <- geocode("boston university")
(gc <- as.numeric(gc))
revgeocode(gc)
revgeocode(gc, output="more")
from <- c("houston", "houston", "dallas")
to <- c("waco, texas", "san antonio", "houston")
mapdist(from, to)
###############################################################
map <- get_googlemap("02134", markers = df, scale = 4)
ggmap(map, extent = 'device')

geocode("Boston")
set.seed(50)
df <- round(data.frame(
  x = jitter(rep(-71.05977, 40), amount = .3),
  y = jitter(rep( 42.35843, 40), amount = .3)
), digits = 2)
map <- get_googlemap('Boston', markers = df, path = df, scale = 1)
ggmap(map, extent = 'device')

# Google's four type: terrain, satellite, roadmap, hybrid



# Both Stamen Maps and CloudMade Maps are built using OpenStreetMap data

#                                the ggmap function
# The one minor drawback to using
# CloudMade Maps is that the user must register with CloudMade to obtain an API key and then pass
# the API key into get_map with the api_key argument
paris <- get_map(location = "paris")
str(paris)
qmap(baylor, zoom = 14, maptype = 53428, api_key = api_key, source = "cloudmade") 
qmap("houston", zoom = 10, maptype = 58916, api_key = api_key, source = "cloudmade")

ggplot(aes(x = lon, y = lat), data = fourCorners) +
  geom_blank() + coord_map("mercator") +
  annotation_raster(ggmap, xmin, xmax, ymin, ymax)

# It accepts three possible strings: "normal" shown in Figure 7, "panel" shown in Figures 10 and
# 12, and "device" shown in every other figure.

# setting the limits of the plot panel to be the longitude and latitude extents of the map with
# scale_[x,y]_continuous(expand = c(0,0))

# base_layer, facet_wrap and facet_grid

ggmap(paris, extent = "device")

# The legend-related arguments of ggmap are legend and padding, only applicable
# when extent = "device" 

#                                ggmap in action
str(crime)

# gglocator , a ggplot2 analogue of base’s locator function exported from ggmap. 
# gglocator works not only for ggmap plots, but ggplot2 graphics in general.

# find a reasonable spatial extent
qmap('houston', zoom = 13)
gglocator(2)
# only violent crimes
violent_crimes <- subset(crime, 
                         offense != "auto theft" & offense != "theft" & offense != "burglary")
# order violent crimes
violent_crimes$offense <- factor(violent_crimes$offense,
                                 levels = c("robbery", "aggravated assault", "rape", "murder"))
# restrict to downtown
violent_crimes <- subset(violent_crimes,
                         -95.39681 <= lon & lon <= -95.34188 &
                           29.73631 <= lat & lat <= 29.78400)




clicks <- clicks <- gglocator(4)
box <- expand.grid(lon=clicks$lon, lat=clicks$lat)

