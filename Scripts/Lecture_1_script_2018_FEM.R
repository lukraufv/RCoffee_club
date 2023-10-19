#This script is part of the first lecture on the introduction to R.
#Written by Floriaan Eveleens Maarse, doctoral student at ?bo Akademi.

#This is called a script, the way of inputting commands into R.
#If a line of code is beginning with '#*, the text will appear in 
#a different color and R will recognize is at text  and it will
#be skipped when running the code.
 
#Getting started
#-----------------------------------------------------------------------------

#The first thing to do when starting a new script is running this 
#line of code:
rm(list=ls())

#This will remove all objects from R's memory left over from a 
#previous session, ensuring that there will be no confusion with 
#the previous sesion. To remove leftover plots, click the broom icon
#atop the lower right window.

#To run a line of code, either place the cursor on that line and 
#click 'run' in the upper right part of this window or press 
#Ctrl + Enter. You can also select multiple lines of code with the 
#mouse and run them all at once.

#Try it with a simple sum:

1+1

#If a line of code is not recognized by R, it will generate an error 
#message:

ThismakesnosensetoR

#Creating objects in R
#-------------------------------------------------------------------------------
#Let's start by making a Vector(a single line of numeric values),

c(3,6,8,5)

#The the numbers now appear in the console, but they are not saved.
#To save an object it must be assigned a name by using the 
#"<-" function

Vector1 <- c(3,6,8,5)

#Note that the object now appears in the upper-right window.
#We can now use the objects name to work with, for instance,
#typing the name will return the values in the vector

Vector1

#We can also do some calculations on our object like 
#multiplying by 2

Vector1*2

#And we can save the multiplied vector in a new object:

Vector2<-Vector1*2

#Or calculate the mean:

mean(Vector1)

#A matrix is a table consisting of collumns and rows of values
#We'll try making a matrix.

Matrix1<-matrix(c(1,6,3,8),2,2)

#the numbers in the inner bracets are the values and the numbers
#in the outer bracets are the dimensions of the matrix, 
#in this case 2x2


#Dataframes and loading data
#-------------------------------------------------------------------------------
#Dataframes are tables like matrices, but unlike a matrix,a dataframe
#can store different data types (numeric, character, factor, etc.).
#To load a dataframe into R we must first set the work directory,
#which is the folder on the computer in which the data is stored.

#Type the location of your folder into the formula below:
#(Note that the \ must be changed to /)

setwd("C:/Users/feveleen/Documents/R lectures EA")

#Check the work directory and its content with:
getwd()
dir()

#Load the file you want by using the read.table fuction and 
#assigning it a name (in this case "dat"):

dat <-read.table("Env.EA.ytta.txt", header=T, sep="\t")

#If any NA values appear in the dataframe, they can be removed with:

dat<-na.omit(dat)

#You can check your dataframe with these commands:

# list the variables in dat
names(dat)

# list the structure of dat
str(dat)

# class of an object (numeric, matrix, data frame, etc)
class(dat$ORGANIC.CONTENT)

#The $ is used to indicate the dataframe in wich to find the object
#to forego that we can use the attach function

attach(dat)

#Now if you want to use the variable you just have to refer to the 
#name, for instance when examining the values

ORGANIC.CONTENT

#Graphs
#-------------------------------------------------------------------------------


#To make basic graphs in R, look up the code for the kind of
#graph you want

#Like a histogram

hist(OXYGEN)

#A boxplot

boxplot(OXYGEN)

#A scatter plot:

plot(OXYGEN)  

#Or barplot

barplot(OXYGEN)

#The barplot does't have any labels on the x-axis. to assign those,
#use the names.arg command and choose the object station.nr 

barplot(OXYGEN, names.arg = STATION.NR)

#The scatterplot doesn't have a very nice x axis, seeing as there
#are only four stations and it plots along a continous scale. 
#One way of fixing this is by using xaxt=n which specifies the 
#x axis type. Specifying "n" suppresses plotting of the axis.
#Using the axis command, refering to the stations object and the
#range will allow you to customize your x axis

plot(OXYGEN, xaxt = "n")
axis(STATION.NR, at = 1:4)

#To  graphs with 2 sets of values you can specify in the
#script what you want to include. for instance lets look at the
#relationship between organic content and total nitrogen

plot(ORGANIC.CONTENT, TOT.N)

#To add labels and a title, specify that wih the "main" and "x-ylab"
#function. To change the look of the points, use the pch function

plot(ORGANIC.CONTENT, TOT.N, main="Scatterplot example", 
xlab="Organic content (mg/l)", ylab="Total nitrogen (ug/L)", pch= 18)

#To add a regressionline you use the abline command and specify
#the linear model (lm) you want it to represent. Use the col command
#to assign it a colour

abline(lm(TOT.N~ORGANIC.CONTENT), col="red")

#To plot 2 sets of data and have 2 Y axes first start with plotting
#one variable. 
#First, use par(mar=) to set the margins so there is enough space.
#In the order bottom, left, top and right margins respectively

par(mar=c(5,4,3,4))

#The type=l function indicates that you want a line
#instead of points. Let's supress the x axis and customize it again.

plot(TOT.N, type ="l", ylab = "Total nitrogen (ug/L)",
     main = "Two y-axis line plot", xlab = "Station",
     col = "blue", xaxt = "n")
axis(STATION.NR, at = 1:4)

#Use the par(new = TRUE) function to add onto the previous graph

par(new = TRUE)

#Plot the second variable. fist suppres the x axis by using
#xaxt = "n". Same for the y axis: yaxt = "n"
#(if you don't use this the new axes will overlap)
#lty=2 specifies the line type, 2 is for a dashed line

plot(TOT.P, type = "l", xaxt = "n", yaxt = "n",
     ylab = "", xlab = "", col = "red", lty = 3)

#Now specify where you want the new y axis: side=4 indicates the 
#right side.

axis(side = 4)

#Add a label to the new axis with mtext, this allows you to write 
#in the margins. specify the text, the side and use line= to specify
#the distance of the text from the figure.

mtext("Total phosphorous (ug/L)", side = 4, line = 3)

#Finally add a legend to link the lines to the axes.
#Specify where you want the legend, the corresponding text, color
#and line type. 
#!!!Make sure they correspond with the correct data!!!

legend("topleft", c("Total nitrogen", "Total phosphorous"),
       col = c("blue", "red"), lty = c(1, 2))

#Excersizes
#-------------------------------------------------------------------------------
#1.
#Create a matrix of random numbers with 3 rows and 2 columns

#2.
#Load the data from the 2nd tab from the excel file,
#examine the data and make a boxplot of the oxygen and include data
#labels for the stations and axis labels and title

#3.
#Make a scatterplot for the salinity and temperature and add a green
#trendline include a legend, title and labels

#4.
#Make a line graph with oxygen and temperature along two y axes
#include a legend, title and labels

#5.
#Since the most common way to learn new R functions, is by looking
#it up on the internet, try teaching yourself something new.
#Produce a vector with random numbers.
#Make a pie chart of the vector, assign a rainbow color 
#scheme and data labels.



