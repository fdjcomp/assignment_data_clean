## Project Description

This is the codebook for the "Getting and Cleaning Data Course" assignment from the Coursera DataScience course, June 2015.

The assignment uses data from the "Human Activity Recognition Using Smartphones Dataset" (see reference below)

For a group of 30 persons, mobile phone accelerometer and gyroscope data were obtained (resulting in a total of 561 variables, raw and processed data) during six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING, where each activity was performed a number of times for each person).  

For this assignment, after reading the available data for each person and activity, keeping only the variables labelled as "mean" and "std" (standard deviation) from the whole list of 561 variables, a "tidy" table is produced giving the mean for the selected variables per person/activity.  


### Study design and data processing
 
#### Collection of the raw data

Rawdata file "getdata_projectfiles_UCI HAR Dataset.zip" downloaded from

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>,

as given on the assignment page

The zip file contains data files for a "train" and a "test" set which were rejoined to get one dataframe from which the final table was produced. 

##### Notes on the original (raw) data 

The original raw data come with various explanatorty files

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

which explain 

- what data are in the various files (so that they can be read and given appropriate interpretation) 

- the names of all 561 variables, from which are selected only those which are a mean or a standard deviation

The original data have been split into a "train" and "test" set, which need to be joined back again.

#### Creating the tidy datafile

- download the raw data zip file
- unzip in appropriate directory
- run the "run_analysis.R" script which will
    - read the "features.txt" to get the 561 vector variable names
    - read the "activity_labels.txt": to get integer factor levels and associated names of the activities
    - per set ("train" or "test") read the three files 

        - "subject_test.txt": integer for each subject, range 1-30
    
        - "y_test.txt": integer for each activity, range 1-6
    
        - "X_test.txt": for each line of subject-activity, a 561 element
          vector (and keep only variables with "mean" or "std" in their name)
    - where possible set the colum names when reading 
    - join the three dataframes to a "train" and "test" dataframe
    - join the "train" and "test" dataframe
    - the subject column is made into a factor and the activity column is equally transformed to a factor 
    - from this dataframe produces the final table (by grouping per subject and activity and taking the mean of all kept variables)

See the [README](/README.md/) for a detailed description


### Description of the variables in the tidy_data.txt file


As shown by str(data),
'tidydata.txt' has:   180 obs. of  88 variables:

- 01 - subject - 30 total                  : int  1 1 1 1 1 1 2 2 2 2 ...

- 02 - activity                            : Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1 4 6 5 2 ...

- 03 - 88
a total of 86 - variables like
tBodyAcc.mean...X                   : num  0.277 0.255 0.289 0.261 0.279 ...


#### Variable 01: Subject
class: integer

values: range 1-30, each integer identifies one subject

#### Variable 02: Activity 
class: factor

number of levels: 6

levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING


#### Variable number 03 to 88
Each variable is a mean, for the quantity indicated by its name, for the available measurements of this quantity per person and per activity (so we get means of quantities which are a mean and means of quantities which are a standard deviation).

A subset of the original 561 variables was selected: only those variables with "mean" or "std" in their original name
(see all 561 original name in the file "features.txt", present in the raw data)

For the exact nature of the raw measurements see the "features_info.txt" file in the raw data: this indicates how accelerometer and gyroscope 3-axial raw signals are transformed into the 561 feature set

##### Note on variable names
original names are like "tBodyAcc-mean()-X"
in the current "tidydata.txt" the '()-' sequence has been converted to '...'
(this happens on reading the data with read.table, where the columnames are set from the names as found in the "features.txt")

#### Names of variable number 03 to 88

03-tBodyAcc.mean...X                    
04-tBodyAcc.mean...Y                     
05-tBodyAcc.mean...Z                     
06-tBodyAcc.std...X                     
07-tBodyAcc.std...Y                      
08-tBodyAcc.std...Z                      

09-tGravityAcc.mean...X                 
10-tGravityAcc.mean...Y                 
11-tGravityAcc.mean...Z                 
12-tGravityAcc.std...X                 
13-tGravityAcc.std...Y                  
14-tGravityAcc.std...Z                  

15-tBodyAccJerk.mean...X               
16-tBodyAccJerk.mean...Y                
17-tBodyAccJerk.mean...Z                
18-tBodyAccJerk.std...X                
19-tBodyAccJerk.std...Y                 
20-tBodyAccJerk.std...Z                 

21-tBodyGyro.mean...X                  
22-tBodyGyro.mean...Y                   
23-tBodyGyro.mean...Z                   
24-tBodyGyro.std...X                   
25-tBodyGyro.std...Y                    
26-tBodyGyro.std...Z                    
27-tBodyGyroJerk.mean...X              
28-tBodyGyroJerk.mean...Y               
29-tBodyGyroJerk.mean...Z               
30-tBodyGyroJerk.std...X               
31-tBodyGyroJerk.std...Y                
32-tBodyGyroJerk.std...Z                

33-tBodyAccMag.mean..                  
34-tBodyAccMag.std..                    

35-tGravityAccMag.mean..                
36-tGravityAccMag.std..                

37-tBodyAccJerkMag.mean..               
38-tBodyAccJerkMag.std..                

39-tBodyGyroMag.mean..                 
40-tBodyGyroMag.std..                   
41-tBodyGyroJerkMag.mean..              
42-tBodyGyroJerkMag.std..              

43-fBodyAcc.mean...X                    
44-fBodyAcc.mean...Y                    
45-fBodyAcc.mean...Z                   
46-fBodyAcc.std...X                     
47-fBodyAcc.std...Y                     
48-fBodyAcc.std...Z                    
49-fBodyAcc.meanFreq...X                
50-fBodyAcc.meanFreq...Y                
51-fBodyAcc.meanFreq...Z               
52-fBodyAccJerk.mean...X                
53-fBodyAccJerk.mean...Y                
54-fBodyAccJerk.mean...Z               
55-fBodyAccJerk.std...X                 
56-fBodyAccJerk.std...Y                 
57-fBodyAccJerk.std...Z                
58-fBodyAccJerk.meanFreq...X            
59-fBodyAccJerk.meanFreq...Y            
60-fBodyAccJerk.meanFreq...Z           

61-fBodyGyro.mean...X                   
62-fBodyGyro.mean...Y                   
63-fBodyGyro.mean...Z                  
64-fBodyGyro.std...X                    
65-fBodyGyro.std...Y                    
66-fBodyGyro.std...Z                   
67-fBodyGyro.meanFreq...X               
68-fBodyGyro.meanFreq...Y               
69-fBodyGyro.meanFreq...Z              

70-fBodyAccMag.mean..                   
71-fBodyAccMag.std..                    
72-fBodyAccMag.meanFreq..              

73-fBodyBodyAccJerkMag.mean..           
74-fBodyBodyAccJerkMag.std..            
75-fBodyBodyAccJerkMag.meanFreq..      

76-fBodyBodyGyroMag.mean..              
77-fBodyBodyGyroMag.std..               
78-fBodyBodyGyroMag.meanFreq..         
79-fBodyBodyGyroJerkMag.mean..          
80-fBodyBodyGyroJerkMag.std..           
81-fBodyBodyGyroJerkMag.meanFreq..     

82-angle.tBodyAccMean.gravity.          
83-angle.tBodyAccJerkMean..gravityMean. 
84-angle.tBodyGyroMean.gravityMean.    
85-angle.tBodyGyroJerkMean.gravityMean. 
86-angle.X.gravityMean.                 
87-angle.Y.gravityMean.                
88-angle.Z.gravityMean.        



###Sources / References

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012)

