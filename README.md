======================================================================
Getting and Cleaning Data - Coursera Data Science Specialization Track
======================================================================

README
--------
Assignment Week 4 
=================

This file describes how to run the 'run_analysis.R' script in order to produce the 'tidyset.csv' file.
Although comments in the script describe most of the operations, a general overview of the steps is given as well.

How to run the script for the first time
========================================

- Be aware that new directories will be created in whatever directory is set as your standard directory for R.
  If you want to allocate another directory to the project, please alter the location of the first setwd('~/') statement.
- Uncomment all lines that start with a '#', unless the one with the install.packages statement if you have the dplyr and data.table package already installed.
- Line 10-12 will read in the data set made available online as partially described in 'CodeBook.md'.
- Rest of the code is explained in the script.


How to run the script for a second/third... time
================================================

- If you have already downloaded the data set, you can comment line 7-12.
  Make sure however that line 6 is as follows setwd('location that contains the UCI HAR Dataset folder')

Output
======

The output of this script is a file called 'tidyset.csv', located in the 'UCI HAR Dataset' folder.
This file contains the averages for all the 66 features that were either a mean or the standard deviation of original measurements.
An average value (vector) is given for every activity/subject pair.
The third column 'group' mentions whether the subject was part of the training or test set.