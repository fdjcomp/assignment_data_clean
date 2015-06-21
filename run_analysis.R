#general remarks
#rawdata:"getdata_projectfiles_UCI HAR Dataset.zip"
#unzipped into dir './course_data', in current working directory, see result of getwd()
#therefore the root becomes root <- "./course_data/UCI_HAR_Dataset"
#read data from files where filename given by "root/fname"
#immediately during reading set columnames where feasible

## indicates copied illustrative script output

#load needed library
library(dplyr)

#get the names of the 561 vars from features.txt
root <- "./course_data/UCI_HAR_Dataset"
fname <- "features.txt" 
pfname <- sprintf("%s/%s", root, fname)
dffeat <- read.table(pfname, col.names=c("var_num", "var_name"), stringsAsFactors=FALSE )

##> str(dffeat)
##'data.frame':   561 obs. of  2 variables:
## $ var_num : int  1 2 3 4 5 6 7 8 9 10 ...
## $ var_name: chr  "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ...

#get the descriptive names of the activities
root <- "./course_data/UCI_HAR_Dataset"
fname <- "activity_labels.txt" 
pfname <- sprintf("%s/%s", root, fname)
dfact_labels<- read.table(pfname, col.names=c("id", "activity_name"), stringsAsFactors=FALSE )

#make the factor corresponding to the activities
#put ids in vector, give ids=integers=levels names according to "activity_name"
actlevels<-dfact_labels$id
names(actlevels)<-dfact_labels$activity_name

##> str(actlevels)
## Named int [1:6] 1 2 3 4 5 6
## - attr(*, "names")= chr [1:6] "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...

#read train set
root <- "./course_data/UCI_HAR_Dataset/train"

fname <- "subject_train.txt" 
pfname <- sprintf("%s/%s", root, fname)
dfst <- read.table(pfname, col.names=c("subject"))

fname <- "y_train.txt" 
pfname <- sprintf("%s/%s", root, fname)
dfact <- read.table(pfname, col.names=c("activity"))

fname <- "X_train.txt" 
pfname <- sprintf("%s/%s", root, fname)
#read data and set col names from features.txt
dfXvec <- read.table(pfname, col.names=dffeat$var_name)

#select cols only mean or std
dfXvec_selcols<-select(dfXvec, matches("(mean|std)"))

#now join dfst, dfact, dfXvec_selcols to one df for the train set
dftrain<-data.frame(dfst, dfact, dfXvec_selcols)

##> str(dftrain)
##'data.frame':   7352 obs. of  88 variables
## $ subject                             : int  1 1 1 1 1 1 1 1 1 1 ...
## $ activity                            : int  5 5 5 5 5 5 5 5 5 5 ...
## $ tBodyAcc.mean...X                   : num  0.289 0.278 0.28 0.279 0.277 ...
## note: other 87 variables not shown

#read test set
root <- "./course_data/UCI_HAR_Dataset/test"

fname <- "subject_test.txt" 
pfname <- sprintf("%s/%s", root, fname)
dfst <- read.table(pfname, col.names=c("subject"))

fname <- "y_test.txt" 
pfname <- sprintf("%s/%s", root, fname)
dfact <- read.table(pfname, col.names=c("activity"))

fname <- "X_test.txt" 
pfname <- sprintf("%s/%s", root, fname)

#read data and set col names from features.txt
dfXvec <- read.table(pfname, col.names=dffeat$var_name)

#select cols only mean or std
dfXvec_selcols<-select(dfXvec, matches("(mean|std)"))

#now join dfst, dfact, dfXvec_selcols to one df for the test set
dftest <- data.frame(dfst, dfact, dfXvec_selcols)

##> str(dftest)
##'data.frame':   2947 obs. of  88 variables:
## $ subject                             : int  2 2 2 2 2 2 2 2 2 2 ...
## $ activity                            : int  5 5 5 5 5 5 5 5 5 5 ...
## $ tBodyAcc.mean...X                   : num  0.257 0.286 0.275 0.27 0.275 ...
## note: other 87 variables not shown

#join the two df's
dfall<-rbind(dftest,dftrain)

