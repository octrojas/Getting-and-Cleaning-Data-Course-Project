#Merging the training and the test sets to create one data set.
train<-read.table("X_train.txt")
test<-read.table("X_test.txt")
merge<-rbind(train, test)

#Labelling the data set with descriptive variable names.
features<-read.table("features.txt")
names<-features[,2]
colnames(merge)<-names

#Extracting the measurements on the mean and standard deviation for each measurement.
extractmeansd<- merge[,grep ("mean|std", colnames(merge))]
extract<- extractmean[,-grep("meanFreq()", colnames (extractmeansd))]

#Using descriptive activity names to name the activities in the data set
activities_test<-read.table("y_test.txt")
activities_train<-read.table("y_train.txt")
activities<-rbind(activities_train, activities_test)
activities$V1<-gsub("1", "WALKING", activities$V1)
activities$V1<-gsub("2", "WALKING_UPSTAIRS", activities$V1)
activities$V1<-gsub("3", "WALKING_DOWNSTAIRS", activities$V1)
activities$V1<-gsub("4", "SITTING", activities$V1)
activities$V1<-gsub("5", "STANDING", activities$V1)
activities$V1<-gsub("6", "LAYING", activities$V1)
colnames(activities)<- "Activity"
merge<-cbind(merge, activities)

#Including the subjects IDs in the dataset
subject_test<-read.table("subject_test.txt")
subject_train<-read.table("subject_train.txt")
subject<-rbind(subject_train, subject_test)
colnames(subject)<- "Subject"
merge<-cbind(merge, subject)

#Creating a independent tidy data set with the average of each variable for each activity and each subject.
tidy_data<-aggregate(.~Activity+Subject, data = merge, FUN=mean)
write.table(tidy_data,"tidy_data.txt", row.name = FALSE)




