install.packages("reshape")
install.packages("reshape2")
library(reshape)
library(reshape2)


setwd("C:\\Users\\Ahmad\\Downloads\\Data Science\\Mid")
list.files()
# read data into data frames
X_test <- read.table("X_test.txt")
Y_test <- read.table("Y_test.txt")
X_train <- read.table("X_train.txt")
Y_train <- read.table("Y_train.txt")
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")
test_sub <- read.table("subject_test.txt")
train_sub <- read.table("subject_train.txt")


# combine files into one dataset
Subjects <- rbind(test_sub,train_sub)
y <- rbind(Y_train,Y_test)
x <- rbind(X_train,X_test)
final <- cbind(Subjects,y)
final <- cbind(final,x)

# determine which columns contain "mean()" or "std()"
indexes <- grep("mean|std",features[,2])
indexes <- indexes+2
indexes <- c(1,2,indexes)
# remove unnecessary columns
f_dataset <- final[,indexes]



indexes <- grep("mean|std", features[,2])

feature_titles <- features[,2]
features_titles <- feature_titles[indexes]
features_titles <- lapply(features_titles, as.character)
features_titles <- c("Subjects", "Activity", features_titles)

colnames(f_dataset) <- features_titles

#Appropriately labels the data set with descriptive
#activity names

activity_labels <- read.table("activity_labels.txt")
activity_titles <- activity_labels[,2]
activities_titles <- lapply(activity_titles, as.character)
f_dataset <- within(f_dataset, Activity <- factor(Activity, labels = activities_titles))




# average of each variable for each activity and each subject
# create the tidy data set
melting <- melt(f_dataset, id=c("Subjects","Activity"))
tidying <- dcast(melting, Subjects+Activity ~ variable, mean)

# write the tidy data set to a file
write.table(tidying, "tidy_Data.txt", row.names=FALSE)



