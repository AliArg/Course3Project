## Getting and Cleaning Data 
## Course project
## Codebook

The data used for this assignment is based on the UCI HAR dataset (Human Activity Recognition Using Smartphones Dataset, V 1.0 by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) which represents data collected from the accelerometers from the Samsung Galaxy S smartphone. 

The original experiment was carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the authors captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The files README.txt and features_info.txt on that site describe the experiments and the data collected.

*This codebook describes the data developed during the assignment*


### Feature Selection in the original data set

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

### Feature Selection in the current data set

The aim of this course project has been to summarize the data by averaging the variables by subject and activity. Given that there are 30 subjects and 6 activities the resulting data has 180 records. 

The assignment focuses only on variables that reflected *means and averages* of the sensor readings, and which included “-mean()-“ or “-average()-“ in their names. These are 66 variables, listed below.

### Files included

* codebook.txt
* features_info.txt: Shows information about the variables used on the feature vector on the original dataset. This file was part of the original dataset
* run_analysis.R: script used to read the data, merge the original training and the test sets to create one data set, extract only variables corresponding to mean and standard deviation of measurements, and creates a tidy data set with the average of each variable for each activity and each subject. This final data set is described in this codebook.
* result.txt: the resulting tidy data setm which can be read back into R using read.table
* README.txt: describes how the R script works


*For each record in the result.txt data file the following are provided*

* An identifier of the subject who carried out the experiment.
* Its activity label. 
* A 66-feature vector with time and frequency domain variables. 
    + Each value is the average from the original readings for a given subject and activity label. 
    + The original readings had been normalized and bounded within [-1,1]. 
    + For the meaning of each reading see **features_info.txt**
    + Variable names have been adapted to follow lowerCamelCase convention for clarity.
    + Each feature vector is a row on the text file. 
    
The 66 features are:


tBodyAccMeanX

tBodyAccMeanY

tBodyAccMeanZ

tBodyAccStdX

tBodyAccStdY

tBodyAccStdZ

tGravityAccMeanX

tGravityAccMeanY

tGravityAccMeanZ

tGravityAccStdX

tGravityAccStdY

tGravityAccStdZ

tBodyAccJerkMeanX

tBodyAccJerkMeanY

tBodyAccJerkMeanZ

tBodyAccJerkStdX

tBodyAccJerkStdY

tBodyAccJerkStdZ

tBodyGyroMeanX

tBodyGyroMeanY

tBodyGyroMeanZ

tBodyGyroStdX

tBodyGyroStdY

tBodyGyroStdZ

tBodyGyroJerkMeanX

tBodyGyroJerkMeanY

tBodyGyroJerkMeanZ

tBodyGyroJerkStdX

tBodyGyroJerkStdY

tBodyGyroJerkStdZ

tBodyAccMagMean

tBodyAccMagStd

tGravityAccMagMean

tGravityAccMagStd

tBodyAccJerkMagMean

tBodyAccJerkMagStd

tBodyGyroMagMean

tBodyGyroMagStd

tBodyGyroJerkMagMean

tBodyGyroJerkMagStd

fBodyAccMeanX

fBodyAccMeanY

fBodyAccMeanZ

fBodyAccStdX

fBodyAccStdY

fBodyAccStdZ

fBodyAccJerkMeanX

fBodyAccJerkMeanY

fBodyAccJerkMeanZ

fBodyAccJerkStdX

fBodyAccJerkStdY

fBodyAccJerkStdZ

fBodyGyroMeanX

fBodyGyroMeanY

fBodyGyroMeanZ

fBodyGyroStdX

fBodyGyroStdY

fBodyGyroStdZ

fBodyAccMagMean

fBodyAccMagStd

fBodyAccJerkMagMean

fBodyAccJerkMagStd

fBodyGyroMagMean

fBodyGyroMagStd

fBodyGyroJerkMagMean

fBodyGyroJerkMagStd


### Transformations done on the original data
The following transformations were done on the original data and are performed by the attached R script run_analysis.txt:

1. Preparing the training data, by merging in one file the data, the feature names, the activity labels, and the subjects. All of these were separate files in the original data, resulting in 7352 obs. of  563 variables.  

2. Preparing the test data in the same way, resulting in 2947 obs. of 563 variables

3. Concatenating the training and test records into a single data set, resulting in  10299 obs. of 563 variables. 

4. Extracting only the variables with mean and standard deviation for each measurement (variables that contain in their name the strings "mean()" or "std()"), resulting in 10299 obs. of 68 variables.

5. Changing the values of the activity labels from integer to the set (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) by converting the int variable into a factor and renaming the levels. 

6. Changing the variable names to be more descriptive. Due to the length of the variable names I have used the lowerCamelCase convention to make them more readable (see http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) rather than using lower case only. Also, some names have been adapted according to the feature description file. In particular the steps followed were: 
    + remove (,  ), -
    + capitalize first letter of “mean” and “std”
    + change the string “BodyBody” in some of the vars to “Body”

7. Creating a second, independent tidy data set with the average of each  variable for each activity and each subject, resulting in 180 obs. of  68 variables. 
 
8. Writing the data into as a txt file created with write.table() using row.names=FALSE as requested in the assignment.


### License
Use of the original dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


