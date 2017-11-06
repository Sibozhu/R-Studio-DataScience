library(openxlsx)


#writing data into xlsx file
for (i in 2001:2016) {
  YEAR = i
  load(paste0("./cleaned_data/ave_temp_",YEAR,".Rdata"))
  write.xlsx(data.output,file = "Sub_continent_West_data_"+YEAR,sheetName="Sheet1",colnames=TRUE,row.names=FALSE,append=FALSE,showNA=TRUE)
}
