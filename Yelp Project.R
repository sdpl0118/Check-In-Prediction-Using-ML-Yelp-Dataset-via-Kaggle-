#Import dataset
data = read.csv("D:/Yelp Data project/newrestaurantsdata.csv")

#Check the data
head(data)

install.packages('ggplot2')
install.packages('tidyverse')
library(ggplot2)
library(tidyverse)
install.packages('dplyr')
install.packages('stringr')
library(dplyr)
library(stringr)
install.packages('jsonlite')
install.packages('tidyverse')
install.packages('rjson')
library(rjson)
library(jsonlite)
install.packages('plyr')
library(plyr)
install.packages("leaflet")
library(leaflet)
install.packages("GGally")
library(GGally)

basemap <- addTiles(leaflet())
torontofoodmap <- addCircleMarkers(setView(basemap, lng=-79, lat=43,zoom = 14), lng = data$longitude, lat = data$latitude, radius = 1, fillOpacity = 6, color = "purple")

#matrix of scatter plots for visualizing the correlation between variables
ggpairs(data %>% select(checkins,review_count,stars,compliment_count))

# various graphs for exploratory data analysis 
ggplot(data,aes(x=stars,y=checkins))+geom_point(color = "blue")+facet_wrap(~PricingRange)+labs(title="Stars vs Check Ins By Price Range")
ggplot(data,aes(x=PricingRange,y=checkins))+geom_col(color = "blue")+labs(title="Price Range vs Check Ins")
ggplot(data, aes(x=factor(FreeWiFi), y=checkins)) + geom_col(aes(group=factor(FreeWiFi),color="red"))
ggplot(data,aes(x=UserExp, y=checkins))+geom_point()
ggplot(data,aes(x=as.factor(Simplified_PostalCode), y=checkins))+ geom_col()+labs(x="Postal Code",y="Check Ins",title="Check Ins by Postal Code")
ggplot(data,aes(x=as.factor(Simplified_PostalCode), y=checkins))+ geom_col(fill = "blue") +
  labs(title = "Postal Code vs Checkins", y = "checkins",x= "Postal Code") +
  theme(plot.title = element_text(hjust = 0.5))
ggplot(data,aes(x=stars,y=checkins))+geom_point(color = "blue")+facet_wrap(~PricingRange)+labs(title="Stars vs Check Ins By Price Range")

#Scatter Plot of User Exp vs Check-ins
ggplot(data, aes(x=data$checkins, y = data$UserExp, color = data$UserExp))+ geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "User Exp vs Checkins", x = "checkins",y= "UserExp") +
  theme(plot.title = element_text(hjust = 0.5))

#Boxplot of Check-ins vs Price Range
ggplot(data, aes(x=as.factor(data$PricingRange), y = data$checkins))+ geom_boxplot(col = "blue") +
  labs(title = "Checkins vs Price Range by S", y = "checkins",x= "Price Range") +
  theme(plot.title = element_text(hjust = 0.5))

#Scatter Plot of Review Count vs Check-ins
ggplot(data, aes(x=data$checkins, y = data$review_count, color = data$review_count))+ geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Review Count vs Checkins", x = "checkins",y= "Review Count") +
  theme(plot.title = element_text(hjust = 0.5))

#Histogram of Check-ins vs Postal Code
ggplot(data,aes(x=as.factor(Simplified_PostalCode), y=checkins))+ geom_col(fill = "blue") +
  labs(title = "Checkins vs Postal Code", y = "checkins",x= "Postal Code") +
  theme(plot.title = element_text(hjust = 0.5))

#-----------------------------------------Modeling----------------------------------------------------------

#Base Model

basefit = lm(checkins~stars+compliment_count+review_count, data)
summary(basefit)
step(basefit)

#----------------------------------------------------------------------------------------------------------

#Intuitive Models

intuitivefit1 = lm(checkins~as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups)+as.factor(OutdoorSeating)+as.factor(DaysOpen)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(Lounges)+compliment_count+as.factor(RestaurantsTakeOut)+as.factor(RestaurantsDelivery)+as.factor(FreeWiFi)+as.factor(Desserts)+review_count+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping)+as.factor(Beer)+as.factor(Wine)+as.factor(fullbar), data)
summary(intuitivefit1)
step(intuitivefit1)

step_intuitivefit1 = lm(formula = checkins ~ as.factor(RestaurantsTableService) + 
                          as.factor(OutdoorSeating) + as.factor(Bars) + as.factor(PriceRange2) + 
                          compliment_count + as.factor(RestaurantsTakeOut) + as.factor(RestaurantsDelivery) + 
                          as.factor(FreeWiFi) + as.factor(Desserts) + review_count + 
                          as.factor(CoffeeTea) + as.factor(IceCream) + as.factor(Shopping), 
                        data = data)

