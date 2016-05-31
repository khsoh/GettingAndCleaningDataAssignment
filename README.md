### Course Assignment for Getting And Cleaning Data

This repo contains the assignment for the "Getting and Cleaning Data" course in Coursera.

The repo contains the following:

- 'UCI_HAR_Dataset': The unzipped directory of the downloaded data for this assignment
- 'run_analysis.R' : R script for analyzing the data in UCI_HAR_Dataset.  This script must
                     be run within the same directory as itself.
- 'CodeBook.md'    : Codebook for final result grouped_means.txt
- 'grouped_means.txt' : Final output of assignment

As the assignment was not very clear as to which subset of variables was required, this
script adopted a strict interpretation - only features (as described in feature.txt)  containing "mean()" or "std()" are subsetted for the purpose of this assignment.

The script will perform the following:

- Read the dataset
- Load the activity and feature info
- Extract only the features that have mean() and std() 
- Change the names of the features to replace "-" with "_" and remove "()"
- Read in the test dataset and filter only the mean() and std() features
- Change the column names to match the filtered features.
- Add in test activity and test subject as additional columns
- Read in the test activity and test subject id datasets
- Add the activities and subjects as new columns to test dataset
- Perform the same tasks for the training dataset
- Merge the training and test datasets 
- Compute the grouped means of the variables - grouped by subject and activity
