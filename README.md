# README

This is the the README for the "Getting and Cleaning Data Course" assignment from the Coursera DataScience course, June 2015.

The assignment uses data from the "Human Activity Recognition Using Smartphones Dataset" (see [CodeBook](/CodeBook.md/)).

For a group of 30 persons, mobile phone accelerometer and gyroscope data were obtained (resulting in a total of 561 variables, raw and processed data) during six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, where each activity was performed a number of times for each person). 

The "run_analysis.R" script takes raw data from this project, and produces a table of means for selected variables, grouped by person and by activity.

This file explains the use of the "run_analysis.R" script: 

- how the raw data were obtained
- the data folder / file layout
- which input files were used
- what intermediate data variables were used
- the selection of variables to keep from the original 561
- how the data sets "train" and "test" were joined
- what output was produced (final table in "tidydata.txt").

The variable descriptions (codebook) for the final table in "tidydata.txt" are in the [CodeBook](/CodeBook.md/).


## Download raw data

Download rawdata file "getdata_projectfiles_UCI HAR Dataset.zip" from

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> ,

as given on the assignment page

steps for reading the various files

- make a subdir of the working dir called "course_data"
- unzip rawdata file into dir './course_data', 
- folder / file layout is then:

> Folder ./course_data/UCI_HAR_Dataset/test

> Folder ./course_data/UCI_HAR_Dataset/train

> ./course_data/UCI_HAR_Dataset/activity_labels.txt

> ./course_data/UCI_HAR_Dataset/features.txt

> ./course_data/UCI_HAR_Dataset/features_info.txt

> ./course_data/UCI_HAR_Dataset/README.txt

in "run_analysis.R" the root for file reading becomes root "./course_data/UCI_HAR_Dataset"

script reads data from files where filename to read is given by "root/fname"

## Reading the data and producing dataframe with all needed data (this completes step 1-4 of the assignment)

Immediately during reading the columnames are set where feasible / available

"run_analysis.R" proceeds by reading 

- "features.txt" : to get names of the 561 variables

- "activity_labels.txt" : to properly get integer levels and associated names of the activities

Then the "train set" and "test set" data are read from their respective folders

in each folder there are the following 3 files

- "subject_test.txt": integer for each subject, range 1-30

- "y_test.txt": integer for each activity, range 1-6

- "X_test.txt": for each line of subject-activity, a 561 element vector


for each file read

- a dataframe is produced, with the correct column names by reading each of these files
(one dataframe for subject, one for activity, one for the 561 vector elements, colum names from "features.txt", as indicated above)
- the matching (name has "mean" or "std") columns are selected from the vector data (the rest are discarded)
- for each set, these three dataframes are united in one dataframe (giving intermediate dataframes: dftrain, dftest)

these two dataframes (dftrain, dftest) are then joined with rbind to one dataframe named  "dfall" 

as a final step

- the subject column is made into a factor
- the activity column is equally transformed to a factor (using the vector produced from reading "activity_labels.txt")

this completes step 1 to 4 of the task

## Producing the tidy table (step 5 of the assignment)

from the data set in step 4 (dfall), create a second, independent tidy data set 
with the average of each variable for each activity and each subject.
(the selection of these variables was already done in step 1-4)

using dplyr functions "group_by" and "summarise_each"

group the data with

> tmpby<-group_by(dfall, subject, activity)

produce a table grouped by subject and activity giving the mean of each var
(ie each mean var and each std var)

> task5_table<-summarise_each(tmpby, funs(mean))

write the table out to "tidydata.txt"
end result will be in file

>./course_data/UCI_HAR_Dataset/tidydata.txt

for review of the data
from the supplied link on the review page of the assignment
download "tidydata.txt" to your working dir
then in R

>	data <- read.table("tidydata.txt", header = TRUE)

>	View(data)











