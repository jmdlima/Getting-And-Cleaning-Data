library(reshape2)
library(plyr)


# Check if the directory and data exists
# Download data if not already done
if (!file.exists("./Course Project")) { dir.create("./Course Project")}
setwd("Course Project")

if (!file.exists("UCI HAR Dataset.zip")) { 
    fileurl ="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl,destfile="Data.zip")
    unzip("UCI HAR Dataset.zip",exdir=".")
}

# read the txt files into R
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")


X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")

features<-read.table("./UCI HAR Dataset/features.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")

# check the structure of the files to determine the fields to manipulate
dim(X_test)
dim(y_test)
dim(subject_test)
dim(features)
str(activity_labels)
dim(X_train)
dim(y_train)
dim(subject_train)

#assign descriptive variable names
names(activity_labels)<-c("ActivityId","Activity_Desc")

names(subject_train)<-"subjectID"
names(subject_test)<-"subjectID"

names(X_test)<-features$V2
names(X_train)<-features$V2

names(y_test)<-"ActivityId"
names(y_train)<-"ActivityId"


# As the number of rows are the same for the test related files 
#Combine all the test related files into one consolidated file called test
# Do the same process for train

test.activity<-merge(y_test,activity_labels)
test<-cbind(subject_test,test.activity,X_test)

train.activity<-merge(y_train,activity_labels)
train<-cbind(subject_train,train.activity,X_train)

test_train<-rbind(test,train)


#2 Extract only the measurements on the mean and standard deviation for each measurement.
mean<-grepl("mean()",names(test_train),fixed=T)
std<-grepl("std()",names(test_train),fixed=T)
mean_std<-mean|std
variablesdf<-test_train[,mean_std]
vars<-names(variablesdf)

# Retains the subjectId , Activity Id and Activity Description fields
mean_std[1:3] <-TRUE

consolidated<-test_train[,mean_std]

#5: Creates a second, independent tidy data set with the
## average of each variable for each activity and each subject.

#dop the unwanted columns
#applies the ddply function from 

consolidated %>% melt(id.vars=c("subjectID","Activity_Desc")) %>%
    tapply(variable,list(subjectID,Activity_Desc,mean)) %>%
    ##ddply(.(subjectID, Activity_Desc, variable), summarize, mean = mean(value)) %>%
    ##dcast(subjectID + Activity_Desc ~ variable,value.var="mean") %>%
  write.csv("Mytidy.csv",row.names=F)

