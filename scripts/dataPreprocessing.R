setwd("/home/suhasini/workspace/talkingData/")

# load libraries
library(sqldf)

# read-in training label data
train_label_DT = read.csv("./data/gender_age_train.csv", colClasses="character")

# M vs F table
table(train_label_DT$gender)
# F     M 
# 26741 47904 

# Conclusion: more male than female in dataset

# age distribution
# M
hist(train_label_DT[which(train_label_DT$gender=='M'),]$age)
quantile(train_label_DT[which(train_label_DT$gender=='M'),]$age, seq(0,1,0.1))
#  0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
#   1   21   24   26   27   29   31   34   37   44   90 
# F
hist(train_label_DT[which(train_label_DT$gender=='F'),]$age)
quantile(train_label_DT[which(train_label_DT$gender=='F'),]$age, seq(0,1,0.1))
#  0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
#  10   21   24   26   27   29   31   35   40   47   96

# Conclusion: M vs F age distribution is very similar

# combine device id for train and test
test_device_DT = read.csv("./data/gender_age_test.csv", colClasses="character")
device_DT = data.frame(device_id = c(train_label_DT$device_id, test_device_DT$device_id))

# add phone brand and device model to device_DT
phone_DT = read.csv("./data/phone_brand_device_model.csv", colClasses="character")
# 1)
dim(phone_DT)
# [1] 187245      3
length(unique(phone_DT$device_id))
# [1] 186716
sum(duplicated(phone_DT$device_id))
# [1] 529
dup_device_list = phone_DT[duplicated(phone_DT$device_id),]$device_id
dup_device_DT = phone_DT[which(phone_DT$device_id %in% dup_device_list),]
dup_device_DT = dup_device_DT[with(dup_device_DT, order(device_id)),]
# Conclusion: device_id not unique in phone_DT
# 2)
phone_uniq_DT = phone_DT[!duplicated(phone_DT$device_id),]
# 3)
input_DT = merge(device_DT, phone_uniq_DT, by="device_id")

###########################################################################################################################
# Feature engineering

# App category
# Problem def: 
# 1) find out App categories (or groups of categories) that can differentiate gender
# 2) age group within gender

# device_id => event_id : events.csv (3,252,951)
# event_id => app_id: app_events.csv (32,473,068)
# app_id => label_id: app_labels.csv (459,944)
# label_id => label_categories (931)


# join table: events.csv, app_events.csv, app_labels.csv
app_event_DT = read.csv("", colClasses="character")
app_label_DT = read.csv("./data/app_labels.csv", colClasses="character")