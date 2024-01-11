

#Example: Importing multiple HOBO loggers at once

#### Import the HOBO data ####

#Imports all 20 HOBO mesocosm files at once

# Create a list of all the paths of all HOBO files
# using the dir() function to list files in a directory.

#This code snippet should work on anyones device
listpath <- dir(
  path = "Data/Temperature/HOBO/1.9.23",    # The directory path where the files are located.
  pattern = "2023-09-01",                    # A regular expression pattern to match the filenames (every file in this folder contains 1.9.23 in the file name)
  full.names = TRUE                  # If TRUE, returns the full file paths; if FALSE, only filenames are returned.
)




# Read all HOBO files into a list of data frames and rename columns

data_meso_list <- lapply(listpath, function(file_path) { # The lapply() function applies the anonymous function to each file_path in the listpath.
  data_meso <- read_excel(file_path)  # Reads the excel file into a data frame.
  # Rename the columns of the data frame using colnames() function.
  # The new column names are "NUM", date_time" and "temp"
  colnames(data_meso) <- c("NUM","date_time", "temp")
  # The data_meso data frame with updated column names is returned by the anonymous function
  # and added to the data_meso_list.
  data_meso
})


# Attach the data frames from the list to the global environment with desired names
names(data_meso_list) <- paste0("data_meso_", seq_along(data_meso_list))
list2env(data_meso_list, envir = .GlobalEnv) #send your lists (your dataframes) to your environment

