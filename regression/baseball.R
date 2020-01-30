library(readr)
library(dplyr)
rm(list=ls())
test1 <- read_csv("test1.csv")
## 데이터전처리

# 1시즌 밖에 없는 선수들 제외시키기.
frequency<-c()
sum(test1$playerid==test1$playerid[2])

for( i in 1:992) {
  frequency[i]<-sum(test1$playerid==test1$playerid[i])
}

test2<-cbind(test1,frequency)
test2_1<-test2[!(test2$frequency==1),]

# 1년뒤 war 1년전시즌 row에 넣기(전시즌 데이터로 다음시즌 war예측하기위함)
bewar<-c()
for(i in 2:866) {
  bewar[1]<-100
  if(test2_1$playerid[i-1]==test2_1$playerid[i]) {
    bewar[i]<-test2_1$WAR[i-1]
  } else {
    bewar[i]<-100
  }
}

test3<-cbind(test2_1,bewar)
test3_1<-test3[!(test3$bewar==100),]