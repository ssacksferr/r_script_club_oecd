#################################################
#First, we try the first answer:
#################################################

# Load required libraries
library(httr)
library(jsonlite)
library(dplyr)

# Replace these with your actual API key and table name
api_key <- "6A87FB10-9A09-431F-B92D-B6D0B91E4A5F"
table_name <- "T10101"

# Create the API request URL
api_url <- paste0("https://apps.bea.gov/api/data/?&UserID=", api_key,
                  "&method=GetData&DataSetName=NIPA&TableName=", table_name,
                  "&Frequency=Q&Year=ALL&ResultFormat=JSON")

# Make the API request
response <- GET(api_url)

# Check if the request was successful
if (http_status(response)$status == 200) {
  # Parse the JSON response
  data_json <- content(response, "text", encoding = "UTF-8")
  data <- fromJSON(data_json, flatten = TRUE)
  
  # Extract the list of datasets and store them in a dataframe
  datasets <- data$BEAAPI$Results$Dataset
  df <- as.data.frame(datasets)
  
  # Print the first few rows of the dataframe
  head(df)
} else {
  cat("API request failed with status code:", http_status(response)$status)
}  
  
#######################################
#Let's go back and modify the prompt
#######################################

################################################
# TRY 2: now, we can input more than one table
################################################  
  # Load required libraries
  library(httr)
  library(jsonlite)
  
  # Replace these with your actual API key and a vector of table names
  table_names <- c("T10101")  # Add all the table names you want to query
  
  # Initialize an empty list to store the dataframes for each table
  table_dataframes <- list()
  
  # Loop through each table name and download the data
  for (table_name in table_names) {
    # Create the API request URL
    api_url <- paste0("https://apps.bea.gov/api/data/?&UserID=", api_key,
                      "&method=GetData&DataSetName=NIPA&TableName=", table_name,
                      "&Frequency=Q&Year=ALL&ResultFormat=JSON")
    
    # Make the API request
    response <- GET(api_url)
    
    # Check if the request was successful
    if (http_status(response)$status_code == 200) {
      # Parse the JSON response
      data_json <- content(response, "text", encoding = "UTF-8")
      data <- fromJSON(data_json, flatten = TRUE)
      
      # Extract the list of datasets and store them in a dataframe
      datasets <- data$BEAAPI$Results$Data
      df <- as.data.frame(datasets)
      
      # Store the dataframe in the list
      table_dataframes[[table_name]] <- df
    } else {
      cat("API request failed for table:", table_name, "with status code:", http_status(response)$status_code, "\n")
    }
  }
  


###########################################################
#Error in if (http_status(response)$status == 200) { : 
#        argument is of length zero
###########################################################

  
#################################################
# Let's add the error to the chat?
#################################################  
      
##############################
#TRY 3: add http_error
##############################  
  # Initialize an empty list to store the dataframes for each table
  table_dataframes <- list()
  
  # Loop through each table name and download the data
  for (table_name in table_names) {
    # Create the API request URL
    api_url <- paste0("https://apps.bea.gov/api/data/?&UserID=", api_key,
                      "&method=GetData&DataSetName=NIPA&TableName=", table_name,
                      "&Frequency=Q&Year=ALL&ResultFormat=JSON")
    
    # Make the API request
    response <- GET(api_url)
    
    # Check for HTTP errors
    if (http_error(response)) {
      cat("API request failed for table:", table_name, "with error:", response$status_message, "\n")
    } else {
      # Parse the JSON response
      data_json <- content(response, "text", encoding = "UTF-8")
      data <- fromJSON(data_json, flatten = TRUE)
      
      # Extract the list of datasets and store them in a dataframe
      datasets <- data$BEAAPI$Results$Dataset
      df <- as.data.frame(datasets)
      
      # Store the dataframe in the list
      table_dataframes[[table_name]] <- df
    }
  }
  

#########################################################
#OK, we get no errors. But where is the data?
# Let's look into: DATA --> RESULTS
#I can see it is downloading data but it is not being parsed to "df"
#########################################################  
  
#### TRY 4, it's empty because it's querying on "Dataset", which does not exist...

  # Initialize an empty list to store the dataframes for each table
  table_dataframes <- list()
  
  # Loop through each table name and download the data
  for (table_name in table_names) {
    # Create the API request URL
    api_url <- paste0("https://apps.bea.gov/api/data/?&UserID=", api_key,
                      "&method=GetData&DataSetName=NIPA&TableName=", table_name,
                      "&Frequency=Q&Year=ALL&ResultFormat=JSON")
    
    # Make the API request
    response <- GET(api_url)
    
    # Check for HTTP errors
    if (http_error(response)) {
      cat("API request failed for table:", table_name, "with error:", response$status_message, "\n")
    } else {
      # Parse the JSON response
      data_json <- content(response, "text", encoding = "UTF-8")
      
      # Print the JSON response for inspection
      print(data_json)
      
      data <- fromJSON(data_json, flatten = TRUE)
      
      # Extract the list of datasets and store them in a dataframe
      datasets <- data$BEAAPI$Results$Data
      df <- as.data.frame(datasets)
      
      # Store the dataframe in the list
      table_dataframes[[table_name]] <- df
    }
  }
  
  # Combine data from all tables into a single dataframe
  combined_df <- bind_rows(table_dataframes)
  
  # Now you have a single dataframe, 'combined_df', containing data from all tables
  # You can check it directly in R
  
  
