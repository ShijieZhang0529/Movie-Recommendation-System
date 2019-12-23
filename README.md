# Project 4: Algorithm implementation and evaluation: Collaborative Filtering

### [Project Description](doc/project4_desc.md)

**Term: Fall 2019**<br>
**Team: Section 1, Group 6**

**Using Probabilistic Matrix Factorization and Large-Scale Parallel Collaborative Filtering using SVD with KNN**

**Team members**
  * Yanan Li | yl4062@columbia.edu
  * Daniel Weiss | dmw2180@columbia.edu
  * Bingquan Wu | bw2585@columbia.edu
  * Shijie Zhang | sz2781@columbia.edu
  * Na Zhuo | nz2297@columbia.edu
<br>

**Project summary:**<br>
Recommender systems are an essential part of any customer facing business. In large scale e-commerce like Amazon, Netflix and others, product recommendations can be personalized across millions of users and products to optimize sales. Companies today use Collaborative Filtering methods to combine data from different users and predict which items will appeal.

To this end, in 2006 Netflix released user and movie rating data, challenging teams to beat their algorithms's predictions. There are several challenges in working with this data set. Algorithms must be able to analyze massive amounts of data. There are many users with few ratings, which means there is also sparseness of data for individual users.

Many new methods were created, this project specifically analyzes Probabilistic Matrix Factorization (PMF) and Large-Scale Parallel Collaborative Filtering (LPCF). These methods are then post processed using Singular Value Decomposition (SVD) with K-Nearest Neighbor (KNN). Both models use root mean squared error (RMSE) to test model predictions against actual user ratings. They apply regularization terms as well to prevent overfitting during optimization. Similar to how people create factors such as genre, actors, and directors to define movies, these methods use computer generated factors to automatically characterize items.

Using cross validation to test PMF parameters, we tuned three parameters to decrease error. These were the number of factors for each user and movie and the ratio of variance in ratings to variance in user and movie features, squared. We found these values to be 10 factors and squared feature ratios of 0.1 for users and 0.2 for movies. This gave us an RMSE of 1.15.

Again using cross validation for LPCF, we tuned two parameters to decrease error. These factors were the number of features and the weight for regularization. We found these values to be 20 and 0.15, respectively. This gave us an RMSE of 1.10.
<p>&nbsp;</p>

**Contribution statement:**
* A2, Probabilistic Matrix Factorization algorithm: Yanan Li, Daniel Weiss, Na Zhuo<br>
* A3, Large-Scale Parallel Collaborative Filtering algorithm: Bingquan Wu, Shijie Zhang<br>
* P2, Post Processing SVD with KNN: Yanan Li, Bingquan Wu, Shijie Zhang<br>
* Project Summary: Daniel Weiss<br>
* Presentation: Yanan Li, Daniel Weiss<br>
* Presented by Yanan Li<br>
<br>

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

