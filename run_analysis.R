library(plyr)

####################################################################################
### PREPARE THE TRAINING SET
### It is assumed the data is already in wd

#Read the training set
xTrainingData<-read.table("UCI HAR Dataset/train/X_train.txt")
#data.frame':   7352 obs. of  561 variables: 

# Read the variable names (features) and attach them to training data
featuresData<-read.table("UCI HAR Dataset/features.txt")
colnames(xTrainingData)<-featuresData[,2]

#read the training labels (activity column)
yTrainingData<-read.table("UCI HAR Dataset/train/y_train.txt")  
names(yTrainingData)<-c("activity")

# read the subject data: Each row identifies the subject who performed the
# activity for each window sample. Its range is from 1 to 30.
subjectTrainData<-read.table("UCI HAR Dataset/train/subject_train.txt")
names(subjectTrainData)<-c("subject")

## attach label and subject columns to training set
xTrainingData<-cbind(subjectTrainData,xTrainingData, yTrainingData)

# 'data.frame':   7352 obs. of  563 variables:

####################################################################################
### PREPARE THE TEST SET
###
#Read the test set
xTestData<-read.table("UCI HAR Dataset/test/X_test.txt")
# 'data.frame':   2947 obs. of  561 variables:

# Attach variable names (features) to test data
colnames(xTestData)<-featuresData[,2]

#read the test labels
yTestData<-read.table("UCI HAR Dataset/test/y_test.txt")  
names(yTestData)<-c("activity")

# read the subject data 
subjectTestData<-read.table("UCI HAR Dataset/test/subject_test.txt")
names(subjectTestData)<-c("subject")

## attach label and subject column to test  set
xTestData<-cbind(subjectTestData, xTestData, yTestData)

# 'data.frame':   2947 obs. of  563 variables:

####################################################################################
### 1.   Merge the training and the test sets to create one data set.
###

data<-rbind(xTrainingData,xTestData) 

# 'data.frame':   10299 obs. of  563 variables:
   
####################################################################################
### 2.   Extract only the measurements on the mean and standard deviation for
### each measurement. These are columns that contain in their name the strings
### "mean()" or "std()". Uses grep to create subset of variable names that meet
### condition

subData<-data[,grep("mean\\(\\)|std\\(\\)|^activity$|^subject$", names(data))]

## data.frame':   10299 obs. of  68 variables

####################################################################################
### 3.	Uses descriptive activity names to name the activities in the data set

activityNames<-read.table("UCI HAR Dataset/activity_labels.txt")

## convert activity variable into a factor and rename the levels
subData$activity<-factor(subData$activity)
levels(subData$activity) <- activityNames[,2]

####################################################################################
### 4.	Appropriately labels the data set with descriptive variable names. 

###  Due to the length of the variable names I have used the lowerCamelCase 
###  convention to make them more readable (see
###  http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) 
###  rather than lower case only. Also, some names have been adapted according to
###  the feature descripton file, for example:
###  fBodyBodyAccJerkMag-std() has become fBodyAccJerkMag-std()

varNames<- names(subData)
#varNames <- tolower(varNames)
varNames <- gsub("-mean","Mean", varNames)
varNames <- gsub("-std","Std", varNames)
varNames <- gsub("-","",varNames)
varNames <- gsub("\\(\\)","",varNames)
varNames <- gsub("BodyBody", "Body", varNames)
names(subData)<-varNames

####################################################################################
### 5. Creates a second, independent tidy data set with the average of each
### variable for each activity and each subject.
### This results in 180 rows (30 subjects each performing 6 activities) 
### and for each combination there are the mean/sd measurements.
### The group.by columns in the new set have the same names as originally: subject and activity

#The following line is for one of the vars, and has been used to verify the results
#ddply(subData, .(activity,subject),summarize, tBodyAccMeanX=mean(tBodyAccMeanX))

result<-aggregate(subset(subData,select=-c(activity,subject)), 
                  by=list(subject=subData$subject,activity=subData$activity), 
                  FUN= mean)

# sample output:
#'data.frame':   180 obs. of  68 variables:
#   subject activity tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ tBodyAccStdX tBodyAccStdY tBodyAccStdZ
# 1       1  WALKING     0.2773308   -0.01738382    -0.1111481   -0.2837403   0.11446134   -0.2600279
# 2       2  WALKING     0.2764266   -0.01859492    -0.1055004   -0.4236428  -0.07809125   -0.4252575
# 3       3  WALKING     0.2755675   -0.01717678    -0.1126749   -0.3603567  -0.06991407   -0.3874120
# 4       4  WALKING     0.2785820   -0.01483995    -0.1114031   -0.4408300  -0.07882674   -0.5862528
# 5       5  WALKING     0.2778423   -0.01728503    -0.1077418   -0.2940985   0.07674840   -0.4570214
# 6       6  WALKING     0.2836589   -0.01689542    -0.1103032   -0.2965387   0.16421388   -0.5043242


####################################################################################
### Save result in txt file

write.table(result,file="result.txt",row.names=FALSE)
