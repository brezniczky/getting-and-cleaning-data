# Please do not forget to set the working directory as described in 
# the README before running this script.

# clear the workspace?
# rm(list = ls())

# Expectations:
#
# "Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# 
# From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject."

# read in and merge the data sets: train and test
train = read.table(file ="train/X_train.txt", header = FALSE, dec = ".", sep = "", strip.white = FALSE)
test  = read.table(file ="test/X_test.txt", header = FALSE, dec = ".", sep = "", strip.white = FALSE)
full = rbind(train, test)

# (save memory)
rm(train)
rm(test)

# select only the variables of interest:
# mean and standard deviation values
features = read.table(file = "features.txt", stringsAsFactors = FALSE)[, 2]

# giving (even if not too nice) names at an early stage
# can help inspecting the data, do it
colnames(full) <- features

# filter for the mean and standard deviation columns
relevant.features = grep("-mean\\(\\)|-std\\(\\)", features)
full = full[, relevant.features]

# read up activity codes
train.act.codes = read.table(file = "train/y_train.txt")
test.act.codes = read.table(file = "test/y_test.txt")
act.codes = rbind(train.act.codes, test.act.codes)

# convert them to labels -
# get the table first
act.label.table = read.table("activity_labels.txt", stringsAsFactors = FALSE)
act.labels = act.label.table[act.codes[, 1], 2]

# keep labeling the data set with descriptive names
new.names = c(colnames(full), "activity")
full = cbind(full, act.labels)
colnames(full) <- new.names

# now that the full data set is ready, create 
# a third data set with subjects (= step 4) 
train.subj = read.table(file = "train/subject_train.txt")
test.subj = read.table(file = "test/subject_test.txt")
subj = rbind(train.subj, test.subj)

new.names = c(colnames(full), "subject")
full.with.subj = cbind(full, subj)
names(full.with.subj) = new.names

# "From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each activity 
# and each subject."
library(dplyr)
grouped = group_by(full.with.subj, activity, subject)

#full$`tBodyAcc-mean()-X`
n.cols.to.calc = ncol(full.with.subj) - 2

for(col in (1 : n.cols.to.calc)) {
  summarised.col = summarise(grouped, paste0("mean(`", colnames(full.with.subj)[col], "`)"))
  if (col == 1) {
    tidy.data = summarised.col
  }
  else {
    tidy.data = merge(tidy.data, summarised.col)
  }
}

# clean the column names:
colnames(tidy.data) <- 
  # remove double or single quotes (twice - only one gets removed in each go)
  sub("\"|`", "",
      # remove 
      sub("\"|`", "", colnames(tidy.data))
  )

# output the file
write.table(tidy.data, "tidy_data.txt", row.name = FALSE)
