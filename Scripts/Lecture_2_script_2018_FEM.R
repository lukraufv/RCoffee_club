#This script is part of the first lecture on the introduction to R.
#Written by Floriaan Eveleens Maarse, doctoral student at ?bo Akademi.

#This lecture will cover several statistical analyses and plotting
#figures
#-----------------------------------------------------------------------------
rm(list=ls())

#load the Abun.EA data into R

setwd("C:/Users/feveleen/Documents/R lectures EA") #Set you personalized directory

getwd() #What shows up in the console is your current directory
dir() #what folders do you have in this directory?

dat <-read.table("Data/Lectures_FEM/Abun.EA.txt", header=T, sep="\t")  #For GitHub users: This file can be found in the folder "/Data/Lectures_FEM"

#The data consists of 10 species found in 4 samples with 5 replicates
#per sample

#Let's calculate the total abundance per replicate using the rowSums
#function

#Examine the dataframe

names(dat)

#Get rid of any NA values

dat<-na.omit(dat)

#Make a new column in the dataframe called tot.abun and specify
#which columns to add up with the rowSums command

dat$tot.abun <- rowSums (dat[3:12])


#The data frame has a new column

names(dat)
dat$tot.abun

#Shannon's index (H)and Pielou's evenness (J).
#-------------------------------------------------------------------------------

#To calculate H and J you could write the entire formula into R
#but it is much easier to load a package and have R do it for you
#Packages are expansions on R's basic programmingand allow for more
#fuctions. One, which is very useful for environmental 
#biologists, is called "vegan".

#To install a package click Tools and Install packages and search for
#vegan. Install the package and use the library function

library(vegan)

#Now make a new column called H and use the diversity function
#specify the range and the type of index (shannon, simpson, etc.).

dat$H<- diversity(dat[3:12],index="shannon")

#Calculate species richness (s) with specnumber

dat$S <- specnumber(dat[3:12])


#Calculate Pilou's Evenness (J) by dividing H by log S

dat$J <- dat$H/log(dat$S)

head(dat)

#QQplot and normality
#-------------------------------------------------------------------------------

#To test for normality, you can have a look at the rough distribution
#of the data by plotting a histogram.

hist(dat$tot.abun)

#Or with a QQplot. 

qqnorm(dat$tot.abun)

#Add a line to the plot to see the ideal distribution.

qqline(dat$tot.abun)

#For the total abundance, it seems to follow the line quite well,
#which would indicate normal distribution.

#The Shapiro-Wilk normality test, is another method to test for
#normality. It tests the H-0 that the data is normally
#distributed.

shapiro.test(dat$tot.abun)

#In this case it returns a p-value of 0.8781 (p>0.05), which means
#we accept the H-0 and we can state that no significant departure
#from normality was found.

#Variance homogenity
#-------------------------------------------------------------------------------
#To test is samples come from populations with equal variance
#you can illustrate to get a rough overview with a boxplot
#Use the boxplot function, indicate the total abundance and 
#test between the different samples by indicating the "sample"
#column after the "~".

boxplot(dat$tot.abun~dat$sample)

#The 4 samples seem quite different in their variance
#Test this further by using the Bartlett test. The Bartlett test
#tests the H-0 that the variance is similar between groups.
#Use the bartlett.test function and indicate the total abundance 
#as data and samples as groups

bartlett.test(dat$tot.abun~dat$sample)

#The test returns a p-value of 0.8386 which is > than 0.05, so
#we accept the H-0 and assume the variance is equal
#amongst the different samples

#One-way ANOVA and Tukey test
#-------------------------------------------------------------------------------
#Now that we know how to check for normality and variance, let's
#do an ANOVA. Start by changing the class of the sample column
#from numeric to factor(This is not necessary for the actual ANOVA
#but otherwise there will be problems with the post-hoc Tukey test).

dat$sample <- as.factor(dat$sample)

#Create a model using the <- aov function to indicate ANOVA. Then
#select the column you want to analyse and the column indicating
#the groups(dat$H ~ dat$sample).

model1 <- aov(dat$H ~ dat$sample)

#Retrieve the result using the summary function and specify the model.

summary(model1)

#This returns the degrees of freedom (Df), sum of squares,
#mean of squares, the F-value and the p-value.
#In this case we get F= 0.035 and p=0.991

#To examine the difference between the different groups, we can use
# and post-hoc test, like a Tukey test.
#Assign a new objectm use the TukeyHSD function and specify
#the model from the ANOVA.

tuk<- TukeyHSD(model1)

#Examine the new object by typing the name

tuk

#This will return the difference of the means for the different
#groups. So sample 2 has a 0.085216425 average lower H than sample 1.
#You get the upper and lower limits for the 95% confidence interval
#And the p-value, after adjustment for the multiple comparisons.

#Jaccard and Czekanowski index
#-------------------------------------------------------------------------------
#To make a Jaccard index table first check the columns with only
#species data.

names(dat)

#Transform those columns into presence/absence data(0 and 1) with
#the decostand function and the command "pa"

dat.pa <- decostand(dat[3:12],"pa")

#To create the jaccard index, use the vegdist function, select
#the p/a data, select jaccard as methos, binary=FALSE, diag=FALSE,
# upper=FALSE

jac.ind <-vegdist(dat.pa, method="jaccard", binary=FALSE, diag=FALSE, upper=FALSE)

#return the new object to get the values.

jac.ind

#To calculate the Czekanowski index, install and load the clustsig
#package

library(clustsig)

#Create a new object, using the simprof function, specify the
#p/a data and czekanowski and method for calculating the index.

cz.ind <- simprof(data=dat.pa, method.distance="czekanowski")

#Retrieve the new object.

cz.ind

cz.ind1<-vegdist(dat.pa, method="bray", binary=FALSE, diag=FALSE, upper=FALSE, na.rm = FALSE)

cz.ind1
#Barplot with error bars
#-------------------------------------------------------------------------------
#To make a barplot with errorbars first we will need some more
#packages: install and load plotrix, dplyer, and ggplot2.

library(plotrix)
library(dplyr)
library(ggplot2)

#Start by grouping the data accoring to samples with the group-by
#function.

grouped.dat<-group_by(dat,sample)

#Next summarise the new dataset according to mean and standard error
#Use the summarise_each, specify the grouped dataset, with the funs
#command, specify that you want both the mean and the standard error.

sum.dat<-summarise_each(grouped.dat,funs(mean=mean,std_error=std.error))

#Create an object for the plot and use the ggplot function.
#Specify the summarised data. Within the aes select the sample
#column for the x-axis, and the total abundance average.
#leave geom_col() blank for default colors. Add error bars with
#geom_errorbar(aes). Specify the minimum value for the errorbars at
#the mean-the standard error and the max as mean + standard error.

Abun.plot <- ggplot(data = sum.dat, aes(sum.dat$sample, sum.dat$tot.abun_mean)) + 
  geom_col() +  
  geom_errorbar(aes(ymin = sum.dat$tot.abun_mean - sum.dat$tot.abun_std_error, ymax = sum.dat$tot.abun_mean + sum.dat$tot.abun_std_error), width=0.2)

#Select the plot and add labels

Abun.plot + labs(y="Mean total abundance", x = "Sample")



#Trellis diagram
#-------------------------------------------------------------------------------
#To make a Trellis diagram, install and load the "lattice" package

library(lattice) 

#Use the function density plot and select total abundance to be
#plotted per sample (|)as seperator. Add labels 

densityplot(~dat$tot.abun | dat$sample, 
            main="Density Plot total abundance per sample",
            xlab="sample")

str(dat)
dat[3:12]<-lapply(dat[3:12],as.integer)
