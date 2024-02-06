#Creating a data frame----
  x=c(1,1,1,1)
  y=c(2,3,4,5) #Creates 2 vectors

  Grid_A=cbind(x,y) #cbind() creates a matrix combining the two vectors as columns, 
                    #in the order they are listed
  Grid_A
  Grid_B=rbind(x,y) #rbind() creates a matrix combining the two vectors as rows, 
                    #in the order they are listed
  Grid_B

  Dataframe_A=data.frame(x,y)
  Dataframe_A #data.frame() function works the same way as cbind! 
              #Combines vectors as columns in the order they are listed

#Column and Rows operations----
#For the rest of the script, I will use the mtcars dataset, which is available in default R
  data("mtcars")
  head(mtcars) #The head() function gives you the first few rows to show you the column names and general structure

  colnames(mtcars) #Gives a vector with all the column names
  colnames(mtcars)[2] #To ask for a specific column name, use the column number in brackets

  rownames(mtcars) #Gives a vector with all the row names
  rownames(mtcars)[2] #To ask for a specific row name, use the row number in brackets

#colnames() can be used to assign new names to your columns
  renamed_mtcars=mtcars
  colnames(renamed_mtcars)
  colnames(renamed_mtcars)=c("Miles/Gallon","cylinders","displacement","horse_power","axle_ratio","weight","1/4_mile_time","Engine","Transmission","Gears","Carburators")
  colnames(renamed_mtcars)

#rownames() can be used to assign new names to your rows
  rownames(renamed_mtcars)
  rownames(renamed_mtcars)=c(1:32)
  rownames(renamed_mtcars)

#Navigating values in data frames----
#Formula to extract values from tables/Data frames is: Dataframe[Row,Column]
  mtcars[1,1] #Value of the 1st row, 1st column
  mtcars[1,2] #Value of the 1st row, 2nd column
  mtcars[2,1] #Value of the 2nd row, 1st column

#Works also with the text name of the column/row, but needs to be in " "
  mtcars["Mazda RX4","mpg"]
  mtcars["Mazda RX4","cyl"]
  mtcars["Honda Civic","mpg"]

#You can ask for all the values of a given row or column by leaving the other term empty
#But you still need to have the comma, even if you are only typing one value in the []

  mtcars["Mazda RX4"]#Comma missing, does not work
  mtcars["Mazda RX4",]
  length(mtcars["Mazda RX4",]) #Gives the length of the vector with all the values from a given row, equal to the number of columns

#Also works with numbers
  mtcars[1,]
  length(mtcars[1,])

  mtcars["mpg"] #Comma missing, will return the column but as a data frame with 1 column, not as a vector 
              #this can be an issue depending on what function you use this with
  mtcars[,"mpg"]#Correct way to call a specific column with brackets

  length(mtcars["mpg"]) #incorrect length: returns 1 for the number of columns
  length(mtcars[,"mpg"])  #Gives the length of the vector with all the values from a given column, equal to the number of rows

#You can also use $ to select a specific column using its name
  mtcars$mpg
  mtcars$cyl

#You can use R operators to select a range of values rather than one value, notably ":" and "c(,)"
  head(mtcars)
  mtcars[3:5,2] #returns values from rows 3, 4 and 5 of column 2 thanks to the "2:4" argument on the row side of the coordinates

#you can also request specific values out of order by using a vector
  mtcars[c(1,3),2] #returns values from rows 1 AND 3 -but not row 2- of column 2 thanks to the "c(1,3)" argument on the row side of the coordinates

#Can be used on both sides for different purposes
  mtcars[c(1,3),2:5] #Values from rows 1 and 3 of column 2, 3, 4 and 5

#Finding column/row names or number----
#If you want to know the numeric value of a row or column with a given name, you can use the "which" function
#The which() function searches which values of a given vector match the logic argument
  which(colnames(mtcars)=="hp")
  which(rownames(mtcars)=="Honda Civic")

#needs to be ==, not = because this is a logical operator ("is equal to"), not a numeric operator 
  which(colnames(mtcars)="hp")
  which(rownames(mtcars)="Honda Civic")

#colnames() and rownames() can also be used for the opposite, to find what is the name of a column/row of a given number
  colnames(mtcars)[2]
  rownames(mtcars)[2]

