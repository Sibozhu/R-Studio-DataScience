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
mean(products$bottle_size)
min(products$bottle_size)
max(products$bottle_size)


###################### focus on SALES table! ######################
# how many rows are we dealing with?
dbGetQuery(con, statement = "
           SELECT count(*)
           FROM sales
           ")


# what are the unique categories? this query may take some time
dbGetQuery(con, statement = "
           SELECT DISTINCT category_name
           FROM sales
           WHERE category_name IS NOT NULL
           ")


# how many unique items are there? this query may also take some time
dbGetQuery(con, statement = "
           SELECT COUNT(DISTINCT category_name)
           FROM sales
           ")


# what are the unique counties?
dbGetQuery(con, statement = "
SELECT DISTINCT county
FROM sales
           ")


# how many vendors are there per county? 
dbGetQuery(con, statement = "
SELECT county, count(vendor) as n_vendor
FROM sales
GROUP BY county
ORDER BY 2 DESC
           ")

# top 5: polk, linn, scott, black hawk, johnson

# how many stores are there per county? are the top 5 the same as above query?
dbGetQuery(con, statement = "
SELECT county, count(store) as n_store
           FROM sales
           GROUP BY county
           ORDER BY 2 DESC
           ")
# there's a null, you may want to remove that by including a WHERE statement. 
# and YES top 5 is the same as abov equery

#################### JOIN SALES + COUNTIES TABLE #################### 
# what are the top 10 most populated counties along with their... 
## average sales [sales.total] as sales
## number of stores [count(sales.store)] as n_stores

data <- dbGetQuery(con, statement = "
SELECT sales.county, counties.population, avg(sales.total) as total_sales, 
       count(sales.store) as n_stores
FROM sales
LEFT JOIN counties
ON sales.county = counties.county
WHERE sales.county is not null
GROUP BY 1,2
ORDER BY 2 DESC
LIMIT 10
                   ")

# dbGetQuery(con, statement = "SELECT * FROM counties LIMIT 5;")


# visually represent population by county
ggplot(data, aes(county, population)) +
  geom_bar(stat="identity", fill="#E8BCB9")

# reorder bars so it's ranked by population, flip the axis
ggplot(data, aes(reorder(county, population), population)) +
  geom_bar(stat="identity", fill="#E8BCB9") +
  coord_flip()