data <- readLines("VOSClim_GTS_apr_2001.txt")

df <- NULL
for (i in 1:length(data)) {
  tmp <- data[i]
  subtmp <- paste0(substr(tmp, 1, 21), substr(tmp, 69, 73), substr(tmp, 84, 89))
  df <- rbind(df, subtmp)
}

data.clean <- read.fwf(textConnection(df), widths=c(4,2,2,4,5,4,1,4,2,4))
names(data.clean) <- c("YR", "MO", "DY", "HR", "LAT", "LON", "IT", "AT", "SI", "SST")

