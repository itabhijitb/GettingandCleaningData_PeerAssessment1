
library(plyr)
#
# Constants
#
HARUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
HARZip = "getdata-projectfiles-UCI-HAR-Dataset.zip"
workdir = "work"
outputdir = "output"
TidyCSV = "tidy_data.csv"
#
# Cached Data
#
columnnames = NULL
activitynames = NULL

download <- function(overlay = FALSE)
{
  if (!file.exists(workdir))
  {
    dir.create(workdir)
  }
  if (overlay == TRUE || !file.exists(file.path(workdir, HARZip)))
  {
    download.file(HARUrl, destfile = file.path(workdir, HARZip))
    unzip(file.path(workdir, HARZip), exdir = workdir)
  }
}
readDS <- function(name)
{
  rawDS <- read.table(file.path(
    workdir,
    "UCI HAR Dataset",
    name,
    paste("X_", name, '.txt', sep = "")
  ))
  activities <- read.table(file.path(
    workdir,
    "UCI HAR Dataset",
    name,
    paste("Y_", name, '.txt', sep = "")
  ))[[1]]
  subjects <- read.table(file.path(
    workdir,
    "UCI HAR Dataset",
    name,
    paste("subject_", name, '.txt', sep = "")
  ))[[1]]
  if (is.null(columnnames))
  {
    columnnames <- as.character(read.csv(
      file.path(workdir,
                "UCI HAR Dataset",
                "features.txt"),
      header = FALSE, sep = " "
    )[[2]])
  }
  if (is.null(activitynames))
  {
    activitynames <- as.character(read.csv(
      file.path(workdir,
                "UCI HAR Dataset",
                "activity_labels.txt"),
      header = FALSE, sep = " "
    )[[2]])
  }
  meanStdIndices <- grep("mean\\(\\)|std\\(\\)", columnnames)
  
  colnames(rawDS) <- columnnames
  rawDS <- rawDS[, meanStdIndices]
  activities <- factor(activities,
                       sort(unique(activities)),
                       activitynames)
  rawDS <- cbind(Subject = subjects, Activity = activities, rawDS)
  rawDS
}

processDS <- function()
{
  trainDS <- readDS('train')
  testDS <- readDS('test')
  tidyDS <- rbind(trainDS, testDS)
  tidyMeans <- ddply(tidyDS, .(Subject, Activity),
                     function(data) {
                       colMeans(data[,-c(1,2)])
                     })
  names(tidyMeans)[-c(1,2)] <-
    paste0("Mean-", names(tidyMeans)[-c(1,2)])
  tidyMeans
}

download()
tidyMeans <- processDS()
if (!file.exists(outputdir))
{
  dir.create(outputdir)
}
write.table(tidyMeans, file = file.path(outputdir, TidyCSV), row.names = FALSE, sep = ",")
