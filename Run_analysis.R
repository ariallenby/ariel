# assuming all files were read into the tables of the same names

# combine Train and Test

train_test_X <- rbind(X_Train,X_Test)
train_test_Y <- rbind(y_Train,y_Test)
train_test_sub <- rbind(subject_train,subject_test)

# Give names to the variables

colnames(train_test_X) <- features$V2
colnames(train_test_Y) <- "activity"
colnames(train_test_sub) <-"subject"

# combine all three parts into one 

all_data <- cbind(train_test_X, train_test_Y, train_test_sub)

# Create vector with the column names for mean() & stddev() columns but without meanFreq() 

colNames <- (colnames(all_data)[(

 grepl("mean()", colnames(all_data))

| grepl("std()",colnames(all_data))

| grepl("subject",colnames(all_data))

| grepl("activity",colnames(all_data))) == TRUE])

# counting meanFreq()

colNamesEx <- (colnames(all_data)[ grepl("meanFreq()", colnames(all_data))== TRUE])

# excluding meanFreq()

colNames <- colNames[-which(colNames %in% colNamesEx)]

#remove unnecesary columns

part_data <- all_data[colnames(all_data) %in% colNames]

# finding average for each column for each pair of subject & activity

final_data <- aggregate(part_data,by=list(part_data$subject, part_data$activity),FUN=mean)

# removing two first columns

final_data1 <- final_data[-(1:2)]

# assigning activity labels instead of 1,2,3,4,5,6

final_data2 <- merge(final_data1, activity_labels, by.x = "activity", by.y = "V1")

# changing the last variable's name

names(final_data2)[names(final_data2) == "V2"] <- "activity"
