# Check-In Prediction Using ML (Yelp Dataset via Kaggle)

**Notes**

- Original R Script developed by: [Sai Kiran Reddy](https://www.linkedin.com/in/saikiran1003/) , [Ho Tai Peter Law](https://www.linkedin.com/in/ho-tai-peter-law-53262048/) (Myself), [Keena Desai](https://www.linkedin.com/in/keena-desai-15849289/), [Crystal Li](https://www.linkedin.com/in/jiawen-crystal-li/), and [Yash Kanoongo](https://www.linkedin.com/in/yashkanoongo/)

- Team report and analysis is avalible on Medium via ["Predicting Attributes Influencing User Engagement on Yelp"](https://medium.com/@yashkanoongo/yelp-engagement-bbd9cb1ce2c9) 

- Original code completed on: Aug 23, 2019

- Modified by myself on: Aug 04, 2020

(Note: As a 4-year Yelp Elite myself, I simply can't say "no" to the opportunity to have some fun with a platform that I have been constantly engaging with. If you are interested in my reviews, please feel free to check it out [here](https://www.yelp.com/user_details?userid=7jnvMS6BA3e91B--nzPcPg))

**Goal**

- To Understand the influence of avalible independent variables within the dataset on the dependent varaible (Check-Ins, in this case, user engagement) for our targeted location, Toronto.

**Exploratory Analysis & Data Preparation**

After removing irrelavent and missing data, the remaining variables had been bucketed into the four following catagories: 
- Yelp Engagement Metrics (eg: Check-Ins, Compliments, Reviews)
- Business categories (eg: Bakeries, Coffee, Bars)
- Business Attributes (eg: Free Wi-Fi, Delivery, Price)
- General Descriptors (eg: Post Code)