#colSums() gives you the sum of all rows for each column in a vector
  colSums(mtcars)
  colSums(mtcars)[4] #Using coordinates allows to retrieve specific sums

#rowSums() gives you the sum of all columns for each row in a vector (not every meaningful for cars but more about total fauna abundances from samples etc)
  rowSums(mtcars)
  rowSums(mtcars)[4] #Using coordinates allows to retrieve specific sums 

#For both rowSums() and colSums(), you can specify which columns/rows you want to add within the formula
  colSums(mtcars) #Sum of all rows for each column
  colSums(mtcars[1:10,])#Sum for rows 1 to 10 for each column
  rowSums(mtcars) #Sum of all column for each row
  rowSums(mtcars[,5:7]) #Sum for column 5 to 7 for each row

#Editing your data frame----
#You can append to your data frame using the rbind() or cbind() functions
#Importantly, the row you add must contain as many values as there are columns, 
#and the column you add must contain as many values as there are rows 

  Dataframe_B=cbind(mtcars,"New Variable"=rep(c(0,1),16)) #adds a new column named "Variable C" with 32 values (32 rows)
  head(Dataframe_B)
  
  Dataframe_C=rbind(mtcars,"Sample 5"=c(0,0,0,0,0,0,0,0,0,0,0)) #adds a new row named "Sample 5" with 11 values (11 columns)
  Dataframe_C
  
#To add a column to a data frame without creating a new data frame, you can either 
#assign the cbind() to the same name 
  mtcars=cbind(mtcars,"TestVariable_1"=rep(c(0,1),16))
  head(mtcars)
#or directly name the new column with $ 
  mtcars$TestVariable_2=rep(c(0,1),16)
  head(mtcars)
  
  data("mtcars")#resets the dataset

#You can also use operators on Data frame columns or rows as if they were regular vectors
  Dataframe_D=rbind(mtcars,"Sample Car"=mtcars[32,]*2) 
#adds a new row named "Sample Car" containing the values of the last row (Volvo  142E) multiplied by 2
  Dataframe_D[32:33,]

#You can merge data frames, but only as long as they have the same number of rows
  mtcars_2=mtcars*2
  head(mtcars_2)

  Combined_DF=cbind(mtcars,mtcars_2)
  head(Combined_DF)

#Useful Functions for data frames----

  dim(mtcars) #gives a VECTOR with the number of rows and number of columns
  dim(mtcars)[1] #asks the number of rows (1st value in the dim vector)
  dim(mtcars)[2] #asks the number of columns (2nd value in the dim vector)

  summary(mtcars) #gives the summary of each column as if it was a vector

#Subsetting, filtering and selective operations----
  
#In the mtcars data, "vs" and "am" are categorical factors 
#(automatic vs manual transmission and V-shaped vs straight engine respective)
#but as summary() shows, R is treating it as a continuous number, doing means and quartiles on them

  which(colnames(mtcars)=="am"|colnames(mtcars)=="vs") #This which() command asks which colname is either equal to "am" OR equal to "vs"
  summary(mtcars)[,8:9]
  
#We need to re-assign the variable so that R reads it as a factor
  mtcars$am=as.factor(mtcars$am)
  mtcars$vs=as.factor(mtcars$vs)
#summary() now shows how many observations of each level (0 or 1) there are
  summary(mtcars)[,8:9]

#The tapply function applies a function on a subset based on an index vector
#tapply(vector, factor, function)
#Let's see what the mean  horsepower (hp) for each type of transmission (am)
  tapply(mtcars[,"hp"], mtcars[,"am"], mean) 

#tapply can also use any function from R, such as summary()
  tapply(mtcars[,"hp"], mtcars[,"am"], summary) 

  
#Example that combines multiple commands: which car has the highest horse power?
  max(mtcars[,"hp"]) #finds the maximum value of the "hp" vecctor
  which(mtcars[,"hp"]==335) #returns the index of the elements in the "hp" vector that meet the criteria (is equal to 335)
  rownames(mtcars)[31]  #returns the name of the 31st row (here the car model) 

#This line contains all the previous steps as one command  
  rownames(mtcars)[which(mtcars[,"hp"] == max(mtcars[,"hp"]))]

  