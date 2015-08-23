### Raw data

This data set is exclusively based on the [Human Activity Recognition Using Smartphones Dataset
Version 1.0](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

For details on how that data was collected, or the raw data itself, please refer to the accompanying documents contained within that compressed archive.

### Processed data

#### Summary

Processing the data results in a table saved as text (in _tidy_data.txt_) by _write.table()_.

Column Name|Data Type|Description
-----------|---------|-----------
activity|Text|Activity name,  one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING (further described in the raw data archive).
subject |Integer|Subject ID
...     |Numeric|Further columns contain means of original mean and standard deviation values, broken down by subject and activity ID.

#### Column naming

Original feature names have been embedded inside the parentheses of a mean( ) to emphasize that the values are now the means broken down by test subject and activity. Example: _mean(tBodyAcc-mean()-Y)_.

#### Transformations applied

1. The train and test measurement sets are merged.

2. Columns are assigned their respective feature names.

3. Only mean and standard deviation fields are kept (those with names containing _-std()_ or _-mean()_).

4. Train and test activity codes are read up from the files and are merged.

5. Activity codes are replaced by names: the activity code to activity key assigment is read up and applied. This as a column is appended to the table in Step 3 as "activity".

6. Train and test subjects IDs are read up from the respective files and are merged. The resulting sequence is appended as the "subject" column. This gives Data 1.

7. Mean values are calculated for each column other than subject ID and activity of Data 1, grouped by subject ID and activity.

8. The calculated mean values are iteratively joined together as calculated using the subject ID + activity as the key, to continuously extend a table of these means.

9. Columns resulting from step 7. are named as "Column naming" in the joined table.

10. The joined table is saved as the processed data file (_tidy_data.txt_).
