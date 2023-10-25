
library(ggplot2)



#loop with 3 plates
#each plate =6 wells
#loop in a loop (first plates, then whells in each plate)
#plot all

plates<-c(1,2,3)
replicates<-c(1,2,3,4,5,6)
df <- expand.grid(Plate = plates, Replicate = replicates)
df$RandomNumber <- runif(nrow(df), min = 1, max = 10)
df$RandomNumber2 <- runif(nrow(df), min = 1, max = 10)


# Create a loop to iterate through each plate


# Load the necessary libraries
library(ggplot2)

# Define a function to create a scatter plot for a specific combination of "Plate" and "Replicate"
create_scatter_plot <- function(plate, replicate) {
  # Subset the data based on the plate and replicate
  subset_data <- df[df$Plate == plate & df$Replicate == replicate, ]
  
  # Create a scatter plot using ggplot2
  p <- ggplot(subset_data, aes(x = RandomNumber, y = RandomNumber2)) +
    geom_point() +
    labs(title = paste("Plate", plate, "Replicate", replicate))
  
  # Print the plot or save it as an image
  print(p)
  # You can save the plots as images with ggsave if needed
}

# Loop through each combination of "Plate" and "Replicate" and create a scatter plot for each
for (plate in unique(df$Plate)) {
  for (replicate in unique(df$Replicate)) {
    create_scatter_plot(plate, replicate)
  }
}
