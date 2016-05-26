

This file explains the functioning of the scrip run_analysis.R which is written to fulfil the requirement for the "Final Project" for the Coursera "Getting and Cleaning Data" class.

This single script performs all the tasks required in the assignment. The routine performs the following operations in the specified order:

1. Reads the file “features.txt” which contains the names of all 561 features contained in the vectors. On this file, the following operations are performed
   a. Strip the numbers at the beginning of the feature name
   b. Stores the remaining characters in a character vector for future use as column names for the final tidy dataset
2. Reads the files “y_train.txt” and “y_test.txt” and:
   a. Converts the numbers to factors.
   b. Replaces the activity number with the activity name instead to make the file easier to interpret 
3. Reads the files “x_train.txt” and “x_test.txt” and:
   a. Adds the columns for subject number and activity name to each one
   b. Adds the variable name to each column 
   c. Combines the “train” and “test” datasets into a single tidy data set 
   d. Writes it out to a .csv file called “tidy_data.csv”
   e. This completes the requirement for a single, tidy data set
4. The scripts then extracts the measurements of mean and standard deviation by:
   a. Using the grep function to find which columns have a variable name that has the strings “mean” or “std” in them.
   b. Subset the tidy_dat dataset only by those columns
   c. Write out a reduced data set with only the columns that have mean and standard deviation measurements to a csv file called “red_data.csv”
   d. This completes the requirement for a reduced data set
5. The scripts them computes a summary with the averages for each activity for each subject by:
   a. Construct two vectors that have all the unique subject numbers and all unique activity names
   b. Cycle through those vector using for loops and
      i. Subset the tidy_dat dataset for each subject and activity name
      ii. Use the colMeans function to compute the column means for each column for that subset of the data
      iii. Build a summary dataset (sum_tidy) row by row as the values are compute for each subject and each activity
   c. Write the summary data set to a csv file called “sum_data.csv”
   d. This completes the requirement for a summary data set with the average of each column for each subject and each activity type.

