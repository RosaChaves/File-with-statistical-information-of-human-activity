# File-with-statistical-information-of-human-activity
mean and std of features describing human activities of data organized in training and test
These are the steps of the program
1. Download and unzip the dataset if it does not already exist in the working directory
2. Select the activity and feature information
3. Selects both the training and test datasets, keeping only those columns with a mean or standard deviation
4. Merges the two datasets
5.transform activities & subjects into factors
6. Creates a tidy dataset that consists of the average (mean) value of each   variable for each subject and activity pair.The end result is shown in the file `tidyFile.txt`.
