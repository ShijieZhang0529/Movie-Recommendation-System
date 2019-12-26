# Recommender System: Collaborative Filtering

## Project Description:

Recommender systems are an essential part of any customer facing business. In large scale e-commerce like Amazon, Netflix and others, product recommendations can be personalized across millions of users and products to optimize sales. Companies today use Collaborative Filtering methods to combine data from different users and predict which items will appeal.

To this end, in 2006 Netflix released user and movie rating data, challenging teams to beat their algorithms's predictions. There are several challenges in working with this data set. Algorithms must be able to analyze massive amounts of data. There are many users with few ratings, which means there is also sparseness of data for individual users.

In this project, I implement Alternative Least Squares (ALS) and Probabilistic Matrix Factorization (PMF) from scratch. These methods are then post-processed using Singular Value Decomposition (SVD) with K-Nearest Neighbor (KNN) and Kernel Ridge Regression (KRR). Both models use root mean squared error (RMSE) to test model predictions against actual user ratings. I also add penalty of magnitudes and bias/intercept regularizations to prevent overfitting during optimization. Similar to how people create factors such as genre, actors, and directors to define movies, these methods use computer generated factors to automatically characterize items.



Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.

