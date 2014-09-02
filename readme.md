#### This folder contains my deliverables for course project for the "Getting and Cleaning Data" course of the JHU/Coursera Data Science specialization.

file # | file name | description
-------|-----------|-------------
1 | codebook.md | a list of the features used in the tidy dataset
2 | readme.md | **this** document
3 | run_analysis.R | the R code that aggregates and labels the data, and produces the tidy dataset
4 | tidy.txt | the main deliverable of the project; a tidy dataset with the average values of 66 metrics, for 30 subjects, in 6 different positions; see the codebook for more information on the features

#### further description of the R code, run_analysis.R:

This code should be run in the folder containing the Samsung data, available here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The code is broken-down into five main steps:
* 1. Merges testing and training data (including activity names, subject numbers, and the raw measurements) into one large data set
* 2. Extracts only the features relating to means and standard deviations
* 3. Describes the features (later exported into the codebook)
* 4. Re-labels the feature names with more intuitive variable names; note--because the file names were somewhat long, I used lowercase labels, seperated with underscores.  I felt this was more readable than just lowercase w/ no spaces, and I prefer this to other naming conventions (such as FirstUpper, camelCase, etc).
* 5. Creates a "tidy" data set with the average of each feature, grouped by activity and subject ID

Lastly, the code also exports the codebook (with the feature names from step #4 and the descriptions from step #3, above). Further inspection of the code will reveal more granular documentation.
