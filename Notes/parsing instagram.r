require(httr)
full_url <- oauth_callback()
full_url <- gsub("(.*localhost:[0-9]{1,5}/).*", x=full_url, replacement="\\1")
print(full_url)

library(jsonlite)
library(RCurl)
library(instaR)
# devtools::install_github("pablobarbera/instaR/instaR")

######################## authorize and get token ########################

app_name <- "test615"
client_id <- "1e4e577aac6c4c7197595dd3f95301ca"
client_secret <- "bdf5949cc2304efcae5cebbb6435bafd"
scope = "public_content"

instagram <- oauth_endpoint(
  authorize = "https://api.instagram.com/oauth/authorize",
  access = "https://api.instagram.com/oauth/access_token")
myapp <- oauth_app(app_name, client_id, client_secret)
ig_oauth <- oauth2.0_token(instagram, myapp,scope="basic",  type = "application/x-www-form-urlencoded",cache=FALSE)
tmp <- strsplit(toString(names(ig_oauth$credentials)), '"')
token <- tmp[[1]][4]
token

########################## parse owner's profile ##########################

# instagram endpoints: 
# https://www.instagram.com/developer/endpoints/

# entering these links in browser
# https://api.instagram.com/v1/users/self/?access_token=230831693.1e4e577.810bba799931498584ff3e97db319b49
# https://api.instagram.com/v1/users/self/media/recent/?access_token=230831693.1e4e577.810bba799931498584ff3e97db319b49

owner_info <- paste('https://api.instagram.com/v1/users/self/?access_token=',token,sep="")
data <- getURL(owner_info)
json <- fromJSON(data)

recent_media <- paste('https://api.instagram.com/v1/users/self/media/recent/?access_token=',token,sep="")
data <- getURL(recent_media)
json <- fromJSON(data)


######################## with package "instaR" ########################

instaOAuth(client_id, client_secret, scope)
my_oauth <- instaOAuth(app_id=client_id, app_secret=client_secret)
save(my_oauth, file="my_oauth")
load("my_oauth")

maine <- searchInstagram(tag="maine", token=my_oauth)
media <- getUserMedia("starlettscarlet", token= my_oauth, n = 9)


# devtools::install_github('rCharts', 'ramnathv')
library(rCharts)
m <- mPlot(x = "created_time", y = c("comments_count", "likes_count"), type = "Line", data = media)
m






