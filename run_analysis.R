packages <- c("data.table", "reshape2")
require("data.table")
require("reshape2")


# 1) Merge the training and the test sets to create one data set.
setwd("E:/Coursera/03. Getting and Cleaning data/Project")
homeDir<-getwd()

trainDir<-paste0(homeDir,"/UCI HAR Dataset/train")
testDir<-paste0(homeDir,"/UCI HAR Dataset/test")

setwd(trainDir)
getwd()

subjTrain = read.table("subject_train.txt", sep=" ", col.names=c("subject"))
tTrain = read.table("X_train.txt", sep="" )
activTrain = read.table("y_train.txt", sep=" ", col.names=c("activityNo"))




setwd(testDir)
getwd()

subjTest = read.table("subject_test.txt", sep="", col.names=c("subject"))
tTest = read.table("X_test.txt", sep="" )
activTest = read.table("y_test.txt", sep="", col.names=c("activityNo"))


#Read the "features.txt" into a data frame (the measurements names)
featuresPath <- paste0(homeDir,"/UCI HAR Dataset")
setwd(featuresPath)
getwd()
features = read.table("features.txt", sep="")

#make the elements from factors to characters in order to be able to split them with strsplit
features<-data.frame(lapply(features, as.character), stringsAsFactors=FALSE)
colnames(features) <- c("featNo","featName")
features$featNo<-as.numeric(as.character(features$featNo))
features$featName<-as.character(features$featName)

vectMeas<-features$featName
vectMeas


names(tTest)<-vectMeas
names(tTrain)<-vectMeas

#Merge the 3 data frames with train information into 1 data frame.
dfTrain <- cbind(subjTrain, activTrain, tTrain)
#Merge the 3 data frames with test information into 1 data frame.
dfTest <- cbind(subjTest, activTest, tTest)


#Merge the Train and Test data frames into All data frame
dfAll<- rbind(dfTrain, dfTest)

#Order the data frame with all the results by subject number and activity number.
dfAll<-dfAll[with(dfAll, order(subject, activityNo)), ]









# 2) Extract only the measurements on the mean and standard deviation for each measurement. 

#Keep just the rows where The Mean and Standard deviation are mentioned
extractedMeas <- features[grepl("mean\\(\\)|std\\(\\)", features$featName),]


#From the original data set, in the measurements column, keep just the elements of each list (row) that
#correspond to the numbers in the featNo column in the features data frame.
feat.sel <- dfAll[,extractedMeas$featNo+2]
feat.sel<-cbind(dfAll[,1:2],feat.sel)









# 3) Use descriptive activity names to name the activities in the data set

dfActiv = read.table("activity_labels.txt", sep="")
#make the elements from factors to characters in order to be able to split them with strsplit
#dfActiv<-data.frame(lapply(dfActiv, as.character), stringsAsFactors=FALSE)
#Split the string in each row into 2 columns, Number numeric and Name character

colnames(dfActiv) <- c("activityNo","activityName")

desc.feat<-merge(feat.sel,dfActiv,by="activityNo",all=TRUE)
#Reorder the order of the columns
ord.feat<-desc.feat[,c(2,1,69,3:68)]


# 4) Appropriately label the data set with descriptive variable names. 

# 5) Create a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 

tidyData <- tapply(ord.feat[,4:69],ord.feat$subject,mean)

library(reshape2)
t1=melt(ord.feat,id.vars=c("activityName","subject"))


meas.labels<-extractedMeas$featName
feat.melt <- melt(ord.feat,id=c("subject","activityName"),measure.vars=meas.labels)
AvData <- dcast(feat.melt, subject + activityName ~ variable, mean)
