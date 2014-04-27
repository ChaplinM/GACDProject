## Introduction

First make sure you have navigated to the correct working directory and that this contains `run_analysis.R`. Then ensure that the `data.table` package (and any others that might be missing) are installed and loaded (there are commented out lines in the script that would do this).

## Running the script

Run the script from RStudio by issuing the following command `source("run_analysis.R")` from the R Console. 
Parts of the script may take some time to run, but it should not be overly slow.

## What the script produces

Running the script will result of the definition of several new variables and a function, as well as the creation of the two output datafiles in your working directory.

### Variables defined

The script will result in definition of the following variables in the environment:
* subject_train
* X_train
* y_train
* subject_test 
* X_test 
* y_test 
* subject_all - training + test subjects
* X_all - training + test feature data
* y_all - training + test activities
* lookup_features 
* lookup_activity_labels
* lookup_act() function
* toMatch - values for regex column filtering
* matches - values for regex column filtering
* X_mean_std
* data_mean_std - the data table for the first dataset
* data_all
* mean_bygroup - the data frame for the second datset

### Files created

The two files that will be created are:
* "data_mean_std.txt" - the first dataset
* "mean_bygroup.txt" - the second dataset



