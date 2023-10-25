#This is a script to load data in R and call values

#The setwd() function allows to set a specific folder as your work directory
#This will allow you to ask R to read files from a specific folder more easily, rather than having to type the full file path each time ----

setwd("[C:/folder path]") #Be careful when you copy your folder path here, the separation symbols should be "/" not "\" !
getwd() #tells you what the current work directory is


#How to load CSV data in R ----
CSV_File=read.csv("[File Name].csv", sep = ";") #Loads a CSV file from your file directory, be careful at what separator your file uses, ";" or ","
View(CSV_File) #Views the CSV file you've loaded in a new tab of this pane

#How to load Xlsx data (Excel) in R ----
install.packages("readxl") #Installs the "Readxl" package
library(readxl)            #Loads the "Readxl" package
Xlsx_File= as.data.frame( read_excel("[File Name].xlsx"))  #Loads an Xlsx (Excel) file from your file directory and make it into a data frame
View(Xlsx_File) #Views the Xlsx file you've loaded in a new tab of this pane


#Shows a summary of each of the columns in the data frame ----
summary(Xlsx_File)


#How to call data within a data frame ----
#to call data within an object (vector, matrix, data frame etc.), you will usually use "[]" after the object you want to extract data from
Xlsx_File[1,]   #shows all the values from the 1st row, all  columns
Xlsx_File[,5]   #shows all the values from the 5th column, all  rows
#Be careful of the positioning of the comma! 
#A value BEFORE indicates rows, AFTER indicates columns

Xlsx_File[2,1]  #shows the 2nd value from the 1st column

Xlsx_File[,"Column name"] #Instead of using a column's number you can use its name. 
                          #It has to be exact so be careful of typos and capitalization!
Xlsx_File["Row name",]    #This can  also be done with row names, though it is rare for rows to have unique names 

Xlsx_File$Factor          #You can also call a column using "$" and the column's name. Does not work for rows