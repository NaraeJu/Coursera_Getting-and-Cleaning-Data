# Coursera_Getting-and-Cleaning-Data
Assignment project of a course of getting and cleaning data from coursera

This is a repository from Narae Ju created for the pupose of submission of the assignment from a course of Getting and Cleaning Data.

The dataset was obtained from a reserach of Human Acitivity Recognition Using Smartphones Dataset (http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

This repo inlcudes the following files:
- 'README.md'
- 'Codebook.md': The description of how the script works and what each variables represent
- 'run_analysis.R': R script of how the data was prepared and followed by the 5 steps required to follow for the course assignment.
  1. Merge train and test datasets
  2. Extract the measurements on the mean and standard deviation (std) for each measurements
  3. Use descriptive activity names to name the acitivites in the dataset
  4. Put appropriate lables in the dataset with descriptive variables names
  5. Make a second, independet tidy dataset with the avaerage of each variable for each acitivity and subject
- 'Tidydata.txt': Tidy dataset exported from step 5 containing each subject, activity, and the mean of each variables.
