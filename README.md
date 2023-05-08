# PCA & Cluster Analysis on Credit Card Customer data

Performed PCA to find low dimensional representation of the customer that explain a good fraction variation of the entire dataset. Also performed K-means and Hierarchical cluster to find the related customers.

The Credit Card Customer data is from [kaggle.com](https://www.kaggle.com/datasets/aryashah2k/credit-card-customer-data)

# Principal Components Analysis

The dataset does not have any NA values. The data was also normalized before PCA since clearly there is a difference between the average mean and variance between the variables.

![](./images/summary_stat.png)

The table below shows the PCA results. The first two principle components explain about 83.17% of the variability of the entire dataset.

![](./images/pca.png)


The figure below, is the scree plot of the cumulative proportional variance

![](./images/scree_plot.png)
