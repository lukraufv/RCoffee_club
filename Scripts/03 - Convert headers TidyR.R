#This is a script to prepare data with headers and column in data for R

#Installs and loads the "tidyr" package ----
install.packages("tidyr")
library(tidyr)

#Loads your data in R (from the work directory -or wd for short- folder, 
#to check what your current wd is, use getwd() ----
Data=read.csv("[File Name].csv",sep=",") #Remember to change the separator depending on if your CSV uses "," or ";"
View(Data) #Views the CSV file you've loaded in a new tab of this pane


#Converts the column heads in one variable, repeated for each row of the first column ----
Data_transformed=pivot_longer(Data,             #The data to be transformed
                              cols=2:dim(Data)[2],  #The columns to have their header combined. 
                                                    #The dim(Data)[2] gives the total number of columns in the dataset, assuming the headers to be transformed are from column 2 all the way to the end of the table
                              names_to = "Column Headers variable",#The name of the column the headers will be combined into
                              values_to = "Variable values")  #The name of the column the values will be combined into

View(Data_transformed) #Views the transformed file with the headers in a single column