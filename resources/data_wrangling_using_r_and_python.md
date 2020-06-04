### R to python data wrangling snippets

I've been a great fan of the `dplyr` package in R. The beauty of `dplyr` is the limited number of functions or `verbs` (*as the R family loves to call them as*) it has, that can be used to solve relatively a diverse set of problems. 

While transitioning to Python, I've immensely missed the ease with which I could solve problems using dplyr in R. 
The purpose of this document is two fold, as given below:

1. To perform data manipulation using dplyr in R
2. To demonstrate how to execute the key dplyr verbs when manipulating data using pandas package in Python.

dplyr is organised around six key verbs:

----

- `filter`    : subset a dataframe according to condition(s) in a variable(s) 
- `select`    : choose a specific variable or set of variables 
- `arrange`   : order dataframe by index or variable 
- `group_by`  : create a grouped dataframe  
- `summarise` : reduce variable to summary variable (e.g. mean) 
- `mutate`    : transform dataframe by adding new variables 

---

The excellent pandas package in Python easily allows you to implement all of these actions (and much, much more!). Below are some snippets to highlight some of the more basic conversions. 

[@duttashish_](https://twitter.com/duttashish_)


*All of this code still works in pandas and should ease the transition from R, but for those interested in getting the most out of the package I strongly recommend this series on modern pandas https://tomaugspurger.github.io/modern-1-intro.html*

## Filter
R

    filter(df, var > 20000 & var < 30000) 
    filter(df, var == 'string') # df %>% filter(var != 'string')
    df %>% filter(var != 'string')
    df %>% group_by(group) %>% filter(sum(var) > 2000000)
    

Python

    df[(df['var'] > 20000) & (df['var'] < 30000)]
    df[df['var'] == 'string']
    df[df['var'] != 'string']
    df.groupby('group').filter(lambda x: sum(x['var']) > 2000000)
    

## Select
R

    select(df, var1, var2)
    select(df, -var3)
    

Python

    df[['var1', 'var2']]
    df.drop('var3', 1)
    
## Arrange
R

    arrange(df, var1)
    arrange(df, desc(var1))


Python

    df.sort_values('var1')
    df.sort_values('var1', ascending=False)
    
## Grouping 
R

    df %>% group_by(group) 
    df %>% group_by(group1, group2)
    df %>% ungroup()


Python

    df.groupby('group1')
    df.groupby(['group1', 'group2'])
    df.reset_index() / or when grouping: df.groupby('group1', as_index=False)

## Summarise / Aggregate df by group 
R

    df %>% group_by(group) %>% summarise(mean_var1 = mean(var1))
    df %>% 
      group_by(group1, group2) %>% 
      summarise(mean_var1 = mean(var1), 
    sum_var1 = sum(var1), 
    count_var1 = n())
      
    df %>% 
      group_by(group1, group2) %>% 
      summarise(mean_var1 = mean(var1),
    sum_2 = sum(var2),
    var3 = first(var3))
    
Python

    df.groupby('group1')['var1'].agg({'mean_col' : np.mean()}) # pass dict to specifiy column name
    
    df.groupby(['group1', 'group2'])['var1].agg(['mean', 'sum', 'count']) # for count also consider 'size'. size will return n for NaN values also, whereas 'count' will not.
    
    # first perform the aggregation
    group_agg = df.groupby(["group1", "group2"]).agg({
      "var1" : ["mean"], 
      "var2" : ["sum"], 
      "var3" : ["first"]
      })
    # second rename the columns by joining the column name with the agg function (e.g. "var1_mean")
    group_agg.columns = ["_".join(x) for x in group_agg.columns.ravel()]
    
    # You can also pass multiple functions to aggregate the same column e.g:
    group_agg = df.groupby(["group1", "group2"]).agg({"var1" : ["mean", "std", "sum"]})



## Mutate / transform df by group 
R


    df %>% group_by(group) %>% mutate(mean_var1 = mean(var1))

Python

    df.groupby('group').assign(mean_var1 = lambda x: np.mean(x.var1)


## Distinct
R

    df %>% distinct()
    df %>% distinct(col1) # returns dataframe with unique values of col1
    

Python

    df.drop_duplicates()
    df.drop_duplicates(subset='col1') # returns dataframe with unique values of col1

## Sample                
R

    sample_n(df, 100)
    sample_frac(df, 0.5)
   

Python

    df.sample(100)
    df.sample(frac=0.5)       
