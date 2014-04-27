## Introduction

The dataset used for this project comes from kinematic readings taken from Galaxy S Smartphone, made available as a zip file. The detailed data files contained in "InertialSignals" sub-directories have not been used. The main breakdown is between "training" and "test" groups of datasets. 
Within these two groups, there are datasets for the following three items:
* subject - this is the person's ID as a number
* X - this contains the set of all features (e.g. acceleration in each of three axes) and consists of various statistics on these features, e.g. mean, standard deviation, etc.
* y - this contains the 
It is assumed that the numbering within each of the three datasets (for test and for train) is consistent, so they can be simply pasted together "side-by-side" using `cbind`. In what follows I will refer to datasets as if they have been named in accordance with the files from which they are read using `read.table`.

## Format of the lookup data

There are files that contain the definitions of activity levels, and meaningful names for the features themselves (see "Format of X" subsection below).

The activity levels are loaded into a data table called `lookup_activity_labels` that consists of six rows and two columns, namely:
* V1: the activity number (int)
* V2: the activity name (factor with six levels)

The feature names are loaded into a data table called `lookup_features` that consists of 561 rows and two columns, namely:
* V1: the feature number (int)
* V2: the feature name (factor with 477 levels - not sure why this is not 561)

## Format of the datasets

The format of the three datasets is unique to each. Of these the X (features) is by far the trickiest so I will start there.

### Format of X (X_train or X_test)

After reading the file into a data.table, the format of this dataset is 561 numerical variables named V1 .. V561. By using the `setnames` function, the lookup values from`lookup_features` are assigned to the column names.
Once this has been done the column names have the following format: <i>descriptor-function()-furtherQualifier</i>.
The descriptor indicates the type of reading, e.g. tBodyAcc indicates bodily acceleration. The function is typically a statistical function such as `mean` or `std`. The further qualifier is optional and is typically used to indicate the axis direction in which that measurement is taken (X, Y or Z). 

### Format of y (y_train or y_test)

After reading the file into a data.table, the format of this dataset is a single integer variables called V1. This is the activity identifier. By applying the custom function `lookup_act` to every observation, these activity identifiers are translated into activity names. 

### Format of subject (subject_train or subject_test)

After reading the file into a data.table, the format of this dataset is a single integer variables called V1. This is simply the subject's identifier and needs no further transformation.

## The full merged dataset

Each of the three datasets is merged across the training and test groups by using the `rbind` function. Then the these three datasets (activities, subjects and features) are merged column-wise by using `cbind`.

## Format of the output data

The output datasets are much like the full combined dataset (with activity, subject, and all features) but with differences either in columns (dataset 1 has fewer columns, dataset 1 has fewer rows).

### Format of the first dataset containing means and standard deviations

This dataset is a subset of the full combined dataset (train+test rows, y(activity)+subject+X(features) columns). It consists of the total number of rows in the training and test dataset and the following variables:
* activity (a factor variable with levels: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING" )
* subject (an integer identifier for the subject)
* numeric feature columns limited to those that pertain to means or standard deviations (i.e. contain "mean()" or "std()" in the column names), the first few of which are: tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X)

### Format of the second dataset containing subtotals

This dataset consists of as many rows as there are distinct combinations of activity and subject, and the following columns:
* activity (a factor variable with levels: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING" )
* subject (an integer identifier for the subject)
* all numeric feature columns, the first few of which are: tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z, tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z, tBodyAcc-mad()-X) 
The values in the rows under the feature columns are the means of the relevant column across the particular combination of activity and subject indicated by the first two columns of that row. It was assumed that it was appropriate to do a straight average of measurements across different cases even though some individuals (subjects) may have provided a lot more data than others.




