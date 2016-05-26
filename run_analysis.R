#
# Script file to complete the final project for the Coursera "Getting and 
# cleaning data" class.  
# 

# load all needed libraries

library(dplyr)
library(RCurl)
library(httr)

# Clear memory

rm(list=ls())

# Set working directory to the correct address

setwd("C:/Users/jchacin72799/Documents/R/Sample Scripts/Coursera/Getting and Cleaning Data/Week 4/Final Project")

#################### Parts 1,3 and 4 of the project ########################################

# Read in the file "features.txt"

features <- read.table("./features.txt",sep = "\t", header = FALSE, stringsAsFactors = FALSE)

# Strip out the numbers and blank spaces at the beginning of the strings so they can be
# used as column names

names <- apply(features, 1, function(x){as.character(sub("^[0-9]* ","",x))})

# Add two more names to this array for the first two columns of the final tidy data set 

names <- c("Subject","Activity",names)

# Read in the activity data set for both the train and test data sets

y_test <- read.csv2("./test/y_test.txt",sep = ",", header = FALSE, stringsAsFactors = FALSE)
y_train <- read.csv2("./train/y_train.txt",sep = ",", header = FALSE, stringsAsFactors = FALSE)

# Change the activity designation numbers to factors instead

y_test <- as.factor(y_test[,1])
y_train <- as.factor(y_train[,1])

# Change the factor numbers for descriptive names instead

levels(y_test) <- c("Walk","Walk Up","Walk Down","Sit","Stand","Lay")
levels(y_train) <- c("Walk","Walk Up","Walk Down","Sit","Stand","Lay")

# Read in the subject designation file for both the train and test data sets

test_sub <- read.table("./test/subject_test.txt",sep = "\t", header = FALSE, stringsAsFactors = FALSE)
train_sub <- read.table("./train/subject_train.txt",sep = "\t", header = FALSE, stringsAsFactors = FALSE)

# Read in the full featured data vector for both the training and test data sets. Treat files as
# fixed width

x_test <- read.delim("./test/X_test.txt", sep = "", header = FALSE)
x_train <- read.delim("./train/X_train.txt",sep = "", header = FALSE)

# Attach subject and activity columns to the datasets

x_test <- cbind(test_sub,y_test,x_test)
x_train <- cbind(train_sub,y_train,x_train)

# Set variable names and Write tidy data to new file in csv format

names(x_test) <- names
names(x_train) <- names

# Combine both measurements into a single data set

tidy_data <- rbind(x_test,x_train)

# Write out the tidy data set to a csv file

write.csv(tidy_data,file = "./tidy_data.csv", row.names = FALSE)

############## Part 2 of Project #######################################################

# Extract only the measurements for the mean and standard deviation from the tidy data set

red_col <- c(grep("mean",names),grep("std",names))
red_col <- sort(red_col)

# Add back the first and second column with the subject and activity names

reduced <- c(1:2,red_col)

# Extract and write out the reduced data set

red_data <- tidy_data[,reduced]
write.csv(red_data,file = "./red_data.csv", row.names = FALSE)

############## Part 5 of Project #######################################################

# Subset dataset by subject and activity

subj <- unique(tidy_data[,1])           # Number of subjects
acti <- unique(tidy_data[,2])           # Number of activities

f <- 0          # First time counter

for (i in subj) {
    for (j in acti) {
        temp <- tidy_data[{tidy_data$Subject == i & tidy_data$Activity == j},]  # Subset data
        tempMeans <- colMeans(temp[,3:ncol(temp)])                              # Compute column means
        temp1 <- data.frame(as.factor(i),as.factor(j))
        temp1[,3:ncol(tidy_data)] <- tempMeans
        if (f == 0) {
            sum_tidy <- temp1
            f <- 1
        } else {
            sum_tidy <- rbind(sum_tidy,temp1)
        }
    }
}

# Write output table

names(sum_tidy) <- names
write.table(sum_tidy,file = "./sum_data.txt", row.names = FALSE)



