
## The below code pertains to activities 1, 3 and 4 from assignment
## read features.txt into a dataframe using newline as the separator and no header flag.
## assign first column of the dataframe to a vector, fl.
dfl <- read.csv("features.txt", sep = "\n", header = F)
fl <- as.vector(dfl$V1)

dfa <- read.csv("activity_labels.txt", sep = " ", header = F)
colnames(dfa) <- c("activity", "activityname")

##read X_train.txt into dataframe df_tr such that each row of the file is read as one element
df_tr <- read.csv("./train/X_train.txt", sep = "\n", header = F)

##tidy each row of data by removing spaces in the beginning of the row and then splitting the row by space(s)
l1 <- lapply(df_tr[,], function(x){strsplit(sub("^\\s+", "", as.vector(x)), "\\s+")})

##convert this list to dataframe
df_tr1 <- as.data.frame(l1)

## dataframe has 561 rows and 7352 columns hence transpose
df_tr2 <- t(df_tr1)

## asssign column names from features.txt

colnames(df_tr2) <- fl

## assign serial rownames
rownames(df_tr2) <- c(1:7352)

##create a dataframe of subjects from subject_train.txt

df_trsub <- read.csv("./train/subject_train.txt", sep = "\n", header = F)
colnames(df_trsub) <- "subject"

##create a dataframe of activities from y_train.txt

df_tract <- read.csv("./train/y_train.txt", sep = "\n", header = F)
colnames(df_tract) <- "activity"

##merge with activity labels to give names to activity 
df_tract <- merge(df_tract, dfa, id = "activity")

##create a dataframe with datatype of TRAIN 7352 rows 
df_trdt <- as.data.frame(c(rep("TRAIN", 7352)))
colnames(df_trdt) <- "datatype"

## column bind datatype, subject, activity and training dataframes to create a dataframe with all TRAINING data

df_trn <- cbind(df_trdt, df_trsub, df_tract, df_tr2)

## Similarly create a dataframe with all TEST data

##read X_test.txt into dataframe df_tr such that each row of the file is read as one element
df_tt <- read.csv("./test/X_test.txt", sep = "\n", header = F)

##tidy each row of data by removing spaces in the beginning of the row and then splitting the row by space(s)
l2 <- lapply(df_tt[,], function(x){strsplit(sub("^\\s+", "", as.vector(x)), "\\s+")})

##convert this list to dataframe
df_tt1 <- as.data.frame(l2)

## dataframe has 561 rows and 2947 columns hence transpose
df_tt2 <- t(df_tt1)

## asssign column names from features.txt

colnames(df_tt2) <- fl

## assign serial rownames
rownames(df_tt2) <- c(1:2947)

##create a dataframe of subjects from subject_train.txt

df_ttsub <- read.csv("./test/subject_test.txt", sep = "\n", header = F)
colnames(df_ttsub) <- "subject"

##create a dataframe of activities from y_train.txt

df_ttact <- read.csv("./test/y_test.txt", sep = "\n", header = F)
colnames(df_ttact) <- "activity"

##merge with activity labels to give names to activity 
df_ttact <- merge(df_ttact, dfa, id = "activity")

##create a dataframe with datatype of TRAIN 7352 rows 
df_ttdt <- as.data.frame(c(rep("TEST", 2947)))
colnames(df_ttdt) <- "datatype"

## column bind datatype, subject, activity and training dataframes to create a dataframe with all TEST data

df_test <- cbind(df_ttdt, df_ttsub, df_ttact, df_tt2)

## combine TEST and TRAIN data

df_all <- rbind(df_trn, df_test)


## The below code pertains to activitie 2 from assignment - extract mean and std deviation data
## dataframe to extract mean and std deviation for each measurement
library(dplyr)
##column list
cols <- c(colnames(df_all)[1:4], grep("mean|std", colnames(df_all), value = T))
df1 <- select(df_all, one_of(cols))
write.csv(df1, "meanstd.csv")

## The below code pertains to activitie 5 from assignment -  independent tidy data set with the average of each variable 
df_all[fl] <- sapply(df_all[fl], as.numeric)

df_mean = aggregate( df_all[,5:565], df_all[,1:4], FUN = mean )

write.csv(df_mean, "df_mean.csv")
