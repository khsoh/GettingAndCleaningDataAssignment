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