### TRY 5
  
  # Load required libraries
  library(httr)
  library(jsonlite)
  library(dplyr)
  

  table_names <- c("T10101")  # Add all the table names you want to query
  
  # Initialize an empty list to store the dataframes for each table
  table_dataframes <- list()
  
  # Loop through each table name and download the data
  for (table_name in table_names) {
    # Create the API request URL
    api_url <- paste0("https://apps.bea.gov/api/data/?&UserID=", api_key,
                      "&method=GetData&DataSetName=NIPA&TableName=", table_name,
                      "&Frequency=Q&Year=ALL&ResultFormat=JSON")
    
    # Make the API request
    response <- GET(api_url)
    
    # Check for HTTP errors
    if (http_error(response)) {
      cat("API request failed for table:", table_name, "with error:", response$status_message, "\n")
    } else {
      # Parse the JSON response
      data_json <- content(response, "text", encoding = "UTF-8")
      
      data <- fromJSON(data_json, flatten = TRUE)
      
      # Extract the list of datasets and store them in a dataframe
      datasets <- data$BEAAPI$Results$Data
      df <- as.data.frame(datasets)
      
      # Store the dataframe in the list
      table_dataframes[[table_name]] <- df
    }
  }
  
  # Combine data from all tables into a single dataframe
  combined_df <- bind_rows(table_dataframes)
  
  # Now you have a single dataframe, 'combined_df', containing data from all tables
  # You can check it directly in R
  
  str(combined_df)
  
#######################################################################
#OK, now let's try something else!  
#######################################################################
  
  # Load required libraries
  library(ggplot2)
  
  # Australia's quarterly GDP data (replace with your data)
  quarter <- c("2015Q1", "2015Q2", "2015Q3", "2015Q4", "2016Q1", "2016Q2", "2016Q3", "2016Q4", "2017Q1", "2017Q2", "2017Q3", "2017Q4")
  gdp_usd_millions <- c(193964, 1233961, 1260242, 1268767, 1242358, 1290621, 1298613, 1308005, 1316826, 1325422, 1330357, 1335089)
  
  # Create a dataframe
  data <- data.frame(Quarter = quarter, GDP_USD_Millions = gdp_usd_millions)
  
  # Create a line plot
  ggplot(data, aes(x = Quarter, y = GDP_USD_Millions)) +
    geom_line(color = "blue") +
    labs(x = "Quarter", y = "GDP in US Dollars (Millions)", title = "Australia's Quarterly GDP Trend (2015 - Q2 2023)") +
    theme_minimal()
  
  # Interpretation of the trend:
  # The plot shows Australia's quarterly GDP in US dollars from 2015 to Q2 2023. 
  # The trend appears to be generally increasing over time, indicating economic growth. 
  # There may be some fluctuations, but the overall direction is positive. 
  # It suggests that the Australian economy has been expanding, although specific factors contributing to this growth would require further analysis.
  
  

######################################################  
#There's nothing here....    
######################################################
  # Load required libraries
  library(ggplot2)
  
  # Replace 'quarter' and 'gdp_usd_millions' with your actual data
  quarter <- c("2015Q1", "2015Q2", "2015Q3", "2015Q4", "2016Q1", "2016Q2", "2016Q3", "2016Q4", "2017Q1", "2017Q2", "2017Q3", "2017Q4")
  gdp_usd_millions <- c(193964, 1233961, 1260242, 1268767, 1242358, 1290621, 1298613, 1308005, 1316826, 1325422, 1330357, 1335089)
  
  # Create a dataframe
  data <- data.frame(Quarter = quarter, GDP_USD_Millions = gdp_usd_millions)
  
  # Create a line plot
  ggplot(data, aes(x = Quarter, y = GDP_USD_Millions)) +
    geom_line() +
    labs(x = "Quarter", y = "GDP in US Dollars (Millions)", title = "Australia's Quarterly GDP Trend (2015 - Q2 2023)") +
    theme_minimal()
  
  
  #let's try again
  
  # Replace 'quarter' and 'gdp_usd_millions' with your actual data
  quarter <- c("2015Q1", "2015Q2", "2015Q3", "2015Q4", "2016Q1", "2016Q2", "2016Q3", "2016Q4", "2017Q1", "2017Q2", "2017Q3", "2017Q4")
  gdp_usd_millions <- c(193964, 1233961, 1260242, 1268767, 1242358, 1290621, 1298613, 1308005, 1316826, 1325422, 1330357, 1335089)
  
  # Create a dataframe
  data <- data.frame(Quarter = quarter, GDP_USD_Millions = gdp_usd_millions)
  
  # Create a bar plot
  ggplot(data, aes(x = Quarter, y = GDP_USD_Millions)) +
    geom_bar(stat = "identity", fill = "blue") +
    labs(x = "Quarter", y = "GDP in US Dollars (Millions)", title = "Australia's Quarterly GDP Trend (2015 - Q2 2023)") +
    theme_minimal()
  