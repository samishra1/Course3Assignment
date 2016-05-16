Variable names:

1. datatype: a factor variable indicating whether the data is Training or Test data. Has two values
	TEST: For data loaded from X_test.txt
	TRAIN: For data loaded from X_test.txt

2. subject: a factor variable that identifies the subject who performed the activity for each window sample. 	
	Its range is from 1 to 30. It is loaded from subject_test.txt and subject_train.txt from TEST and 	TRAIN datatype respectively.

3. activity: a factor variable that identifies the activity performed by the subject. It ranges from 1 to 6. 	
	It is loaded from y_test.txt and y_train.txt for TEST and TRAIN datatype respectively. 
	1 - WALKING
	2 - WALKING_UPSTAIRS
 	3 - WALKING_DOWNSTAIRS
	4 - SITTING 
	5 - STANDING
 	6 - LAYING

4. variables listed in feature.txt

Procedure:

1. Create a vector fl from file feature.txt
2. Load data from activity_labels.txt to a dataframe dfa and assign column names "activity" and "activity_name"
2. Load data from X_train.txt into a dataframe (df_tr2) such that each row is loaded as one element. Then tidy data for each row by removing spaces from the beginning of each row and replacing multiple spaces with one space. Then create a list of each row by splitting each row by "space" and then convert the list to the data frame.
3. Assign colnames to df_tr from fl
4. Load data from subject_train.txt to dataframe df_trsub and assign column name "subject"
5. Load data from y_train.txt to dataframe df_tract and assign column name "activity". Merge data with dfa using "activity"
6. Create a dataframe df_trdt containing one column and 7352 rows with value TRAIN in each cell
7. Column bind df_trdt, df_trsub, df_tract and df_tr2 to get a complete TRAINING dataset
8. Repeat the same process to create TEST dataset
9. Row bind TRAIN and TEST dataframes to create a dataframe df_all containing all data set
10. To extract mean and std deviation, ceate a column list "cols" contain only those columns from df_all that contain mean or std in the column name
11. Select columns in "cols" from df_all (using dplyr package) and output to meanstd.csv
12. Create another dataframe with mean of all columns and output to avg.csv

