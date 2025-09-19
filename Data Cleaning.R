# ========================== #
# TASK 2 – DATA CLEANING + EDA (STUDENT PERFORMANCE DATA)
# ========================== #

# Load libraries
library(tidyverse)
library(readr)
library(janitor)
library(ggplot2)
library(ggcorrplot)

# Step 1: Load and Clean
data <- read_csv("C:/Users/wardi/OneDrive/Desktop/Data Science/study_performance.csv")
data <- clean_names(data)

# Step 2: Handle missing/duplicates
data <- distinct(data)
data[data == ""] <- NA
data <- drop_na(data)

# Step 3: Convert categorical to factors
data <- data %>%
  mutate(across(where(is.character), as.factor))

# Step 4: Select numeric columns for clustering
numeric_data <- data %>%
  select(math_score, reading_score, writing_score)

# Step 5: EDA

# Histogram: Math Score
ggplot(data, aes(x = math_score)) +
  geom_histogram(fill = "steelblue", bins = 20, color = "black") +
  labs(title = "Distribution of Math Scores")

# Boxplot: Writing Score by Gender
ggplot(data, aes(x = gender, y = writing_score, fill = gender)) +
  geom_boxplot() +
  labs(title = "Writing Score by Gender", y = "Writing Score")

# Correlation Matrix
cor_matrix <- cor(numeric_data)
ggcorrplot(cor_matrix, lab = TRUE, title = "Correlation Between Scores")

# Step 6: Scale the numeric data
scaled_data <- scale(numeric_data)

# Optional: Save cleaned and scaled data
write_csv(as.data.frame(scaled_data), "C:/Users/wardi/OneDrive/Desktop/Data Science/study_scaled.csv")
