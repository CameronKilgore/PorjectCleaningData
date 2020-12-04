# CodeBook

This is a repository that does the following:

-Must contain folder "UCI HAR Dataset" containing the activity_labels.txt, features.txt, "test", and "train" folders with test and training datasets.

-With that folder present, it takes no input, but will take the features.txt and activity_labels.txt datasets. It cleans the activity_labels activities names by capitalizing the variables and removing the "_". 

-Then for both test and train, it does the following with the initial_clean function:
  1) Checks that the input to the function is either "Test" or "Train"
  2) Sets the activity data as X_temp, sets activities as Y_temp naming the variables "ActivityNumber", and sets the subjects as temp_subjects naming the variables "Subjects"
  3) Changes the names of X_temp to be the features names
  4) Filters the X_temp dataset to only the mean (-mean()) and standard deviation (-std()) variables.Names the dataset trimX.
  5) Merges the activity labels onto the Y_temp (activitynumber) dataset to contain the actual names, then pastes "Test" or "Train" onto the beginning of the activity depending on which dataset is being used
  6) Combines the subject, activity, and actual activity data datasets with a cbind()
  7) Cleans up the names of the variables changing "-mean()"" to "Mean" and "-std()" to "Standard Deviation"
  
-Sets tidy_dataset as the test and train datasets stacked on each other with an rbind()

-Sets the means dataset as the mean of each variable based on subject and activity 

-Cleans the name from Group.1 and Group.2 to "Subject" and "Activity"

-Writes both tables to their .txt files.

*The variable names are the same as in the original activity data datasets, just cleaned to not have -mean() and -std(), so the variables are the same as the explanantions in UCI HAR Dataset.