Course Project: Shiny Application and Reproducible Pitch
========================================================
author:Julian Paolo S. Alejandro
date: August 11, 2019
autosize: true

<style>
.small-code pre code {
  font-size: 0.8em;
}
.reveal .state-background {
  background: lightblue;
} 
</style>

Application Overview: Breast Cancer Tumor Prediction
========================================================
css: custom.css

This shiny web application entitled, "Breast Cancer Tumor Prediction" enables user to predict the type of tumor associated with breast cancer whether it is **benign** or **malignant**. To give you a background. A **tumor** is an abnormal lump or growth of cells. 

The prediction model was built using the rpart (recursive partitioning and regression trees) method on a training dataset comprised of 70% of the dataset. In addition to the prediction, the classification tree from which the prediction was derived is shown on the main panel including the Top 5 features that greatly contributes to the prediction.  

Application Building: Breast Cancer Tumor Prediction
========================================================
class: small-code



A. Loading Data and Partitioning


```r
data_tumor <- read.csv('breast_cancer_dataset.csv')
inTrain <- createDataPartition(y=data_tumor$class, p = 0.7, list=FALSE)
training <- data_tumor[inTrain,]; testing <- data_tumor[-inTrain,]
str(data_tumor)
```

```
'data.frame':	569 obs. of  10 variables:
 $ clump_thickness            : int  5 5 3 6 4 8 1 2 2 4 ...
 $ uniformity_of_cell_size    : int  1 4 1 8 1 10 1 1 1 2 ...
 $ uniformity_of_cell_shape   : int  1 4 1 8 1 10 1 2 1 1 ...
 $ marginal_adhesion          : int  1 5 1 1 3 8 1 1 1 1 ...
 $ single_epithelial_cell_size: int  2 7 2 3 2 7 2 2 2 2 ...
 $ bare_nuclei                : int  1 10 2 4 1 10 10 1 1 1 ...
 $ bland_chromatin            : int  3 3 3 3 3 9 3 3 1 2 ...
 $ normal_nucleoli            : int  1 2 1 7 1 7 1 1 1 1 ...
 $ mitosis                    : int  1 1 1 1 1 1 1 1 5 1 ...
 $ class                      : int  2 2 2 2 2 4 2 2 2 2 ...
```

B. Model Development using **rpart** Method


```r
tumor_model <- train(class ~ ., method="rpart", data=data_tumor)
```

Application Building: Breast Cancer Tumor Prediction
========================================================
class: small-code

C. Classification Tree
<center>

```r
fancyRpartPlot(tumor_model$finalModel)
```

![plot of chunk three](course proj-figure/three-1.png)
</center>

Application Building: Breast Cancer Tumor Prediction
========================================================
class: small-code

D. Variable Importance
<center>

```r
rpart_imp <- varImp(tumor_model, scale = FALSE)
plot(rpart_imp, top = 5)
```

![plot of chunk four](course proj-figure/four-1.png)
</center>

Application Building: Breast Cancer Tumor Prediction
========================================================
class: small-code

E. Running a Sample New Input

```r
userInput <-data.frame(3,4,3,2,1,5,6,1,1)
names(userInput)<-c("clump_thickness","uniformity_of_cell_size","uniformity_of_cell_shape",
                    "marginal_adhesion","single_epithelial_cell_size","bare_nuclei",
                    "bland_chromatin","normal_nucleoli","mitosis")
levels(data_tumor$class)[predict(tumor_model,newdata=userInput)]
```

```
NULL
```

Breast Cancer Tumor Prediction Links
========================================================

Shiny Application:  
https://jsalejandro.shinyapps.io/CourseProj/


Github Repository:  
