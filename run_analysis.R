library(data.table)
download_data <- function()
{
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ", 
                "getdata-projectfiles-UCI-HAR-Dataset.zip")
  unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}
#download_data()

DTActivity_names <- read.table('./UCI HAR Dataset/features.txt')
DTTrain_subjects <- scan('./UCI HAR Dataset/train/subject_train.txt', what = integer(0))
DTTrain <- read.table('./UCI HAR Dataset/train/X_train.txt')
setnames(DTTrain, as.character(DTTrain_names$V2))
DTTrain$subjects <- DTTrain_subjects

DTTest <- read.table('./UCI HAR Dataset/test/X_test.txt')
setnames(DTTest, as.character(DTTrain_names$V2))
DTTest_subjects <- scan('./UCI HAR Dataset/test/subject_test.txt', what = integer(0))
DTTest$subjects <- DTTest_subjects

DTActivity <- rbind(DTTrain, DTTest)
for(name in DTTrain_names$V2)
{
    if(!grepl( "mean|std", name))
    {
      DTActivity[name] <- NULL
    }
}
DTActivity_avg <- aggregate(DTActivity, by=list(DTActivity$subjects),FUN=mean)
DTActivity_avg$Group.1 <- NULL
write.csv(file = "tidy_data.txt", x = DTActivity_avg)
