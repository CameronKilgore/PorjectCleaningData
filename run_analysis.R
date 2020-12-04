
'Bring on the initial featurse and activity labels datasets'
library(stringr)
features<-read.table("./UCI HAR Dataset/features.txt")[,2]
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt",
                            col.names = c("ActivityNumber","Activity"))
'Clean up the activity names'
activity_labels[,2]<-str_to_title(gsub("_", " ",activity_labels[,2]))

'section should be either "Test" or "Train"
This cleans the train and test datasets to only
include the means and standard devs, cleans up the names, and
combines the activity names and subjects.'
initial_clean<-function(section){
  if(section != "Test" & section != "Train"){
    print("Invalid section")
    stop()
  }
  
  if(section=="Test"){
    X_temp<-read.table("./UCI HAR Dataset/test/X_test.txt")
    Y_temp<-read.table("./UCI HAR Dataset/test/Y_test.txt",
                       col.names="ActivityNumber")
    temp_subjects<-read.table("./UCI HAR Dataset/test/subject_test.txt",
                              col.names="Subject")
  }
  else if(section=="Train"){
      X_temp<-read.table("./UCI HAR Dataset/train/X_train.txt")
      Y_temp<-read.table("./UCI HAR Dataset/train/Y_train.txt",
                         col.names="ActivityNumber")
      temp_subjects<-read.table("./UCI HAR Dataset/train/subject_train.txt",
                                col.names="Subject")
  }
  names(X_temp)<-features
  trimX<-X_temp[,grep("-mean\\(\\)|-std\\(\\)",names(X_temp))]
  
  activities<-paste(section,merge(Y_temp, activity_labels, 
                    by.y="ActivityNumber")$Activity)
  
  trimX<-cbind(temp_subjects, activities,trimX)
  names(trimX)<-gsub("-std\\(\\)", " Standard Deviation",
                     gsub("-mean\\(\\)", " Mean", names(trimX)))
  return(trimX)
}

'calls function for test and clean dataset'
test_set<-initial_clean("Test")
train_set<-initial_clean("Train")
'brings the train set onto the test set'
tidy_set<-rbind(test_set,train_set)
'Finds mean based on subject and activity of each variable'
means<-aggregate(tidy_set[,3:ncol(tidy_set)],
                 list(tidy_set$Subject,tidy_set$activities), FUN=mean)

names(means)<-c("Subject","Activity",names(means)[3:length(means)])

'exports both datasets'
write.table(tidy_set,file="./tidy_dataset.txt")
write.table(means,file="./means.txt")