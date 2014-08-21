
## Course project for JHU/Coursera 'Getting and Cleaning Data' Course
##
# This code:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. 


#1. Merge data ################################################################

# gathers data
setwd('') ## enter working directory with UCI HAR data!!!
data <- rbind(read.table('test/X_test.txt'), read.table('train/X_train.txt'))
activity <- rbind(read.table('test/y_test.txt'), read.table('train/y_train.txt'))
subjects <- rbind(read.table('test/subject_test.txt'), read.table('train/subject_train.txt'))
features <- read.table('features.txt')
features <- as.character(features[,2])

# recodes activities per the README file
activity[activity==1] <- "Walking"
activity[activity==2] <- "Walking_Upstairs"
activity[activity==3] <- "Walking_Downstairs"
activity[activity==4] <- "Sitting"
activity[activity==5] <- "Standing"
activity[activity==6] <- "Laying"

# binds subject and activity to data and adds "subject" to features list
data <- cbind(subjects, activity, data)
rm(activity, subjects)
features <- c("subject", "activity", features)

# names columns according to the features list
library(data.table)
colnames(data)[1] <- 'subject'
colnames(data)[2] <- 'activity'
setnames(data, old = c(names(data)), new = c(as.character(features)))



#2. Extracts mean and standard deviation values ###############################

# finds features with "mean()" and "std()" in the name
mean.features <- features[grepl("mean()", features, fixed=TRUE)==TRUE]
std.features <- features[grepl("std()", features, fixed=TRUE)==TRUE]

# subsets data with the above feature names and drops unnecessary vectors
data <- data[c("subject", "activity", mean.features, std.features)]
data <- cbind(data[c(2)], data[c(1)], data[-c(1:2)]) ## slight reordering
rm(features, mean.features, std.features)



#3. Create descriptive activity names (for codebook) ##########################

