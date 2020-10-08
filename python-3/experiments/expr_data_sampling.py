# -*- coding: utf-8 -*-
"""
Created on Thu Oct  8 13:01:58 2020

@author: Ashish
"""
# load required libraries
import pandas as pd
# create some dummy data
df = pd.DataFrame({'num_legs': [2, 4, 8, 0],
                   'num_wings': [2, 0, 0, 0],
                   'num_specimen_seen': [10, 2, 1, 8]},
                  index=['falcon', 'dog', 'spider', 'fish'])
print("## Original data ##\n",df)
# Sampling methods
# 1. Simple random sampling: Extract 3 random rows
print("\n Simple random sample")
print(df.sample(3, random_state=10))

# 1.1. Simple random sampling: Extract 3 random elements from the Series df['num_legs']
print("\n Simple random sample of particular column\n",df['num_legs'].sample(n=3, random_state=10))

print("\nA random 50% sample of the DataFrame with replacement:")
print(df.sample(frac=0.5, replace=True, random_state=10))

print("\nAn upsample sample of the DataFrame with replacement")
print(df.sample(frac=2, replace=True, random_state=10))

print("\nUsing a DataFrame column as weights. Rows with larger value in the num_specimen_seen column are more likely to be sampled.")
print(df.sample(n=2, weights='num_specimen_seen', random_state=10))

print("\nStratified Random Sampling")
print(df.groupby('num_legs', group_keys=False).apply(lambda x: x.sample(min(len(x), 2))))
