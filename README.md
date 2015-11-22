# GettingandCleaningData_PeerAssessment1

This is part of the Project work for the Coursera course Getting and Cleaning Data

1. Forkout this project 
2. Ensure that you have write access to the folder containing the script run_analysis.R
3. Ensure that you have net connectivity and you are not behind a firewall.
4. Run the script run_analysis.R
  4.1 Incase the script fails to download the file
  
    4.1.1 Create a directory work under the Script Home directory. (Script Home directory is the path containing the R Script)
    
    4.1.2 Download the archive from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip as getdata-projectfiles-UCI-HAR-Dataset.zip
    
    4.1.3 Unzip the content under the work directory
    
    4.1.4 Ensure that you have the following folder structure
    
```    
      $ROOT
        |
        \-->run_anaysis.R
        |
        \-->getdata-projectfiles-UCI-HAR-Dataset
        |
        \-->work
             |
             \--> UCI HAR Dataset
                   |
                   \-->(files in the archive)
```

    4.1.5 Rerun the SCript.
5. Ensure that it creates a directory named output under the Script Home folder and it contains a file tidy_data.csv
6. Open the file tidy_data.csv and verify the content is the same
