rm(list=ls())
#install.packages(c('dplyr','data.table'))
library(dplyr)
library(utils)
library(data.table)
setwd('~/') # change this if you want to use a specific directory to store all the files created by this script
setwd('./Coursera/GettingCleaning')
#dir.create('./Assignment')
setwd('./Assignment')
#url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#download.file(url,'projectfiles.zip')
#unzip('projectfiles.zip')
folder <- 'UCI HAR Dataset'
setwd(paste0('./',folder))
labels <- fread('activity_labels.txt')   # read in the meaning of each activity label (e.g '1' = 'walking')
features <- fread('features.txt') # read in the meaning of every measured variable 
a<-grepl('mean\\W|std\\W', features[,V2],fixed=F) # only retain variables that are either a mean/sd 
colclass <- ifelse(a, 'character', 'NULL') # create a vector to determine which features to read in -- this will substantially speed up reading process
testset <- as.data.table(read.delim2('./test/X_test.txt',sep='',header=F, colClasses=colclass))  # reading in necessary test data
setnames(testset,tolower(gsub("\\(|\\)",'',features[a][,V2]))) # changing headers to descriptive variable names
testset[,group:='test'] # include information that the subject was part of the test group
subjecttest <- fread('./test/subject_test.txt',header=F) # information on subject of recorded vector 
activitytest1 <- fread('./test/y_test.txt',header=F) # information on activity of recorded vector 
activitytest <- merge(activitytest1,labels,by="V1",all=T,sort=F) # replace activity number by descriptive activity name
testset[,subject:=subjecttest] # add information on subject
testset[,activity:=tolower(activitytest[,V2])] # add information on activity
trainset <- as.data.table(read.delim2('./train/X_train.txt',sep='',header=F,colClasses=colclass)) # reading in necessary train data
setnames(trainset,tolower(gsub("\\(|\\)",'',features[a][,V2]))) # changing headers to descriptive variable names
trainset[,group:='train'] # include information that the subject was part of the test group
subjecttrain <- fread('./train/subject_train.txt',header=F) # information on subject of recorded vector 
activitytrain1 <- fread('./train/y_train.txt',header=F) # information on activity of recorded vector
activitytrain <- merge(activitytrain1,labels,by="V1",all=T,sort=F) # replace activity number by descriptive activity name
trainset[,subject:=subjecttrain] # add information on subject
trainset[,activity:=tolower(activitytrain[,V2])] # add information on activity


DT <- rbind(trainset,testset) # combine test and train data in one data table

DTnew <- DT[, lapply(.SD, as.numeric),by=list(group,activity)] # cast all numeric values as such
DT2 <- DTnew[order(activity,subject), lapply(.SD, mean),by=list(subject,activity,group)] # calculated aggregated mean over activity/subject pairs
write.table(DT2,file='tidyset.txt',row.names = F) # write out resulting tidy dataset to a csv file
