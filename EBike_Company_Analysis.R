library(DBI)
library(tidyr)
library(dplyr)
library(esquisse)
library(dplyr)
library(RSQLite)
library(tidyr)
library(ggplot2)
library(lubridate)

options("esquisse.display.mode" = "browser")
options("esquisse.display.mode" = "dialog")

setwd("~/DB_Directory")
sqlite <- dbDriver("SQLite")
conn <- dbConnect(sqlite,"Divvy")


dbListTables(conn)
dbListObjects(conn)

Divvy_df <- dbReadTable(conn,"Divvy_Trips_2019")

res <- dbSendQuery(conn,
"SELECT * 
FROM Divvy_Trips_2019
LIMIT 1000;")
dbFetch(res)
res1 <- dbReadTable(res,"Divvy_Trips_2019")

head(Divvy_df)
colnames(Divvy_df)
str(Divvy_df)
summary(Divvy_df)
nrow(Divvy_df)
dim(Divvy_df)


Divvy_df <-  Divvy_df %>% 
  mutate(usertype = recode(Divvy_df$usertype,"Subscriber" = "member","Customer" = "casual"))

table(Divvy_df$usertype)

# Add columns that list the date, month, day, and year of each ride
# This will allow us to aggregate ride data for each month, day, or year ... before completing these operations we could only aggregate at the ride level
# https://www.statmethods.net/input/dates.html more on date formats in R found at that link
Divvy_df$date <- as.Date(Divvy_df$start_time) #The default format is yyyy-mm-dd
Divvy_df$month <- format(as.Date(Divvy_df$date), "%m")
Divvy_df$day <- format(as.Date(Divvy_df$date), "%d")
Divvy_df$year <- format(as.Date(Divvy_df$date), "%Y")
Divvy_df$day_of_week <- format(as.Date(Divvy_df$date), "%A")

Divvy_df$tripduration <- difftime(Divvy_df$end_time,Divvy_df$start_time)


is.factor(Divvy_df$tripduration)
Divvy_df$tripduration <- as.numeric(as.character(Divvy_df$tripduration))
is.numeric(Divvy_df$tripduration)

Divvy_df_v2 <- Divvy_df[!(Divvy_df$start_time == "HQ QR" | Divvy_df$tripduration<0),]

head(Divvy_df_v2)

# Descriptive analysis on tripduration (all figures in seconds)
mean(Divvy_df_v2$tripduration) #straight average (total ride length / rides)
median(Divvy_df_v2$tripduration) #midpoint number in the ascending array of ride lengths
max(Divvy_df_v2$tripduration) #longest ride
min(Divvy_df_v2$tripduration) #shortest ride

summary(Divvy_df_v2$tripduration)

# Compare members and casual users
aggregate(Divvy_df_v2$tripduration ~ Divvy_df_v2$usertype, FUN = mean)
aggregate(Divvy_df_v2$tripduration ~ Divvy_df_v2$usertype, FUN = median)
aggregate(Divvy_df_v2$tripduration ~ Divvy_df_v2$usertype, FUN = max)
aggregate(Divvy_df_v2$tripduration ~ Divvy_df_v2$usertype, FUN = min)

colnames(Divvy_df_v2)
table(Divvy_df_v2$day_of_week)

# See the average ride time by each day for members vs casual users
aggregate(Divvy_df_v2$tripduration ~ Divvy_df_v2$usertype + Divvy_df_v2$day_of_week, FUN = mean)

# Notice that the days of the week are out of order
Divvy_df_v2$day_of_week <- ordered(Divvy_df_v2$day_of_week, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

#  run the average ride time by each day for members vs casual users
aggregate(Divvy_df_v2$tripduration ~ Divvy_df_v2$usertype + Divvy_df_v2$day_of_week, FUN = mean)


# analyze ridership data by type and weekday
Divvy_df_v2 %>% 
  mutate(weekday = wday(start_time, label = TRUE)) %>%  #creates weekday field using wday()
  group_by(usertype, weekday) %>%  #groups by usertype and weekday
  summarise(number_of_rides = n()							#calculates the number of rides and average duration 
            ,average_duration = mean(tripduration)) %>% 		# calculates the average duration
  arrange(usertype, weekday)								# sorts

# Let's visualize the number of rides by rider type
Divvy_df_v2 %>% 
  mutate(weekday = wday(start_time, label = TRUE)) %>% 
  group_by(usertype, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(tripduration)) %>% 
  arrange(usertype, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = usertype)) +
  geom_col(position = "dodge")


# Let's create a visualization for average duration
Divvy_df_v2 %>% 
  mutate(weekday = wday(start_time, label = TRUE)) %>% 
  group_by(usertype, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(tripduration)) %>% 
  arrange(usertype, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = usertype)) +
  geom_col(position = "dodge")