descriptions <- vector()  ## initializes the vector
descriptions[1] <- "Activity type: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing, Laying"
descriptions[2] <- "Subject number (1-30)"
descriptions[3] <- "Average time domain signals of the body, recorded by the x-axis of the phone's accelerometer"
descriptions[4] <- "Average time domain signals of the body, recorded by the y-axis of the phone's accelerometer"
descriptions[5] <- "Average time domain signals of the body, recorded by the z-axis of the phone's accelerometer"
descriptions[6] <- "Average time domain signals of the body's gravity, recorded by the x-axis of the phone's gyroscope"
descriptions[7] <- "Average time domain signals of the body's gravity, recorded by the y-axis of the phone's gyroscope"
descriptions[8] <- "Average time domain signals of the body's gravity, recorded by the z-axis of the phone's gyroscope"
descriptions[9] <- "Average jerk, derived from body linear acceleration and angular velocity, recorded by the x-axis of the phone's accelerometer"
descriptions[10] <- "Average jerk, derived from body linear acceleration and angular velocity, recorded by the y-axis of the phone's accelerometer"
descriptions[11] <- "Average jerk, derived from body linear acceleration and angular velocity, recorded by the z-axis of the phone's accelerometer"
descriptions[12] <- "Average time domain signals of the body, recorded by the x-axis of the phone's gyroscope"
descriptions[13] <- "Average time domain signals of the body, recorded by the y-axis of the phone's gyroscope"
descriptions[14] <- "Average time domain signals of the body, recorded by the z-axis of the phone's gyroscope"
descriptions[15] <- "Average jerk, derived from body linear acceleration and angular velocity, recorded by the x-axis of the phone's gyroscope"
descriptions[16] <- "Average jerk, derived from body linear acceleration and angular velocity, recorded by the y-axis of the phone's gyroscope"
descriptions[17] <- "Average jerk, derived from body linear acceleration and angular velocity, recorded by the z-axis of the phone's gyroscope"
descriptions[18] <- "Average value of the magnitude of the time domain signals of the body, recorded by the phone's accelerometer"
descriptions[19] <- "Average value of the magnitude of the time domain signals of the body's gravity, recorded by the phone's gyroscope"
descriptions[20] <- "Average value of the magnitude of the jerk, derived from body linear acceleration and angular velocity, recorded by the phone's accelerometer"
descriptions[21] <- "Average value of the magnitude of the time domain signals of the body, recorded by the phone's gyroscope"
descriptions[22] <- "Average value of the magnitude of the jerk, derived from body linear acceleration and angular velocity, recorded by the phone's gyroscope"
descriptions[23] <- "Average value of the frequency domain signals, of the body, recorded by the x-axis of the phone's accelerometer"
descriptions[24] <- "Average value of the frequency domain signals, of the body, recorded by the y-axis of the phone's accelerometer"
descriptions[25] <- "Average value of the frequency domain signals, of the body, recorded by the z-axis of the phone's accelerometer"
descriptions[26] <- "Average value of the frequency domain signals, of the jerk, derived from body linear acceleration and angular velocity, recorded by the x-axis of the phone's accelerometer"
descriptions[27] <- "Average value of the frequency domain signals, of the jerk, derived from body linear acceleration and angular velocity, recorded by the y-axis of the phone's accelerometer"
descriptions[28] <- "Average value of the frequency domain signals, of the jerk, derived from body linear acceleration and angular velocity, recorded by the z-axis of the phone's accelerometer"
descriptions[29] <- "Average value of the frequency domain signals, of the body, recorded by the x-axis of the phone's gyroscope"
descriptions[30] <- "Average value of the frequency domain signals, of the body, recorded by the y-axis of the phone's gyroscope"
descriptions[31] <- "Average value of the frequency domain signals, of the body, recorded by the z-axis of the phone's gyroscope"
descriptions[32] <- "Average value of the magnitude of the frequency domain signals of the body, recorded by the phone's accelerometer"
descriptions[33] <- "Average value of the magnitude of the jerk of the frequency domain signals, derived from body linear acceleration and angular velocity, recorded by the phone's accelerometer"
descriptions[34] <- "Average value of the magnitude of the frequency domain signals of the body, recorded by the phone's gyroscope"
descriptions[35] <- "Average value of the magnitude of the jerk of the frequency domain signals, derived from body linear acceleration and angular velocity, recorded by the phone's gyroscope"
descriptions[36] <- "Standard deviation of the time domain signals of the body, recorded by the x-axis of the phone's accelerometer"
descriptions[37] <- "Standard deviation of the time domain signals of the body, recorded by the y-axis of the phone's accelerometer"
descriptions[38] <- "Standard deviation of the time domain signals of the body, recorded by the z-axis of the phone's accelerometer"
descriptions[39] <- "Standard deviation of the time domain signals of the body's gravity, recorded by the x-axis of the phone's gyroscope"
descriptions[40] <- "Standard deviation of the time domain signals of the body's gravity, recorded by the y-axis of the phone's gyroscope"
descriptions[41] <- "Standard deviation of the time domain signals of the body's gravity, recorded by the z-axis of the phone's gyroscope"
descriptions[42] <- "Standard deviation of the jerk, derived from body linear acceleration and angular velocity, recorded by the x-axis of the phone's accelerometer"
descriptions[43] <- "Standard deviation of the jerk, derived from body linear acceleration and angular velocity, recorded by the y-axis of the phone's accelerometer"
descriptions[44] <- "Standard deviation of the jerk, derived from body linear acceleration and angular velocity, recorded by the z-axis of the phone's accelerometer"
descriptions[45] <- "Standard deviation of the time domain signals of the body, recorded by the x-axis of the phone's gyroscope"
descriptions[46] <- "Standard deviation of the time domain signals of the body, recorded by the y-axis of the phone's gyroscope"
descriptions[47] <- "Standard deviation of the time domain signals of the body, recorded by the z-axis of the phone's gyroscope"
descriptions[48] <- "Standard deviation of the jerk, derived from body linear acceleration and angular velocity, recorded by the x-axis of the phone's gyroscope"
descriptions[49] <- "Standard deviation of the jerk, derived from body linear acceleration and angular velocity, recorded by the y-axis of the phone's gyroscope"
descriptions[50] <- "Standard deviation of the jerk, derived from body linear acceleration and angular velocity, recorded by the z-axis of the phone's gyroscope"
descriptions[51] <- "Standard deviation of the magnitude of the time domain signals of the body, recorded by the phone's accelerometer"
descriptions[52] <- "Standard deviation of the magnitude of the time domain signals of the body's gravity, recorded by the phone's gyroscope"
descriptions[53] <- "Standard deviation of the magnitude of the jerk, derived from body linear acceleration and angular velocity, recorded by the phone's accelerometer"
descriptions[54] <- "Standard deviation of the magnitude of the time domain signals of the body, recorded by the phone's gyroscope"
descriptions[55] <- "Standard deviation of the magnitude of the jerk, derived from body linear acceleration and angular velocity, recorded by the phone's gyroscope"
descriptions[56] <- "Standard deviation of the frequency domain signals, of the body, recorded by the x-axis of the phone's accelerometer"
descriptions[57] <- "Standard deviation of the frequency domain signals, of the body, recorded by the y-axis of the phone's accelerometer"
descriptions[58] <- "Standard deviation of the frequency domain signals, of the body, recorded by the z-axis of the phone's accelerometer"
descriptions[59] <- "Standard deviation of the frequency domain signals, of the jerk, derived from body linear acceleration and angular velocity, recorded by the x-axis of the phone's accelerometer"
descriptions[60] <- "Standard deviation of the frequency domain signals, of the jerk, derived from body linear acceleration and angular velocity, recorded by the y-axis of the phone's accelerometer"
descriptions[61] <- "Standard deviation of the frequency domain signals, of the jerk, derived from body linear acceleration and angular velocity, recorded by the z-axis of the phone's accelerometer"
descriptions[62] <- "Standard deviation of the frequency domain signals, of the body, recorded by the x-axis of the phone's gyroscope"
descriptions[63] <- "Standard deviation of the frequency domain signals, of the body, recorded by the y-axis of the phone's gyroscope"
descriptions[64] <- "Standard deviation of the frequency domain signals, of the body, recorded by the z-axis of the phone's gyroscope"
descriptions[65] <- "Standard deviation of the magnitude of the frequency domain signals of the body, recorded by the phone's accelerometer"
descriptions[66] <- "Standard deviation of the magnitude of the jerk of the frequency domain signals, derived from body linear acceleration and angular velocity, recorded by the phone's accelerometer"
descriptions[67] <- "Standard deviation of the magnitude of the frequency domain signals of the body, recorded by the phone's gyroscope"
descriptions[68] <- "Standard deviation of the magnitude of the jerk of the frequency domain signals, derived from body linear acceleration and angular velocity, recorded by the phone's gyroscope"



