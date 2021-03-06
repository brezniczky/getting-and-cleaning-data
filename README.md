## Overview

### Directory contents

This directory contains 3 files and this README, which are all part of the solution of the Coursera Getting and Cleaning Data course project of Janos Brezniczky.

### Project specification

The project specification for this task was:

    "You should create one R script called run_analysis.R that does the following. 

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 

    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
    
### Resulting Files

Name | Contents
---- | --------
_run_analysis.R_ | A detailed R script that creates a tidy data set with the above specifics from the raw data files.
_CodeBook.md_ | Provides information on the interpretation and history of each variable in the resulting tidy data.
_tidy_data.txt_ | The resulting tidy data, as generated by the _run_analysis.R_ script.

The raw data files were be obtained from the [Human Activity Recognition Using Smartphones Dataset Version 1.0](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

In order to run this script, this data is expected to exist unzipped in the R working directory (_setwd()_ can be used to achieve this if necessary). The directory is supposed to contain the _test_ and _train_ subdirectories as well as _activity_labels.txt_, _features.txt_ files etc.