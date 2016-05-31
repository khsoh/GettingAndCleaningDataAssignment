library(dplyr)

basedir <- "UCI_HAR_Dataset"

# Read the activity label associated with each activity 
activities_file <- paste(basedir, "activity_labels.txt", sep="/")
activity_df <- read.table(activities_file, col.names=c("activity_label", "activity"), 
                          stringsAsFactors = FALSE)

# Read the feature label associated with each feature
features_file <- paste(basedir, "features.txt", sep="/")
features_df <- read.table(features_file, col.names=c("feature_label", "feature"), 
                          stringsAsFactors = FALSE)

# Extract only the mean() and std() from features_df
mean_std_features_df <- features_df[grep("(mean|std)\\(\\)", features_df$feature),]

# Change the names by replacing - with _ and removing ()
mean_std_features_df$feature <- gsub("-", "_", mean_std_features_df$feature)
mean_std_features_df$feature <- gsub("\\(\\)", "", mean_std_features_df$feature)

# Read in the test subject ID
test_subject_id_file <- paste(basedir, "test", "subject_test.txt", sep="/")
test_subject_id_df <- read.table(test_subject_id_file, col.names=c("subject_id"),
                                 stringsAsFactors = FALSE)

# Read in the test activities
test_activity_file <- paste(basedir, "test", "y_test.txt", sep="/")
test_activity_id_df <- read.table(test_activity_file, col.names=c("activity_label"),
                                  stringsAsFactors = FALSE)

# Read in the test dataset
test_dataset_file <- paste(basedir, "test", "X_test.txt", sep="/")
test_dataset <- read.table(test_dataset_file, stringsAsFactors = FALSE)

# Extract out only the mean() and std()
test_dataset <- test_dataset[,mean_std_features_df$feature_label]

# Give them nice column names
colnames(test_dataset) <- mean_std_features_df$feature

# Merge by activity_label to identify activity name per row in test_activity_id_df
#  and assign to test_activity_df
test_activity_df <- merge(test_activity_id_df, activity_df, by = "activity_label")

# Add in the subject ID and activity labels per row to the dataset
test_dataset$subject_id <- test_subject_id_df$subject_id
test_dataset$activity <- test_activity_df$activity


### Now do the same for the training data
# Read in the training subject ID
train_subject_id_file <- paste(basedir, "train", "subject_train.txt", sep="/")
train_subject_id_df <- read.table(train_subject_id_file, col.names=c("subject_id"),
                                  stringsAsFactors = FALSE)

# Read in the training activities
train_activity_file <- paste(basedir, "train", "y_train.txt", sep="/")
train_activity_id_df <- read.table(train_activity_file, col.names=c("activity_label"),
                                   stringsAsFactors = FALSE)

# Read in the train dataset
train_dataset_file <- paste(basedir, "train", "X_train.txt", sep="/")
train_dataset <- read.table(train_dataset_file, stringsAsFactors = FALSE)

# Extract out only the mean() and std()
train_dataset <- train_dataset[,mean_std_features_df$feature_label]

# Give them nice column names
colnames(train_dataset) <- mean_std_features_df$feature

# Merge by activity_label to identify activity name per row in test_activity_id_df
#  and assign to train_activity_df
train_activity_df <- merge(train_activity_id_df, activity_df, by = "activity_label")

# Add in the subject ID and activity labels per row to the dataset
train_dataset$subject_id <- train_subject_id_df$subject_id
train_dataset$activity <- train_activity_df$activity

#### Combine 2 datasets (requirement for steps 1-4 in assignment)
#   the 2 datasets have non-intersecting subject_id - so the 2 sets can just
#   be added together using rbind
final_dataset <- rbind(test_dataset, train_dataset)


#### For step 5 in assignment
## Calculate the means of each variable, grouped by subject and activity
grouped_mean_dataset <- final_dataset %>% 
  group_by(subject_id, activity) %>% 
  summarise_each(funs(mean))

# Change the column names by prepending GROUPED_MEAN_
colnames(grouped_mean_dataset)[3:(2+length(mean_std_features_df$feature))] <-
  gsub("^(.*)", "GROUPED_MEAN_\\1", mean_std_features_df$feature)


### Finally, the required dataset containing average of each variable for each
### activity and each subject is in grouped_mean_dataset