##> str(dfall)
##'data.frame':   10299 obs. of  88 variables:
## $ subject                             : int  2 2 2 2 2 2 2 2 2 2 ...
## $ activity                            : int  5 5 5 5 5 5 5 5 5 5 ...
## $ tBodyAcc.mean...X                   : num  0.257 0.286 0.275 0.27 0.275 ...
## note: other 87 variables not shown

#set subject and activity column to factor
dfall$subject<-factor(dfall$subject)

#use previously read activity names as factor names
dfall$activity<-factor(dfall$activity, levels=actlevels, labels=names(actlevels))


#task 1 to 4 is now done
#data.frame "dfall": realizes point 1-4 of the task by joining the two data sets and naming all variables

##> str(dfall)
##'data.frame':   10299 obs. of  88 variables:
## $ subject                             : Factor w/ 30 levels "1","2","3","4",..: 2 2 2 2 2 2 2 2 2 2 ...
## $ activity                            : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
## $ tBodyAcc.mean...X                   : num  0.257 0.286 0.275 0.27 0.275 ...
## note: other 87 variables not shown



#task-5
#From the data set in step 4 (=dfall), creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

#group
tmpby<-group_by(dfall, subject, activity)

#produces a table with grouped by subject and activity giving the mean of each var
task5_table<-summarise_each(tmpby, funs(mean))

##> task5_table
##Source: local data frame [180 x 88]
##Groups: subject
##
##   subject activity tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z tBodyAcc.std...X tBodyAcc.std...Y tBodyAcc.std...Z
##1        1        1         0.2773308      -0.017383819        -0.1111481      -0.28374026      0.114461337      -0.26002790
##2        1        2         0.2554617      -0.023953149        -0.0973020      -0.35470803     -0.002320265      -0.01947924
##3        1        3         0.2891883      -0.009918505        -0.1075662       0.03003534     -0.031935943      -0.23043421
##4        1        4         0.2612376      -0.001308288        -0.1045442      -0.97722901     -0.922618642      -0.93958629
##5        1        5         0.2789176      -0.016137590        -0.1106018      -0.99575990     -0.973190056      -0.97977588
##6        1        6         0.2215982      -0.040513953        -0.1132036      -0.92805647     -0.836827406      -0.82606140
##7        2        1         0.2764266      -0.018594920        -0.1055004      -0.42364284     -0.078091253      -0.42525752
##8        2        2         0.2471648      -0.021412113        -0.1525139      -0.30437641      0.108027280      -0.11212102
##9        2        3         0.2776153      -0.022661416        -0.1168129       0.04636668      0.262881789      -0.10283791
##10       2        4         0.2770874      -0.015687994        -0.1092183      -0.98682228     -0.950704499      -0.95982817
##


#write out the table
root <- "./course_data/UCI_HAR_Dataset"
fname <- "tidydata.txt" 
pfname <- sprintf("%s/%s", root, fname)
write.table(task5_table, pfname, row.name=FALSE)

#for peer-reviewers
##final check
##data <- read.table(pfname, header = TRUE)
##View(data)



#codebook
#Informationaboutthevariables(includingunits!)inthe
#data set not contained in the tidy data
#• Information about the summary choices you made
#• Information about the experimental study design you
#used
#


#====================================================================================
#get indexes within the group of 561 vars of matches for "-Mean", "-mean" and "-std"
#this will include also means like "fBodyGyro-meanFreq()-X"
#these are the col_names in X_train.txt or X_test.txt
#integer index of columns to keep
#idx<-grep("(-[Mm]ean|-std)", dffeat$var_name)


#NOTCLEAR IF TO BE DONE
#IS NOT TO BE DONE, SEE FORUM discussion
#drop cols with "std"
#dfallmean<-select(dfall, -matches("std"))

#> str(dfallmean)
#'data.frame':   10299 obs. of  55 variables:
# $ subject                             : Factor w/ 30 levels "1","2","3","4",..: 2 2 2 2 2 2 2 2 2 2 ...
# $ activity                            : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ tBodyAcc.mean...X                   : num  0.257 0.286 0.275 0.27 0.275 ...



