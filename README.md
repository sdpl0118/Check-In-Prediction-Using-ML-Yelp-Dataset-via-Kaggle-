# Yelp Check-In Prediction Using ML (Yelp Dataset via Kaggle)

**Notes**

- Original R Script developed by: [Sai Kiran Reddy](https://www.linkedin.com/in/saikiran1003/) , [Ho Tai Peter Law](https://www.linkedin.com/in/ho-tai-peter-law-53262048/) (Myself), [Keena Desai](https://www.linkedin.com/in/keena-desai-15849289/), [Crystal Li](https://www.linkedin.com/in/jiawen-crystal-li/), and [Yash Kanoongo](https://www.linkedin.com/in/yashkanoongo/)

- Team report and analysis is available on Medium via ["Predicting Attributes Influencing User Engagement on Yelp"](https://medium.com/@yashkanoongo/yelp-engagement-bbd9cb1ce2c9) 

- The orginal dataset from Yelp can be found [here](https://www.kaggle.com/yelp-dataset/yelp-dataset?select=yelp_academic_dataset_checkin.json)

- Original code completed on: Aug 23, 2019

- Modified by myself on: Aug 04, 2020

(Note: As a 4-year Yelp Elite myself, I simply can't say "no" to the opportunity to have some fun with a platform that I have constantly been engaging with. If you are interested in my reviews, please feel free to check it out [here](https://www.yelp.com/user_details?userid=7jnvMS6BA3e91B--nzPcPg))

**Goal**

- To Understand the influence of available independent variables within the dataset on the dependent variables (Check-Ins, in this case, user engagement) for our targeted location, Toronto.

**Exploratory Analysis & Data Preparation**

After removing irrelevant and missing data, the remaining variables had been bucketed into the four following categories: 
- Yelp Engagement Metrics (eg: Check-Ins, Compliments, Reviews)
- Business categories (eg: Bakeries, Coffee, Bars)
- Business Attributes (eg: Free Wi-Fi, Delivery, Price)
- General Descriptors (eg: Post Code)

*Graphic Examples of the Exploratory Analysis using "ggplot2" Package*

<img src="Graphs/Key%20Factor%20Correlation%20Exploratory%20Analysis.png" Width=400 Height=370>

<img src="Graphs/Diner%20Expenses%20vs%20Number%20of%20CheckIns.png" Width=400 Height=310>

<img src="Graphs/Number%20of%20Reviews%20vs%20CheckIn.png" Width=400 Height=310>

<img src="Graphs/Stars%20vs%20CheckIn%20Correlation%20Exploratory%20Analysis.png" Width=400 Height=310>

**Modeling**

Base Model: Built based on the popularity/recognition the business had
- *Predicted(Check-Ins)* = stars + compliment_count + review_count)
- R-Square = 0.7123, AIC = 19359.94

Intuitive Variable Selection based on Business Understanding (featuring popular categories, represented by 0 or 1):
- Model 1: 
    - *Predicted(Check-Ins)* = as.factor(RestaurantsTableService) + as.factor(OutdoorSeating) + as.factor(Bars) + as.factor(PriceRange2) + **compliment_count** + as.factor(RestaurantsTakeOut) + as.factor(FreeWiFi) + as.factor(Desserts) + review_count + as.factor(RestaurantsDelivery) + as.factor(CoffeeTea) + as.factor(IceCream) + as.factor(Shopping)
    - R-Square = 0.7134, AIC = 19200.62

- Model 2: 
    - *Predicted(Checkins)* = as.factor(HasTV) + as.factor(Bars) + as.factor(PriceRange2) + **compliment_count** + as.factor(RestaurantsDelivery) + as.factor(FreeWiFi) + as.factor(Desserts) + UserExp + as.factor(IceCream)+ as.factor(Shopping)
    - R-Square = 0.7885, AIC = 18703.91

Forward selection:
- *Predicted(Check-Ins)* = review_count + UserExp + compliment_count + as.factor(FreeWiFi) + as.factor(HasTV) + as.factor(Bars) + as.factor(PriceRange2) + as.factor(RestaurantsDelivery) + as.factor(Desserts) + as.factor(CoffeeTea) + as.factor(IceCream) + as.factor(Shopping)
- R-Square = 0.7947, AIC = 18642.53

Backward selection:
- *Predicted(Check-Ins)* = as.factor(Sandwiches) + as.factor(Chinese) + as.factor(Pubs) + as.factor(EthnicFood)+ as.factor(Japanese) + as.factor(Bakeries) + as.factor(HasTV) + as.factor(Bars) + as.factor(PriceRange2) + compliment_count + as.factor(RestaurantsDelivery) + as.factor(FreeWiFi) + as.factor(Desserts) + review_count + as.factor(CoffeeTea) + as.factor(IceCream) + as.factor(Shopping) + UserExp
- R-Square = 0.797, AIC = 18624.26

**Model Evaluation**
- Despite having higher R^2, the forward selection model and backward selection model are both out of context. The backward selection model kept many variables to maintain its relatively high R^2 while both models kept two both highly correlative and interactive variables within the model at the same time (UserExp & review_count). Hence, the second intuitive model is recommended for actual use.
