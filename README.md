## Getting and Cleaning Data Course Project
### Contents of the answer

* README.md: describes how the R script works
* codebook.txt: describes the data set obtained and the preprocessing done on the original variables. 
* features_info.txt: Shows information about the variables used on the feature vector on the original dataset. This file was part of the original dataset
* run_analysis.R: script used to read the data, merge the original training and the test sets to create one data set, extract only variables corresponding to mean and standard deviation of measurements, and creates a tidy data set with the average of each variable for each activity and each subject. This final data set is described in this codebook.
* result.txt: the resulting data file 

### Notes on running the script

* In order to process the data, run script *run_analysis.R*. 
* The script assumes that the UCI HAR Dataset folder is in the working directory. 


###How the script works: Transformations done on the original data

The following transformations were done on the original data and are performed by the attached R script run_analysis.txt:

1. Preparing the training data, by merging in one file the data, the feature names, the activity labels, and the subjects. All of these were separate files in the original data, resulting in 7352 obs. of  563 variables.  

2. Preparing the test data in the same way, resulting in 2947 obs. of 563 variables

3. Concatenating the training and test records into a single data set, resulting in  10299 obs. of 563 variables. 

4. Extracting only the variables with mean and standard deviation for each measurement (variables that contain in their name the strings "mean()" or "std()"), resulting in 10299 obs. of 68 variables.

5. Changing the values of the activity labels from integer to the set (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) by converting the int variable into a factor and renaming the levels. 

6. Changing the variable names to be more descriptive. Due to the length of the variable names I have used the lowerCamelCase convention to make them more readable (see http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) rather than using lower case only. Also, some names have been adapted according to the feature description file. In particular the steps followed were: 
  + remove (,),-
  + capitalize first letter of “mean” and “std”
  + change the string “BodyBody” in some of the vars to “Body”

7. Creating a second, independent tidy data set with the average of each  variable for each activity and each subject, resulting in 180 obs. of  68 variables. 
 
8. Writing the data into as a txt file created with write.table() using row.names=FALSE as requested in the assignment.
