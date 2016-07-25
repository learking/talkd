setwd("/home/suhasini/workspace/talkingData/")

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
