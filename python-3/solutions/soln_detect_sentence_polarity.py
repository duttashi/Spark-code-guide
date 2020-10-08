# -*- coding: utf-8 -*-
"""
Created on Wed Oct  7 20:10:13 2020

@author: Ashish
"""
import pandas as pd
import numpy as np
from textblob import TextBlob
data = {"Date":["1/10/2020","2/10/2020","3/10/2020","4/10/2020","5/10/2020"],
        "ID":[1,2,3,4,5],
        "Tweet":["I Hate Migrants",
                 "#trump said he is ok", "the sky is blue",
                 "the weather is bad","i love apples"]}
    # convert data to dataframe
df = pd.DataFrame(data)
# print(df)
df['sentiment'] = df['Tweet'].apply(lambda Tweet: TextBlob(Tweet).sentiment)
# print(df)

# split the sentiment column into two
df1=pd.DataFrame(df['sentiment'].tolist(), index= df.index)

# append cols to original dataframe
df_new = df
df_new['polarity'] = df1['polarity']
df_new.polarity = df1.polarity.astype(float)
df_new['subjectivity'] = df1['subjectivity']
df_new.subjectivity = df1.polarity.astype(float)
# print(df_new)

# add label to dataframe based on condition
conditionList = [
    df_new['polarity'] == 0,
    df_new['polarity'] > 0,
    df_new['polarity'] < 0]
choiceList = ['neutral', 'not_fake', 'fake']
df_new['label'] = np.select(conditionList, choiceList, default='no_label')
print(df_new)
df_new.to_csv("polarity_sent.csv")
