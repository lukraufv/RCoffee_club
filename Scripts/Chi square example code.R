dataframe=data.frame(c(9,1),c(17,25),c(15,10))
colnames(dataframe)=c("milk","plant","no milk") #renames the columns of the data frame
rownames(dataframe)=c("male","female") #renames the rows of the data frame
View(dataframe) #Views the data frame
Chitest=chisq.test(dataframe)  #Assigns the output of the Chi² test to the "Chitest" object
Chitest #Test output
Chitest$expected #Table of expected values the test is comparing the observations with
Chitest$residuals #Table of residuals of each cell
contribution <- 100*Chitest$residuals^2/Chitest$statistic #Calculate how much each cell contributes to the difference between observed and expected values (in percentages)
round(contribution, 2) #Display the contribution of each cell (up to 2 decimals)