#TASK 1 (Loading, exploring, and preparing the dataset (no visualization))
# Load required libraries
library(readr)
library(dplyr)

# Step 1: Load dataset (adjust path as needed)
data <- read_csv("study_performance(in).csv")

# Step 2: Explore the dataset
str(data)            # Check structure and variable types
summary(data)        # Summary statistics
head(data)           # View first few rows
table(data$gender)   # Check balance of gender

# Step 3: Clean the data
data <- distinct(data)        # Remove duplicates
# Replace empty strings with NA
data[data == ""] <- NA        
data <- drop_na(data)         # Drop rows with missing values

# Step 4: Convert character columns to factor
data <- data %>%
  mutate(across(where(is.character), as.factor))

# Step 5: Select only numeric columns for clustering
numeric_data <- data %>%
  select(math_score, reading_score, writing_score)

# Step 6: Scale numeric columns
scaled_data <- scale(numeric_data)

str(scaled_data)