# Data-Science
This repository features a number of examples of work I did while pursuing a [Master of Information and Data Science](https://datascience.berkeley.edu/) at UC Berkeley. I completed the MIDS degree in August 2016.

Information regarding the final Capstone Project for the degree can be found here: https://www.ischool.berkeley.edu/projects/2016/brand-buzz-reddit. This was a group project completed with my colleagues Vincent Chio, Filip Krunic and Ritesh Soni. Our final presentable, which can be accessed through the previous link, can also be viewed directly here: http://team-gilded-dashboard.herokuapp.com/

The contents of this repo are divided as follows:

* **[Audio Quality Experiment](https://github.com/hdanish/Data-Science/tree/master/Audio%20Quality%20Experiment):** My colleague Jasen Jones and I designed an experiment with the aim to answer the question of whether audio quality affects a user’s enjoyment of music. Included is a link to our final report findings, the data we collected as well as some of the code for the analysis I did using R.
* **Machine Learning Examples:** These examples are presented using Python in Jupyter notebooks and they make use of re (regex module), numpy, matplotlib and scikit-learn 
  * **Digit Classification of MNIST data:** Using the popular [MNIST database of handwritten digits](http://yann.lecun.com/exdb/mnist/), I implement a image recognition system using the k-nearest neighbors algorithm (KNN) and the naive Bayes classifier (NB).
  * **Topic Classication:** Using text data from newsgroup postings, I implement classifiers to distinguish between the topics based on the text using KNN, NB and logistic regression (LR).
  * **Exploring Properties of Mushrooms:** Using a classic dataset featuring over 8000 observations of mushrooms described using a variety of features and whether the mushrooms are poisonous or not, I use principal component analysis (PCA) to reduce the dimensionality to visualize the data. I then experiment with clustering using KMeans and density estimation using Gaussian Mixtume Models (GMM).
  * **Influencers in Social Networks:** This was a group project done based on the a [Kaggle competition for predicting which people are influential in a social network](https://www.kaggle.com/c/predict-who-is-more-influential-in-a-social-network/data). Our submission makes use of PCA, LR and ensemble methods such as bagging, boosting and random forests.
* **Streaming Tweet Processing:** Having set up a Spark cluster on SoftLayer, I use Scala and Spark streaming to build a Twitter popular topic and user reporting system.
* **Click-Through Rate (CTR) Prediction:** Using a Jupyter notebook template with Python and Spark, I use the Criteo Labs dataset from a Kaggle competion for featurizing categorical data using one-hot encoding (OHE) and predicting CTR.
