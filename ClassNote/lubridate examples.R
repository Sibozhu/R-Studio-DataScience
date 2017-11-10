## use the lubridate libary to support data and time calculations

library(lubridate)

# convert strings into objects you can use for calculations

x <- ymd("2012-03-26")
y <- ymd("2012-04-02")


x-y



t2 <- make_datetime(year = 2017, month = 8, day = 20, hour = 10, tz = "UTC")

t1 <- make_datetime(year = 2017, month = 8, day = 20, hour = 10, tz = "EST")

# automatic tz adjustment
t1 - t2




z <- mdy("july 4, 2012")

z1 <- mdy("july 20, 2012")

z1 - z

yr <- "2017"
mo1 <- "August"
mo2 <- "July"
day1 <- "20"
day2 <- "3"
hour <- "10:00"

c1 <- paste(mo1,day1,yr)

z2 <- mdy(c1)
z1-z2

# assign a time to data object z
z

hour(z) <- 3

z

# and assign any timezone
z.shanghai <- force_tz(z, tzone = "asia/shanghai")

# list of timezones at 
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

z.kolkata <- force_tz(z, tzone = "asia/kolkata")
z.midway <- force_tz(z, tzone = "pacific/midway")