#4. Applies new variable names ################################################
# Note, due to the length of the variable names, 
# I used underscores to make the labels more readable

colnames(data)[3] <- "time_signal_body_acc_mean_x_axis"
colnames(data)[4] <- "time_signal_body_acc_mean_y_axis"
colnames(data)[5] <- "time_signal_body_acc_mean_z_axis"
colnames(data)[6] <- "time_signal_gravity_acc_mean_x_axis"
colnames(data)[7] <- "time_signal_gravity_acc_mean_y_axis"
colnames(data)[8] <- "time_signal_gravity_acc_mean_z_axis"
colnames(data)[9] <- "time_signal_body_acc_jerk_mean_x_axis"
colnames(data)[10] <- "time_signal_body_acc_jerk_mean_y_axis"
colnames(data)[11] <- "time_signal_body_acc_jerk_mean_z_axis"
colnames(data)[12] <- "time_signal_body_gyro_mean_x_axis"
colnames(data)[13] <- "time_signal_body_gyro_mean_y_axis"
colnames(data)[14] <- "time_signal_body_gyro_mean_z_axis"
colnames(data)[15] <- "time_signal_body_gyro_jerk_mean_x_axis"
colnames(data)[16] <- "time_signal_body_gyro_jerk_mean_y_axis"
colnames(data)[17] <- "time_signal_body_gyro_jerk_mean_z_axis"
colnames(data)[18] <- "time_signal_body_acc_mag_mean"
colnames(data)[19] <- "time_signal_gravity_acc_mag_mean"
colnames(data)[20] <- "time_signal_body_acc_jerk_mag_mean"
colnames(data)[21] <- "time_signal_body_gyro_mag_mean"
colnames(data)[22] <- "time_signal_body_gyro_jerk_mag_mean"
colnames(data)[23] <- "frequency_signal_body_acc_mean_x_axis"
colnames(data)[24] <- "frequency_signal_body_acc_mean_y_axis"
colnames(data)[25] <- "frequency_signal_body_acc_mean_z_axis"
colnames(data)[26] <- "frequency_signal_body_acc_jerk_mean_x_axis"
colnames(data)[27] <- "frequency_signal_body_acc_jerk_mean_y_axis"
colnames(data)[28] <- "frequency_signal_body_acc_jerk_mean_z_axis"
colnames(data)[29] <- "frequency_signal_body_gyro_mean_x_axis"
colnames(data)[30] <- "frequency_signal_body_gyro_mean_y_axis"
colnames(data)[31] <- "frequency_signal_body_gyro_mean_z_axis"
colnames(data)[32] <- "frequency_signal_body_acc_mag_mean"
colnames(data)[33] <- "frequency_signal_body_body_acc_jerk_mag_mean"
colnames(data)[34] <- "frequency_signal_body_body_gyro_mag_mean"
colnames(data)[35] <- "frequency_signal_body_body_gyro_jerk_mag_mean"
colnames(data)[36] <- "time_signal_body_acc_st_dev_x_axis"
colnames(data)[37] <- "time_signal_body_acc_st_dev_y_axis"
colnames(data)[38] <- "time_signal_body_acc_st_dev_z_axis"
colnames(data)[39] <- "time_signal_gravity_acc_st_dev_x_axis"
colnames(data)[40] <- "time_signal_gravity_acc_st_dev_y_axis"
colnames(data)[41] <- "time_signal_gravity_acc_st_dev_z_axis"
colnames(data)[42] <- "time_signal_body_acc_jerk_st_dev_x_axis"
colnames(data)[43] <- "time_signal_body_acc_jerk_st_dev_y_axis"
colnames(data)[44] <- "time_signal_body_acc_jerk_st_dev_z_axis"
colnames(data)[45] <- "time_signal_body_gyro_st_dev_x_axis"
colnames(data)[46] <- "time_signal_body_gyro_st_dev_y_axis"
colnames(data)[47] <- "time_signal_body_gyro_st_dev_z_axis"
colnames(data)[48] <- "time_signal_body_gyro_jerk_st_dev_x_axis"
colnames(data)[49] <- "time_signal_body_gyro_jerk_st_dev_y_axis"
colnames(data)[50] <- "time_signal_body_gyro_jerk_st_dev_z_axis"
colnames(data)[51] <- "time_signal_body_acc_mag_st_dev"
colnames(data)[52] <- "time_signal_gravity_acc_mag_st_dev"
colnames(data)[53] <- "time_signal_body_acc_jerk_mag_st_dev"
colnames(data)[54] <- "time_signal_body_gyro_mag_st_dev"
colnames(data)[55] <- "time_signal_body_gyro_jerk_mag_st_dev"
colnames(data)[56] <- "frequency_signal_body_acc_st_dev_x_axis"
colnames(data)[57] <- "frequency_signal_body_acc_st_dev_y_axis"
colnames(data)[58] <- "frequency_signal_body_acc_st_dev_z_axis"
colnames(data)[59] <- "frequency_signal_body_acc_jerk_st_dev_x_axis"
colnames(data)[60] <- "frequency_signal_body_acc_jerk_st_dev_y_axis"
colnames(data)[61] <- "frequency_signal_body_acc_jerk_st_dev_z_axis"
colnames(data)[62] <- "frequency_signal_body_gyro_st_dev_x_axis"
colnames(data)[63] <- "frequency_signal_body_gyro_st_dev_y_axis"
colnames(data)[64] <- "frequency_signal_body_gyro_st_dev_z_axis"
colnames(data)[65] <- "frequency_signal_body_acc_mag_st_dev"
colnames(data)[66] <- "frequency_signal_body_body_acc_jerk_mag_st_dev"
colnames(data)[67] <- "frequency_signal_body_body_gyro_mag_st_dev"
colnames(data)[68] <- "frequency_signal_body_body_gyro_jerk_mag_st_dev"



