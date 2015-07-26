## Project Code Book

This code book describes the steps followed to create the resulting tidy data set.

### Data Set Information:

A group of 30 volunteers performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

### Attribute Information

* features.txt: Names of the 561 features with time and domain variables.
* activity_labels.txt: Labels for each of the 6 activities.
* X_train.txt: 7352 observations for 561 feature variables.
* subject_train.txt: A vector of 7352 observations, containing the ID of the volunteer.
* y_train.txt: A vector of 7352 observations, denoting the ID of the activity in X_train.txt.
* X_test.txt: 2947 observations for 561 feature variables.
* subject_test.txt: A vector of 2947 observations, containing the ID of the volunteer.
* y_test.txt`: A vector of 2947 observations, denoting the ID of the activity in X_test.txt.

More information about the files is available in `README.txt`. More information about the features is available in `features_info.txt`.

### Data files that were not used
This analysis was performed using 'only' the files above. .

### Processing steps

1. Read the data files into data frames
2. Add column headers accordingly after identifying the structure.
3. Combine the training and test datasets into one.
4. Remove feature columns not needed for the project
5. A tidy data set was created containing the mean of each feature for each subject and each activity.