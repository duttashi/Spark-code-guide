# Indian Foods dataset
# data source: https://www.kaggle.com/nehaprabhavalkar/indian-food-101

library(tidyverse)

# read the data
df<- read_csv(file = "data/kaggle_indian_food.csv", na=c("-1","","NA"))

# convert all character cols to factors
df<- df %>%
  mutate_if(is.character, factor)
str(df)

# Exploratory Data Analysis
## Data cleaning

# 1. split the ingredients column into separate cols
df<- df %>%
  separate(ingredients, into = c("ingr1","ingr2","ingr3","ingr4","ingr5","ingr6","ingr7","ingr8","ingr9","ingr10") ,sep = ",")
# 2. lowercase all column names
names(df)<- tolower(names(df))
colnames(df)

# 3. Check which columns has NA's
(lapply(lapply(df,is.na), table))

# 4. subset data where state, region, flavor profile are not missing
df1<- df %>%
  #filter(state!= NA & region!=NA)
  filter(!is.na(state) & !is.na(region) & !is.na(flavor_profile))%>%
  filter(!is.na(prep_time) & !is.na(cook_time))

# 3. Initial plots
# 3.1 proportion of dishes based on region
ggplot(data = df1, mapping = aes(x=region))+
  geom_bar()+
  theme_light()
# 3.2 proportion of dishes based on meal course
ggplot(data = df1, mapping = aes(x=course))+
  geom_bar()+
  theme_light()
# 3.3 proportion of flavor profiles based on meal course
ggplot(data = df1, mapping = aes(x=flavor_profile))+
  geom_bar()+
  theme_light()
# 3.4 proportion of dishes based on prep time
ggplot(data = df1, mapping = aes(x=flavor_profile,y=prep_time))+
  geom_boxplot()+
  theme_light()
# 3.5 proportion of dishes based on cook time
ggplot(data = df1, mapping = aes(x=flavor_profile,y=cook_time))+
  geom_boxplot()+
  theme_light()

# filter foods with prep and cook time greater than 30 minutes
df_high<- df1 %>%
  filter(prep_time>30 | cook_time>30)

ggplot(data = df_high, mapping = aes(x=flavor_profile,y=prep_time))+
  geom_boxplot()+
  theme_light()

# drop factor levels into smaller number of categories
df1$ing_grp <- NA
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"dough|Besan|flour|Flour|Rice flakes|maida|wheat|Rava|gourd|Vermicelli"),"flour",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"Palak|Mushrooms|dal|lentils|Chana|Chenna|Chhena|Chickpeas|Chole|beans|moong|peas|Urad"),"dal",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"Yoghurt|Yogurt"),"yogurt",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"ginger|Greens|onion|Carrots|Cucumber|Semolina|Cauliflower|Potato|finger|Bottle gourd|Bitter gourd|potatoes|Arbi|corn|Amaranth|Aloo|Gobi|Ridge gourd|pumpkin|chillies|mirch|tomato|tomatoes|chilli"),"vegetable",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"Milk|milk|cream|ghee|Ghee|paneer|Paneer|butter|dahi"),"milk_produce",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"bread|Bread"),"bread",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"soda|vinegar|syrup|Sugar|sugar|acid|jaggery|sauce|gur"),"baking_produce",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"meat|Chicken|chicken|Beef|Lamb"),"meat_produce",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"Apricot|fruits|Banana|banana|orange"),"fruit",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"oil"),"cooking_oil",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"masala|leaves|saffron"),"spices",df1$ing_grp)
df1$ing_grp<- ifelse(str_detect(df1$ingr1,"nuts"),"nuts",df1$ing_grp)

df1$ing_grp2 <- NA
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"dough|Besan|flour|Flour|Rice flakes|maida|wheat|Rava|gourd|Vermicelli"),"flour",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"Palak|Mushrooms|dal|lentils|Chana|Chenna|Chhena|Chickpeas|Chole|beans|moong|peas|Urad"),"dal",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"Yoghurt|Yogurt"),"yogurt",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"ginger|Greens|onion|Carrots|Cucumber|Semolina|Cauliflower|Potato|finger|Bottle gourd|Bitter gourd|potatoes|Arbi|corn|Amaranth|Aloo|Gobi|Ridge gourd|pumpkin|chillies|mirch|tomato|tomatoes|chilli"),"vegetable",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"Milk|milk|cream|ghee|Ghee|paneer|Paneer|butter|dahi"),"milk_produce",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"bread|Bread"),"bread",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"soda|vinegar|syrup|Sugar|sugar|acid|jaggery|sauce|gur"),"baking_produce",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"meat|Chicken|chicken|Beef|Lamb"),"meat_produce",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"Apricot|fruits|Banana|banana|orange"),"fruit",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"oil"),"cooking_oil",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"masala|leaves|saffron"),"spices",df1$ing_grp2)
df1$ing_grp2<- ifelse(str_detect(df1$ingr2,"nuts"),"nuts",df1$ing_grp2)

table(df1$ing_grp)
