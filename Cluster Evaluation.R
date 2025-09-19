# ========================== #
# TASK 4 – CLUSTER EVALUATION
# ========================== #

# 1. Silhouette Score: How well-separated the clusters are
silhouette_scores <- silhouette(kmeans_model$cluster, dist(scaled_data))
mean_silhouette <- mean(silhouette_scores[, 3])
cat("Average Silhouette Score:", round(mean_silhouette, 3))

# 2. Cross-tab Analysis (e.g., Gender vs Cluster)
cat("\nCross-Tab: Gender vs Cluster\n")
print(table(data$gender, data$cluster))

# 3. Visual Inspection with known label (e.g., gender)
pca_data$gender <- data$gender

ggplot(pca_data, aes(x = PC1, y = PC2, color = cluster, shape = gender)) +
  geom_point(size = 2, alpha = 0.7) +
  labs(title = "Cluster Visualization by Gender",
       subtitle = "K-Means Clusters with PCA and Gender",
       x = "Principal Component 1", y = "Principal Component 2") +
  theme_minimal() +
  scale_color_brewer(palette = "Dark2")
