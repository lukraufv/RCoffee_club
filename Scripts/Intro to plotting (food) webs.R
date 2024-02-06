#Basic introduction to plotting food webs


library(igraph)


dev.off()
rm(list=ls())

# To build a food web in it's simplest form, all we need to know is 

# 1) What species are present?
# 2) What species interact (predator-prey)

#Lets make a super simple food web with three species

# 1) What species are present?
# Cod
# Herring
# Anchovy


# 2) What species interact? (predator-prey)
# 1 = this species feeds on the other
# 0 = no feeding interaction

# Creating a 3x3 matrix with specified values
food.web <- matrix(c(0, 1, 0,
                     0, 0, 1,
                     0, 0, 0),
                     
                   nrow = 3, ncol = 3)

# Naming the columns (each column = one species)
colnames(food.web) <- c("Cod", "Herring", "Anchovy")

# Print the matrix with column names
print(food.web)

# Plot the food web (igraph)
# Create a graph object
food_web_graph <- graph_from_adjacency_matrix(food.web, mode = "directed", 
                                              weighted = TRUE, diag = FALSE)

# Plot the graph
plot(food_web_graph, layout = layout.circle(food_web_graph), 
     vertex.label.cex = 1.5, vertex.size = 30, vertex.color = "magenta", edge.width = 2)

# Another way to visualize feeding
netmatrix <- get.adjacency(food_web_graph, sparse=F)
heatmap(netmatrix, Rowv=NA, Colv=NA, scale="none")








#Add more species to the web

# Creating a 3x3 matrix with specified values
food.web <- matrix(c(0, 1, 0,1 ,0,
                     0, 0, 1,1 ,1,
                     0, 0, 0,0,1,
                     0,0,0,0, 1,
                     0,0,0,0,0),
                   
                   nrow = 5, ncol = 5)

# Naming the columns (each column = one species)
colnames(food.web) <- c("Cod", "Herring", "Anchovy", "Gammarus", "Fucus vesiculosus")




# Print the matrix with column names
print(food.web)

# Plot the food web (igraph)

# Create a graph object
food_web_graph <- graph_from_adjacency_matrix(food.web, mode = "directed", 
                                              weighted = TRUE, diag = FALSE)

# Plot the graph
plot(food_web_graph, layout = layout.circle(food_web_graph), 
     vertex.label.cex = 1.5, vertex.size = 30, vertex.color = "pink", edge.width = 2)

# Another way to visualize feeding
netmatrix <- get.adjacency(food_web_graph, sparse=F)
heatmap(netmatrix, Rowv=NA, Colv=NA, scale="none")

# Change colours
# Trophic levels

dev.off()