#5. Creates tidy dataset w/ the average of each variable for each activity and subject ######

# start tidy dataset
tidy <- head(data,n=0)
tidy_names <- names(tidy)

# converts activity names from character to factor to numeric (for for-loop)
data$activity <- factor(data$activity)
data$activity <- as.numeric(data$activity)

# loop to find averages for each activity, by subject
for (i in 1:30){
  d <- data[data$subject == i,]
  for (j in 1:6){
    d2 <- d[d$activity == j,]
    tidy <- rbind(tidy, colMeans(d2))
  }
}

# restores variable names
wrong_names <- names(tidy)
setnames(tidy, old = c(wrong_names), new = c(tidy_names))

# restores activity names, per the README file
tidy$activity[tidy$activity==1] <- "Walking"
tidy$activity[tidy$activity==2] <- "Walking_Upstairs"
tidy$activity[tidy$activity==3] <- "Walking_Downstairs"
tidy$activity[tidy$activity==4] <- "Sitting"
tidy$activity[tidy$activity==5] <- "Standing"
tidy$activity[tidy$activity==6] <- "Laying"

# drop clutter
rm(d, d2, i, j, tidy_names, wrong_names)

# print data
write.table(tidy, "tidy.txt", row.names=FALSE)

## prints codebook
codebook <- data.frame(feature=names(data), description=descriptions)
write.table(codebook, "codebook.txt", sep="\t")