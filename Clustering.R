# ========================== #
# TASK 3 – CLUSTERING (K-MEANS)
# ========================== #

library(factoextra)
library(cluster)

# Step 1: Elbow Method to find optimal clusters
fviz_nbclust(scaled_data, kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = "dashed", color = "red") +
  labs(title = "Elbow Method for Optimal K")

# Step 2: Apply K-Means (use 3 clusters as example)
set.seed(42)
kmeans_model <- kmeans(scaled_data, centers = 3, nstart = 25)

# Step 3: Attach cluster labels
data$cluster <- factor(kmeans_model$cluster)

# Step 4: Output summary
print("Cluster Sizes:")
print(kmeans_model$size)

print("Cluster Centers (scaled):")
print(kmeans_model$centers)

# Step 5: Visualize Clusters (with PCA)
pca_result <- prcomp(scaled_data)
pca_data <- as.data.frame(pca_result$x[, 1:2])
pca_data$cluster <- factor(kmeans_model$cluster)

ggplot(pca_data, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(size = 2, alpha = 0.6) +
  labs(title = "K-Means Clustering Visualization (PCA)", x = "PC1", y = "PC2") +
  theme_minimal() +
  scale_color_brewer(palette = "Dark2")