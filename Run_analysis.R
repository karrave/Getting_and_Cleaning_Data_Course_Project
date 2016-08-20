
## Read all the training tables

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
SUB_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")


## Read all the test tables

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
SUB_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Read the activity labels and features

act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

features <- read.table("./UCI HAR Dataset/features.txt")


## Extract the mean and std dev mesaurements fields only

mean_std <- grep(".*mean.*|.*std.*", features[,2])


## Get mean & stddev subset data for training & test data

X_train<- X_train[,mean_std]
X_test <- X_test[,mean_std]


## Get activity names for the  data

Y_train[,1] <-act_labels[Y_train[,1],2]

Y_test[,1] <-act_labels[Y_test[,1],2]


## bind training and test data together 

train_data <- cbind(SUB_train,Y_train,X_train)
test_data <- cbind(SUB_test,Y_test,X_test)


## Merge data 

Final_data <- rbind (train_data ,test_data)

## Get column names

colhead<- gsub("[()]","",as.character(features[mean_std,2]))
colnames(Final_data) <- c("Subject", "Activity",colhead)


## write clean data

write.table(Final_data, "Clean_data.txt",row.name=FALSE)


# Get independent dataset with averages


avg_data <- ddply(Final_data, .(Subject, Activity),numcolwise(mean))

write.table(avg_data, "Average_data.txt",row.name=FALSE)

