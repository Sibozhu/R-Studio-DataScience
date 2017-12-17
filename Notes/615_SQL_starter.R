library(RPostgreSQL)
library(ggplot2)

### order of SQL queries
# SELECT
# FROM
# JOIN (if you are joining)
# WHERE (if you have condition, ex: colname IS NOT NULL)
# GROUP BY (if you need a group by -- aggregate function as well as other cols in select)
# HAVING (if you have a condition on aggregate function)
# ORDER BY 
# LIMIT (limit the number of rows that appear in output)


###################### SQL SET UP ######################

# db details
host <- "analyticsga-east2.c20gkj5cvu3l.us-east-1.rds.amazonaws.com"
port <- "5432"
username <- "analytics_student"
password <- "analyticsga"

# name of specific database you will access
# dbname <- "nyc_taxi_trips_database"
dbname <- "iowa_liquor_sales_database"

# specify the PostreSQL driver
drv <- dbDriver("PostgreSQL")

#  establish the connection
con <- dbConnect(drv, user = username, password = password,
                 dbname = dbname, port = port, host = host)




###################### DATA EXPLORATION ######################

# explore tables within the database
dbListTables(con)

# column names in tables
dbListFields(con, "products")
dbListFields(con, "stores")
dbListFields(con, "counties")
dbListFields(con, "sales")

# first 10 rows in each table
dbGetQuery(con, statement = "SELECT * FROM products LIMIT 10;")
dbGetQuery(con, statement = "SELECT * FROM stores LIMIT 10;")
dbGetQuery(con, statement = "SELECT * FROM counties LIMIT 10;")
dbGetQuery(con, statement = "SELECT * FROM sales LIMIT 10;")

# you can save output of query into df, and do whatever you want in R!
products <- dbGetQuery(con, statement = "SELECT * FROM products;")
View(products)



###################### focus on SALES table! ######################
# how many rows are we dealing with?
dbGetQuery(con, statement = "
           
           ")


# what are the unique categories?
dbGetQuery(con, statement = "
           
           ")


# how many unique items are there?
dbGetQuery(con, statement = "
           
           ")


# what are the unique counties?
dbGetQuery(con, statement = "
           
           ")


# how many vendors are there per county? 
dbGetQuery(con, statement = "
           
           ")

# top 5: 


# how many stores are there per county? are the top 5 the same as above query?
dbGetQuery(con, statement = "
           
           ")


#################### JOIN SALES + COUNTIES TABLE #################### 
# what are the top 10 most populated counties along with their... 
## average sales [sales.total] as sales
## number of stores [count(sales.store)] as n_stores
data <- dbGetQuery(con, statement = "

                   ")



# visually represent population by county
ggplot(data, aes(county, population)) +
  geom_bar(stat="identity", fill="#E8BCB9")
# reorder bars so it's ranked by population, flip the axis



# potential next step: do the same for sales/n_stores and/or  
# explore relationships between variables



#################### NEXT STEPS: NEW DB #################### 
# time to explore a new database!
# db details
host <- "analyticsga-east2.c20gkj5cvu3l.us-east-1.rds.amazonaws.com"
port <- "5432"
username <- "analytics_student"
password <- "analyticsga"
dbname <- "nyc_taxi_trips_database"
drv <- dbDriver("PostgreSQL")

#  establish the connection
con <- dbConnect(drv, user = username, password = password,
                 dbname = dbname, port = port, host = host)




# explore tables within the database
dbListTables(con)

# explore column names in each table
dbListFields(con, "trip_data")
dbListFields(con, "trip_fares")



#################### DATA EXPLORATION #################### 
# explore trip_data
dbGetQuery(con, statement = "SELECT * FROM trip_data LIMIT 10")


# get number of rows
dbGetQuery(con, statement = "
           
           ")


# get average trip time
# in seconds
dbGetQuery(con, statement = "
           
           ")


# in minutes
dbGetQuery(con, statement = "
           
           ")


# explore trip_fares
dbGetQuery(con, statement = "SELECT * FROM trip_fares LIMIT 10")


# get number of transactions/trips for each payment type [order by payment_type descending]
dbGetQuery(con, statement = "
           
           ")


# "CRD" -- card, debit or credit
# "CSH" -- cash
# "DIS" -- disputed fare 
# "NOC" -- no charge
# "UNK" -- unknown


# average total_amount by payment_type
dbGetQuery(con, statement = "
           
           ")


# average tip_amount by payment_type
dbGetQuery(con, statement = "
           
           ")