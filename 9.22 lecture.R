library(tidyverse)

library(nycflights13)

?nycflights13

flights

starwars

filter(starwars,species=="Human")
filter(starwars,mass > 1000)

arrange(mtcars,cyl,disp)
arrange(mtcars,desc(disp))

