## Cleaning Data
Data sciences coursera course by Johns Hopkins - getdata-030

Creates R script called run_analysis.R that does the following on the data collected from the accelerometers 
from the Samsung Galaxy S smartphone:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names.
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## run_analysis.R Code
The run_analysis.R script is heavily annotated and self explanatory.
Given the inputs of the Samsung Galaxy S smartphone datasets in the working directory it creates a tidydata.txt file
Whilst creating the merged dataset,the liberty was taken to merge only the required mean and std measures in the interest of storage efficiency. Alternatively, one could have merged the test and train data and do columns selectection later with dplyr.
The only subtlty is that appropriate melt and cast functions are used from reshape2 package to calculate required means.

## Processing logic

Gave appropriate labels to the variables in the train and test dataset from the feautres vector.

Activity ids were replaced by their corresponding names in the datasets created from y_train.txt and y_test.txt. Also the column was labelled as 'Activity'.

The datasets created from train_subject.txt and test_subject.txt were given the label of 'Subject'

Regular expression was used to restrict the training and test datasets to the columns with mean() and std().

The columns of subject, activity and data were combined to produce a unified dataset for both test and training.

These restricted datasets were combined to produce the restricted merged dataset of measures of interest.

Melt/Cast were used to find mean for subject/activity for each measure.

The tidydata.txt was produced from the above transformations.
