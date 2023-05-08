## ----setup, include=FALSE---------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

 
## ---------------------------------------------------------------------
pacman::p_load(data.table, skimr, tidyverse, cluster)


## ---------------------------------------------------------------------
df <- fread("./data/Credit Card Customer Data.csv")


## ---------------------------------------------------------------------
DataExplorer::plot_missing(df)


## ---------------------------------------------------------------------
names(df)
df %>% skim()


## ---------------------------------------------------------------------
df1 <- df[,-c(1,2)]
apply(df1, 2, mean) # mean
apply(df1, 2, var)  # variance


## ---------------------------------------------------------------------
pr_out <- prcomp(df1, scale = TRUE)


## ---------------------------------------------------------------------
summary(pr_out)


## ---------------------------------------------------------------------
pve <- summary(pr_out)$importance[2,]


## ---------------------------------------------------------------------
par(mfrow = c(1,2))
plot(pve, type = "b", ylim = c(0,1),
     xlab = "Principle component",
     ylab = "Proportional Variance Explained")

plot(cumsum(pve), type = "b", ylim = c(0,1),
     xlab = "Principle component",
     ylab = "Proportional Variance Explained")


## ---------------------------------------------------------------------
#names(df)
biplot(pr_out, scale = T, cex = .8, main = "")


## ---------------------------------------------------------------------
wcss <- c()
k <-  10

for(i in 1:k){
  km = kmeans(scale(df1), i, nstart = 500, iter.max = 500)
  wcss[i] =km$tot.withinss
}

ggplot(data.frame(k = 1:k, wcss= wcss), aes(x = k , y = wcss)) + 
  geom_point() + 
  geom_line() + 
  scale_x_continuous(breaks = 1:k)+
  labs(x = "number of Cluster (k)", y = "Within-cluster sum of squares", title = "Elbow plot K-means") 



## ---------------------------------------------------------------------
set.seed(1)
km_out <- kmeans(scale(df1), 3, nstart = 100, iter.max = 200)


## ---------------------------------------------------------------------
km.out
#km.out$tot.withinss


## ---------------------------------------------------------------------
plot(df1, col = km_out$cluster + 1, pch = 19, cex =.6 ,
     main = paste("K-means Clustering Results with k = ", max(km_out$cluster)) )


## ---------------------------------------------------------------------
ggplot(data.frame(pc1 = pr_out$x[,1],  pc2 = pr_out$x[,2]), aes(x = pc1, y = pc2, color = as.factor(km_out$cluster) )) + 
  geom_point(size = 1.2,show.legend = F) + 
  labs(x = "PC1", y = "PC2",title = paste("K-means Clustering Results with k = ", max(km_out$cluster))) + 
  theme_classic()

plot(pr_out$x[,1],  pr_out$x[,2], pch = 19, cex = .8,
     xlab = "PC1", ylab = "PC2",
     col = (km_out$cluster + 1), main = paste("K-means Clustering Results with k = ", max(km_out$cluster)))


## ---------------------------------------------------------------------
set.seed(1)
hc_complete <- hclust(dist(scale(df1)), method = "complete" )
avg <- hclust(dist(scale(df1)), method = "average" )


## ---------------------------------------------------------------------
plot(hc_complete, main = "Complete Linkage", sub = "", xlab = "")
plot(hc_complete, main = "Average Linkage", sub = "", xlab = "")


## ---------------------------------------------------------------------
hm_cluster <- cutree(hc_complete, 3)


## ---------------------------------------------------------------------
table(hm_cluster, km_cluster_complete = km_out$cluster)


## ---------------------------------------------------------------------
set.seed(1)
hc_pca <- hclust(dist(pr_out$x[,1:2]))


## ---------------------------------------------------------------------
plot(hc_pca, sub = "", xlab = "", main = "Hierarchical cluster on first 2 PCA")


## ---------------------------------------------------------------------
set.seed(1)
km_cluster <- kmeans(pr_out$x[,1:2], 3, nstart = 100,iter.max = 200)


## ---------------------------------------------------------------------
km_cluster


## ---------------------------------------------------------------------
ggplot(data.frame(pc1 = pr_out$x[,1],  pc2 = pr_out$x[,2]), aes(x = pc1, y = pc2, color = as.factor(km_cluster$cluster) )) + 
  geom_point(size = 1.2,show.legend = F) + 
  labs(x = "PC1", y = "PC2",title = paste("K-means Clustering Results with k = ", max(km_out$cluster))) + 
  theme_classic()