summary(step_intuitivefit1)

intuitivefit2 = lm(checkins~as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups)+as.factor(OutdoorSeating)+as.factor(DaysOpen)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(Lounges)+compliment_count+as.factor(RestaurantsTakeOut)+as.factor(RestaurantsDelivery)+as.factor(FreeWiFi)+as.factor(Desserts)+UserExp+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping)+as.factor(Beer)+as.factor(Wine)+as.factor(fullbar), data)
summary(intuitivefit2)
step(intuitivefit2)

step_intuitivefit2 = (lm(formula = checkins ~ as.factor(HasTV) + as.factor(Bars) + 
                           as.factor(PriceRange2) + compliment_count + as.factor(RestaurantsDelivery) + 
                           as.factor(FreeWiFi) + as.factor(Desserts) + UserExp + as.factor(IceCream) + 
                           as.factor(Shopping), data = data))

summary(step_intuitivefit2)

#----------------------------------------------------------------------------------------------------------

#Manual Forward Selection - AIC

fit = lm(checkins~review_count+compliment_count+stars, data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count, data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(RestaurantsTableService), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups)+as.factor(OutdoorSeating), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups)+as.factor(OutdoorSeating)+as.factor(DaysOpen), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups)+as.factor(OutdoorSeating)+as.factor(HasTV), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(RestaurantsTableService)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(Lounges), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsTakeOut), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(OutdoorSeating)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts)+as.factor(CoffeeTea), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts)+as.factor(CoffeeTea)+as.factor(IceCream), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts)+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts)+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping)+as.factor(Beer), data)
summary(fit)
step(fit)

fit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts)+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping)+as.factor(Wine), data)
summary(fit)
step(fit)

forwardfit = lm(checkins~review_count+UserExp+compliment_count+as.factor(FreeWiFi)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(RestaurantsDelivery)+as.factor(Desserts)+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping)+as.factor(fullbar), data)
summary(forwardfit)
step(forwardfit)

step_forwardfit = lm(formula = checkins ~ review_count + UserExp + compliment_count + 
                       as.factor(FreeWiFi) + as.factor(HasTV) + as.factor(Bars) + 
                       as.factor(PriceRange2) + as.factor(RestaurantsDelivery) + 
                       as.factor(Desserts) + as.factor(CoffeeTea) + as.factor(IceCream) + 
                       as.factor(Shopping), data = data)


summary(step_forwardfit)

#----------------------------------------------------------------------------------------------------------

#Automatic Backward Selection - AIC

fit1 = lm(checkins~as.factor(Caters)+as.factor(GoodForKids)+as.factor(Sandwiches)+as.factor(Breakfast)+as.factor(Chinese)+as.factor(Burgers)+as.factor(American)+as.factor(Cafes)+as.factor(Canadian)+as.factor(Juice)++as.factor(Pubs)+as.factor(EthnicFood)+as.factor(Japanese)+as.factor(SushiBars)+as.factor(FastFood)+as.factor(Bakeries)+as.factor(RestaurantsTableService)+as.factor(RestaurantsGoodForGroups)+as.factor(OutdoorSeating)+as.factor(DaysOpen)+as.factor(HasTV)+as.factor(Bars)+as.factor(PriceRange2)+as.factor(Lounges)+compliment_count+as.factor(RestaurantsTakeOut)+as.factor(RestaurantsDelivery)+as.factor(FreeWiFi)+as.factor(Desserts)+review_count+as.factor(CoffeeTea)+as.factor(IceCream)+as.factor(Shopping)+as.factor(Beer)+as.factor(Wine)+as.factor(fullbar)+UserExp, data)
step(fit1)
summary(fit1)


backwardfit = lm(formula = checkins ~ as.factor(Sandwiches) + as.factor(Chinese) + 
                   as.factor(Pubs) + as.factor(EthnicFood) + as.factor(Japanese) + 
                   as.factor(Bakeries) + as.factor(HasTV) + as.factor(Bars) + 
                   as.factor(PriceRange2) + compliment_count + as.factor(RestaurantsDelivery) + 
                   as.factor(FreeWiFi) + as.factor(Desserts) + review_count + 
                   as.factor(CoffeeTea) + as.factor(IceCream) + as.factor(Shopping) + 
                   UserExp, data = data)

summary(backwardfit)

#----------------------------------------------------------------------------------------------------------

